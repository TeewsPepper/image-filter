#  Edit Images with WebAssembly

![Status](https://img.shields.io/badge/status-en%20desarrollo-yellow)
![WASM](https://img.shields.io/badge/WebAssembly-optimizado-blueviolet)
![Made with React](https://img.shields.io/badge/Hecho%20con-React-blue)

- Este proyecto es una aplicación web para aplicar filtros de imagen utilizando WebAssembly (WASM) con código fuente en AssemblyScript y una interfaz en React.

- Permite cargar imágenes, aplicar filtros como escala de grises, sepia, inversión, blur, sharpen. Incluye además una opción para restablecer la imagen original.

---

##  Tecnologías utilizadas

-  **React** (Vite) para la UI
-  **AssemblyScript** para filtros de imagen de alto rendimiento en WASM
-  **Canvas API** para manipulación de píxeles
-  **WebAssembly** para acelerar el procesamiento directamente desde el navegador

---

##  Instalación

1. **Clona el repositorio**
2. **Ve al directorio**
3. **Instala dependencias**
4. **Compila el módulo WASM**

```bash
    git clone https://github.com/teewspepper/edit-images.git
    cd edit-images
    npm install
    npm run asbuild

``` 
- Asegúrate de tener AssemblyScript ≥ 0.27 instalado. Si no:
    
```bash
    npm install --save-dev assemblyscript@latest
```   
    
 5. **Inicia el servidor de desarrollo**

```bash
    npm run dev
```
 
- Abre http://localhost:5173 en tu navegador.


##  Uso

- Clic en “Elegir archivo” para subir una imagen.
- Ajusta el nivel de intensidad del filtro con el slider.
- Selecciona un filtro: Grayscale, Sepia, Invert, Blur, Sharpen.
- Clic en “Restablecer” para volver a la imagen original.


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
- Intensidad ajustable por slider
- Restablecer imagen original
- Interfaz responsive y accesible

##  Aprendizajes clave

- Performance de bajo nivel con WASM
- AssemblyScript para lógica pixel-level
- React moderno para crear una experiencia interactiva
- Comunicación entre JavaScript y WebAssembly


##  Scripts útiles

```bash
    npm run dev        # inicia servidor local
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
















