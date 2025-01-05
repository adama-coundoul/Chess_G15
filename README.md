# Jeu d'échecs Myg

Il s'agit d'un jeu d'échecs pour Pharo basé sur Bloc, Toplo et Myg.

### Obtenir le code

Ce code a été testé dans Pharo 12. Vous pouvez l'obtenir en installant le code de base suivant :

```smalltalk
Metacello new
	repository: 'github://adama-coundoul/Chess_G15:main';
	baseline: 'MygChess';
	onConflictUseLoaded;
	load.
```
### Utilisation

Vous pouvez ouvrir le jeu d'échecs en utilisant l'expression suivante :

```smalltalk
board := MyChessGame freshGame.
board size: 800@600.
space := BlSpace new.
space root addChild: board.
space pulse.
space resizable: true.
space show.
```
### Comment interagissons-nous avec lui ?

Pour interagir avec le jeu, vous pouvez :

 - **Cliquer directement sur une pièce** pour la sélectionner et **Cliquer sur la case** où vous souhaitez déplacer la pièce (mode interactif).
 - **Appuyer sur le bouton "PLAY"** ( mode automatique)

### Où se trouvent votre code/tests ? Faut-il s’occuper de quelque chose ?

Code source : Le code du jeu se trouve dans le package Myg-Chess-Core.
Tests : Les tests unitaires se trouvent dans le package Myg-Chess-Tests.

## Katas

## Maya AIT YAHIA 

### Corriger les mouvements des pions !

Le kata que j'ai réalisé consiste à "Corriger les mouvements des pions” dans un jeu d'échecs. Le but était de pratiquer le débogage, d'implémenter des tests unitaires et de résoudre des problèmes complexes liés à la gestion des mouvements des pions dans un jeu d'échecs.

Voici les principales tâches abordées :

#### 1. Correction du mouvement des pions : 
Le mouvement simple d’une ou deux cases s’il est encore sur sa rangée de départ en vérifiant que les cases devant sont libres.

#### 2. Gestion du mouvement de capture en diagonale : 
Les pions peuvent capturer uniquement en avançant d'une case en diagonale sur une pièce ennemie. J'ai corrigé les erreurs qui permettaient de capturer les pièces de même couleur.

#### 3. Implémentation du mouvement spécial "En passant" (capture en passant) : 
 en respectant toutes ses conditions : 
   - Le pion adverse doit avoir avancé de deux cases dans son dernier mouvement.
   - Le pion qui capture doit se trouver sur une colonne adjacente à celle du pion adverse. 
   - La capture doit être effectuée immédiatement après ce mouvement de deux cases.

#### 4.  Décisions de conception : 
Je me suis appuyé sur le kata de Youssra (double dispatch), qui a créé deux classes distinctes, MyBlackPawn et MyWhitePawn, ce qui m’a permis de structurer mon code de manière séparée et d’éviter à chaque fois de vérifier si le pion était blanc ou noir.

### Les difficultés que vous avez rencontrées et comment vous les avez résolues

1. Le premier problème rencontré est lié à la compréhension du code existant. Pour y remédier, j’ai commencé par effectuer des tests initiaux afin d’identifier précisément les problèmes liés aux mouvements des pions et de déterminer les cas où cela ne fonctionne pas.

2. Parmi les conditions nécessaires pour qu'un mouvement "en passant" soit valide, il faut vérifier le dernier mouvement effectué. Mais en utilisant uniquement la méthode donnée (recordMovementOf), je n'arrivais pas à le récupérer. 
Pour résoudre ce problème, j'ai créé une nouvelle classe appelée **MyMove**, qui inclut trois méthodes principales :
- `lastPiece` : pour récupérer la dernière pièce déplacée,
- `lastSquareFrom` : pour accéder à la case de départ,
- `lastSquareTo` : pour accéder à la case d'arrivée.

En complément, j'ai ajouté dans la classe **Game** une méthode nommée `recordLastMove`, qui permet d'enregistrer ces informations lors d'un mouvement.

3.J’ai rencontré un problème avec la méthode `moveTo`, car Adama avait modifié le code pour intégrer deux variantes de la méthode `move` : une interactive et une automatique. Cette modification empêchait le pion de reconnaître ma méthode, ce qui faisait échouer le mouvement "En passant". Après en avoir discuté avec elle, nous avons décidé de combiner nos méthodes afin de résoudre le problème.

### Dans quelle mesure votre code est-il testé et comment l’avez-vous fait.

#### Tests automatisés : 

J’ai créé des tests unitaires pour vérifier le bon fonctionnement de chaque comportement des pions (déplacement simple d’une case ou de deux cases, capture en diagonale, mouvement en passant) dans la classe **MyPawnTest**, et des tests pour vérifier le bon enregistrement des mouvements dans la classe **MyMoveTest**. Ces tests ont permis de s’assurer que les règles étaient respectées et de détecter rapidement les erreurs.

#### Tests manuels :  

J’ai également effectué des tests manuels pour vérifier tous les cas particuliers et m’assurer que les comportements étaient conformes à ce qui était attendu.


## Youssra DAHOUANE

### Refactoriser le rendu des pièces

Le kata que j'ai réalisé consiste à refactoriser le code afin de retirer les conditions imbriquées dans la méthode de rendu des pièces d'échecs, en utilisant des techniques de refactorisation comme le double dispatch ou la table dispatch.

### Les difficultés que vous avez rencontrées et comment vous les avez résolues

#### 1. Compréhension du code existant 

Le code initial utilisait des conditions imbriquées pour gérer le rendu des pièces en fonction de leur couleur et de celle de la case, ce qui le rendait complexe et difficile à maintenir. Par exemple, pour afficher un cavalier, le jeu utilisait une méthode comme celle-ci :

```
MyChessSquare >> renderKnight: aPiece
           	^ aPiece isWhite
                          	  ifFalse: [ color isBlack
                                                       	  ifFalse: [ 'M' ]
                                                       	  ifTrue: [ 'm' ] ]
                          	  ifTrue: [
                                        	  color isBlack
                                                       	  ifFalse: [ 'N' ]
                                                       	  ifTrue: [ 'n' ] ]
```
Pour cela, j'ai commencé par effectuer des tests avec différentes combinaisons de couleurs de pièces et de cases afin de bien comprendre le comportement de chaque condition. Cela m'a permis d'identifier les parties du code à refactoriser.

####  2. Transition vers le double dispatch 

J’ai opté pour le double dispatch comme solution de refactorisation. La difficulté principale était comment réorganiser le code pour répartir la responsabilité du rendu entre deux objets : la pièce et la case, tout en supprimant les conditions imbriquées.
Pour cela, j'ai créé des sous-classes pour chaque type de pièce. J'ai ensuite ajouté la méthode renderPieceOn dans chaque sous-classe, qui prend la case en paramètre. Par exemple, dans MyBlackBishop, la méthode renderPieceOn délègue le rendu de la pièce noire à la méthode renderBlackBishop de la case. De même, dans MyWhiteBishop, elle appelle renderWhiteBishop pour afficher la pièce blanche sur la case.

##### MyBlackBishop :

```
renderPieceOn: aSquare
           	^ aSquare renderBlackBishop
```
##### MyWhiteBishop :

```
renderPieceOn: aSquare
           	^ aSquare renderWhiteBishop
```
J'ai également créé des sous-classes pour la case : MyBlackChessSquare et MyWhiteChessSquare, chacune disposant de méthodes de rendu spécifiques pour chaque type de pièce (renderBlackBishop, renderWhiteBishop, etc). Ces méthodes renvoient les caractères appropriés en fonction de la couleur de la case.

#### 3. Adaptation du code existant à la nouvelle structure  
Une autre difficulté a été d'adapter le code existant à la nouvelle structure mise en place avec le double dispatch. Cela a impliqué plusieurs modifications, notamment :
Modifier les méthodes d'initialisation, telles que initializeSquares dans MyChessBoard et initialize dans MyChessImporters (plus précisément dans MyFenParser), afin d'initialiser les pièces avec la couleur et la classe appropriées.
Mettre à jour les tests et ajuster les appels de rendu dans l'ensemble du code.
Remplacer les anciennes méthodes de rendu par les nouvelles.

### Dans quelle mesure votre code est-il testé et comment l’avez-vous fait. Tests automatisés, tests de mutation, tests manuels ?

#### Tests automatisés : 

J’ai créé des tests unitaires dans la classe “MyPieceRenderingTest” pour vérifier que chaque pièce est correctement rendue selon sa couleur et celle de la case. Par exemple, un test automatisé vérifie que MyBlackKnight sur MyWhiteChessSquare affiche bien le caractère 'n'. Ces tests m'ont permis de m'assurer que la refactorisation n'a pas introduit de régressions et que les pièces sont rendues correctement.

#### Tests manuels : 

J’ai exécuté le jeu avec différentes combinaisons de pièces et de cases pour vérifier visuellement que les caractères affichés correspondent aux attentes.

#### Tests de mutation : 

J'ai réalisé des tests en introduisant des erreurs dans le code pour vérifier que les tests automatisés détectaient bien les problèmes.

### Décisions de conception 

#### Pourquoi le code est-il comme ça ?  

Le code utilise le double dispatch pour répartir la logique de rendu entre les pièces et les cases. Cela permet de rendre chaque objet responsable de son propre rendu, ce qui simplifie le code et évite les conditions imbriquées. Ce choix a pour but de rendre le code plus modulaire, lisible et maintenable.

#### Pourquoi cette partie du code est-elle plus testée que l’autre ? 

J'ai focalisé mes tests sur la partie du code relatif au rendu des pièces, car cette partie est essentielle pour assurer la validité du jeu. Un rendu correct est nécessaire au bon fonctionnement du jeu.

#### Où avez-vous placé les priorités ? 

Les priorités ont été mises sur la simplicité et la clarté du code. L'objectif était de nettoyer la logique de rendu avec les conditions imbriquées et de rendre le code plus extensible et lisible.

#### Où avez-vous utilisé (ou non) des modèles de conception dans le code et pourquoi ? 

J'ai utilisé comme modèle de conception le Double Dispatch pour séparer les responsabilités entre la pièce et la case. J'ai choisi de ne pas utiliser d'autres modèles de conception, car le double dispatch répondait parfaitement aux besoins du kata.


### Adama COUNDOUL 

## Promotion du pion

**Objectif** : Pratiquer la compréhension et le débogage du code.

Lorsque les pions arrivent à l'arrière de l'échiquier, le pion est promu : il est transformé en pièce majeure (reine, tour) ou mineure (cavalier, fou), au choix du joueur. Dans une interface interactive, cela nécessite de demander à l'utilisateur ce qu'il doit faire. Dans un joueur/bot automatique, cela nécessite une approche de décision automatisée.

## Décisions de conception

### Pourquoi le code est-il comme ça ?  

Le code de promotion du pion a été conçu pour distinguer clairement les deux modes de jeu : **automatique** et **interactif**. Cette séparation permet de répondre aux deux besoins spécifiques :  

- En mode **automatique**, le pion est promu directement à une reine sans intervention de l'utilisateur.
- En mode **interactif**, une fenêtre demande au joueur de choisir la pièce vers laquelle le pion sera promu.

Ces deux comportements ont été séparés dans deux méthodes distinctes (`moveToAutomaticVersion` et `moveToInteractiveVersion`) afin de rendre le code plus lisible et modulaire.

### Pourquoi cette partie du code est-elle plus testée que l’autre ?  

J'ai concentré mes tests principalement sur les deux méthodes centrales de mon implémentation : `moveToAutomaticVersion` et `moveToInteractiveVersion`. Ces deux méthodes sont au cœur de mon code, car elles définissent respectivement le comportement en mode automatique et en mode interactif.  

**Précautions pour les tests de `moveInteractiveVersion`**  

Pour tester correctement la méthode `moveInteractiveVersion`, j'ai utilisé la méthode `compile` pour `showPromotionDialog`. Cela m'a permis de tester le comportement en forçant un rendu spécifique pour simuler le choix de l’utilisateur dans un contexte de test. Cependant, cette approche introduit une contrainte importante :  

- Avant de lancer le jeu, il est impératif de supprimer (`showPromotionDialog`) dans les classes `MyBlackPawn` et `MyWhitePawn` et ne le laissait que dans MyPawn.

Si ces méthodes ne sont pas supprimées, le pion se transformera directement en fonction du dernier test lancé (qui le crée dans les sous classes) sans demander à l'utilisateur de faire un choix via une fenêtre interactive. Cela pourrait fausser les tests manuels et ne pas refléter le comportement réel attendu.

### Où avez-vous placé les priorités ?

1. **Assurer le bon fonctionnement des deux modes de promotion** (`moveToAutomaticVersion` et `moveToInteractiveVersion`), car ils forment la base de la gestion des promotions.  
2. **Vérifier la validité des règles de promotion** (choix de la pièce correcte et remplacement du pion).  
3. **Tester l’intégration avec l'interface** pour garantir que la fenêtre de choix s'affiche correctement et que la promotion s'applique sans perturber le jeu.  

### Décision spécifique : Gestion de la fenêtre de promotion  

Une précision à savoir concernant la fenêtre de choix de la promotion en mode interactif. Actuellement, cette fenêtre s'affiche dans l'interface de **Pharo** au lieu de l'interface graphique du jeu. Une fois que l'utilisateur initie le mouvement vers la dernière rangée, il doit cliquer dans l'interface Pharo. Le jeu se ferme temporairement, la fenêtre de sélection de la pièce apparaît dans Pharo, l'utilisateur choisit une pièce, puis il rouvre le jeu pour constater que le changement a été appliqué.

### Où avez-vous utilisé (ou non) des modèles de conception dans le code et pourquoi ?

Je me suis appuyé sur le kata de Youssra (double dispatch), qui avait créé deux classes distinctes, MyBlackPawn et MyWhitePawn. Cela m’a permis de structurer mon code de manière claire et d’implémenter directement des méthodes spécifiques à chaque classe pour retourner la nouvelle pièce promue.


## Les difficultés que vous avez rencontrées et comment vous les avez résolues

### 1. Comprendre le code et se familiariser avec l'environnement

Le premier problème a été de me familiariser avec le code existant et l'environnement Pharo. Pour cela, j'ai commencé par écrire des tests simples pour comprendre les bases.  

### 2. Création et gestion des méthodes `moveToAutomaticVersion` et `moveToInteractiveVersion`

Après avoir écrit les méthodes pour la promotion (`moveToAutomaticVersion` et `moveToInteractiveVersion`), je me suis posé la question suivante :  
**Où et comment appeler ces méthodes correctement ?**

#### Partie automatique  
La solution est venue en explorant la méthode `play` dans la classe `MyChessGame`. Cette méthode gérait les actions automatiques, et en remontant son fonctionnement, j'ai compris où intégrer la promotion automatique.

#### Partie interactive  
Pour la partie interactive, j'avais initialement une mauvaise hypothèse :  
Je cherchais une méthode dans `MyPiece` pour dire qu'une pièce était sélectionnée. Cependant, le concept de sélection est lié aux cases (`Square`), pas aux pièces elles-mêmes.  

Le déclic a été la méthode `clickOn` de la classe `MySelectedState`. J'ai compris que cette méthode permet de récupérer le contenu de la case sélectionnée, ce qui m'a permis de gérer correctement la promotion interactive.

### 3. Conflit lors de l'intégration avec le code de Maya

Un autre problème important est survenu lors du **merge** avec la partie de Maya, qui gérait les mouvements des pions. Maya avait modifié la méthode `moveTo` pour son implémentation, alors que dans mon cas, la méthode `moveTo` était maintenant réservée aux autres pièces. Les pions utilisaient uniquement `moveToAutomaticVersion` et `moveToInteractiveVersion`.

Ce conflit a été résolu en combinant :  
- **`moveTo`** avec **`moveToAutomaticVersion`**, en conservant le nom `moveToAutomaticVersion`.  
- **`moveToInteractiveVersion`** avec la logique de `moveTo`, en gardant également `moveToInteractiveVersion` pour ne pas casser le code.

Cette solution a permis d'unifier les deux implémentations tout en respectant les spécificités de chaque partie.

### 4. Problème en fin de projet : impossibilité d'ouvrir le jeu

Un problème critique a été rencontré en fin de projet : l’interface graphique du jeu ne s’ouvrait plus, ce qui m’empêchait de tester manuellement mon code. De plus, lorsque je poussais mes modifications sur le *main*, les autres membres de l'équipe ne parvenaient plus non plus à ouvrir le jeu.

Pour résoudre ce problème :  

Maya a **push** sur le *main* ses modifications et **repull** son code, ce qui a permis de rouvrir le jeu sans problème. Ensuite, pour éviter de compromettre le projet, je n’ai plus poussé mes modifications directement dans le dépôt. J'envoyais mes modifications à Maya, qui se chargeait de tester manuellement mon code à ma place et de pousser les ajustements nécessaires dans le dépôt.

## Dans quelle mesure votre code est-il testé et comment l’avez-vous fait ?  

### 1. Tests automatisés  

- **Pour le mode automatique**, des tests ont été effectués pour vérifier que la promotion s'effectue correctement, sans intervention de l'utilisateur, en transformant le pion en reine.  
- **Pour le mode interactif**, j'ai testé que la pièce sélectionnée remplace correctement le pion sur l'échiquier.


### 2. Tests manuels  

En complément de ces tests automatisés, j'ai également vérifié manuellement que l'écran s'affiche correctement, que le pion est bien promu après sélection, et que le jeu continue de fonctionner comme prévu. Ces tests manuels étaient nécessaires pour m'assurer du bon rendu dans l'interface graphique, notamment pour la gestion de la fenêtre en mode interactif.



