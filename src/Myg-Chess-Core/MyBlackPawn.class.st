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
