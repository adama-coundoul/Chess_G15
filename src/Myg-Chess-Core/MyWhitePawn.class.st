Class {
	#name : 'MyWhitePawn',
	#superclass : 'MyPawn',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'accessing' }
MyWhitePawn >> canCaptureEnPassant [
	^ self square file = $5.
]

{ #category : 'accessing' }
MyWhitePawn >> diagLeftSquare [
    ^ self square left ifNotNil: [ self square left up ].

]

{ #category : 'accessing' }
MyWhitePawn >> diagRightSquare [
    ^ self square right ifNotNil: [ self square right up ].
]

{ #category : 'accessing' }
MyWhitePawn >> oneMove [
    ^ self square up hasPiece ifFalse: [ self square up ] ifTrue: [ nil ].

]

{ #category : 'accessing' }
MyWhitePawn >> promoteToBishop [ 

^ MyWhiteBishop new . 
]

{ #category : 'accessing' }
MyWhitePawn >> promoteToKnight [ 

^ MyWhiteKnight new . 
]

{ #category : 'accessing' }
MyWhitePawn >> promoteToQueen [ 

^ MyWhiteQueen new. 
]

{ #category : 'accessing' }
MyWhitePawn >> promoteToRook [ 

^ MyWhiteRook new . 
]

{ #category : 'rendering' }
MyWhitePawn >> renderPieceOn: aSquare [

	^ aSquare renderWhitePawn
]

{ #category : 'accessing' }
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
