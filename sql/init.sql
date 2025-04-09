CREATE TABLE clientes (
  id INT PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(100),
  correo VARCHAR(100)
);

INSERT INTO clientes (nombre, correo) VALUES
('Ana Ruiz', 'ana@example.com'),
('Luis García', 'luis@example.com'),
('Carla Torres', 'carla@example.com');