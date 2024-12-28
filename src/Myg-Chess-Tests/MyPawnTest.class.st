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
	board at: 'd7' put: (pawn := MyWhitePawn new).
	

	pawn moveToAutomaticVersion: (board at: 'd8').
	self assert: ((board at:'d8') contents) class equals: MyWhiteQueen.
	
]

{ #category : 'tests' }
MyPawnTest >> testEnPassantCaptureSuccessful [ 
    | pawn opponentPawn board targetSquare |
    
    board := MyChessBoard empty.
    pawn := MyWhitePawn new .
    opponentPawn := MyBlackPawn new.
    
    "Placez le pion noir sur la case e7"
    board at: 'f7' put: opponentPawn.
    
    "Le pion blanc doit se trouver en e5 pour capturer en passant"
    board at: 'e5' put: pawn.

    "Déplacez le pion noir de f7 à f5"
    opponentPawn moveToAutomaticVersion: (board at: 'f5').

    "Simulez la capture en passant"
    targetSquare := 'f6'.
    pawn moveToAutomaticVersion: (board at: targetSquare).

    "Vérifiez que le pion noir est capturé"
    self assert: ((board at: 'f6') contents equals: pawn).

    self assert: ((board at: 'e5') contents isNil).
    self assert: ((board at: 'f5') contents isNil).
]

{ #category : 'tests' }
MyPawnTest >> testId [ 

	self assert: MyPawn new id equals: 'P'
]

{ #category : 'tests' }
MyPawnTest >> testInteractivePawnPromotion [
    | pawn board |
    
   
    board := MyChessBoard empty.
    pawn := MyBlackPawn new.
    board at: 'd7' put: pawn.
    self assert: ((board at:'d7') contents) equals: pawn .
    
  
    pawn class compile: 'promptForPromotion ^ MyBlackBishop new'.
   
    pawn moveToInteractiveVersion: (board at: 'd8').
    
   	self assert: ((board at:'d8') contents) class equals: MyBlackBishop .
    
   self assert: ((board at: 'd7') contents isNil).

    
    

   
]

{ #category : 'tests' }
MyPawnTest >> testNoAutomaticPawnPromotionWhenNotInLastRank [

| pawn board |
	board := MyChessBoard empty.
	board at: 'd6' put: (pawn := MyWhitePawn new).
	

	pawn moveToAutomaticVersion: (board at: 'd7').
	self assert: ((board at:'d7') contents)  equals: pawn.
	
]

{ #category : 'tests' }
MyPawnTest >> testNoInteractivePawnPromotionWhenNotInLastRank [

    | pawn board |
    
   
    board := MyChessBoard empty.
    pawn := MyBlackPawn new.
    board at: 'd5' put: pawn.
    self assert: ((board at:'d5') contents) equals: pawn .
    
  
    pawn class compile: 'promptForPromotion ^ MyBlackBishop new'.
   
    pawn moveToInteractiveVersion: (board at: 'd6').
    
   	self deny: ((board at:'d6') contents) class equals: MyBlackBishop .
    
   self assert: ((board at: 'd5') contents isNil).
   self assert: ((board at:'d6') contents) equals: pawn .
    
    

   
]

{ #category : 'tests' }
MyPawnTest >> testNoPromotionWhenNotPawn [

| piece board |
	board := MyChessBoard empty.
	board at: 'd7' put: (piece := MyWhiteRook new).
	

	piece moveToAutomaticVersion: (board at: 'd8').
	self assert: ((board at:'d8') contents) equals: piece.
	
]

{ #category : 'tests' }
MyPawnTest >> testPawnCaptureMove [ 
    | whitePawn blackPawnLeft blackPawnRight board squares |
    
    board := MyChessBoard empty.

    board at: 'e5' put: (whitePawn := MyWhitePawn new).

    board at: 'd6' put: (blackPawnLeft := MyBlackPawn new).
    board at: 'f6' put: (blackPawnRight := MyBlackPawn new).

    squares := whitePawn targetSquaresLegal: true. 

    self assertCollection: squares
        includesAll: (#(e6 d6 f6) collect: [ :name | board at: name ]).

]

{ #category : 'tests' }
MyPawnTest >> testPawnInitialDoubleMove [ 
    | pawn1 pawn2 squares1 squares2 board |
    board := MyChessBoard empty. 
    board at: 'e2' put: (pawn1 := MyWhitePawn new). 
    board at: 'e7' put: (pawn2 := MyBlackPawn new). 

    squares1 := pawn1 targetSquaresLegal: true. 
    squares2 := pawn2 targetSquaresLegal: true. 

    self assertCollection: squares1
        includesAll: (#(e3 e4) collect: [ :name | board at: name ]).
    self assertCollection: squares2
        includesAll: (#(e6 e5) collect: [ :name | board at: name ]).

]

{ #category : 'tests' }
MyPawnTest >> testSimplePawnMove [ 
    | pawn1 pawn2 squares1 squares2 board | 

    board := MyChessBoard empty.  

    board at: 'e4' put: (pawn1 := MyWhitePawn new).  
    board at: 'e7' put: (pawn2 := MyBlackPawn new ). 

    squares1 := pawn1 targetSquares.  
    squares2 := pawn2 targetSquares.

    self assertCollection: squares1 
        includesAll: 
            (#( e5) collect: [ :name | 
                board at: name ]).

    self assertCollection: squares2
        includesAll: 
            (#( e6) collect: [ :name | 
                board at: name ]).
]
