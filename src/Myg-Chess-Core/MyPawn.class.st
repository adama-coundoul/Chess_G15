Class {
	#name : 'MyPawn',
	#superclass : 'MyPiece',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'accessing' }
MyPawn >> id [ 

	^ 'P'
]

{ #category : 'accessing' }
MyPawn >> moveTo: aSquare [ 
	
    "Déplace le pion vers une nouvelle case et vérifie s'il doit être promu."
    (self legalTargetSquares includes: aSquare) ifFalse: [ ^ self ].
    square emptyContents.
    square := aSquare.
    ((aSquare file = $1 ) or: (aSquare file = $8))
                ifTrue: [ aSquare contents: self promoteToQueen ]
					 ifFalse: [aSquare contents: self]
]

{ #category : 'accessing' }
MyPawn >> promoteToQueen [ 
    "Transforme le pion en une reine de la même couleur."
    ^ MyQueen new color: self color.
]

{ #category : 'accessing' }
MyPawn >> renderPieceOn: aSquare [ 
	
	^ aSquare renderPawn: self
]

{ #category : 'accessing' }
MyPawn >> targetSquaresLegal: aBoolean [
    self isWhite 
        ifTrue: [ ^ self targetSquaresLegalWhite: aBoolean ] 
        ifFalse: [ ^ self targetSquaresLegalBlack: aBoolean ].
]

{ #category : 'accessing' }
MyPawn >> targetSquaresLegalBlack: aBoolean [

	| downSquare doubleDownSquare diagRightSquare diagLeftSquare leftSquare rightSquare possibleMoves upSquare|
	"Récupère les cases voisines"
	downSquare := self square down.
	doubleDownSquare := downSquare down .
	diagRightSquare := self square right ifNotNil: [ self square right down ].
	diagLeftSquare := self square left ifNotNil: [ self square left down ].
	leftSquare := self square left.
	rightSquare := self square right.
	upSquare := self square up.
	possibleMoves := OrderedCollection new.

	"Déplacement en avant d'une case"
	downSquare hasPiece ifFalse: [ possibleMoves add: downSquare ].
	
	"Déplacement en avant de deux cases"
	(self square file = $7 and: [
		downSquare hasPiece not and: [ doubleDownSquare hasPiece not ] ])
		ifTrue: [ possibleMoves add: doubleDownSquare ].

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
		 leftSquare contents color ~= self color ] ]]) ifTrue: [possibleMoves add: diagLeftSquare].
       (possibleMoves includes: diagLeftSquare) ifTrue: [ upSquare contents: nil. ].

	"Capture en passant à droite"
	(self square file = $4 and: [
		 rightSquare notNil and: [
		 rightSquare hasPiece and: [
		 rightSquare contents color ~= self color ] ]] ) ifTrue: [possibleMoves add: diagRightSquare].
       (possibleMoves includes: diagRightSquare) ifTrue: [ upSquare contents: nil. ].

	^ possibleMoves 
]

{ #category : 'accessing' }
MyPawn >> targetSquaresLegalWhite: aBoolean [

	| upSquare doubleUpSquare diagRightSquare diagLeftSquare leftSquare rightSquare possibleMoves downSquare|
	"Récupère les cases voisines"
	upSquare := self square up.
	doubleUpSquare := upSquare ifNotNil: [ upSquare up ].
	leftSquare := self square left.
	downSquare := self square down.
	rightSquare := self square right.
	diagRightSquare := rightSquare ifNotNil: [ self square right up ].
	diagLeftSquare := leftSquare ifNotNil: [ self square left up ].

	possibleMoves := OrderedCollection new.

	"Déplacement en avant d'une case"
	upSquare hasPiece ifFalse: [ possibleMoves add: upSquare ].
	"Déplacement en avant de deux cases"
	(self square file = $2 and: [
		 upSquare hasPiece not and: [ doubleUpSquare hasPiece not ] ]) ifTrue: [
		possibleMoves add: doubleUpSquare ].

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
	(self square file = $5 and: [
		 leftSquare notNil and: [
		 leftSquare hasPiece and: [
				 leftSquare contents color ~= self color ] ]]) ifTrue: [
		possibleMoves add: diagLeftSquare].
	   (possibleMoves includes: diagLeftSquare) ifTrue: [ downSquare contents: nil.].
	
	
	"Capture en passant à droite"
	(self square file = $5 and: [
		 rightSquare notNil and: [
		 rightSquare hasPiece and: [
				 rightSquare contents color ~= self color ] ]] ) ifTrue: [
		possibleMoves add: diagRightSquare ].
	   (possibleMoves includes: diagRightSquare) ifTrue: [ downSquare contents: nil.].
	
	
	^ possibleMoves
]
