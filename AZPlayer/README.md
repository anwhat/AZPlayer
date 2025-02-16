# AZPlayer

## Fonctionnalités
L'app implemente 2 pages : une liste de vidéos et le player associé à chaque vidéo

## Architecture
Le projet utilise l'architecture MVVM
Les dépendences sont injectées dans les init des objets

Une classe Router gère la navigation dans l'application
Les routes disponibles sont listées dans l'enum `Route`

La classe VideoAPI gère les appels réseaux

## Tests
La classe VideoAPIMock permet de tester sans faire d'appels réseaux

### RouterTests
Dans le test `testDestination()` j'ai rencontré un problème pour vérifier le type de la vue retournée.
Par manque de temps pour investiguer ce problème j'ai uniquement vérifier que l'objet est non nil 

### URLSessionProtocol
Ce protocol sert uniquement à contourner une erreur pour surcharger la méthode `func data(from url: URL) async throws -> (Data, URLResponse)`
```
Non-@objc instance method 'data(from:)' is declared in extension of 'URLSession' and cannot be overridden
```
Cela permet de mocker URLSession dans les tests
