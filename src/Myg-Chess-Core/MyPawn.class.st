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
MyPawn >> moveTo: aSquare [
	
    "Déplace le pion vers une nouvelle case et vérifie s'il doit être promu."
    (self legalTargetSquares includes: aSquare) ifFalse: [ ^ self ].
    square emptyContents.
    square := aSquare.
    (self isOnLastRank: square )
                ifTrue: [ aSquare contents: self promoteToQueen ]
					 ifFalse: [aSquare contents: self]
 
    
   
    
            
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

{ #category : 'as yet unclassified' }
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

{ #category : 'accessing' }
MyPawn >> renderPieceOn: aSquare [ 
	
	^ aSquare renderPawn: self
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
