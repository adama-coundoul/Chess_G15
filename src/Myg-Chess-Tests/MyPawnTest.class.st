Class {
	#name : 'MyPawnTest',
	#superclass : 'TestCase',
	#category : 'Myg-Chess-Tests',
	#package : 'Myg-Chess-Tests'
}

{ #category : 'tests' }
MyPawnTest >> testId [ 

	self assert: MyPawn new id equals: 'P'
]

{ #category : 'tests' }
MyPawnTest >> testOneMove [

	| board pawnWhite pawnBlack moveWhite moveBlack |
	board := MyChessBoard empty.

	board at: 'e2' put: (pawnWhite := MyWhitePawn new).
	board at: 'e7' put: (pawnBlack := MyBlackPawn new).

	moveWhite := pawnWhite oneMove.
	moveBlack := pawnBlack oneMove.
	self assert: moveWhite equals: (board at: 'e3').
	self assert: moveBlack equals: (board at: 'e6')
]

{ #category : 'tests' }
MyPawnTest >> testPawnCaptureMove [

	| board whitePawn blackPawnLeft blackPawnRight moveLeft moveRight |

	board := MyChessBoard empty.

	board at: 'e5' put: (whitePawn := MyWhitePawn new).
	board at: 'd6' put: (blackPawnLeft := MyBlackPawn new). 
	board at: 'f6' put: (blackPawnRight := MyBlackPawn new). 

	moveLeft := whitePawn checkDiagonalCapture: whitePawn square left up.
	self assert: moveLeft equals: (board at: 'd6').
	moveRight := whitePawn checkDiagonalCapture: whitePawn square right up.
	self assert: moveRight equals: (board at: 'f6').

]

{ #category : 'tests' }
MyPawnTest >> testPawnMoveWithObstacle [
    | board pawnWhite pawnBlack moveWhite moveBlack obstacleSquare |
    
    board := MyChessBoard empty.

    board at: 'e2' put: (pawnWhite := MyWhitePawn new).
    board at: 'e7' put: (pawnBlack := MyBlackPawn new).

    board at: 'e3' put: (obstacleSquare := MyBlackPawn new).
    board at: 'e6' put: (obstacleSquare := MyWhitePawn new). 

    moveWhite := pawnWhite oneMove.
    moveBlack := pawnBlack oneMove.

    self assert: moveWhite isNil. 
    self assert: moveBlack isNil. 

]

{ #category : 'tests' }
MyPawnTest >> testTwoMoves [

	| board pawnWhite pawnBlack moveWhite moveBlack |
	board := MyChessBoard empty.

	board at: 'e2' put: (pawnWhite := MyWhitePawn new).
	board at: 'e7' put: (pawnBlack := MyBlackPawn new).

	moveWhite := pawnWhite twoMoves.
	moveBlack := pawnBlack twoMoves.
	self assert: moveWhite equals: (board at: 'e4').
	self assert: moveBlack equals: (board at: 'e5')
]
