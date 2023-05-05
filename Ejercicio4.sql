/* Esta vez requerimos gestionar los datos de nuestra aplicación. Antes de comenzar, recordemos ciertos conceptos.

1.-¿Qué es una transacción en MySql? Definalo y escriba un ejemplo.

R: Una transacción en MySQL es un conjunto de operaciones que se realizan como una única unidad lógica de trabajo, 
es decir, se ejecutan como un bloque y si ocurre un error en alguna de las operaciones, 
todas las operaciones realizadas en la transacción son deshechas o "deshacen", 
de tal forma que la base de datos no queda en un estado inconsistente. 
Por ejemplo, si se realiza una transacción para transferir dinero de una cuenta bancaria a otra, 
se asegura que si ocurre algún error, la operación no se realizará y las cuentas bancarias implicadas no se modificarán.

2.-Qué beneficios tiene para la consistencia de los datos, ejecutar transacciones.

R: La ejecución de transacciones en una base de datos MySQL ayuda a mantener la consistencia y 
la integridad de los datos al garantizar que las operaciones se completen en su totalidad o 
se deshagan por completo en caso de que ocurra un error. 
Si una transacción no se completa con éxito, todas las operaciones realizadas durante la transacción se 
deshacen automáticamente, lo que garantiza que la base de datos se mantenga en un estado coherente y predecible. 
Además, las transacciones pueden ser utilizadas para coordinar el acceso concurrente a los datos y 
evitar conflictos entre transacciones concurrentes que pueden causar inconsistencias en la base de datos.

3.-¿Qué propiedades tienen las transacciones? Definirlas.

R: Las propiedades de las transacciones en MySQL son las siguientes:

    -Atomicidad: garantiza que una transacción se trata como una unidad completa y, por lo tanto, todas las operaciones en la transacción se realizan o ninguna. Si alguna operación falla, todas las operaciones de la transacción se deshacen.

    -Consistencia: asegura que una transacción lleva la base de datos desde un estado válido a otro estado válido.

    -Aislamiento: asegura que las transacciones se ejecutan en un entorno aislado, lo que significa que los cambios realizados por una transacción no son visibles para otras transacciones hasta que se haya completado.

    -Durabilidad: garantiza que una vez que una transacción se ha confirmado, los cambios realizados por la transacción se mantendrán incluso en caso de falla del sistema.

En resumen, estas propiedades aseguran que las transacciones se ejecuten de manera confiable y consistente, protegiendo la integridad de los datos y evitando situaciones de lectura sucia, escritura sucia y otros problemas de concurrencia.

4.-Qué utilidades tienen las sentencias START TRANSACTION, COMMIT y ROLLBACK.

R: Las sentencias START TRANSACTION, COMMIT y ROLLBACK son esenciales en la gestión de transacciones en bases de datos MySQL.

    -START TRANSACTION se utiliza para iniciar una transacción.
    -COMMIT se utiliza para confirmar una transacción. Si todas las operaciones realizadas dentro de la transacción se han completado correctamente, la transacción se confirma y los cambios se guardan de forma permanente en la base de datos.
    -ROLLBACK se utiliza para deshacer una transacción. Si alguna de las operaciones realizadas dentro de la transacción falla, se deshacen todos los cambios realizados y la base de datos vuelve a su estado anterior a la transacción.

Estas sentencias son útiles para garantizar la integridad y consistencia de los datos al realizar múltiples operaciones en la base de datos como una sola unidad atómica. Si algo sale mal durante la transacción, se puede deshacer y volver a un estado coherente. Por otro lado, si todas las operaciones se realizan correctamente, se pueden confirmar como una sola unidad coherente.

5.-En términos de sintaxis ¿Cuándo finaliza una transacción?

R: En términos de sintaxis, una transacción en MySQL finaliza cuando se ejecuta la sentencia COMMIT o ROLLBACK. 
La sentencia COMMIT confirma los cambios realizados en la transacción y los guarda permanentemente en la base de datos, 
mientras que la sentencia ROLLBACK revierte los cambios y deshace la transacción. 
Si no se ejecuta ninguna de estas dos sentencias, la transacción seguirá abierta y los cambios realizados no se guardarán permanentemente en la base de datos.
*/

-- Crear una base de datos
create database Ejercicio4;
use Ejercicio4;
-- Crear un usuario con todos los privilegios para trabajar con la base de datos recién creada.
CREATE USER 'admin'@'localhost' IDENTIFIED BY 'admin';
GRANT ALL PRIVILEGES ON Ejercicio4.* TO 'admin'@'localhost';

/* Crea dos tablas en la base de datos. La primera almacena todos los usuarios sin una
participación activa en tu aplicación y la segunda agrupa a los usuarios que son considerados
especiales, debido a su alta participación en tu aplicación web.*/

CREATE TABLE usuarios_inactivos (
  id INT PRIMARY KEY,
  nombre VARCHAR(50),
  apellido VARCHAR(50),
  correo_electronico VARCHAR(100),
  telefono VARCHAR(20),
  genero ENUM('M', 'F', 'O')
);

CREATE TABLE usuarios_especiales (
  id INT PRIMARY KEY,
  nombre VARCHAR(50),
  apellido VARCHAR(50),
  correo_electronico VARCHAR(100),
  telefono VARCHAR(20),
  genero ENUM('M', 'F', 'O')
);
-- La primera tabla debe tener 5 usuarios en un comienzo.
INSERT INTO usuarios_inactivos (nombre, apellido, correo_electronico, telefono, genero)
VALUES 
  ('Juan', 'Pérez', 'juanperez@gmail.com', '123456789', 'M'),
  ('María', 'González', 'mariagonzalez@gmail.com', '987654321', 'F'),
  ('Pedro', 'Rodríguez', 'pedrorodriguez@gmail.com', NULL, 'M'),
  ('Laura', 'López', 'lauralopez@gmail.com', '55555555', 'F'),
  ('Carlos', 'Gómez', 'carlosgomez@gmail.com', '999999999', 'M');

-- Transfiera tres usuarios desde la primera tabla a la segunda.
START TRANSACTION;
INSERT INTO usuarios_especiales (id, nombre, apellido, correo_electronico, telefono, genero)
    SELECT id, nombre, apellido, correo_electronico, telefono, genero
    FROM usuarios_inactivos
    WHERE id IN (1, 2, 3);
DELETE FROM tabla1 WHERE id IN (1, 2, 3);
commit;
-- Anule la transferencia del tercer usuario.
ROLLBACK;










