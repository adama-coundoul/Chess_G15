Class {
	#name : 'MyPawnTest',
	#superclass : 'TestCase',
	#category : 'Myg-Chess-Tests',
	#package : 'Myg-Chess-Tests'
}

{ #category : 'tests' }
MyPawnTest >> testAutomaticPawnPromotion [

| pawn board |
	board := MyChessBoard empty.
	board game: MyChessGame freshGame.
	board at: 'd7' put: (pawn := MyWhitePawn new).
	

	pawn moveToAutomaticVersion: (board at: 'd8').
	self assert: ((board at:'d8') contents) class equals: MyWhiteQueen.
	
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
    | pawn board |
    
   
    board := MyChessBoard empty.
    board game: MyChessGame freshGame.
    pawn := MyWhitePawn new.
    board at: 'd7' put: pawn.
    self assert: ((board at:'d7') contents) equals: pawn .
    
   pawn class compile: 'showPromotionDialog ^ 3'.
   
    pawn moveToInteractiveVersion: (board at: 'd8').
    
   	self assert: ((board at:'d8') contents) class equals: MyWhiteBishop .
    
   self assert: ((board at: 'd7') contents isNil).

    
    

   
]

{ #category : 'tests' }
MyPawnTest >> testNoAutomaticPawnPromotionWhenNotInLastRank [

| pawn board |
	board := MyChessBoard empty.
	board game: MyChessGame freshGame.
	board at: 'd6' put: (pawn := MyWhitePawn new).
	

	pawn moveToAutomaticVersion: (board at: 'd7').
	self assert: ((board at:'d7') contents)  equals: pawn.
	
]

{ #category : 'tests' }
MyPawnTest >> testNoInteractivePawnPromotionWhenNotInLastRank [

    | pawn board |
    
   
    board := MyChessBoard empty.
    board game: MyChessGame freshGame.
    pawn := MyWhitePawn new.
    board at: 'd5' put: pawn.
    self assert: ((board at:'d5') contents) equals: pawn .
    
  
  pawn class compile: 'showPromotionDialog ^ 3'.
   
    pawn moveToInteractiveVersion: (board at: 'd6').
    
   	self deny: (((board at:'d6') contents) class) equals: MyWhiteBishop.
    
   self assert: ((board at: 'd5') contents isNil ).
   self assert: ((board at:'d6') contents) equals: pawn .
    
    

   
]

{ #category : 'tests' }
MyPawnTest >> testNoPromotionWhenNotPawn [

| piece board |
	board := MyChessBoard empty.
	board at: 'd7' put: (piece := MyWhiteRook new).
	

	piece moveTo: (board at: 'd8').
	self assert: ((board at:'d8') contents) equals: piece.
	
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
