Class {
	#name : 'MyBlackPawn',
	#superclass : 'MyPawn',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'accessing' }
MyBlackPawn >> promoteToBishop [ 

^ MyBlackBishop new .
]

{ #category : 'accessing' }
MyBlackPawn >> promoteToKnight [ 

^ MyBlackKnight new .
]

{ #category : 'accessing' }
MyBlackPawn >> promoteToQueen [ 

^ MyBlackQueen new .
]

{ #category : 'accessing' }
MyBlackPawn >> promoteToRook [ 

^ MyBlackRook new .
]

{ #category : 'rendering' }
MyBlackPawn >> renderPieceOn: aSquare [

	^ aSquare renderBlackPawn
]

{ #category : 'accessing' }
MyBlackPawn >> targetSquaresLegal: aBoolean [ 

	| downSquare doubleDownSquare diagRightSquare diagLeftSquare leftSquare rightSquare possibleMoves upSquare|
	"Récupère les cases voisines"
	downSquare := self square down.
	doubleDownSquare := downSquare ifNotNil: [ downSquare down ].
	leftSquare := self square left.
	upSquare := self square up.
	rightSquare := self square right.
	diagRightSquare := rightSquare ifNotNil: [ self square right down ].
	diagLeftSquare := leftSquare ifNotNil: [ self square left down ].

	possibleMoves := OrderedCollection new.

	"Déplacement en avant d'une case"
	downSquare hasPiece ifFalse: [ possibleMoves add: downSquare ].
	"Déplacement en avant de deux cases"
	(self square file = $7 and: [
		 downSquare hasPiece not and: [ doubleDownSquare hasPiece not ] ]) ifTrue: [
		possibleMoves add: doubleDownSquare ].

	"Capture en diagonale gauche"
    (diagLeftSquare notNil and: [
        diagLeftSquare hasPiece and: [
        diagLeftSquare contents color ~= self color ]])
        ifTrue: [ possibleMoves add: diagLeftSquare ].

	"Capture en diagonale droite"
	(diagRightSquare notNil and: [
        diagRightSquare hasPiece and: [
        diagRightSquare contents color ~= self color ]])
        ifTrue: [ possibleMoves add: diagRightSquare ].

	"Capture en passant à gauche"
	(self square file = $4 and: [
		 leftSquare notNil and: [
		 leftSquare hasPiece and: [
				 leftSquare contents color ~= self color ] ]]) ifTrue: [
		possibleMoves add: diagLeftSquare].
	   (possibleMoves includes: diagLeftSquare) ifTrue: [ upSquare contents: nil.].
	
	
	"Capture en passant à droite"
	(self square file = $4 and: [
		 rightSquare notNil and: [
		 rightSquare hasPiece and: [
				 rightSquare contents color ~= self color ] ]] ) ifTrue: [
		possibleMoves add: diagRightSquare ].
	   (possibleMoves includes: diagRightSquare) ifTrue: [ upSquare contents: nil.].
	
	
	^ possibleMoves
]
