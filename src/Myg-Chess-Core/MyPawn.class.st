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
    
    (self isOnLastRank: square) 
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
MyPawn >> promoteToBishop [
    "Transforme le pion en une reine de la même couleur."
    ^ self subclassResponsibility 
]

{ #category : 'accessing' }
MyPawn >> promoteToKnight [
    "Transforme le pion en une reine de la même couleur."
    ^ self subclassResponsibility 
]

{ #category : 'accessing' }
MyPawn >> promoteToQueen [ 
    "Transforme le pion en une reine de la même couleur."
    ^ self subclassResponsibility 
]

{ #category : 'accessing' }
MyPawn >> promoteToRook [
    "Transforme le pion en une reine de la même couleur."
    ^ self subclassResponsibility 
]

{ #category : 'as yet unclassified' }
MyPawn >> promptForPromotion [
    | choice promotedPiece |
    "Afficher un dialogue personnalisé dans votre interface de jeu"
    choice := self showPromotionDialog.
    
    "Créer la nouvelle pièce selon le choix de l'utilisateur"
    choice = 'Queen' ifTrue: [promotedPiece := self promoteToQueen].
    choice = 'Rook' ifTrue: [promotedPiece := self promoteToRook ].
    choice = 'Bishop' ifTrue: [promotedPiece := self promoteToBishop ].
    choice = 'Knight' ifTrue: [promotedPiece := self promoteToKnight ].
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
   ^ self subclassResponsibility 
]
