Class {
	#name : 'MyBlackPawn',
	#superclass : 'MyPawn',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'rendering' }
MyBlackPawn >> diagLeftSquare [
    ^ self square left ifNotNil: [ self square left down ].

]

{ #category : 'rendering' }
MyBlackPawn >> diagRightSquare [
    ^ self square right ifNotNil: [ self square right down ].
]

{ #category : 'rendering' }
MyBlackPawn >> oneMove [
    ^ self square down hasPiece ifFalse: [ self square down ] ifTrue: [ nil ].

]

{ #category : 'rendering' }
MyBlackPawn >> renderPieceOn: aSquare [

	^ aSquare renderBlackPawn
]

{ #category : 'rendering' }
MyBlackPawn >> targetSquaresLegal: aBoolean [ 

	|   diagRightSquare diagLeftSquare  possibleMoves |



	possibleMoves := OrderedCollection new.


	"Déplacement en avant d'une case"
	possibleMoves add: self oneMove.
	"Déplacement en avant de deux cases"
   possibleMoves add: self twoMoves.

	"Capture en diagonale"
    diagLeftSquare := self checkDiagonalCapture: self diagLeftSquare .
    diagRightSquare := self checkDiagonalCapture: self diagRightSquare .
    possibleMoves add: diagLeftSquare;
               add: diagRightSquare.

"Capture en passant à gauche
(self square file = $5 and: [ 
    leftSquare notNil and: [ 
        leftSquare hasPiece and: [ 
            leftSquare contents color ~= self color and: [ 
                (self board game lastMove = '1. Pa5') or: [(self board game lastMove = '1. Pb5')
	        ]]]]])ifTrue: [ 
    Faire quelque chose si le dernier mouvement correspond à un pion passant de 7 à 5.
    possibleMoves add: diagLeftSquare. 
    (possibleMoves includes: diagLeftSquare) ifTrue: [ downSquare contents: nil. ].
]."
	
	
	"Capture en passant à droite
	(self square file = $5 and: [
		 rightSquare notNil and: [
		 rightSquare hasPiece and: [
				 rightSquare contents color ~= self color ] ]] ) ifTrue: [
		possibleMoves add: diagRightSquare ].
	   (possibleMoves includes: diagRightSquare) ifTrue: [ downSquare contents: nil.]."
	
	
	^ possibleMoves
]

{ #category : 'rendering' }
MyBlackPawn >> twoMoves [
    "Renvoie la case en avant de deux cases si le déplacement est valide, sinon nil."
    | downSquare doubleDownSquare |
    downSquare := self square down.
    doubleDownSquare := downSquare ifNotNil: [ downSquare down ].
    (self square file = $7 and: [
        downSquare hasPiece not and: [
            doubleDownSquare hasPiece not ] ])
        ifTrue: [ ^ doubleDownSquare ].
    ^ nil.
]
