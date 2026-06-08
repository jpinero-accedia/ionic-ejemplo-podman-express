import express from "express";
import path from 'path';
import { fileURLToPath } from 'url';

import recetasRouter from "./routes/recetas.route.js";

const app = express();

// Para que __filename y __dirname funcionen en ES_MODULES
const __filename = fileURLToPath(import.meta.url);
const __dirname  = path.dirname(__filename);

// El puerto se coje de la variable de entorno para que sea coherente con el resto del setup
const PORT = process.env.PORT || 3000;

// Configurar el motor de plantillas para que use EJS
app.set('view engine', 'ejs');
app.set('views', path.join(__dirname, 'views'));

// Configurar donde guardamos los documentos estáticos
app.set(express.static(path.join(__dirname, 'public')));


// ====> RUTAS
app.get('/', (req,res) => {
    res.render('index',{
        nombre: "Luis"
    });
});

app.use('/receta', recetasRouter);

app.listen(PORT, '0.0.0.0', () => {
    console.log(`🚀 Servidor Express corriendo en http://localhost:${PORT}`);
});
