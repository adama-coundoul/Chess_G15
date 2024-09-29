Class {
	#name : 'MyPawnTest',
	#superclass : 'TestCase',
	#category : 'Myg-Chess-Tests',
	#package : 'Myg-Chess-Tests'
}

{ #category : 'tests' }
MyPawnTest >> testSimplePawnMove [ 
    | pawn squares board |  "Déclare les variables"

    board := MyChessBoard empty.  "Crée un échiquier vide"

    board at: 'e4' put: (pawn := MyPawn white).  "Place un pion blanc à 'e4'"

    squares := pawn targetSquares.  "Récupère les cases cibles du pion"

    "Vérifie que le pion peut se déplacer vers 'e5'"
    self assertCollection: squares 
        includesAll: 
            (#( e5) collect: [ :name | 
                board at: name ]).
]
