const express = require('express');
const swaggerUi = require('swagger-ui-express');
const fs = require('fs');
const YAML = require('yaml');
const app = express();

app.use(express.json());

// Cargar Swagger
const file = fs.readFileSync('./swagger.json', 'utf8');
const swaggerDocument = YAML.parse(file);

// Rutas CRUD mock (sin base de datos)
app.get('/peliculas', (req, res) => {
  res.json([{ id: 1, titulo: 'El Padrino', genero: 'Drama', año: 1972, director: 'Francis Ford Coppola' }]);
});

app.get('/peliculas/:id', (req, res) => {
  res.json({ id: req.params.id, titulo: 'El Padrino', genero: 'Drama', año: 1972, director: 'Francis Ford Coppola' });
});

app.post('/peliculas', (req, res) => {
  res.status(201).json({ message: 'Película creada' });
});

app.get('/clientes', (req, res) => {
  res.json([{ id: 1, nombre: 'Carlos López', email: 'carlos@email.com', telefono: '0987654321' }]);
});

app.get('/generos', (req, res) => {
  res.json([{ id: 1, nombre: 'Drama' }]);
});

app.get('/alquileres', (req, res) => {
  res.json([{ id: 1, fechaAlquiler: '2024-08-01', fechaDevolucion: '2024-08-03', clienteId: 1, peliculaId: 1 }]);
});

app.get('/empleados', (req, res) => {
  res.json([{ id: 1, nombre: 'Ana Martínez', cargo: 'Vendedor' }]);
});

app.get('/inventario', (req, res) => {
  res.json([{ id: 1, peliculaId: 1, copiasDisponibles: 3, copiasTotales: 5 }]);
});

app.get('/devoluciones', (req, res) => {
  res.json([{ id: 1, alquilerId: 1, fechaDevolucion: '2024-08-03', estado: 'devuelto' }]);
});

// Ruta de ejemplo distribuido con FDW
app.get('/peliculas/:id/inventario', (req, res) => {
  res.json({
    pelicula: { id: req.params.id, titulo: 'El Padrino', genero: 'Drama', año: 1972 },
    inventario: [
      { id: 1, copiasDisponibles: 3, copiasTotales: 5 },
      { id: 2, copiasDisponibles: 1, copiasTotales: 2 }
    ]
  });
});

// Swagger docs
app.use('/docs', swaggerUi.serve, swaggerUi.setup(swaggerDocument));

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`API de Tienda de Películas escuchando en http://localhost:${PORT}`);
}); 