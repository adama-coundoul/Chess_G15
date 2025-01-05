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
MyPawnTest >> testEnPassantCaptureBlackPawn [     

	| pawnWhite pawnBlack board squareFrom enPassantSquareTo|     
	
	board := MyChessBoard empty.     
	board game: MyChessGame freshGame.      	 
	board at: 'e2' put: (pawnWhite := MyWhitePawn white).     
	board at: 'd7' put: (pawnBlack := MyBlackPawn black). 
	      	 
	board game move: pawnBlack to: pawnBlack square down down. 	 
	board game move: pawnBlack to: pawnBlack square down. 	 
	squareFrom := pawnWhite square. 
	 	 
	board game move: pawnWhite to: pawnWhite square up up. 	 
	enPassantSquareTo := pawnWhite square down.  
		 	 
	self assert: (pawnBlack enPassantCapture includes: enPassantSquareTo). 
	 	 
	board game move: pawnBlack to: enPassantSquareTo.  	 
	self assert: pawnBlack square equals: enPassantSquareTo. 	 
	self deny: squareFrom hasPiece.
]

{ #category : 'tests' }
MyPawnTest >> testEnPassantCaptureFailsIfNotLastMove [ 
    | pawnWhite pawnBlack board anotherPiece enPassantSquareTo |
    board := MyChessBoard empty.
    board game: MyChessGame freshGame.

    board at: 'e2' put: (pawnWhite := MyWhitePawn new).
    board at: 'd7' put: (pawnBlack := MyBlackPawn new).
    board at: 'a1' put: (anotherPiece := MyWhiteRook new).


    board game move: pawnWhite to: (board at: 'e4').
    board game move: pawnWhite to: (board at: 'e5').

    board game move: pawnBlack to: (board at: 'd5').

    "Un autre mouvement est effectué"
    board game move: anotherPiece to: (board at: 'a2').

    "Capture en passant échoue car le dernier mouvement n'était pas celui du pion noir"
    enPassantSquareTo := board at: 'd6'. 
    self deny: (pawnWhite enPassantCapture includes: enPassantSquareTo).

]

{ #category : 'tests' }
MyPawnTest >> testEnPassantCaptureFailsIfNotTwoSquares [ 
    | pawnWhite pawnBlack board enPassantSquareTo |
    board := MyChessBoard empty.
    board game: MyChessGame freshGame.
    
    board at: 'e2' put: (pawnWhite := MyWhitePawn white).
    "Le pion noir n'est pas à sa position initiale"
    board at: 'd6' put: (pawnBlack := MyBlackPawn black). 

    board game move: pawnWhite to: pawnWhite square up up.
    board game move: pawnWhite to: pawnWhite square up.
    "Le pion noir avance d'une seule case"
    board game move: pawnBlack to: pawnBlack square down. 

    enPassantSquareTo := pawnBlack square up.

    "La capture en passant n'est pas possible"
    self deny: (pawnWhite enPassantCapture includes: enPassantSquareTo).

]

{ #category : 'tests' }
MyPawnTest >> testEnPassantCaptureWhitePawn [ 
    | pawnWhite pawnBlack board squareFrom enPassantSquareTo|
    board := MyChessBoard empty.
    board game: MyChessGame freshGame.
    
	 board at: 'e2' put: (pawnWhite := MyWhitePawn white).
    board at: 'd7' put: (pawnBlack := MyBlackPawn black).
    

	 board game move: pawnWhite to: pawnWhite square up up.
	 board game move: pawnWhite to: pawnWhite square up.
	 squareFrom := pawnWhite square.

	 board game move: pawnBlack to: pawnBlack square down down.
	 enPassantSquareTo := pawnBlack square up. 
	
	 self assert: (pawnWhite enPassantCapture includes: enPassantSquareTo).

	 board game move: pawnWhite to: enPassantSquareTo.

	 self assert: pawnWhite square equals: enPassantSquareTo.
	 self deny: squareFrom hasPiece. 
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

    "Pion blanc"
    self assertCollection: movePawnWhite 
        includesAll: 
            (#( e3 e4) collect: [ :name | 
                board at: name ]).

    "Pion noir"
    self assertCollection: movePawnBlack 
        includesAll: 
            (#( e6 e5) collect: [ :name | 
                board at: name ]).

]

{ #category : 'tests' }
MyPawnTest >> testInteractivePawnPromotioWhenUserChooseBishop [
   | pawnWhite pawnBlack board |
    
   
    board := MyChessBoard empty.
    pawnWhite := MyWhitePawn new.
    pawnBlack := MyBlackPawn new.
    board game: MyChessGame freshGame.
    board at: 'd7' put: pawnWhite.
    board at: 'c2' put: pawnBlack .
    self assert: ((board at:'d7') contents) equals: pawnWhite .
    self assert: ((board at:'c2') contents) equals: pawnBlack .
    
    "3 représente l'index du bishop dans la liste des options de promotion dans la méthode showPromotionDialog."
    pawnWhite class compile: 'showPromotionDialog ^ 3'.
    pawnBlack class compile: 'showPromotionDialog ^ 3'.
    
   
    pawnWhite moveToInteractiveVersion: (board at: 'd8').
    pawnBlack moveToInteractiveVersion: (board at: 'c1').
    
    self assert: ((board at: 'd7') contents isNil ).
    self deny: ((board at:'d8') contents) equals: pawnWhite .

    
    self assert: ((board at: 'c2') contents isNil ).
    self deny: ((board at:'c1') contents) equals: pawnBlack .

    self assert: (((board at:'d8') contents) class) equals: MyWhiteBishop .
	 self assert: (((board at:'c1') contents) class) equals: MyBlackBishop .
    
]

{ #category : 'tests' }
MyPawnTest >> testInteractivePawnPromotioWhenUserChooseKnight [
   | pawnWhite pawnBlack board |
    
   
    board := MyChessBoard empty.
    pawnWhite := MyWhitePawn new.
    pawnBlack := MyBlackPawn new.
    board game: MyChessGame freshGame.
    board at: 'd7' put: pawnWhite.
    board at: 'c2' put: pawnBlack .
    self assert: ((board at:'d7') contents) equals: pawnWhite .
    self assert: ((board at:'c2') contents) equals: pawnBlack .
    
    "4 représente l'index du Knight dans la liste des options de promotion dans la méthode showPromotionDialog."
    pawnWhite class compile: 'showPromotionDialog ^ 4'.
    pawnBlack class compile: 'showPromotionDialog ^ 4'.

   
    pawnWhite moveToInteractiveVersion: (board at: 'd8').
    pawnBlack moveToInteractiveVersion: (board at: 'c1').
    
    self assert: ((board at: 'd7') contents isNil ).
    self deny: ((board at:'d8') contents) equals: pawnWhite .

    
    self assert: ((board at: 'c2') contents isNil ).
    self deny: ((board at:'c1') contents) equals: pawnBlack .

    self assert: (((board at:'d8') contents) class) equals: MyWhiteKnight .
	 self assert: (((board at:'c1') contents) class) equals: MyBlackKnight .
]

{ #category : 'tests' }
MyPawnTest >> testInteractivePawnPromotioWhenUserChooseQueen [
   | pawnWhite pawnBlack board |
    
   
    board := MyChessBoard empty.
    pawnWhite := MyWhitePawn new.
    pawnBlack := MyBlackPawn new.
    board game: MyChessGame freshGame.
    board at: 'd7' put: pawnWhite.
    board at: 'c2' put: pawnBlack .
    self assert: ((board at:'d7') contents) equals: pawnWhite .
    self assert: ((board at:'c2') contents) equals: pawnBlack .
    
    "1 représente l'index de la reine dans la liste des options de promotion dans la méthode showPromotionDialog."
    pawnWhite class compile: 'showPromotionDialog ^ 1'.
    pawnBlack class compile: 'showPromotionDialog ^ 1'.

   
    pawnWhite moveToInteractiveVersion: (board at: 'd8').
    pawnBlack moveToInteractiveVersion: (board at: 'c1').
    
    self assert: ((board at: 'd7') contents isNil ).
    self deny: ((board at:'d8') contents) equals: pawnWhite .

    
    self assert: ((board at: 'c2') contents isNil ).
    self deny: ((board at:'c1') contents) equals: pawnBlack .

    self assert: (((board at:'d8') contents) class) equals: MyWhiteQueen .
	 self assert: (((board at:'c1') contents) class) equals: MyBlackQueen .
]

{ #category : 'tests' }
MyPawnTest >> testInteractivePawnPromotioWhenUserChooseRook [
   | pawnWhite pawnBlack board |
    
   
    board := MyChessBoard empty.
    pawnWhite := MyWhitePawn new.
    pawnBlack := MyBlackPawn new.
    board game: MyChessGame freshGame.
    board at: 'd7' put: pawnWhite.
    board at: 'c2' put: pawnBlack .
    self assert: ((board at:'d7') contents) equals: pawnWhite .
    self assert: ((board at:'c2') contents) equals: pawnBlack .
    
    "2 représente l'index du rook dans la liste des options de promotion dans la méthode showPromotionDialog."
    pawnWhite class compile: 'showPromotionDialog ^ 2'.
    pawnBlack class compile: 'showPromotionDialog ^ 2'.

   
    pawnWhite moveToInteractiveVersion: (board at: 'd8').
    pawnBlack moveToInteractiveVersion: (board at: 'c1').
    
    self assert: ((board at: 'd7') contents isNil ).
    self deny: ((board at:'d8') contents) equals: pawnWhite .

    
    self assert: ((board at: 'c2') contents isNil ).
    self deny: ((board at:'c1') contents) equals: pawnBlack .

    self assert: (((board at:'d8') contents) class) equals: MyWhiteRook .
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
MyPawnTest >> testPawnCaptureMoveBySameColor [
    | pawn capturedPawn1 capturedPawn2 board movePawnWhite |
    board := MyChessBoard empty.
    board game: MyChessGame freshGame.
    board at: 'e4' put: (pawn := MyWhitePawn white).

    "capture diagonale gauche"
    board at: 'd5' put: (capturedPawn1 := MyWhitePawn white).
    "capture diagonale droite"
    board at: 'f5' put: (capturedPawn2 := MyWhitePawn white).

    movePawnWhite := pawn targetSquares.


    "Le pion ne peut pas capturer les pièces de sa propre couleur"
    self assertCollection: movePawnWhite 
        includesAll: 
            (#( e5) collect: [ :name | 
                board at: name ]).

]

{ #category : 'tests' }
MyPawnTest >> testPawnCaptureMoveOponentPiece [
    | pawn capturedPawn1 capturedPawn2 board movePawnWhite |
    board := MyChessBoard empty.
    board game: MyChessGame freshGame.
    board at: 'e4' put: (pawn := MyWhitePawn white).

    "capture diagonale gauche"
    board at: 'd5' put: (capturedPawn1 := MyBlackPawn black).
    "capture diagonale droite"
    board at: 'f5' put: (capturedPawn2 := MyBlackPawn black).

    movePawnWhite := pawn targetSquares.

    self assertCollection: movePawnWhite 
        includesAll: 
            (#( e5 d5 f5) collect: [ :name | 
                board at: name ]).

]

{ #category : 'tests' }
MyPawnTest >> testPromoteToBishop [ 

|pawnWhite pawnBlack piece1 piece2 |
pawnWhite := MyWhitePawn new.
pawnBlack := MyBlackPawn new.

piece1:= pawnWhite promoteToBishop .
piece2:= pawnBlack promoteToBishop .

self assert: piece1 class equals: MyWhiteBishop .
self assert: piece2 class equals: MyBlackBishop .
]

{ #category : 'tests' }
MyPawnTest >> testPromoteToKnight [

|pawnWhite pawnBlack piece1 piece2 |
pawnWhite := MyWhitePawn new.
pawnBlack := MyBlackPawn new.

piece1:= pawnWhite promoteToKnight .
piece2:= pawnBlack promoteToKnight .

self assert: piece1 class equals: MyWhiteKnight .
self assert: piece2 class equals: MyBlackKnight .
]

{ #category : 'tests' }
MyPawnTest >> testPromoteToQueen [

|pawnWhite pawnBlack piece1 piece2 |
pawnWhite := MyWhitePawn new.
pawnBlack := MyBlackPawn new.

piece1:= pawnWhite promoteToQueen .
piece2:= pawnBlack promoteToQueen .

self assert: piece1 class equals: MyWhiteQueen .
self assert: piece2 class equals: MyBlackQueen 
]

{ #category : 'tests' }
MyPawnTest >> testPromoteToRook [

|pawnWhite pawnBlack piece1 piece2 |
pawnWhite := MyWhitePawn new.
pawnBlack := MyBlackPawn new.

piece1:= pawnWhite promoteToRook .
piece2:= pawnBlack promoteToRook .

self assert: piece1 class equals: MyWhiteRook .
self assert: piece2 class equals: MyBlackRook .
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

    "Pion blanc"
    self assertCollection: movePawnWhite 
        includesAll: 
            (#( e5) collect: [ :name | 
                board at: name ]). 

    "Pion noir"
    self assertCollection: movePawnBlack 
        includesAll: 
            (#( e2) collect: [ :name | 
                board at: name ]).
]
