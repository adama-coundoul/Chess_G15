Class {
	#name : 'MyPawn',
	#superclass : 'MyPiece',
	#instVars : [
		'enPassant'
	],
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'as yet unclassified' }
MyPawn >> checkDiagonalCapture: aSquare [  

	^ (aSquare notNil and: [
					aSquare hasPiece and: [
						aSquare contents color ~= self color ]] )
				ifTrue: [ aSquare ]
				ifFalse: [ nil ].
]

{ #category : 'accessing' }
MyPawn >> id [ 

	^ 'P'
]

{ #category : 'path commands' }
MyPawn >> initialize [ 
        super initialize.
		  enPassant := nil.
]

{ #category : 'testing' }
MyPawn >> isPawn [ 
^ true 
]

{ #category : 'accessing' }
MyPawn >> isWhite [ 
    ^ self color = Color white.
]

{ #category : 'rendering' }
MyPawn >> renderPieceOn: aSquare [

	^ self subclassResponsibility 

]

{ #category : 'accessing' }
MyPawn >> targetSquaresLegal: aBoolean [
   ^ self subclassResponsibility 
]
