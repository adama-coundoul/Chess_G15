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

{ #category : 'accessing' }
MyPawn >> moveTo: aSquare [ 
	
    "Déplace le pion vers une nouvelle case et vérifie s'il doit être promu."
    (self legalTargetSquares includes: aSquare) ifFalse: [ ^ self ].
    square emptyContents.
    square := aSquare.
    ((aSquare file = $1 ) or: (aSquare file = $8))
                ifTrue: [ aSquare contents: self promoteToQueen ]
					 ifFalse: [aSquare contents: self]
]

{ #category : 'accessing' }
MyPawn >> promoteToQueen [ 
    "Transforme le pion en une reine de la même couleur."
    ^ MyQueen new color: self color.
]

{ #category : 'rendering' }
MyPawn >> renderOn: aSquare [
    ^ aSquare renderPawn: self.
]

{ #category : 'accessing' }
MyPawn >> targetSquaresLegal: aBoolean [
    | up1 up2 diagRight diagLeft down1 down2 |
    
    "Calcul des cases à déplacer"
    up1 := self square up.
    up2 := up1 ifNotNil: [ up1 up ].
    diagRight := self square right ifNotNil: [ self square right up ].
    diagLeft := self square left ifNotNil: [ self square left up ].
    down1 := self square down.
    down2 := down1 ifNotNil: [ down1 down ].
    
    ^ self isWhite
        ifTrue: [
            "Le pion est blanc"
            (self square file = $2)
                ifTrue: [
                    "Le pion est sur la ligne de départ"
                    { up1. up2. diagRight. diagLeft } select: [:s |
                        s notNil and: [
                            (s = up1 or: [ s = up2 ]) ifTrue: [ s hasPiece not ]
                            ifFalse: [ s hasPiece and: [ s contents color ~= self color ] ]
                        ]
                    ]
                ]
                ifFalse: [
                    "Le pion n'est pas sur la ligne de départ"
                    { up1. diagRight. diagLeft } select: [:s |
                        s notNil and: [
                            (s = up1) ifTrue: [ s hasPiece not ]
                            ifFalse: [ s hasPiece and: [ s contents color ~= self color ] ]
                        ]
                    ]
                ]
        ]
        ifFalse: [
            "Le pion est noir"
            (self square file = $7)
                ifTrue: [
                    "Le pion est sur la ligne de départ"
                    { down1. down2. diagRight. diagLeft } select: [:s |
                        s notNil and: [
                            (s = down1 or: [ s = down2 ]) ifTrue: [ s hasPiece not ]
                            ifFalse: [ s hasPiece and: [ s contents color ~= self color ] ]
                        ]
                    ]
                ]
                ifFalse: [
                    "Le pion n'est pas sur la ligne de départ"
                    { down1. diagRight. diagLeft } select: [:s |
                        s notNil and: [
                            (s = down1) ifTrue: [ s hasPiece not ]
                            ifFalse: [ s hasPiece and: [ s contents color ~= self color ] ]
                        ]
                    ]
                ]
        ].

]
