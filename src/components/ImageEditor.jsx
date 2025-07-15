

import React, { useState, useRef, useEffect, useCallback } from 'react';
import '../styles/editor.css';

export default function ImageEditor() {
  const canvasRef    = useRef(null);
  const fileInputRef = useRef(null);

  const [wasm,  setWasm]  = useState(null);
  const [image, setImage] = useState(null);          // <img> original
  const [origData, setOrigData] = useState(null);     // ImageData original
  const [isProcessing, setIsProcessing] = useState(false);

  /* ───────────── Carga del módulo WASM ───────────── */
  useEffect(() => {
    (async () => {
      const importObject = { env: { abort() {} } };
      const { instance } = await WebAssembly.instantiateStreaming(
        fetch('/optimized.wasm'),
        importObject
      );
      setWasm(instance.exports);
    })();
  }, []);

  /* ───────────── Al cargar la imagen ───────────── */
  const handleFileChange = (e) => {
    const file = e.target.files?.[0];
    if (!file) return;

    const img = new Image();
    img.onload = () => {
      setImage(img);
      const canvas = canvasRef.current;
      const ctx    = canvas.getContext('2d');
      canvas.width  = img.width;
      canvas.height = img.height;
      ctx.drawImage(img, 0, 0);
      // Guarda una copia inmutable de los píxeles originales
      const original = ctx.getImageData(0, 0, canvas.width, canvas.height);
      setOrigData(original);
    };
    img.src = URL.createObjectURL(file);
  };

  /* ───────────── Aplica filtros con WASM ───────────── */
  const applyFilter = useCallback(async (filterName) => {
    if (!wasm || !image || isProcessing) return;

    setIsProcessing(true);
    try {
      const canvas    = canvasRef.current;
      const ctx       = canvas.getContext('2d');
      const imageData = ctx.getImageData(0, 0, canvas.width, canvas.height);

      /* Memoria compartida */
      const mem  = wasm.memory;
      const ptr  = wasm.getPixelPtr();
      let view   = new Uint8Array(mem.buffer);
      const need = imageData.data.length;

      if (view.length < ptr + need) {
        const pages = Math.ceil((ptr + need - view.length) / 65536);
        mem.grow(pages);
        view = new Uint8Array(mem.buffer);
      }

      view.set(new Uint8Array(imageData.data.buffer), ptr);
      wasm[filterName](ptr, canvas.width, canvas.height);

      const result = new Uint8ClampedArray(mem.buffer, ptr, need);
      ctx.putImageData(new ImageData(result, canvas.width, canvas.height), 0, 0);

    } catch (err) {
      console.error('Error applying filter:', err);
    } finally {
      setIsProcessing(false);
    }
  }, [wasm, image, isProcessing]);

  /* ───────────── Restablecer ───────────── */
  const resetImage = () => {
    if (!origData) return;
    const canvas = canvasRef.current;
    const ctx    = canvas.getContext('2d');
    ctx.putImageData(origData, 0, 0);
  };

  /* ───────────── UI ───────────── */
  return (
    <div className="container">
      <h1 className="title">Editor de Imagen con Filtros WASM</h1>

      <input
        ref={fileInputRef}
        type="file"
        accept="image/*"
        onChange={handleFileChange}
        className="fileInput"
      />

      <div className="canvasWrapper">
        <canvas ref={canvasRef} />
      </div>

      <div className="buttonGroup">
        <button onClick={() => applyFilter('grayscale')}
                disabled={!wasm || !image || isProcessing}>
          Escala de grises
        </button>
        <button onClick={() => applyFilter('sepia')}
                disabled={!wasm || !image || isProcessing}>
          Sepia
        </button>
        <button onClick={() => applyFilter('invert')}
                disabled={!wasm || !image || isProcessing}>
          Invertir
        </button>
        <button onClick={() => applyFilter('blur')}
                disabled={!wasm || !image || isProcessing}>
          Blur
        </button>
        <button onClick={() => applyFilter('sharpen')}
                disabled={!wasm || !image || isProcessing}>
          Sharpen
        </button>

        {/* Nuevo botón de reset */}
        <button onClick={resetImage}
                disabled={!origData || isProcessing}
                style={{ marginLeft: '1rem' }}>
          Restablecer
        </button>
      </div>
    </div>
  );
}

