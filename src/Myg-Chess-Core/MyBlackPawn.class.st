Class {
	#name : 'MyBlackPawn',
	#superclass : 'MyPawn',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'accessing' }
MyBlackPawn >> promoteToQueen [ 

^ MyBlackQueen new .
]

{ #category : 'rendering' }
MyBlackPawn >> renderPieceOn: aSquare [

	^ aSquare renderBlackPawn
]
