Class {
	#name : 'MyWhitePawn',
	#superclass : 'MyPawn',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'rendering' }
MyWhitePawn >> canCaptureEnPassant [
	^ self square file = $5.
]

{ #category : 'rendering' }
MyWhitePawn >> diagLeftSquare [
    ^ self square left ifNotNil: [ self square left up ].

]

{ #category : 'rendering' }
MyWhitePawn >> diagRightSquare [
    ^ self square right ifNotNil: [ self square right up ].
]

{ #category : 'rendering' }
MyWhitePawn >> oneMove [
    ^ self square up hasPiece ifFalse: [ self square up ] ifTrue: [ nil ].

]

{ #category : 'rendering' }
MyWhitePawn >> renderPieceOn: aSquare [

	^ aSquare renderWhitePawn
]

{ #category : 'rendering' }
MyWhitePawn >> targetSquaresLegal: aBoolean [
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
MyWhitePawn >> twoMoves [
    "Renvoie la case en avant de deux cases si le déplacement est valide, sinon nil."
    | upSquare doubleUpSquare |
    upSquare := self square up.
    doubleUpSquare := upSquare ifNotNil: [ upSquare up ].
    (self square file = $2 and: [
        upSquare hasPiece not and: [
            doubleUpSquare hasPiece not ] ])
        ifTrue: [ ^ doubleUpSquare ].
    ^ nil.
]
