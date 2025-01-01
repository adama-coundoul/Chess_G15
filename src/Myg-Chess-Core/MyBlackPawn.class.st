Class {
	#name : 'MyBlackPawn',
	#superclass : 'MyPawn',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'accessing' }
MyBlackPawn >> canCaptureEnPassant [
	^ self square file = $4.
]

{ #category : 'accessing' }
MyBlackPawn >> diagLeftSquare [
    ^ self square left ifNotNil: [ self square left down ].

]

{ #category : 'accessing' }
MyBlackPawn >> diagRightSquare [
    ^ self square right ifNotNil: [ self square right down ].
]

{ #category : 'accessing' }
MyBlackPawn >> enPassantCapture [ 
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
            capture := oppositePawnPosition down.
                    
            enPassant := capture.
            enPassantMoves add: capture.]]]].

    ^ enPassantMoves.
]

{ #category : 'accessing' }
MyBlackPawn >> moveTo: aSquare [ 

	| enPassantSquare twoMoves |
	enPassantSquare := (self enPassantCapture includes: aSquare)
		                         ifTrue: [aSquare up ].
	enPassantSquare ifNotNil: [ enPassantSquare emptyContents ].
	twoMoves := aSquare = self twoMoves.
	aSquare ~= square ifFalse: [ ^ self ].
	super moveTo: aSquare.
	enPassant := twoMoves
		             ifTrue: [ aSquare ]
		             ifFalse: [ nil ].

]

{ #category : 'rendering' }
MyBlackPawn >> oneMove [
    ^ self square down hasPiece ifFalse: [ self square down ] ifTrue: [ nil ].

]

{ #category : 'accessing' }
MyBlackPawn >> promoteToBishop [ 

^ MyBlackBishop new .
]

{ #category : 'accessing' }
MyBlackPawn >> promoteToKnight [ 

^ MyBlackKnight new .
]

{ #category : 'accessing' }
MyBlackPawn >> promoteToQueen [ 

^ MyBlackQueen new .
]

{ #category : 'accessing' }
MyBlackPawn >> promoteToRook [ 

^ MyBlackRook new .
]

{ #category : 'rendering' }
MyBlackPawn >> renderPieceOn: aSquare [

	^ aSquare renderBlackPawn
]

{ #category : 'accessing' }
MyBlackPawn >> targetSquaresLegal: aBoolean [
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
MyBlackPawn >> twoMoves [
    "Renvoie la case en avant de deux cases si le déplacement est valide, sinon nil."
    | downSquare doubleDownSquare |
    downSquare := self square down.
    doubleDownSquare := downSquare ifNotNil: [ downSquare down ].
    (self square file = $7 and: [
        downSquare hasPiece not and: [
            doubleDownSquare hasPiece not ] ])
        ifTrue: [ ^ doubleDownSquare ].
    ^ nil.
]
