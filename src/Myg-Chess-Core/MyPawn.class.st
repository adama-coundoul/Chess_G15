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
