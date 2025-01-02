Class {
	#name : 'MyPawnTest',
	#superclass : 'TestCase',
	#category : 'Myg-Chess-Tests',
	#package : 'Myg-Chess-Tests'
}

{ #category : 'tests' }
MyPawnTest >> testAutomaticPawnPromotion [

   |pawnWhite pawnBlack board |
	board := MyChessBoard empty.
	board at: 'd7' put: (pawnWhite := MyWhitePawn new).
	board at: 'c2' put: (pawnBlack := MyBlackPawn new).
	board game: MyChessGame freshGame.

	pawnWhite moveToAutomaticVersion: (board at: 'd8').
	pawnBlack moveToAutomaticVersion: (board at: 'c1').
	self deny: ((board at:'d8') contents)  equals: pawnWhite .
	self deny: ((board at:'c1') contents)  equals: pawnBlack .
	self assert: (((board at:'d8') contents) class) equals: MyWhiteQueen.
	self assert: (((board at:'c1') contents) class) equals: MyBlackQueen .
   self assert: ((board at: 'd7') contents isNil ).
   self assert: ((board at: 'c2') contents isNil ).
]

{ #category : 'tests' }
MyPawnTest >> testId [ 

	self assert: MyPawn new id equals: 'P'
]

{ #category : 'tests' }
MyPawnTest >> testInitialTwoMoves [
 
    | pawnWhite movePawnWhite pawnBlack movePawnBlack board |  
    board := MyChessBoard empty. 
    board game: MyChessGame freshGame.

    board at: 'e2' put: (pawnWhite := MyWhitePawn new).  
    board at: 'e7' put: (pawnBlack := MyBlackPawn new). 
    
	 movePawnWhite := pawnWhite targetSquares. 
    movePawnBlack := pawnBlack targetSquares. 

    self assertCollection: movePawnWhite 
        includesAll: 
            (#( e3 e4) collect: [ :name | 
                board at: name ]).


    self assertCollection: movePawnBlack 
        includesAll: 
            (#( e6 e5) collect: [ :name | 
                board at: name ]).

]

{ #category : 'tests' }
MyPawnTest >> testInteractivePawnPromotion [
   | pawnWhite pawnBlack board |
    
   
    board := MyChessBoard empty.
    pawnWhite := MyWhitePawn new.
    pawnBlack := MyBlackPawn new.
    board game: MyChessGame freshGame.
    board at: 'd7' put: pawnWhite.
    board at: 'c2' put: pawnBlack .
    self assert: ((board at:'d7') contents) equals: pawnWhite .
    self assert: ((board at:'c2') contents) equals: pawnBlack .
    
  
    pawnWhite class compile: 'showPromotionDialog ^ 3'.
    pawnBlack class compile: 'showPromotionDialog ^ 2'.

   
    pawnWhite moveToInteractiveVersion: (board at: 'd8').
    pawnBlack moveToInteractiveVersion: (board at: 'c1').
    
    self assert: ((board at: 'd7') contents isNil ).
    self deny: ((board at:'d8') contents) equals: pawnWhite .

    
    self assert: ((board at: 'c2') contents isNil ).
    self deny: ((board at:'c1') contents) equals: pawnBlack .

    self assert: (((board at:'d8') contents) class) equals: MyWhiteBishop.
	 self assert: (((board at:'c1') contents) class) equals: MyBlackRook .
]

{ #category : 'tests' }
MyPawnTest >> testNoAutomaticPawnPromotionWhenNotInLastRank [

| pawnWhite pawnBlack board |
	board := MyChessBoard empty.
	board at: 'd6' put: (pawnWhite := MyWhitePawn new).
	board at: 'c3' put: (pawnBlack := MyBlackPawn new).
	board game: MyChessGame freshGame.

	pawnWhite moveToAutomaticVersion: (board at: 'd7').
	pawnBlack moveToAutomaticVersion: (board at: 'c2').
	self deny: (((board at:'d7') contents) class) equals: MyWhiteQueen.
	self deny: (((board at:'c2') contents) class) equals: MyBlackQueen .
	self assert: ((board at:'d7') contents)  equals: pawnWhite .
	self assert: ((board at:'c2') contents)  equals: pawnBlack .
   self assert: ((board at: 'd6') contents isNil ).
   self assert: ((board at: 'c3') contents isNil ).
]

{ #category : 'tests' }
MyPawnTest >> testNoInteractivePawnPromotionWhenNotInLastRank [

    | pawnWhite pawnBlack board |
    
   
    board := MyChessBoard empty.
    pawnWhite := MyWhitePawn new.
    pawnBlack := MyBlackPawn new.
    board game: MyChessGame freshGame.
    board at: 'd5' put: pawnWhite.
    board at: 'c3' put: pawnBlack .
    self assert: ((board at:'d5') contents) equals: pawnWhite .
    self assert: ((board at:'c3') contents) equals: pawnBlack .
    
  
    pawnWhite class compile: 'showPromotionDialog ^ 3'.
    pawnBlack class compile: 'showPromotionDialog ^ 2'.

   
    pawnWhite moveToInteractiveVersion: (board at: 'd6').
    pawnBlack moveToInteractiveVersion: (board at: 'c2').
    
   	self deny: (((board at:'d6') contents) class) equals: MyWhiteBishop.
	self deny: (((board at:'c2') contents) class) equals: MyBlackRook .
    
   self assert: ((board at: 'd5') contents isNil ).
   self assert: ((board at:'d6') contents) equals: pawnWhite .

    
   self assert: ((board at: 'c3') contents isNil ).
   self assert: ((board at:'c2') contents) equals: pawnBlack .
]

{ #category : 'tests' }
MyPawnTest >> testNoPromotionWhenNotPawn [

| piece board piece1|
	board := MyChessBoard empty.
   board at: 'c2' put: (piece1 := MyBlackQueen new).
	board at: 'd7' put: (piece := MyWhiteRook new).

	piece moveTo: (board at: 'd8').
	piece1 moveTo: (board at: 'c1').
	self assert: ((board at:'d8') contents) equals: piece.
	self assert: ((board at:'c1') contents) equals: piece1.
]

{ #category : 'tests' }
MyPawnTest >> testPawnCaptureMove [
    | pawn capturedPawn board movePawnWhite |
    board := MyChessBoard empty.
    board game: MyChessGame freshGame.
    board at: 'e4' put: (pawn := MyWhitePawn new).
    board at: 'd5' put: (capturedPawn := MyBlackPawn new).

    movePawnWhite := pawn targetSquares.

    self assertCollection: movePawnWhite 
        includesAll: 
            (#( e5) collect: [ :name | 
                board at: name ]).

]

{ #category : 'tests' }
MyPawnTest >> testPawnMoveWithOponentObstacle [  

    | pawn squares board |
    board := MyChessBoard empty.
	 board game: MyChessGame freshGame.
    board at: 'e4' put: (pawn := MyWhitePawn new).

    board at: 'e5' put: MyBlackPawn new.
    squares := pawn targetSquares.

    "le pion ne peut pas avancer vers e5 car la case est occupée par le pion noir"
    self assertCollection: squares 
        includesAll: 
            (#( ) collect: [ :name | 
                board at: name ]).
]

{ #category : 'tests' }
MyPawnTest >> testSimpleOneMove [ 
    | pawnWhite movePawnWhite pawnBlack movePawnBlack board |  
    board := MyChessBoard empty. 
    board game: MyChessGame freshGame.

    board at: 'e4' put: (pawnWhite := MyWhitePawn new).  
    board at: 'e3' put: (pawnBlack := MyBlackPawn new). 
    
	 movePawnWhite := pawnWhite targetSquares. 
    movePawnBlack := pawnBlack targetSquares. 

    self assertCollection: movePawnWhite 
        includesAll: 
            (#( e5) collect: [ :name | 
                board at: name ]).


    self assertCollection: movePawnBlack 
        includesAll: 
            (#( e2) collect: [ :name | 
                board at: name ]).
]
