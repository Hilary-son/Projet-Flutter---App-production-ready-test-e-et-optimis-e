# Mes lectures

[![CI](https://github.com/TON-PSEUDO/mes_lectures/actions/workflows/ci.yml/badge.svg)](https://github.com/TON-PSEUDO/mes_lectures/actions/workflows/ci.yml)
![Flutter](https://img.shields.io/badge/Flutter-stable-02569B?logo=flutter)

Une petite application Flutter pour suivre ses lectures : on ajoute un livre, on note où on en est, et on voit combien on en a terminé. Je l'ai construite comme projet final pour apprendre à écrire une app propre, testée et prête à être publiée.

## Captures d'écran

| Accueil | Détail | Statistiques |
|---|---|---|
| ![Accueil](docs/home.png) | ![Détail](docs/detail.png) | ![Stats](docs/stats.png) |

## Ce que fait l'app

- Ajouter un livre (titre, auteur, nombre de pages, couverture facultative)
- Faire avancer la progression avec un curseur
- Supprimer un livre
- Voir des statistiques simples
- Changer la langue entre français et anglais
- Garder ses données sur le téléphone, même après avoir fermé l'app

## Lancer le projet

Il faut avoir [Flutter](https://docs.flutter.dev/get-started/install) installé.

```bash
git clone https://github.com/TON-PSEUDO/mes_lectures.git
cd mes_lectures
flutter pub get
flutter run -d chrome   # dans le navigateur
# ou : flutter run          # sur un téléphone Android / un émulateur
```

## Les tests

```bash
flutter test                      # tests unitaires et de widgets
flutter test integration_test     # tests d'intégration (émulateur ou téléphone branché)
```

Il y a 14 tests unitaires, 6 tests de widgets et 2 tests d'intégration.

## Comment le code est organisé

```
lib/
├── models/      # la classe Book
├── data/        # sauvegarde des livres (repository)
├── providers/   # logique de l'app (livres, langue)
├── screens/     # les 5 écrans
├── widgets/     # morceaux d'interface réutilisables
└── l10n/        # traductions FR / EN
```

J'ai séparé trois choses : les données (`data`), la logique (`providers`) et l'affichage (`screens`). Les écrans ne savent pas comment les livres sont sauvegardés, ils parlent seulement au provider. Grâce à ça, dans les tests je remplace la vraie sauvegarde par une version en mémoire (`InMemoryBookRepository`), et tout reste rapide.

Je gère l'état avec [provider](https://pub.dev/packages/provider), qui est assez simple pour commencer.

## Performance et accessibilité

- Liste construite avec `ListView.builder`, donc seuls les livres visibles sont dessinés
- Les écrans écoutent uniquement ce dont ils ont besoin (`context.select`) pour éviter des rebuilds inutiles
- Widgets `const` partout où c'est possible
- Couvertures chargées avec `cached_network_image`, en petite taille
- Boutons avec `tooltip`, barre de progression et curseur avec un label lisible par un lecteur d'écran

## CI

À chaque push, GitHub Actions vérifie le format, lance `flutter analyze`, exécute les tests et construit un APK, que l'on peut télécharger depuis l'onglet Actions.

## Ce que je ferais ensuite

- Recherche de livres via une API
- Mode sombre
- Tri et filtres sur la liste

Voir le [CHANGELOG](CHANGELOG.md) pour l'historique des versions.
