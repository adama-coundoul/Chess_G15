Class {
	#name : 'MyPawnTest',
	#superclass : 'TestCase',
	#category : 'Myg-Chess-Tests',
	#package : 'Myg-Chess-Tests'
}

{ #category : 'tests' }
MyPawnTest >> testDiagonalCaptureMove [ 

    | pawn capturedPawn possibleMoves board |

    board := MyChessBoard empty.
    board at: 'e4' put: (pawn := MyPawn white).
    board at: 'd5' put: (capturedPawn := MyPawn black).  "Pièce adverse sur la case diagonale"
    
    possibleMoves := pawn targetSquares.

    self assertCollection: possibleMoves 
    includesAll: 
          (#( e5 d5) collect: [ :name | 
              board at: name ]).
]

{ #category : 'tests' }
MyPawnTest >> testEnPassantCaptureMove [
    | pawn opponentPawn board possibleMoves |
    
    board := MyChessBoard empty.
    pawn := MyPawn white.
    opponentPawn := MyPawn black.
    
    board at: 'f7' put: opponentPawn.
    board at: 'e5' put: pawn.

    opponentPawn moveTo: (board at: 'f5').

    possibleMoves := pawn targetSquares.

    self assertCollection: possibleMoves
        includesAll: 
            (#( e6 f6) collect: [ :name | 
                board at: name ]).
]

{ #category : 'tests' }
MyPawnTest >> testId [ 

	self assert: MyPawn new id equals: 'P'
]

{ #category : 'tests' }
MyPawnTest >> testInitialDoubleMove [ 

    | pawnWhite pawnBlack possibleMovesWhite possibleMovesBlack board |

    board := MyChessBoard empty. 
    board at: 'e2' put: (pawnWhite := MyPawn white). 
    board at: 'e7' put: (pawnBlack := MyPawn black ). 

    possibleMovesWhite := pawnWhite targetSquaresLegal: true. 
    possibleMovesBlack := pawnBlack targetSquaresLegal: true. 

    self assertCollection: possibleMovesWhite
        includesAll: (#(e3 e4) collect: [ :name | board at: name ]).
    self assertCollection: possibleMovesBlack
        includesAll: (#(e6 e5) collect: [ :name | board at: name ]).

]

{ #category : 'tests' }
MyPawnTest >> testSimpleMove [ 
    | pawnWhite pawnBlack possibleMovesWhite possibleMovesBlack board | 

    board := MyChessBoard empty.  

    board at: 'e4' put: (pawnWhite := MyPawn white).  
    board at: 'e7' put: (pawnBlack := MyPawn black). 

    possibleMovesWhite := pawnWhite targetSquares.  
    possibleMovesBlack := pawnBlack targetSquares.

    self assertCollection: possibleMovesWhite 
        includesAll: 
            (#( e5) collect: [ :name | 
                board at: name ]).

    self assertCollection: possibleMovesBlack
        includesAll: 
            (#( e6) collect: [ :name | 
                board at: name ]).
]

{ #category : 'tests' }
MyPawnTest >> testSimplePawnPromotion [

| pawn board |
	board := MyChessBoard empty.
	board at: 'd7' put: (pawn := MyPawn white).
	

	pawn moveTo: (board at: 'd8').
	self assert: (board at:'d8') contents equals: MyQueen white.
]
