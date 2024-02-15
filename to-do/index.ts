import express from "express";
import database from "./database";
import session from "express-session";
import connectRedis from "connect-redis";
import { createClient } from "redis";

const REDIS_PORT = process.env.REDIS_PORT || 6379;
const PORT = process.env.APP_PORT || 3000;

// Création de l'application express
const app = express();

// Initialisation de la connection au Redis
const redisClient = createClient({
  url: `redis://redis:${REDIS_PORT}`,
  legacyMode: true
});
redisClient.connect().catch(console.error);
const RedisStore = connectRedis(session);

// On spécifie le dossier où sont stockées les vues ainsi que le moteur de template utilisé (ejs)
app.set("views", "./views");
app.set("view engine", "ejs");

// On utilise un système de session avec une persistance dans une BDD de type Redis
app.use(session({
  store: new RedisStore({client: redisClient}),
  secret: process.env.SESSION_SECRET || "toto",
  resave: false,
  saveUninitialized: true,
  cookie: {}
}));

// On utilise un middleware pour comprendre le format de donnée urlencoded (utiliser par les balises form en html)
app.use(express.urlencoded({extended: true}));

// On rend également des fichiers static (tel qu'elle sans faire de traitement)
app.use(express.static("static"));

// Ma page d'accueil avec la connection
app.get("/", function (req, res) {
  res.render("index");
});

// Route correspondant à la soumission du formulaire de connection
app.post("/login", async function (req, res) {
  try {
    const query = `SELECT * FROM users WHERE username = '${req.body.username}' AND password = '${req.body.password}'`;
    const {rows: users} = await database.query(query);

    if (users.length) {
      req.session.user = users[0];
      res.redirect("/todo");
    } else {
      res.render("index", {
        errorMessage: "Utilisateur non trouvé"
      });
    }

  } catch (e) {
    res.render("index", {
      errorMessage: "Une erreur est survenue"
    });
  }
});

// Affichage de ma liste de todos
app.get("/todo", async function (req, res) {
  try {
    const userId = req.session.user?.id;
    const query = `SELECT * FROM todos WHERE todos.user_id = ${userId} ORDER BY todos.id`;
    const {rows: todos} = await database.query(query);

    res.render("todo", {
      todos
    });
  } catch (e) {
    res.render("todo", {
      todos: [],
      errorMessage: "Impossible de récupérer la liste de todo"
    });
  }
});

// Route correspondant à la soumission du formulaire d'ajout de todo
app.post("/addTodo", async function (req, res) {
  try {
    const userId = req.session.user?.id;
    const query = `INSERT INTO todos (content, user_id) VALUES ($1, $2)`;
    await database.query(query, [req.body.content, userId]);
    res.redirect("/todo");
  } catch (e) {
    res.render("todo", {
      todos: [],
      errorMessage: "Erreur lors de l'ajout d'une tâche"
    });
  }
});

// Route correspondant à la suppression d'un todo
app.get("/removeTodo/:id", async function (req, res) {
  try {
    const query = `DELETE FROM todos WHERE id = ${req.params.id}`;
    await database.query(query);
    res.redirect("/todo");
  } catch (e) {
    res.render("todo", {
      todos: [],
      errorMessage: "Erreur lors de la suppression"
    });
  }
});

// Route correspondant à la modification d'un todo
app.post("/updateTodo/:id", async function (req, res) {
  try {
    const query = `UPDATE todos SET content = $1 WHERE todos.id = $2`;
    await database.query(query, [req.body.content, req.params.id]);
    res.redirect("/todo");
  } catch (e) {
    res.render("todo", {
      todos: [],
      errorMessage: "Erreur lors de la suppression"
    });
  }
});

// Je démarre mon serveur express
app.listen(PORT, function () {
  console.log(`app started at http://localhost:${PORT}`);
});
