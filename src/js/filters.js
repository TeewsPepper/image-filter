
export function grayscaleJS(imageData, level = 1) {
  const d = imageData.data;
  for (let i = 0; i < d.length; i += 4) {
    const avg = (d[i] + d[i + 1] + d[i + 2]) / 3;
    d[i]     += (avg - d[i])     * level;
    d[i + 1] += (avg - d[i + 1]) * level;
    d[i + 2] += (avg - d[i + 2]) * level;
  }
}

export function sepiaJS(imageData, level = 1) {
  const d = imageData.data;
  for (let i = 0; i < d.length; i += 4) {
    const r = d[i], g = d[i + 1], b = d[i + 2];
    const tr = Math.min(255, 0.393*r + 0.769*g + 0.189*b);
    const tg = Math.min(255, 0.349*r + 0.686*g + 0.168*b);
    const tb = Math.min(255, 0.272*r + 0.534*g + 0.131*b);
    d[i]     += (tr - r) * level;
    d[i + 1] += (tg - g) * level;
    d[i + 2] += (tb - b) * level;
  }
}

export function invertJS(imageData, level = 1) {
  const d = imageData.data;
  for (let i = 0; i < d.length; i += 4) {
    d[i]     += (255 - d[i])     * level;
    d[i + 1] += (255 - d[i + 1]) * level;
    d[i + 2] += (255 - d[i + 2]) * level;
  }
}


