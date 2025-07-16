#  Edit Images with WebAssembly

![Status](https://img.shields.io/badge/status-en%20desarrollo-yellow)
![WASM](https://img.shields.io/badge/WebAssembly-optimizado-blueviolet)
![Made with React](https://img.shields.io/badge/Hecho%20con-React-blue)


## 🔗 Demo en vivo

- Podés probar la app funcionando aquí:
 [https://image-editor-wasm.netlify.app](https://image-editor-wasm.netlify.app)



Este proyecto es una **prueba técnica para explorar los beneficios de WebAssembly (WASM)** en la manipulación de imágenes dentro del navegador.
Permite aplicar filtros como escala de grises, sepia, blur, invert y sharpen a imágenes cargadas por el usuario. Los filtros están escritos en AssemblyScript y compilados a WebAssembly, lo que permite ejecutar la lógica de procesamiento en una capa de alto rendimiento independiente del hilo principal de JavaScript.

El objetivo es comparar este enfoque con una solución tradicional en JavaScript puro, poniendo a prueba ventajas como:

-  Menor bloqueo de la UI durante operaciones pesadas
-  Procesamiento más veloz en imágenes grandes
-  Separación clara entre lógica de negocio y presentación

Además, incorpora una interfaz moderna con React y proximamente se agregará un control de intensidad de filtro para demostrar cómo WASM puede integrarse fácilmente en entornos frontend actuales.

##  Benchmark JS vs WASM

 **Objetivo** – medir la diferencia de rendimiento entre la versión JavaScript pura  y la versión WebAssembly (AssemblyScript) aplicando tres filtros a una imagen de **4000 × 6000 px** (~24 MP).

 ```bash
|  Filtro   | JS min | JS max | JS avg   | WASM min   | WASM max   |   WASM avg   |   Mejora    |
|-----------|-------:|-------:|---------:|-----------:|-----------:|-------------:|------------:|
| grayscale | 160 ms | 269 ms | 189.4 ms | **112 ms** | **131 ms** | **118.6 ms** | **+37.4 %** |
| invert    | 165 ms | 268 ms | 185.8 ms | **109 ms** | **180 ms** | **125.2 ms** | **+32.6 %** |
| sepia     | 215 ms | 340 ms | 238.5 ms | **162 ms** | **237 ms** | **185.9 ms** | **+22.1 %** |
```

## ¿Por qué la mejora no es “mágica” al 100 %?

1. **Copia de memoria**  
   - El navegador entrega los píxeles del `canvas` como `ImageData`.  
   - Para procesarlos en WASM hay que copiarlos al heap WebAssembly, y luego volver a copiarlos a JS.  
   - Ese traslado cuesta decenas de milisegundos, sea cual sea la lógica del filtro.

2. **Trabajo real vs. coste fijo**  
   - Si el filtro hace poco cálculo (p.ej. `invert`, que son 3 restas), la copia puede representar la mitad del tiempo total.  
   - Cuanto **más pesada** es la operación, más se amortiza la copia y **mejor luce WASM** (blur, convoluciones grandes, compresión, etc.).

3. **Compilación JIT de JS**  
   - Tras 1‑2 ejecuciones el motor JS optimiza los bucles; la versión WASM está “caliente” desde el inicio, pero el gap se cierra algo después del warm‑up.

---

##  Tecnologías utilizadas

-  **React** (Vite) para la UI
-  **AssemblyScript** para filtros de imagen de alto rendimiento en WASM
-  **Canvas API** para manipulación de píxeles
-  **WebAssembly** para acelerar el procesamiento directamente desde el navegador

---

##  Instalar y reproducir medición

1. **Clona el repositorio**
```bash
    git clone https://github.com/teewspepper/edit-images.git
``` 

2. **Ve al directorio**
```bash
    cd edit-images
```

3. **Instala dependencias**
```bash
    npm install
```

4. **Compila el módulo WASM**
```bash
    npm run asbuild
```

- Asegúrate de tener AssemblyScript ≥ 0.27 instalado. Si no:
    
```bash
    npm install --save-dev assemblyscript@latest
```   
    
 5. **Inicia el servidor local**

```bash
    npm run dev
```

##  Uso
 
1. Abre http://localhost:5173 en tu navegador.
2. Abre DevTools → Console (F12 en Firefox/Chrome).
3. Ejecuta el benchmark


```javascript
// Ejecuta ambas mediciones (WASM y JS) de una sola vez
await benchmarkComparison("grayscale", 10);
await benchmarkComparison("sepia", 10);
await benchmarkComparison("invert", 10);

```

- La función benchmarkComparison (expuesta a window en modo dev) repetirá el filtro 10 veces.
- Calculará min, max, avg y mostrará una tabla como la del README.

Repite con "invert" y "sepia" para comparar.

Nota – la primera corrida siempre es más lenta (warm‑up).
El script descarta ese efecto al promediar 10 repeticiones.

##  Estructura del proyecto

```bash
├── public/
│   └── optimized.wasm        # módulo WASM compilado
├── src/
│   ├── assembly/             # código AssemblyScript
│   │   ├── index.ts
│   │   └── tsconfig.json     # para el editor
│   ├── ImageEditor.jsx       # componente principal React
│   └── App.css               # estilos del editor
├── asconfig.json             # config para AssemblyScript
├── package.json
└── README.md
``` 

##  Características implementadas

- Filtros de imagen en tiempo real
- Carga local de imágenes
- Procesamiento con WebAssembly
- Restablecer imagen original
- Interfaz responsive y accesible

##  Aprendizajes clave

- Performance de bajo nivel con WASM
- AssemblyScript para lógica pixel-level
- React moderno para crear una experiencia interactiva
- Comunicación entre JavaScript y WebAssembly


##  Scripts útiles

```bash
    npm run asbuild    # compila WASM desde src/assembly/index.ts
``` 

##  Posibles mejoras

- Ajustar la intensidad del filtro en tiempo real mediante un control deslizante.
- Guardar imagen procesada (canvas.toBlob)
- Tests básicos con Jest o Vitest
- Drag & Drop para carga de imágenes
- Nuevos filtros con máscaras y kernels personalizados
- PWA para trabajar offline


###  Autor

- José Gómez
- Frontend Developer

[LinkedIn](https://www.linkedin.com/in/jose-gomez-dev)

### Licencia

Este proyecto se distribuye bajo la licencia [MIT](LICENSE).

























