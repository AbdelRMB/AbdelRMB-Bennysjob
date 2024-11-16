# AbdelRMB-bennysjob

![Version](https://img.shields.io/badge/version-1.0.0-blue)
![Author](https://img.shields.io/badge/author-AbdelRMB-green)

## 📋 Description

Cette ressource `AbdelRMB-bennysjob` est un job personnalisé pour **ESX/OX** destiné à gérer le garage Benny's dans le jeu FiveM. Le job permet aux joueurs de travailler comme mécaniciens, de réparer des véhicules...

---

## 📋 Dependencies

This menu relies on the following libraries:

- **AbdelRMBUI**: A flexible UI Menu management library.  
  [🔗 GitHub Repository](https://github.com/Abdelrmb/AbdelRMBUI)

- **AbdelRMB-Notify**: A notification system for sleek, customizable alerts.  
  [🔗 GitHub Repository](https://github.com/Abdelrmb/AbdelRMB-Notify)

- **esx_society**:  
  [🔗 GitHub Repository](https://github.com/esx-framework/esx_society)

---

## ⚙️ Installation

1. **Téléchargez** ou clonez la ressource dans votre dossier `resources`.

2. **Importez** le fichier SQL `AbdelRMB_bennysjob.sql` dans votre base de données.

3. **Ajoutez** la ligne suivante dans votre fichier `server.cfg` :

```
ensure AbdelRMBUI
ensure AbdelRMB-Notify
ensure AbdelRMB-bennysjob
```


4. **Vérifiez** que vous avez bien installé les dépendances suivantes :
- `es_extended`
- `ox_inventory`
- `esx_society`
- `AbdelRMBUI`

---

## ⚙️ Configuration

Le fichier `config.lua` contient divers paramètres que vous pouvez ajuster :

- `DrawDistance` : Distance à laquelle les marqueurs sont visibles.
- `MaxInService` : Limite du nombre de mécaniciens pouvant être en service en même temps.
- `EnablePlayerManagement` : Activer ou désactiver la gestion des employés pour les patrons.
- `EnableSocietyOwnedVehicles` : Permettre aux véhicules de société d'être utilisés.
- `Config.Zones` : Position des différentes zones comme le garage, le coffre, le point de craft, etc.

## 🛠️ Fonctionnalités

### 1. **Menu d'actions (F6)**
- Facturer un joueur.
- Nettoyer un véhicule.
- Supprimer un véhicule.
- Remorquer un véhicule.

### 2. **Menu Benny's**
- Changer la tenue en tenue de travail ou tenue civile.
- Accéder au coffre de l'entreprise.
- Gérer les véhicules de société (spawn/suppression).
- Actions pour les patrons (gestion des employés, etc.).

### 3. **Menu de récolte et de craft**
- Récolter des bouteilles de gaz, des outils de réparation, des outils de carrosserie.
- Craft de chalumeau, kit de réparation, et kit de carrosserie.

### 4. **Inventaire**
- Utiliser des items comme `blowpipe`, `fixkit`, et `carokit` pour réparer ou crocheter des véhicules.

---

## 💾 Base de données

Le fichier [`AbdelRMB_bennysjob.sql`](https://github.com/Abdelrmb/AbdelRMB-Bennysjob) crée les entrées nécessaires dans votre base de données :

- **`jobs`** : Ajoute le job `bennys`.
- **`job_grades`** : Définit les grades pour le job `bennys`.
- **`addon_account`** et **`addon_inventory`** : Gèrent les comptes et inventaires de la société Benny's.

---

## 🎮 Commandes et Raccourcis

- **F6** : Ouvrir le menu d'actions Benny's.
- **E** : Interagir avec les zones marquées (garage, craft, etc.).

---

## 🛠️ Dépannage

Si vous rencontrez des problèmes avec cette ressource, assurez-vous d'avoir bien installé toutes les dépendances listées, et que votre base de données est correctement configurée.

---

## 📬 Support

Pour toute question ou assistance supplémentaire, vous pouvez me contacter sur **Discord** : abdelrmb93.

---
