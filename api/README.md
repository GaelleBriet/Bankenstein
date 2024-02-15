# Bankenstein API

## Introduction

Bienvenue sur la documentation de l'API de Bankenstein.

Cette API est développée en Laravel. Elle est utilisée par l'application multiplateforme Bankenstein. L'API permet entre autre de : 
- Connecter un utilisateur à son compte
- Récupérer les comptes bancaires liés à l'utilisateur connecté
- Récupérer le détail d'un compte bancaire
- Récupérer les transactions d'un compte bancaire
- Récupérer les bénéficiaires d'un utilisateur

Le projet fonctionne avec l'image Docker dédié à Laravel de Bitnami.

## Installation du projet

Le projet peut être lancé avec Docker via les commandes suivantes :

```bash
cp ./.env.example ./.env
# On Windows : copy .\.env.example .\.env 
docker compose up -d --build
```

⚠️ Attention de bien lancer la commande depuis le répertoire courant (et d'effectuer la commande `cd to-do` si toujours à la racine du dépôt).

### Accès

L'API est accessible à l'adresse : `http://localhost:8000`

Pour se connecter, il y a un utilisateur par apprenant de la promotion. Les identifiants sont vos addresses email (O'Clock) et le mot de passe est `password`.

Les données de l'API sont librement modifiables. Il est, par exemple, possible d'ajouter des comptes bancaires, des bénéficiaires, des transactions, etc. Chacun est libre de modifier les données à sa guise.

## Documentation

### Format des données

Les montants sont en centimes d'euros. Par exemple, 100€ = 10000.
Il faut également envoyer des centimes d'euros à l'API lors de la création de transactions.

### Routes

| Route                                     | Méthode | Description                                              | Payload                                                                                                         | Retour                                                                                           |
|-------------------------------------------|---------|----------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------|
| `/api/login`                              | POST    | Connecte un utilisateur à son compte                     | `{"email": "email@email.com", "password": "password"`                                                           | `{access_token: string}`                                                                         |
| `/api/me`                                 | GET     | Récupère les informations de l'utilisateur connecté      | ---                                                                                                             | `{id: int, name: string, email: string}`                                                         |
| `/api/me/recipients`                      | GET     | Récupère les bénéficiaires de l'utilisateur connecté     | ---                                                                                                             | `[{id: int, accountId: int, user_id: int, name: string, iban: string}]`                          |
| `/api/me/accounts`                        | GET     | Récupère les comptes bancaires de l'utilisateur connecté | ---                                                                                                             | `[{id: int, user_id: int, name: string, balance: int, iban: string}]`                            |
| `/api/me/accounts/{account}`              | GET     | Récupère le détail d'un compte bancaire                  | ---                                                                                                             | `{id: int, user_id: int, name: string, balance: int, iban: string}`                              |
| `/api/me/accounts/{account}/transactions` | GET     | Récupère les transactions d'un compte bancaire           | ---                                                                                                             | `[{id: int, from_account_id: int, to_account_id: int, amount: int, date: string, name: string}]` |
| `/api/me/recipients/add`                  | POST    | Ajoute un bénéficiaire à l'utilisateur connecté          | `{"name": "Nom bénéficiaire", "iban": "FR76-XXXX-XXXX-XXXX-XXXX-XXX}`                                           | `{id: int, accountId: int, user_id: int, name: string, iban: string}`                            |
| `/api/me/recipients/delete`               | GET     | Supprime un bénéficiaire de l'utilisateur connecté       | `{"id": 1}`                                                                                                     | ---                                                                                              |
| `/api/me/transactions/create`             | POST    | Crée une transaction entre deux comptes                  | `{"from_account_id": 1, "to_account_id": 2, "amount": 100, "name": "Nom de la transaction", "date": timestamp}` | `{id: int, from_account_id: int, to_account_id: int, amount: int, date: string, name: string}`   |



