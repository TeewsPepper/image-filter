import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react-swc'

// https://vite.dev/config/
export default defineConfig({
  plugins: [react()],
  build: {
    sourcemap: 'hidden', // Oculta los sourcemaps en producción
  },
  esbuild: {
    legalComments: 'none' // Elimina comentarios legales
  }
});
