Class {
	#name : 'MyWhitePawn',
	#superclass : 'MyPawn',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'rendering' }
MyWhitePawn >> renderPieceOn: aSquare [

	^ aSquare renderWhitePawn
]

{ #category : 'rendering' }
MyWhitePawn >> targetSquaresLegal: aBoolean [

	| up1 up2 diagRightWhite diagLeftWhite leftSquare rightSquare targetSquares |
	"Récupère les cases voisines"
	up1 := self square up.
	up2 := up1 ifNotNil: [ up1 up ].
	diagRightWhite := self square right ifNotNil: [ self square right up ].
	diagLeftWhite := self square left ifNotNil: [ self square left up ].
	leftSquare := self square left.
	rightSquare := self square right.

	targetSquares := OrderedCollection new.

	"Déplacement en avant d'une case"
	up1 hasPiece ifFalse: [ targetSquares add: up1 ].
	
	"Déplacement en avant de deux cases"
	(self square file = $2 and: [
		 up1 hasPiece not and: [ up2 hasPiece not ] ]) ifTrue: [
		targetSquares add: up2 ].

	"Capture en diagonale gauche"
	(diagLeftWhite hasPiece and: [
			 diagLeftWhite contents color ~= self color ]) ifTrue: [
		targetSquares add: diagLeftWhite ].

	"Capture en diagonale droite"
	(diagRightWhite hasPiece and: [
			 diagRightWhite contents color ~= self color ]) ifTrue: [
		targetSquares add: diagRightWhite ].

	"Capture en passant à gauche"
	(self square file = $5 and: [
		 leftSquare hasPiece and: [
				 leftSquare contents color ~= self color ] ]) ifTrue: [
		targetSquares add: diagLeftWhite ].

	"Capture en passant à droite"
	(self square file = $5 and: [
		 rightSquare hasPiece and: [
				 rightSquare contents color ~= self color ] ] ) ifTrue: [
		targetSquares add: diagRightWhite ].

	^ targetSquares
]
