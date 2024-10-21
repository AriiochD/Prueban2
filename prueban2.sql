DROP DATABASE IF EXISTS PruebaN2;
CREATE DATABASE IF NOT EXISTS PruebaN2;
USE PruebaN2;

CREATE TABLE ciudades (
  id INT AUTO_INCREMENT,
  nombre VARCHAR(225) NOT NULL,
  clima VARCHAR(255) NOT NULL,
  PRIMARY KEY (id) );
  
  CREATE TABLE monedas (
  id INT AUTO_INCREMENT,
  nombre VARCHAR(255) NOT NULL,
  simbolo VARCHAR(10) NOT NULL,
  PRIMARY KEY (id) );
  
  CREATE TABLE tasas_de_cambio (
  id INT AUTO_INCREMENT,
  moneda_id INT NOT NULL,
  tasa_de_cambio DECIMAL(10, 4) NOT NULL,
  fecha DATE NOT NULL,
  PRIMARY KEY (id),
  FOREIGN KEY (moneda_id) REFERENCES monedas(id) );
  
  CREATE TABLE ciudades_monedas (
  ciudad_id INT NOT NULL,
  moneda_id INT NOT NULL,
  PRIMARY KEY (ciudad_id, moneda_id),
  FOREIGN KEY (ciudad_id) REFERENCES ciudades(id),
  FOREIGN KEY (moneda_id) REFERENCES monedas(id) );
  
  INSERT INTO ciudades (nombre, clima) VALUES
('Londres', 'Nublado'),
('New York', 'Soleado'),
('Paris', 'Lluvioso'),
('Tokyo', 'Nublado'),
('Madrid', 'Soleado');

INSERT INTO monedas (nombre, simbolo) VALUES
('Libra esterlina', '£'),
('Dólar estadounidense', '$'),
('Euro', '€'),
('Yen japonés', '¥'),
('Peso colombiano', '$');
  
  INSERT INTO tasas_de_cambio (moneda_id, tasa_de_cambio, fecha) VALUES
(1, 1.0000, '2024-10-20'),
(2, 1.2000, '2024-10-20'),
(3, 0.8800, '2024-10-20'),
(4, 0.0090, '2024-10-20'),
(5, 1.0000, '2024-10-20');

INSERT INTO ciudades_monedas (ciudad_id, moneda_id) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

-- consulta #1
SELECT c.nombre AS ciudad, t.fecha, t.tasa_de_cambio AS tasa, c.clima
FROM ciudades c
JOIN ciudades_monedas cm ON c.id = cm.ciudad_id
JOIN tasas_de_cambio t ON cm.moneda_id = t.moneda_id
WHERE c.nombre = 'paris' 
  AND t.fecha = CURDATE();

-- consulta #2
SELECT m.nombre AS moneda_local, m.simbolo
FROM ciudades c
JOIN ciudades_monedas cm ON c.id = cm.ciudad_id
JOIN monedas m ON cm.moneda_id = m.id
WHERE c.nombre = 'londres'; 

-- consulta #3
SELECT c.nombre AS ciudad, m.simbolo AS simbolo_moneda_local, ROUND(t.tasa_de_cambio * tu.presupuesto, 2) AS presupuesto_convertido
FROM ciudades c
JOIN ciudades_monedas cm ON c.id = cm.ciudad_id
JOIN monedas m ON cm.moneda_id = m.id
JOIN tasas_de_cambio t ON cm.moneda_id = t.moneda_id
CROSS JOIN (SELECT 1000000 AS presupuesto) AS tu -- presupuesto deseado en pesos colombianos
WHERE c.nombre = 'madrid'; -- nombre de la ciudad deseada

-- consulta #4
SELECT c.nombre AS ciudad,m.simbolo AS simbolo_moneda_local,t.tasa_de_cambio AS tasa_de_cambio_aplicada
FROM ciudades c
JOIN ciudades_monedas cm ON c.id = cm.ciudad_id
JOIN monedas m ON cm.moneda_id = m.id
JOIN tasas_de_cambio t ON cm.moneda_id = t.moneda_id
WHERE c.nombre = 'madrid'; 




