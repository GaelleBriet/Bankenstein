# Failles de sécurité

## 1 - Injections SQL

- fichier : `index.ts`
- lignes : 48, 71, 103, 117

```javascript
  const query = `SELECT * FROM users WHERE username = '${req.body.username}' AND password = '${req.body.password}'`;

  const query = `SELECT * FROM todos WHERE todos.user_id = ${userId} ORDER BY todos.id`;

  const query = `DELETE FROM todos WHERE id = ${req.params.id}`;

  const query = `UPDATE todos SET content = $1 WHERE todos.id = $2`;
  await database.query(query, [req.body.content, req.params.id]);
```

____

## 2 - Mots de passe ne sont pas hachés

 - fichier : `index.ts`
 - ligne : 46
 et 
 - fichier : `init.sql`
 - ligne : 15

 ```javascript
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
```

```
    INSERT INTO users (username, password) VALUES ('admin', 'admin');
```
_____

## 3 - Pas de validation des données utilisateurs

 - fichier : `index.ts`
 - lignes : 46, 68, 86, 101, 115

```javascript
  app.post("/login", async function (req, res) {
    try {
      const query = `SELECT * FROM users WHERE username = '${req.body.username}' AND password = '${req.body.password}'`;
      const {rows: users} = await database.query(query);
  });
  app.get("/todo", async function (req, res) {
  try {
    const userId = req.session.user?.id;
    const query = `SELECT * FROM todos WHERE todos.user_id = ${userId} ORDER BY todos.id`;
    const {rows: todos} = await database.query(query);
  });
  app.post("/addTodo", async function (req, res) {
  try {
    const userId = req.session.user?.id;
    const query = `INSERT INTO todos (content, user_id) VALUES ($1, $2)`;
  });
  app.get("/removeTodo/:id", async function (req, res) {
    try {
      const query = `DELETE FROM todos WHERE id = ${req.params.id}`;
      await database.query(query);
  });
  app.post("/updateTodo/:id", async function (req, res) {
    try {
      const query = `UPDATE todos SET content = $1 WHERE todos.id = $2`;
      await database.query(query, [req.body.content, req.params.id]);
  });
  ```
____

## 4 - Gestion des sessions utilisateur

 - fichier : `index.ts`
 - lignes : 51-52

```javascript
    if (users.length) {
      req.session.user = users[0];
```
_____

## 5 - Pas de protection CSRF

 - fichier : `views/index.ejs`
 - lignes : 16

```javascript
  <form action="/login" method="post">
```
 ____

## 6 - Pas de verification de complexite du MdP en front

 - fichier : `views/index.ejs`
 - lignes : 21

```javascript
  <div class="field">
    <label class="label" for="password">Mot de passe</label>
    <input class="input" id="password" name="password" type="password" placeholder="********">
  </div>
```
  ____

## 7 - Faille XSS

 - fichier : `views/todo.ejs`
 - lignes : 26

```javascript
    <%- todo.content %>
```
____

<blockquote>

## Exemple

Le code laisse passer des injections SQL, car il n'a pas vérifié le contenu de la donnée fournie par l'utilisateur.

- fichier : `src/Models/Car.php`
- ligne : 215

```php
$plate = $_POST['plate']; // donnée brute récupérée, sans filtre ni validation
$model = $_POST['model']; // donnée brute récupérée, sans filtre ni validation
$brand = $_POST['brand']; // donnée brute récupérée, sans filtre ni validation
// Quand on génère la requête SQL, on laisse chaque donnée brute, laissant passer l'injection de code SQL
$sql = 'INSERT INTO car (brand, model, plate) VALUES (\'' . $brand . \', \'' . $model . \', \'' . $plate . \')';
$pdo->exec($sql);
```

</blockquote>
