Class {
	#name : 'MyWhiteChessSquare',
	#superclass : 'MyChessSquare',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'initialization' }
MyWhiteChessSquare >> initialize [ 

   ^ super initialize 
     color: Color white
]

{ #category : 'rendering' }
MyWhiteChessSquare >> renderBlackBishop [ 

    ^ 'V'  
]

{ #category : 'rendering' }
MyWhiteChessSquare >> renderBlackKing [

    ^ 'L'  
]

{ #category : 'rendering' }
MyWhiteChessSquare >> renderBlackKnight [

    ^ 'M'  
]

{ #category : 'rendering' }
MyWhiteChessSquare >> renderWhiteBishop [ 

    ^ 'B'  
]

{ #category : 'rendering' }
MyWhiteChessSquare >> renderWhiteKing [

    ^ 'K'  
]

{ #category : 'rendering' }
MyWhiteChessSquare >> renderWhiteKnight [

    ^ 'N'  
]
