// src/assembly/index.ts

// Utilidad: posición en memoria de un píxel
function getPixelOffset(x: i32, y: i32, width: i32): i32 {
  return (y * width + x) * 4;
}

// Puntero inicial donde se almacenarán los píxeles
export const PIXEL_PTR: i32 = 0;

export function getPixelPtr(): i32 {
  return PIXEL_PTR;
}

// Filtro: Escala de grises
export function grayscale(ptr: i32, width: i32, height: i32): void {
  const length = width * height * 4;
  for (let i = 0; i < length; i += 4) {
    const r = load<u8>(ptr + i);
    const g = load<u8>(ptr + i + 1);
    const b = load<u8>(ptr + i + 2);
    const avg = (r + g + b) / 3;
    store<u8>(ptr + i, avg);
    store<u8>(ptr + i + 1, avg);
    store<u8>(ptr + i + 2, avg);
  }
}

// Filtro: Sepia
export function sepia(ptr: i32, width: i32, height: i32): void {
  const length = width * height * 4;
  for (let i = 0; i < length; i += 4) {
    const r = load<u8>(ptr + i);
    const g = load<u8>(ptr + i + 1);
    const b = load<u8>(ptr + i + 2);

    store<u8>(ptr + i, u8(Math.min(255, r * 0.393 + g * 0.769 + b * 0.189)));
    store<u8>(ptr + i + 1, u8(Math.min(255, r * 0.349 + g * 0.686 + b * 0.168)));
    store<u8>(ptr + i + 2, u8(Math.min(255, r * 0.272 + g * 0.534 + b * 0.131)));
  }
}

// Filtro: Invertir colores
export function invert(ptr: i32, width: i32, height: i32): void {
  const length = width * height * 4;
  for (let i = 0; i < length; i += 4) {
    store<u8>(ptr + i, 255 - load<u8>(ptr + i));
    store<u8>(ptr + i + 1, 255 - load<u8>(ptr + i + 1));
    store<u8>(ptr + i + 2, 255 - load<u8>(ptr + i + 2));
  }
}

// Filtro: Desenfoque (blur)
export function blur(ptr: i32, width: i32, height: i32): void {
  for (let y = 1; y < height - 1; y++) {
    for (let x = 1; x < width - 1; x++) {
      let r = 0, g = 0, b = 0;

      for (let ky = -1; ky <= 1; ky++) {
        for (let kx = -1; kx <= 1; kx++) {
          const offset = getPixelOffset(x + kx, y + ky, width);
          r += load<u8>(ptr + offset);
          g += load<u8>(ptr + offset + 1);
          b += load<u8>(ptr + offset + 2);
        }
      }

      const offset = getPixelOffset(x, y, width);
      store<u8>(ptr + offset, r / 9);
      store<u8>(ptr + offset + 1, g / 9);
      store<u8>(ptr + offset + 2, b / 9);
    }
  }
}

// Filtro: Enfocar (sharpen)
export function sharpen(ptr: i32, width: i32, height: i32): void {
  const kernel = [[0, -1, 0], [-1, 5, -1], [0, -1, 0]];

  for (let y = 1; y < height - 1; y++) {
    for (let x = 1; x < width - 1; x++) {
      let r = 0, g = 0, b = 0;

      for (let ky = -1; ky <= 1; ky++) {
        for (let kx = -1; kx <= 1; kx++) {
          const offset = getPixelOffset(x + kx, y + ky, width);
          const weight = kernel[ky + 1][kx + 1];
          r += load<u8>(ptr + offset) * weight;
          g += load<u8>(ptr + offset + 1) * weight;
          b += load<u8>(ptr + offset + 2) * weight;
        }
      }

      const offset = getPixelOffset(x, y, width);
      store<u8>(ptr + offset, u8(Math.max(0, Math.min(255, r))));
      store<u8>(ptr + offset + 1, u8(Math.max(0, Math.min(255, g))));
      store<u8>(ptr + offset + 2, u8(Math.max(0, Math.min(255, b))));
    }
  }
}
