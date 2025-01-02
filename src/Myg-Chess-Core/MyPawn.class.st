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

{ #category : 'accessing' }
MyPawn >> diagLeftSquare [
 ^ self subclassResponsibility 
]

{ #category : 'accessing' }
MyPawn >> diagRightSquare [
 ^ self subclassResponsibility 
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

{ #category : 'rendering' }
MyPawn >> moveTo: aSquare [ 

	| enPassantSquare twoMoves |
   enPassantSquare := (self enPassantCapture includes: aSquare) 
    ifTrue: [
        self isWhite 
            ifTrue: [aSquare down] 
            ifFalse: [aSquare up]
    ].
   enPassantSquare ifNotNil: [
    enPassantSquare hasPiece ifTrue: [enPassantSquare emptyContents].
    ].
	twoMoves := aSquare = self twoMoves.
	aSquare ~= square ifFalse: [ ^ self ].
	super moveTo: aSquare.
	enPassant := twoMoves
		             ifTrue: [ aSquare ]
		             ifFalse: [ nil ].

]

{ #category : 'as yet unclassified' }
MyPawn >> oneMove [ 
 ^ self subclassResponsibility 
]

{ #category : 'rendering' }
MyPawn >> renderPieceOn: aSquare [

	^ self subclassResponsibility 

]

{ #category : 'accessing' }
MyPawn >> targetSquaresLegal: aBoolean [
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

{ #category : 'as yet unclassified' }
MyPawn >> twoMoves [ 
 ^ self subclassResponsibility 
]
