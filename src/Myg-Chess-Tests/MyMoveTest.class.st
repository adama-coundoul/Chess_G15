Class {
	#name : 'MyMoveTest',
	#superclass : 'TestCase',
	#category : 'Myg-Chess-Tests',
	#package : 'Myg-Chess-Tests'
}

{ #category : 'tests' }
MyMoveTest >> testLastMoveAfterMultipleMoves [

	| board whitePawn blackPawn |
	board := MyChessBoard empty.
	board game: MyChessGame freshGame.

	board at: 'e2' put: (whitePawn := MyWhitePawn white).
	board at: 'd7' put: (blackPawn := MyBlackPawn black).


	board game move: whitePawn to: whitePawn square up up.

	"Deuxième mouvement"
	board game move: blackPawn to: blackPawn square down down.

	"Vérifier que la dernière pièce est le pion noir"
	self assert: board game lastMove lastPiece equals: blackPawn.
	self assert: board game lastMove lastSquareFrom name equals: 'd7'.
	self assert: board game lastMove lastSquareTo name equals: 'd5'
]

{ #category : 'tests' }
MyMoveTest >> testLastMoveBeforeAnyMove [
    | game |
    
    game := MyChessGame freshGame.
    

    self assert: (game lastMove isNil).

]

{ #category : 'tests' }
MyMoveTest >> testLastPieceAfterMove [

	| board whitePawn blackPawn |
	board := MyChessBoard empty.
	board game: MyChessGame freshGame.

	board at: 'e2' put: (whitePawn := MyWhitePawn white).
	board at: 'd7' put: (blackPawn := MyBlackPawn black).

	board game move: whitePawn to: whitePawn square up up.

	"Vérifier que lastPiece est le pion blanc"
	self assert: board game lastMove lastPiece equals: whitePawn
]

{ #category : 'tests' }
MyMoveTest >> testLastSquareFromAfterMove [

	| board whitePawn blackPawn |
	board := MyChessBoard empty.
	board game: MyChessGame freshGame.

	board at: 'e2' put: (whitePawn := MyWhitePawn white).
	board at: 'd7' put: (blackPawn := MyBlackPawn black).


	board game move: whitePawn to: whitePawn square up up.

	"Vérifier que lastSquareFrom est 'e2'"
	self assert: board game lastMove lastSquareFrom name equals: 'e2'
]

{ #category : 'tests' }
MyMoveTest >> testLastSquareToAfterMove [

	| board whitePawn blackPawn |
	board := MyChessBoard empty.
	board game: MyChessGame freshGame.

	board at: 'e2' put: (whitePawn := MyWhitePawn white).
	board at: 'd7' put: (blackPawn := MyBlackPawn black).


	board game move: whitePawn to: whitePawn square up up.

	"Vérifier que lastSquareTo est 'e4'"
	self assert: board game lastMove lastSquareTo name equals: 'e4'
]
