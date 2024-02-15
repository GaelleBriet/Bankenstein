# To'Do

Le projet To'Do est un outil de gestion des tâches permettant d'ajouter, modifier et supprimer des tâches à effectuer.

## Installation du projet

Le projet peut être lancé avec Docker via les commandes suivantes :

```bash
cp ./.env.example ./.env
# On Windows : copy .\.env.example .\.env 
docker compose up -d --build
```

⚠️ Attention de bien lancer la commande depuis le répertoire courant (et d'effectuer la commande `cd to-do` si toujours à la racine du dépôt).

## Architecture

Le projet est décomposé en 3 parties :

- Une base de données PostgreSQL (initialisée au lancement des conteneurs via Docker)
- Une base de données Redis -permettant une persistance des sessions lorsque le serveur redémarre)
- Un serveur Node.js (avec Express) écrit en TypeScript

Le point d'entrée du serveur Node.js est le fichier [index.ts](./index.ts).

## Informations

Le développeur n'a pas eu le temps de s'occuper de la création de comptes utilisateur.  
Il a créé à la main un compte ayant pour identifiants de connexion :
- Identifiant : `admin`  
- Mot de passe : `admin`.

(On peut consulter le script d'initialisation au sein du fichier [init.sql](./init.sql).)