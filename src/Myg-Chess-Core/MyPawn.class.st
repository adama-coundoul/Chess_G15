Class {
	#name : 'MyPawn',
	#superclass : 'MyPiece',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'as yet unclassified' }
MyPawn >> createPromotionDialog [
    | dialog layout |
    dialog := BlSpace new.
    layout := BlLinearLayout vertical.
    
    #('Queen' 'Rook' 'Bishop' 'Knight') do: [ :piece |
        | button |
        button := ToButton new
            label: piece;
            whenClickedDo: [ dialog close. ^piece ].
        layout addChild: button ].
    
    dialog root addChild: (BlElement new
        layout: layout;
        constraintsDo: [ :c |
            c horizontal fitContent.
            c vertical fitContent ]).
    dialog show.
]

{ #category : 'accessing' }
MyPawn >> id [ 

	^ 'P'
]

{ #category : 'as yet unclassified' }
MyPawn >> isOnLastRank: aSquare [ 

^ ((aSquare file = $1 ) or: (aSquare file = $8))
]

{ #category : 'testing' }
MyPawn >> isPawn [ 
^ true 
]

{ #category : 'path commands' }
MyPawn >> moveToAutomaticVersion: aSquare [
    
    (self legalTargetSquares includes: aSquare) ifFalse: [ ^ self ].
    square emptyContents.
    square := aSquare.
    (self isOnLastRank: square)
        ifTrue: [
            | newQueen |
            newQueen := self promoteToQueen.
            aSquare contents: newQueen.
            newQueen square: aSquare. 
        ]
        ifFalse: [
            aSquare contents: self
        ].

]

{ #category : 'path commands' }
MyPawn >> moveToInteractiveVersion: aSquare [
    | promotedPiece |
    
    "Déplace le pion vers une nouvelle case et vérifie s'il doit être promu."
    (self legalTargetSquares includes: aSquare) ifFalse: [ ^ self ].
    square emptyContents.
    square := aSquare.
    
    ((aSquare file = $1) or: (aSquare file = $8)) 
        ifTrue: [
            promotedPiece := self promptForPromotion.
            square contents: promotedPiece.
            promotedPiece square: aSquare.
        ]
        ifFalse: [
            aSquare contents: self
        ].
]

{ #category : 'accessing' }
MyPawn >> promoteToQueen [ 
    "Transforme le pion en une reine de la même couleur."
    ^ MyQueen new color: self color.
]

{ #category : 'as yet unclassified' }
MyPawn >> promptForPromotion [
    | choice promotedPiece |
    "Afficher un dialogue personnalisé dans votre interface de jeu"
    choice := self showPromotionDialog.
    
    "Créer la nouvelle pièce selon le choix de l'utilisateur"
    choice = 'Queen' ifTrue: [promotedPiece := (MyQueen new color: self color)].
    choice = 'Rook' ifTrue: [promotedPiece := (MyRook new color: self color)].
    choice = 'Bishop' ifTrue: [promotedPiece := (MyBishop new color: self color)].
    choice = 'Knight' ifTrue: [promotedPiece := (MyKnight new color: self color)].
    choice ifNil: [self error: 'Invalid choice'].
    
    ^ promotedPiece
]

{ #category : 'rendering' }
MyPawn >> renderPieceOn: aSquare [

	^ self subclassResponsibility 

]

{ #category : 'as yet unclassified' }
MyPawn >> showPromotionDialog [
    | window chosenPiece |
    chosenPiece := nil.
    
    window := SystemWindow new.
    window setLabel: 'Choose promotion piece'.
    
    #('Queen' 'Rook' 'Bishop' 'Knight') do: [ :pieceName |
        window addMorph: (
            ToButton new
                label: pieceName;
                color: Color lightGray;
                borderColor: Color black;
                borderWidth: 2;
                target: [ 
                    chosenPiece := pieceName.
                    window delete.
                ];
                actionSelector: #value
        )
    ].
    
    window extent: 200@250.
    window openCenteredInWorld.
    
    [chosenPiece isNil] whileTrue: [
        window world doOneCycle.
        (Delay forMilliseconds: 50) wait.
    ].
    
    ^ chosenPiece
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
