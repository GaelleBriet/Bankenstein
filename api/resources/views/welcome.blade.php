<!doctype html>
<html>
<head>
  <title>Bankenstein API</title>
  <link rel="stylesheet" href="https://fonts.bunny.net/css2?family=Nunito:wght@400;600;700&display=swap">

  <!-- Scripts -->
  @vite(['resources/css/app.css', 'resources/js/app.js'])

  <style>
    body {
      background: #161616;
    }

    h1 {
      margin-top: 50px;
      color: white !important;
      font-size: 2rem;
    }

    h2 {
      color: white;
      margin-top: 50px;
    }

    .description {
        color: white;
        margin-bottom: 50px;
    }

    code {
      background-color: #161616;
      padding: 5px;
      display: inline-block;
      border-radius: 5px;
    }

    code.white {
        background-color: white;
        color: black;
        padding: 0 3px;
    }

    table {
        margin-bottom: 50px;
    }

    .log-in-link {
        position: fixed;
        top: 10px;
        right: 20px;
        transition: all 0.2s ease-in-out;
    }

    .log-in-link:hover {
        text-decoration: underline;
    }


  </style>
</head>
<body>
  <!-- all classes of page are tailwindcss -->

  <h1 class="
    font-bold
    text-center
    text-gray-800
    mt-10
    mb-10
  ">Bankenstein API Documentation</h1>



  <div class="container mx-auto" style="max-width: 1350px;">

    <a href="/login" class="log-in-link text-white">Log in</a>

    <h2>Endpoints</h2>

    <p class="description">
      Tous les endpoints de l'API ont besoin d'un token, sauf <code class="white">/api/login</code> qui permet de se connecter et récupérer un token. Pour récupérer un token, il faut envoyer un POST à <code class="white">/api/login</code> avec un email et un mot de passe. Le token doit être envoyé dans le header de la requête avec la clé <code class="white">Authorization</code> et la valeur <code class="white">Bearer {token}</code>.
    </p>

    <p class="description">
      Les montants sont stockés en centimes d'euros, il faut donc les diviser par 100 pour obtenir le montant en euros.
    </p>

    <table class="w-full text-sm text-left text-white dark:text-white">
      <thead class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
        <tr>
          <th>Route</th>
          <th>Méthode</th>
          <th>Description</th>
          <th>Payload</th>
          <th>Retour</th>
        </tr>
      </thead>
      <tbody>
        <tr class="bg-white border-b dark:bg-gray-800 dark:border-gray-700">
          <td class="py-4 px-6"><code>/api/login</code></td>
          <td class="py-4 px-6">POST</td>
          <td class="py-4 px-6">Connecte un utilisateur à son compte</td>
          <td class="py-4 px-6">
            <pre><code>{
    "email": "email@email.com",
    "password": "password"
}
</code></pre>
          </td>
          <td class="py-4 px-6"><code>{access_token: string}</code></td>
        </tr>
        <tr class="bg-white border-b dark:bg-gray-800 dark:border-gray-700">
          <td class="py-4 px-6"><code>/api/me</code></td>
          <td class="py-4 px-6">GET</td>
          <td class="py-4 px-6">Récupère les informations de l'utilisateur connecté</td>
          <td class="py-4 px-6">---</td>
          <td class="py-4 px-6">
            <pre>
<code>{
    id: int,
    name: string,
    email: string
}
</code></pre>
          </td>
        </tr>
        <tr class="bg-white border-b dark:bg-gray-800 dark:border-gray-700">
          <td class="py-4 px-6"><code>/api/me/recipients</code></td>
          <td class="py-4 px-6">GET</td>
          <td class="py-4 px-6">Récupère les bénéficiaires de l'utilisateur connecté</td>
          <td class="py-4 px-6">---</td>
          <td class="py-4 px-6">
            <pre><code>[
    {
        id: int,
        account_id: int,
        user_id: int,
        name: string,
        iban: string
    }
]</code></pre></td>
        </tr>
        <tr class="bg-white border-b dark:bg-gray-800 dark:border-gray-700">
          <td class="py-4 px-6"><code>/api/me/accounts</code></td>
          <td class="py-4 px-6">GET</td>
          <td class="py-4 px-6">Récupère les comptes bancaires de l'utilisateur connecté</td>
          <td class="py-4 px-6">---</td>
          <td class="py-4 px-6">
<pre><code>[
    {
        id: int,
        user_id: int,
        name: string,
        balance: int,
        iban: string
    }
]</code></pre></td>
        </tr>
        <tr class="bg-white border-b dark:bg-gray-800 dark:border-gray-700">
          <td class="py-4 px-6"><code>/api/me/accounts/{account}</code></td>
          <td class="py-4 px-6">GET</td>
          <td class="py-4 px-6">Récupère le détail d'un compte bancaire</td>
          <td class="py-4 px-6">---</td>
          <td class="py-4 px-6">
<pre><code>{
    id: int,
    user_id: int,
    name: string,
    balance: int,
    iban: string
}</code></td>
        </tr>
        <tr class="bg-white border-b dark:bg-gray-800 dark:border-gray-700">
          <td class="py-4 px-6"><code>/api/me/accounts/{account}/transactions</code></td>
          <td class="py-4 px-6">GET</td>
          <td class="py-4 px-6">Récupère les transactions d'un compte bancaire</td>
          <td class="py-4 px-6">---</td>
          <td class="py-4 px-6">
<pre><code>[
    {
        id: int,
        from_account_id: int,
        to_account_id: int,
        amount: int,
        date: string,
        name: string
    }
]</code></td>
        </tr>
        <tr class="bg-white border-b dark:bg-gray-800 dark:border-gray-700">
          <td class="py-4 px-6"><code>/api/me/recipients/add</code></td>
          <td class="py-4 px-6">POST</td>
          <td class="py-4 px-6">Ajoute un bénéficiaire à l'utilisateur connecté</td>
          <td class="py-4 px-6">
<pre><code>{
    "name": "Nom bénéficiaire",
    "iban": "FR76 XXXX XXXX XXXX XXXX XXX"
}</code></pre></td>
          <td class="py-4 px-6">
<pre><code>{
    id: int,
    account_id: int,
    user_id: int,
    name: string,
    iban: string
}</code></pre></td>
        </tr>
        <tr class="bg-white border-b dark:bg-gray-800 dark:border-gray-700">
          <td class="py-4 px-6"><code>/api/me/recipients/{id}/delete</code></td>
          <td class="py-4 px-6">GET</td>
          <td class="py-4 px-6">Supprime un bénéficiaire de l'utilisateur connecté</td>
          <td class="py-4 px-6">---</td>
          <td class="py-4 px-6">---</td>
        </tr>
        <tr class="bg-white border-b dark:bg-gray-800 dark:border-gray-700">
          <td class="py-4 px-6"><code>/api/me/transactions/create</code></td>
          <td class="py-4 px-6">POST</td>
          <td class="py-4 px-6">Crée une transaction entre deux comptes</td>
          <td class="py-4 px-6">
<pre><code>{
    "from_account_id": 1,
    "to_account_id": 2,
    "amount": 100,
    "name": "Nom de la transaction",
    "date": "2020-01-01 00:00:00"
}</code></pre></td>
          <td class="py-4 px-6">
<pre><code>{
    id: int,
    from_account_id: int,
    to_account_id: int,
    amount: int,
    date: string,
    name: string
}</code></pre></td>
        </tr>
      </tbody>
    </table>
  </div>
</body>
</html>
