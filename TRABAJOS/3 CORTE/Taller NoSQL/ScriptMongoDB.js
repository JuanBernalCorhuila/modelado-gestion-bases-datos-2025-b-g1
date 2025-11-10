// Creación de base de datos y colecciones
use RedSocialMas;

// Insertar Documentos
// Colección usuarios
db.usuarios.insertMany([
  { _id: "u1", nombre: "Juan Camilo", usuario: "Camilo_B", correo: "juan@gmail.com" },
  { _id: "u2", nombre: "Maria Gimenez", usuario: "Mari_G", correo: "mari_gimenez@gmail.com" },
  { _id: "u3", nombre: "Cristian Guerrero", usuario: "CGuerrero", correo: "guerrerito@gmail.com" },
  { _id: "u4", nombre: "Karol Reyes", usuario: "Karitol", correo: "karol_r@gmail.com" },
  { _id: "u5", nombre: "Jose Rodriguez", usuario: "JotaR", correo: "josee@gmail.com" }
]);

// Colección publicaciones
db.publicaciones.insertMany([
  {
    _id: "p1",
    usuarioId: "u1",
    contenido: "Esta es mi primera publicación en la app",
    fecha: ISODate("2025-11-08T10:00:00Z"),
    comentarios: [
      { autor: "Maria Gimenez", texto: "Excelente publicación, me encantó", fecha: ISODate("2025-11-08T10:05:00Z") }
    ]
  },
  {
    _id: "p2",
    usuarioId: "u2",
    contenido: "Iniciando en MongoDB",
    fecha: ISODate("2025-11-08T10:15:00Z"),
    comentarios: []
  },
  {
    _id: "p3",
    usuarioId: "u3",
    contenido: "Probando con mi familia RedSocial+",
    fecha: ISODate("2025-11-08T11:00:00Z"),
    comentarios: []
  },
  {
    _id: "p4",
    usuarioId: "u4",
    contenido: "Hola a Todos, como van?",
    fecha: ISODate("2025-11-09T09:00:00Z"),
    comentarios: []
  },
  {
    _id: "p5",
    usuarioId: "u5",
    contenido: "Al mi parecer MongoDB es muy flexible",
    fecha: ISODate("2025-11-09T10:30:00Z"),
    comentarios: []
  }
]);

// Colección comentarios
db.comentarios.insertMany([
  { _id: "c1", publicacionId: "p1", autorId: "u2", texto: "Me parece buena app", fecha: ISODate("2025-11-08T10:10:00Z") },
  { _id: "c2", publicacionId: "p2", autorId: "u1", texto: "Estupendo ese avance", fecha: ISODate("2025-11-08T10:20:00Z") },
  { _id: "c3", publicacionId: "p3", autorId: "u4", texto: "La aplicación es muy intuitiva y buena", fecha: ISODate("2025-11-08T11:30:00Z") },
  { _id: "c4", publicacionId: "p4", autorId: "u5", texto: "Bien Gracias a Dios", fecha: ISODate("2025-11-09T09:10:00Z") },
  { _id: "c5", publicacionId: "p5", autorId: "u3", texto: "Eso es verdad", fecha: ISODate("2025-11-09T10:35:00Z") }
]);

// Colección reacciones
db.reacciones.insertMany([
  { _id: "r1", publicacionId: "p1", usuarioId: "u2", tipo: "like" },
  { _id: "r2", publicacionId: "p2", usuarioId: "u1", tipo: "love" },
  { _id: "r3", publicacionId: "p3", usuarioId: "u4", tipo: "like" },
  { _id: "r4", publicacionId: "p4", usuarioId: "u5", tipo: "wow" },
  { _id: "r5", publicacionId: "p5", usuarioId: "u1", tipo: "like" }
]);

// Colección seguidores
db.seguidores.insertMany([
  { _id: "s1", seguidorId: "u2", seguidoId: "u1" },
  { _id: "s2", seguidorId: "u1", seguidoId: "u2" },
  { _id: "s3", seguidorId: "u3", seguidoId: "u4" },
  { _id: "s4", seguidorId: "u4", seguidoId: "u5" },
  { _id: "s5", seguidorId: "u5", seguidoId: "u3" }
]);


// Operaciones CRUD


// Crear un nuevo usuario
db.usuarios.insertOne({ _id: "u6", nombre: "Juliana Puentes", usuario: "Juli", correo: "puentes_jl@gmail.com" });

// Leer publicaciones de un usuario
db.publicaciones.find({ usuarioId: "u5" });

// Actualizar un comentario
db.comentarios.updateOne(
  { _id: "c2" },
  { $set: { texto: "Eso está muy bien, ya verás que es intuitivo de usar" } }
);

// Eliminar una reacción
db.reacciones.deleteOne({ _id: "r3" });


// Consultas


// Listar publicaciones de un usuario
db.publicaciones.find({ usuarioId: "u2" });

// Obtener comentarios de una publicación
db.comentarios.find({ publicacionId: "p4" });

// Contar reacciones de tipo "wow"
db.reacciones.countDocuments({ tipo: "wow" });
