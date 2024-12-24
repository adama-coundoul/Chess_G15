Class {
	#name : 'MyBlackChessSquare',
	#superclass : 'MyChessSquare',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'initialization' }
MyBlackChessSquare >> initialize [ 

   ^ super initialize 
     color: Color black
]

{ #category : 'rendering' }
MyBlackChessSquare >> renderBlackBishop [ 

    ^ 'v'  
]

{ #category : 'rendering' }
MyBlackChessSquare >> renderBlackKing [

    ^ 'l'  
]

{ #category : 'rendering' }
MyBlackChessSquare >> renderWhiteBishop [ 

    ^ 'b'  
]

{ #category : 'rendering' }
MyBlackChessSquare >> renderWhiteKing [

    ^ 'k'  
]
