Class {
	#name : 'MyMove',
	#superclass : 'Object',
	#instVars : [
		'lastPiece',
		'lastSquareFrom',
		'lastSquareTo'
	],
	#category : 'Myg-Chess-Core',
	#package : 'Myg-Chess-Core'
}

{ #category : 'accessing' }
MyMove >> lastPiece [

	^ lastPiece
]

{ #category : 'accessing' }
MyMove >> lastPiece: anObject [

	lastPiece := anObject
]

{ #category : 'accessing' }
MyMove >> lastSquareFrom [

	^ lastSquareFrom
]

{ #category : 'accessing' }
MyMove >> lastSquareFrom: anObject [

	lastSquareFrom := anObject
]

{ #category : 'accessing' }
MyMove >> lastSquareTo [

	^ lastSquareTo
]

{ #category : 'accessing' }
MyMove >> lastSquareTo: anObject [

	lastSquareTo := anObject
]
