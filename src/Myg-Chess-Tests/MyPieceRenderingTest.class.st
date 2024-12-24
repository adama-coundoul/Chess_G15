Class {
	#name : 'MyPieceRenderingTest',
	#superclass : 'TestCase',
	#category : 'Myg-Chess-Tests',
	#package : 'Myg-Chess-Tests'
}

{ #category : 'tests' }
MyPieceRenderingTest >> testMyBishopRendering [

    | whiteSquare blackSquare whiteBishop blackBishop |

    whiteSquare := MyWhiteChessSquare new.
    blackSquare := MyBlackChessSquare new.

    whiteBishop := MyWhiteBishop new.
    blackBishop := MyBlackBishop new.

    self assert: (whiteBishop renderPieceOn: whiteSquare) equals: 'B'.
    self assert: (whiteBishop renderPieceOn: blackSquare) equals: 'b'.
    self assert: (blackBishop renderPieceOn: whiteSquare) equals: 'V'.
    self assert: (blackBishop renderPieceOn: blackSquare) equals: 'v'.

]

{ #category : 'tests' }
MyPieceRenderingTest >> testMyKingRendering [

| whiteSquare blackSquare whiteKing blackKing |

    whiteSquare := MyWhiteChessSquare new.
    blackSquare := MyBlackChessSquare new.

    whiteKing := MyWhiteKing new.
    blackKing := MyBlackKing new.

    self assert: (whiteKing renderPieceOn: whiteSquare) equals: 'K'.
    self assert: (whiteKing renderPieceOn: blackSquare) equals: 'k'.
    self assert: (blackKing renderPieceOn: whiteSquare) equals: 'L'.
    self assert: (blackKing renderPieceOn: blackSquare) equals: 'l'.

]

{ #category : 'tests' }
MyPieceRenderingTest >> testMyKnightRendering [

    | whiteSquare blackSquare whiteKnight blackKnight |

    whiteSquare := MyWhiteChessSquare new.
    blackSquare := MyBlackChessSquare new.

    whiteKnight := MyWhiteKnight new.
    blackKnight := MyBlackKnight new.

    self assert: (whiteKnight renderPieceOn: whiteSquare) equals: 'N'.
    self assert: (whiteKnight renderPieceOn: blackSquare) equals: 'n'.
    self assert: (blackKnight renderPieceOn: whiteSquare) equals: 'M'.
    self assert: (blackKnight renderPieceOn: blackSquare) equals: 'm'.



]

{ #category : 'as yet unclassified' }
MyPieceRenderingTest >> testMyPawnRendering [

   | whiteSquare blackSquare whitePawn blackPawn |

    whiteSquare := MyWhiteChessSquare new.
    blackSquare := MyBlackChessSquare new.

    whitePawn := MyWhitePawn new.
    blackPawn := MyBlackPawn new.

    self assert: (whitePawn renderPieceOn: whiteSquare) equals: 'P'.
    self assert: (whitePawn renderPieceOn: blackSquare) equals: 'p'.
    self assert: (blackPawn renderPieceOn: whiteSquare) equals: 'O'.
    self assert: (blackPawn renderPieceOn: blackSquare) equals: 'o'.


]

{ #category : 'tests' }
MyPieceRenderingTest >> testQueenRendering [ {
    "Créer une case et rendre les reines directement"
    self assert: (MyChessSquare new renderQueen: (MyQueen new color: #white)) = 'Q' 
        description: 'Erreur: rendu reine blanche incorrect.'.

    self assert: (MyChessSquare new renderQueen: (MyQueen new color: #black)) = 'q' 
        description: 'Erreur: rendu reine noire incorrect.'.

    "Afficher les résultats dans le Transcript (facultatif)"
    Transcript show: 'Reine blanche rendue: ', (MyChessSquare new renderQueen: (MyQueen new color: #white)); cr.
    Transcript show: 'Reine noire rendue: ', (MyChessSquare new renderQueen: (MyQueen new color: #black)); cr.
}
]

{ #category : 'tests' }
MyPieceRenderingTest >> testRookRendering [ {  
    "Créer une case et rendre les tours directement"
    self assert: (MyChessSquare new renderRook: (MyRook new color: #white)) = 'R' 
        description: 'Erreur: rendu tour blanche incorrect.'.

    self assert: (MyChessSquare new renderRook: (MyRook new color: #black)) = 'r' 
        description: 'Erreur: rendu tour noire incorrect.'.

    "Afficher les résultats dans le Transcript (facultatif)"
    Transcript show: 'Tour blanche rendue: ', (MyChessSquare new renderRook: (MyRook new color: #white)); cr.
    Transcript show: 'Tour noire rendue: ', (MyChessSquare new renderRook: (MyRook new color: #black)); cr.
}
]
