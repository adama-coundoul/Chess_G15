Class {
	#name : 'MyWhitePawn',
	#superclass : 'MyPawn',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

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

{ #category : 'as yet unclassified' }
MyWhitePawn >> promptForPromotion [ ^ MyWhiteRook new
]

{ #category : 'rendering' }
MyWhitePawn >> renderPieceOn: aSquare [

	^ aSquare renderWhitePawn
]
