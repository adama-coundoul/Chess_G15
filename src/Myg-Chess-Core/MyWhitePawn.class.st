Class {
	#name : 'MyWhitePawn',
	#superclass : 'MyPawn',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'accessing' }
MyWhitePawn >> promoteToQueen [ 

^ MyWhiteQueen new. 
]

{ #category : 'rendering' }
MyWhitePawn >> renderPieceOn: aSquare [

	^ aSquare renderWhitePawn
]
