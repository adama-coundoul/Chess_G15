Class {
	#name : 'MyPawn',
	#superclass : 'MyPiece',
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'accessing' }
MyPawn >> id [ 

	^ 'P'
]

{ #category : 'accessing' }
MyPawn >> renderPieceOn: aSquare [ 
	
	^ aSquare renderPawn: self
]

{ #category : 'accessing' }
MyPawn >> targetSquaresLegal: aBoolean [
    ^ (self isWhite
        ifTrue: [
            "le pion est blanc"
            ((self square file = $2) 
                ifTrue: [
                    "le pion est sur la ligne de départ"
                    | up1 up2 diagRight diagLeft |  
                    
                    up1 := self square up.  
                    up2 := up1 ifNotNil: [ up1 up ].  
                    diagRight := self square right up.
                    diagLeft := self square left up.  
                    
                    { up1. up2. diagRight. diagLeft }  "Collection de cases potentielles"
                        select: [:s | 
                            s notNil and: [ 
                                (s = up1 or: [ s = up2 ]) ifTrue: [ s hasPiece not ]   "Case avant doit être libre"
                                ifFalse: [ s hasPiece and: [ s contents color ~= self color ] ] "Diagonale doit avoir une pièce adverse"
                            ]].
                ]
                ifFalse: [
                    "le pion n'est pas sur la ligne de départ"
                    
                    | diagRight diagLeft |
                    diagRight := self square right up. 
                    diagLeft := self square left up.  
                    
                    { self square up. diagRight. diagLeft } 
                        select: [:s | 
                            s notNil and: [ 
                                (s = self square up) ifTrue: [ s hasPiece not ]   
                                ifFalse: [ s hasPiece and: [ s contents color ~= self color ] ] 
                            ]].
                ])
        ]
        
        ifFalse: [
            "le pion est noir"
            
            ((self square file = $7)  
                ifTrue: [
                    "le pion est sur la ligne de départ"
                    
                    | down1 down2 diagRight diagLeft |  
                    
                    down1 := self square down.  
                    down2 := down1 ifNotNil: [ down1 down ].  
                    diagRight := self square right down.  
                    diagLeft := self square left down. 
                    
                    { down1. down2. diagRight. diagLeft }  
                        select: [:s | 
                            s notNil and: [ 
                                (s = down1 or: [ s = down2 ]) ifTrue: [ s hasPiece not ]   
                                ifFalse: [ s hasPiece and: [ s contents color ~= self color ] ]
                            ]].
                ]
                ifFalse: [
                    "le pion n'est pas sur la ligne de départ"
                    
                    | diagRight diagLeft |
                    diagRight := self square right down.  
                    diagLeft := self square left down.  
                    
                    { self square down. diagRight. diagLeft }  
                        select: [:s | 
                            s notNil and: [ 
                                (s = self square down) ifTrue: [ s hasPiece not ]   
                                ifFalse: [ s hasPiece and: [ s contents color ~= self color ] ] 
                            ]].
                ])
        ]).
]
