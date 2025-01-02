Class {
	#name : 'MyBlackPawn',
	#superclass : 'MyPawn',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'rendering' }
MyBlackPawn >> canCaptureEnPassant [
	^ self square file = $4.
]

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
    | possibleMoves diagLeftSquare diagRightSquare enPassantSquares |
    
    possibleMoves := OrderedCollection new.
    
    "L'avancement d'une seule ou deux cases"
    self oneMove ifNotNil: [ possibleMoves add: self oneMove ].
    self twoMoves ifNotNil: [ possibleMoves add: self twoMoves ].
    
    "Capture en diagonale"
    diagLeftSquare := self checkDiagonalCapture: self diagLeftSquare.
    diagRightSquare := self checkDiagonalCapture: self diagRightSquare.
    diagLeftSquare ifNotNil: [ possibleMoves add: diagLeftSquare ].
    diagRightSquare ifNotNil: [ possibleMoves add: diagRightSquare ].
    
    "Capture en passant"
    enPassantSquares := self enPassantCapture.
    enPassantSquares ifNotNil: [
        enPassantSquares isCollection
            ifTrue: [ possibleMoves addAll: enPassantSquares ]
            ifFalse: [ possibleMoves add: enPassantSquares ]
    ].
    
    ^ possibleMoves.

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
