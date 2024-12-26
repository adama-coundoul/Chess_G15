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

{ #category : 'as yet unclassified' }
MyBlackPawn >> promptForPromotion [ ^ MyBlackBishop new
]

{ #category : 'rendering' }
MyBlackPawn >> renderPieceOn: aSquare [

	^ aSquare renderBlackPawn
]
