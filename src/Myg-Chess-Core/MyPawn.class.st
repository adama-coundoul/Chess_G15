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

{ #category : 'rendering' }
MyPawn >> renderPieceOn: aSquare [

	^ self subclassResponsibility 

]

{ #category : 'accessing' }
MyPawn >> targetSquaresLegal: aBoolean [
   ^ self subclassResponsibility 
]

{ #category : 'as yet unclassified' }
MyPawn >> twoMoves [ 
 ^ self subclassResponsibility 
]
