Class {
	#name : 'MyBlackPawn',
	#superclass : 'MyPawn',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'accessing' }
MyBlackPawn >> canCaptureEnPassant [
	^ self square file = $4.
]

{ #category : 'accessing' }
MyBlackPawn >> diagLeftSquare [
    ^ self square left ifNotNil: [ self square left down ].

]

{ #category : 'accessing' }
MyBlackPawn >> diagRightSquare [
    ^ self square right ifNotNil: [ self square right down ].
]

{ #category : 'rendering' }
MyBlackPawn >> oneMove [
    ^ self square down hasPiece ifFalse: [ self square down ] ifTrue: [ nil ].

]

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
