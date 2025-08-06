-- Inserción usuarios
INSERT INTO usuarios (NOMBRE, APELLIDO, FECHA_NACIMIENTO, CORREO) VALUES
('Laura', 'Gomez', '1990-05-15', 'lauragomez@gmail.com'),
('Carlos', 'Díaz', '1985-08-22', 'carlosdiaz@gmail.com'),
('Ana', 'Torres', '1992-12-30', 'anatorres@gmail.com'),
('Jorge', 'Martínez', '1988-03-10', 'jorgemartinez@gmail.com'),
('Sandra', 'Pérez', '1995-07-25', 'sandraperez@gmail.com');

-- Inserción categorías
INSERT INTO categorias (nombre) VALUES
('Trabajo'), ('Estudio'), ('Personal'), ('Salud'), ('Compras');

-- Inserción tareas
INSERT INTO tareas (TITULO, DESCRIPCION, ESTADO, PRIORIDAD, USUARIO_ID) VALUES
('Revisar informe', 'Revisar el informe financiero del mes', 'pendiente', 'alta', 1),
('Estudiar SQL', 'Aprender comandos básicos de SQL', 'en_progreso', 'media', 2),
('Ir al médico', 'Chequeo anual general', 'pendiente', 'alta', 3),
('Comprar víveres', 'Lista de compras para la semana', 'completada', 'media', 4),
('Enviar reporte', 'Enviar reporte al jefe antes del viernes', 'pendiente', 'alta', 5),
('Hacer ejercicio', '30 minutos de ejercicio matutino', 'pendiente', 'baja', 1),
('Preparar presentación', 'Preparar la presentación para el equipo', 'en_progreso', 'media', 2),
('Llamar al cliente', 'Llamar al cliente para confirmar la cita', 'pendiente', 'alta', 3),
('Hacer la compra', 'Lista de compras para la casa', 'completada', 'media', 4),
('Enviar correo', 'Enviar correo electrónico al jefe', 'pendiente', 'alta', 5);
INSERT INTO tareas (TITULO, DESCRIPCION, ESTADO, PRIORIDAD, USUARIO_ID) VALUES
('Comprar víveres', 'Lista de compras para la semana', 'completada', 'media', 4),
('Enviar reporte', 'Enviar reporte al jefe antes del viernes', 'pendiente', 'alta', 5),
('Hacer ejercicio', '30 minutos de ejercicio matutino', 'pendiente', 'baja', 1),
('Preparar presentación', 'Preparar la presentación para el equipo', 'en_progreso', 'media', 2),
('Llamar al cliente', 'Llamar al cliente para confirmar la cita', 'pendiente', 'alta', 3);

-- Relación tareas y categorías
INSERT INTO TAREAS_CATEGORIAS (TAREA_ID, CATEGORIA_ID) VALUES
(1, 1), (2, 2), (3, 4), (4, 5), (5, 1),
(6, 3), (7, 3), (8, 2), (9, 1), (10, 4),
(11, 3), (12, 3), (13, 2), (14, 5), (15, 1);

-- 1. Obtener todas las tareas de un usuario específico (por ID)
SELECT * FROM tareas WHERE usuario_id = 2;

-- 2. Filtrar tareas por estado o prioridad
SELECT * FROM tareas WHERE estado = 'completada';
SELECT * FROM tareas WHERE prioridad = 'alta';

-- 3. Listar tareas que pertenecen a una categoría específica
SELECT t.*
FROM tareas t
JOIN tareas_categorias tc ON t.id = tc.tarea_id
JOIN categorias c ON c.id = tc.categoria_id
WHERE c.nombre = 'Trabajo';

-- 4. Contar cuántas tareas están completadas por cada usuario
SELECT u.nombre, COUNT(*) AS tareas_completadas
FROM tareas t
JOIN usuarios u ON t.usuario_id = u.id
WHERE t.estado = 'completada'
GROUP BY u.nombre;

-- 5. Ver todas las tareas con un usuario
SELECT t.id, t.titulo, t.descripcion, t.estado, t.prioridad, u.nombre
FROM tareas t
JOIN usuarios u ON t.usuario_id = u.id;

-- 6. Ver tareas con sus categorías.
SELECT t.titulo, c.nombre AS categoria
FROM tareas t
JOIN tareas_categorias tc ON t.id = tc.tarea_id
JOIN categorias c ON c.id = tc.categoria_id;


