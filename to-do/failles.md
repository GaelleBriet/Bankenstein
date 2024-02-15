# Failles de sécurité

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
