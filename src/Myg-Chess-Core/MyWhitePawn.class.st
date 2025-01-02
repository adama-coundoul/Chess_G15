Class {
	#name : 'MyWhitePawn',
	#superclass : 'MyPawn',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'accessing' }
MyWhitePawn >> canCaptureEnPassant [
	^ self square file = $5.
]

{ #category : 'accessing' }
MyWhitePawn >> diagLeftSquare [
    ^ self square left ifNotNil: [ self square left up ].

]

{ #category : 'accessing' }
MyWhitePawn >> diagRightSquare [
    ^ self square right ifNotNil: [ self square right up ].
]

{ #category : 'accessing' }
MyWhitePawn >> enPassantCapture [ 
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
            capture := oppositePawnPosition up.
                    
            enPassant := capture.
            enPassantMoves add: capture.]]]].

    ^ enPassantMoves.
]

{ #category : 'as yet unclassified' }
MyWhitePawn >> moveTo: aSquare [ 

	| enPassantSquare twoMoves |
	enPassantSquare := (self enPassantCapture includes: aSquare)
		                         ifTrue: [aSquare down ].
	enPassantSquare ifNotNil: [ enPassantSquare emptyContents ].
	twoMoves := aSquare = self twoMoves.
	aSquare ~= square ifFalse: [ ^ self ].
	super moveTo: aSquare.
	enPassant := twoMoves
		             ifTrue: [ aSquare ]
		             ifFalse: [ nil ].

]

{ #category : 'accessing' }
MyWhitePawn >> oneMove [
    ^ self square up hasPiece ifFalse: [ self square up ] ifTrue: [ nil ].

]

{ #category : 'accessing' }
MyWhitePawn >> promoteToBishop [ 

^ MyWhiteBishop new . 
]

{ #category : 'accessing' }
MyWhitePawn >> promoteToKnight [ 

^ MyWhiteKnight new . 
]

{ #category : 'accessing' }
MyWhitePawn >> promoteToQueen [ 

^ MyWhiteQueen new. 
]

{ #category : 'accessing' }
MyWhitePawn >> promoteToRook [ 

^ MyWhiteRook new . 
]

{ #category : 'rendering' }
MyWhitePawn >> renderPieceOn: aSquare [

	^ aSquare renderWhitePawn
]

{ #category : 'as yet unclassified' }
MyWhitePawn >> showPromotionDialog [ ^ 3
]

{ #category : 'accessing' }
MyWhitePawn >> targetSquaresLegal: aBoolean [
    | possibleMoves diagLeftSquare diagRightSquare enPassantSquares |
    
    possibleMoves := OrderedCollection new.
    
    "L'avancement d'une seule ou deux cases"
    self oneMove ifNotNil: [ possibleMoves add: self oneMove ].
    self twoMoves ifNotNil: [ possibleMoves add: self twoMoves ].
    
    "Capture en diagonale"
    diagLeftSquare := self checkDiagonalCapture: self diagLeftSquare.
    diagRightSquare := self checkDiagonalCapture: self diagRightSquare.
    diagLeftSquare ifNotNil: [ possibleMoves add: diagLeftSquare ].
    diagRightSquare ifNotNil: [ possibleMoves add: diagRightSquare ].
    
    "Capture en passant"
    enPassantSquares := self enPassantCapture.
    enPassantSquares ifNotNil: [
        enPassantSquares isCollection
            ifTrue: [ possibleMoves addAll: enPassantSquares ]
            ifFalse: [ possibleMoves add: enPassantSquares ]
    ].
    
    ^ possibleMoves.

]

{ #category : 'accessing' }
MyWhitePawn >> twoMoves [
    "Renvoie la case en avant de deux cases si le déplacement est valide, sinon nil."
    | upSquare doubleUpSquare |
    upSquare := self square up.
    doubleUpSquare := upSquare ifNotNil: [ upSquare up ].
    (self square file = $2 and: [
        upSquare hasPiece not and: [
            doubleUpSquare hasPiece not ] ])
        ifTrue: [ ^ doubleUpSquare ].
    ^ nil.
]
