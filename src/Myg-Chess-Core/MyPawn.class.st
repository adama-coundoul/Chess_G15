Class {
	#name : 'MyPawn',
	#superclass : 'MyPiece',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'accessing' }
MyPawn >> id [ 

	^ 'P'
]

{ #category : 'path commands' }
MyPawn >> moveTo: aSquare [
	
    "Déplace le pion vers une nouvelle case et vérifie s'il doit être promu."
    (self legalTargetSquares includes: aSquare) ifFalse: [ ^ self ].
    square emptyContents.
    square := aSquare.
    ((aSquare file = $1 ) or: (aSquare file = $8))
                ifTrue: [ aSquare contents: self promoteToQueen ]
					 ifFalse: [aSquare contents: self]
 
    
   
    
            
]

{ #category : 'as yet unclassified' }
MyPawn >> promoteToQueen [
    "Transforme le pion en une reine de la même couleur."
    ^ MyQueen new color: self color.
]

{ #category : 'accessing' }
MyPawn >> renderPieceOn: aSquare [ 
	
	^ aSquare renderPawn: self
]

{ #category : 'accessing' }
MyPawn >> targetSquaresLegal: aBoolean [
    ^ (self isWhite
        ifTrue: [
            "Déplacement des pions blancs"
            ((self square file = $2)
                ifTrue: [ { (self square up). (self square up up) } ]  "Mouvement de 1 ou 2 cases"
                ifFalse: [ { self square up } ])  "Mouvement de 1 case"
        ]
        ifFalse: [
            "Déplacement des pions noirs"
            ((self square file = $7)
                ifTrue: [ { (self square down). (self square down down) } ]  "Mouvement de 1 ou 2 cases"
                ifFalse: [ { self square down } ])  "Mouvement de 1 case"
        ])
    select: [ :s | 
        s notNil and: [ 
            s hasPiece not or: [ s contents color ~= color ] 
        ] ].

]
