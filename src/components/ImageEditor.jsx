import { useState, useRef, useEffect, useCallback } from "react";
import {
  grayscaleJS,
  sepiaJS,
  invertJS,
  // blurJS,
  // sharpenJS
} from "../js/filters";
import "../styles/editor.css";

export default function ImageEditor() {
  const canvasRef = useRef(null);
  const fileInputRef = useRef(null);

  const [wasm, setWasm] = useState(null);
  const [image, setImage] = useState(null); // <img> original
  const [origData, setOrigData] = useState(null); // ImageData original
  const [isProcessing, setIsProcessing] = useState(false);
  const [useWasm, setUseWasm] = useState(true); // toggle JS ↔ WASM

  /*  Carga del módulo WASM  */
  useEffect(() => {
    (async () => {
      const importObject = { env: { abort() {} } };
      const { instance } = await WebAssembly.instantiateStreaming(
        fetch("/optimized.wasm"),
        importObject
      );
      setWasm(instance.exports);
    })();
  }, []);

  /*  Cargar imagen en el canvas  */
  const handleFileChange = (e) => {
    const file = e.target.files?.[0];
    if (!file) return;

    const img = new Image();
    img.onload = () => {
      setImage(img);
      const canvas = canvasRef.current;
      const ctx = canvas.getContext("2d");
      canvas.width = img.width;
      canvas.height = img.height;
      ctx.drawImage(img, 0, 0);
      setOrigData(ctx.getImageData(0, 0, canvas.width, canvas.height));
    };
    img.src = URL.createObjectURL(file);
  };

  /*  Filtros en JS puro  */
  const applyFilterJS = (filterName, imageData) => {
    switch (filterName) {
      case "grayscale":
        grayscaleJS(imageData);
        break;
      case "sepia":
        sepiaJS(imageData);
        break;
      case "invert":
        invertJS(imageData);
        break;
      // case "blur":   blurJS(imageData);      break; // implementar si quieres
      // case "sharpen":sharpenJS(imageData);   break;
      default:
        return;
    }
  };

  /* Aplica filtro (JS o WASM según toggle)  */
  const applyFilter = useCallback(
    async (filterName) => {
      if (!image || isProcessing) return;
      if (useWasm && !wasm) return; // si pide WASM y no está cargado

      setIsProcessing(true);
      const t0 = performance.now();

      try {
        const canvas = canvasRef.current;
        const ctx = canvas.getContext("2d");

        if (useWasm) {
          /* ----- ruta WASM ----- */
          const imageData = ctx.getImageData(0, 0, canvas.width, canvas.height);

          const mem = wasm.memory;
          const ptr = wasm.getPixelPtr();
          let view = new Uint8Array(mem.buffer);
          const need = imageData.data.length;

          if (view.length < ptr + need) {
            const pages = Math.ceil((ptr + need - view.length) / 65536);
            mem.grow(pages);
            view = new Uint8Array(mem.buffer);
          }

          view.set(new Uint8Array(imageData.data.buffer), ptr);
          wasm[filterName](ptr, canvas.width, canvas.height);

          const result = new Uint8ClampedArray(mem.buffer, ptr, need);
          ctx.putImageData(
            new ImageData(result, canvas.width, canvas.height),
            0,
            0
          );
        } else {
          /* ----- ruta JS pura ----- */
          const imageData = ctx.getImageData(0, 0, canvas.width, canvas.height);
          applyFilterJS(filterName, imageData);
          ctx.putImageData(imageData, 0, 0);
        }
      } catch (err) {
        console.error("Error applying filter:", err);
      } finally {
        const dt = (performance.now() - t0).toFixed(2);
        console.log(`${filterName} (${useWasm ? "WASM" : "JS"}): ${dt} ms`);
        setIsProcessing(false);
      }
    },
    [wasm, image, isProcessing, useWasm]
  );

  /* ─── Restablece imagen original*/
  const resetImage = () => {
    if (!origData) return;
    const ctx = canvasRef.current.getContext("2d");
    ctx.putImageData(origData, 0, 0);
  };

  /* UI */
  const buttonsDisabled = !image || isProcessing || (useWasm && !wasm); // solo exige wasm cuando corresponde

  /* Benchmark */

  useEffect(() => {
    if (import.meta.env.DEV) {
      window.reactBench = {
        applyFilter,
        resetImage,
        get useWasm() {
          return useWasm;
        },
        set useWasm(val) {
          setUseWasm(val);
        },
      };
    }
  }, [applyFilter, resetImage, useWasm]);

  return (
    <div className="container">
      <h1 className="title">Editor de Imagen con Filtros WASM / JS</h1>

      <input
        ref={fileInputRef}
        type="file"
        accept="image/*"
        onChange={handleFileChange}
        className="fileInput"
      />

      {/* Toggle para comparar JS vs WASM */}
      <label style={{ margin: "1rem 0", display: "block" }}>
        <input
          type="checkbox"
          checked={useWasm}
          onChange={() => setUseWasm(!useWasm)}
        />{" "}
        Usar WASM (desmarca para JS puro)
      </label>

      <div className="canvasWrapper">
        <canvas ref={canvasRef} />
        {isProcessing && <div className="processing-overlay">Procesando…</div>}
      </div>

      <div className="buttonGroup">
        {["grayscale", "sepia", "invert", "blur", "sharpen"].map((f) => (
          <button
            key={f}
            onClick={() => applyFilter(f)}
            disabled={
              buttonsDisabled || (!useWasm && ["blur", "sharpen"].includes(f))
            }
          >
            {f}
          </button>
        ))}

        <button onClick={resetImage} disabled={!origData || isProcessing}>
          Restablecer
        </button>
      </div>
    </div>
  );
}

// ─── Benchmark externo para consola DevTools ───────────────
export async function benchmark(filterName, runs = 10) {
  const { applyFilter, resetImage, useWasm } = window.reactBench;
  const times = [];

  for (let i = 0; i < runs; i++) {
    const t0 = performance.now();
    await applyFilter(filterName);
    const t1 = performance.now();
    times.push(t1 - t0);

    resetImage();
    await new Promise((r) => setTimeout(r, 50));
  }

  const avg = (times.reduce((a, b) => a + b) / runs).toFixed(2);
  const min = Math.min(...times).toFixed(2);
  const max = Math.max(...times).toFixed(2);

  console.table([
    { filtro: filterName, modo: useWasm ? "WASM" : "JS", avg, min, max },
  ]);
}
if (import.meta.env.DEV) {
  window.benchmark = benchmark;
}
export async function benchmarkComparison(filterName, runs = 10) {
  const { applyFilter, resetImage } = window.reactBench; // helpers expuestos
  const times = { JS: [], WASM: [] };

  for (const mode of ["JS", "WASM"]) {
    window.reactBench.useWasm = mode === "WASM"; // cambia toggle

    for (let i = 0; i < runs; i++) {
      const t0 = performance.now();
      await applyFilter(filterName);
      const t1 = performance.now();
      times[mode].push(t1 - t0);

      resetImage();
      await new Promise((r) => setTimeout(r, 50));
    }
  }

  const stats = (arr) => {
    const avg = arr.reduce((a, b) => a + b, 0) / arr.length;
    return {
      min: Math.min(...arr).toFixed(2),
      max: Math.max(...arr).toFixed(2),
      avg: avg.toFixed(2),
    };
  };

  const js = stats(times.JS);
  const wasm = stats(times.WASM);
  const gain = (((js.avg - wasm.avg) / js.avg) * 100).toFixed(1) + "%";

  console.table({
    filtro: filterName,
    JS: js,
    WASM: wasm,
    mejora: gain,
  });
}

/* ←── exponé la función para la consola, solo en dev ────→ */
if (import.meta.env.DEV) {
  window.benchmarkComparison = benchmarkComparison;
}
