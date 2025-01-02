Class {
	#name : 'MyPawn',
	#superclass : 'MyPiece',
	#instVars : [
		'enPassant'
	],
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'accessing' }
MyPawn >> canCaptureEnPassant [ 
 ^ self subclassResponsibility 
]

{ #category : 'accessing' }
MyPawn >> checkDiagonalCapture: aSquare [  

	^ (aSquare notNil and: [
					aSquare hasPiece and: [
						aSquare contents color ~= self color ]] )
				ifTrue: [ aSquare ]
				ifFalse: [ nil ].
]

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

{ #category : 'path commands' }
MyPawn >> enPassantCapture [ 
    | enPassantMoves lastMove oppositePawnPosition capture |

    enPassant ifNotNil: [ ^ OrderedCollection with: enPassant ].
    enPassantMoves := OrderedCollection new.
    lastMove := square board game lastMove.

    lastMove ifNotNil: [
        (lastMove lastPiece isPawn
            and: [ (lastMove lastSquareFrom file asInteger - lastMove lastSquareTo file asInteger) abs = 2 ])ifTrue: [
            self canCaptureEnPassant ifTrue: [
            oppositePawnPosition := lastMove lastSquareTo .
            (self square columnDifferenceWith: oppositePawnPosition) abs = 1 ifTrue: [
            capture := self isWhite
                        ifTrue: [ oppositePawnPosition up ]
                        ifFalse: [ oppositePawnPosition down ].
                    
            enPassant := capture.
            enPassantMoves add: capture.]]]].

    ^ enPassantMoves.
]

{ #category : 'accessing' }
MyPawn >> id [ 

	^ 'P'
]

{ #category : 'accessing' }
MyPawn >> initialize [ 
        super initialize.
		  enPassant := nil.
]

{ #category : 'as yet unclassified' }
MyPawn >> isOnLastRank: aSquare [ 

^ ((aSquare file = $1 ) or: (aSquare file = $8))
]

{ #category : 'testing' }
MyPawn >> isPawn [ 
^ true 
]

{ #category : 'accessing' }
MyPawn >> isWhite [ 
    ^ self color = Color white.
]

{ #category : 'path commands' }
MyPawn >> moveToAutomaticVersion: aSquare [ 
        | enPassantSquare twoMoves |
    (self legalTargetSquares includes: aSquare) ifFalse: [ ^ self ].

    enPassantSquare := (self enPassantCapture includes: aSquare)
        ifTrue: [
            self isWhite
                ifTrue: [ aSquare down ]
                ifFalse: [ aSquare up ]
        ].
    enPassantSquare ifNotNil: [ enPassantSquare emptyContents ].
    twoMoves := aSquare = self twoMoves.

    "Vide la case actuelle et met à jour le pion"
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

    enPassant := twoMoves
        ifTrue: [ aSquare ]
        ifFalse: [ nil ].


]

{ #category : 'path commands' }
MyPawn >> moveToInteractiveVersion: aSquare [ 
    | promotedPiece enPassantSquare twoMoves |

    (self legalTargetSquares includes: aSquare) ifFalse: [ ^ self ].

    enPassantSquare := (self enPassantCapture includes: aSquare)
        ifTrue: [
            self isWhite 
                ifTrue: [ aSquare down ] 
                ifFalse: [ aSquare up ]
        ].
    enPassantSquare ifNotNil: [ enPassantSquare emptyContents ].

    twoMoves := aSquare = self twoMoves.

    aSquare ~= square ifFalse: [ ^ self ].

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
   ^ self subclassResponsibility 
]

{ #category : 'as yet unclassified' }
MyPawn >> twoMoves [ 
 ^ self subclassResponsibility 
]
