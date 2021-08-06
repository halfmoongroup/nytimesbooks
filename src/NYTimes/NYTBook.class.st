Class {
	#name : #NYTBook,
	#superclass : #Object,
	#instVars : [
		'title',
		'rank',
		'author',
		'isbn',
		'description'
	],
	#category : #NYTimes
}

{ #category : #accessing }
NYTBook >> author [

	^ author
]

{ #category : #accessing }
NYTBook >> author: anObject [

	author := anObject
]

{ #category : #accessing }
NYTBook >> description [

	^ description
]

{ #category : #accessing }
NYTBook >> description: anObject [

	description := anObject
]

{ #category : #'instance creation' }
NYTBook >> fromData: aDictionary [

	title := (aDictionary at: 'title'). 
	author := (aDictionary at: 'author').
	rank := (aDictionary at: 'rank'). 
	isbn := (aDictionary at: 'primary_isbn10'). 
	description := (aDictionary at: 'description'). 
	^self
]

{ #category : #'as yet unclassified' }
NYTBook >> getData [

	| list | 
	list := Array new. 
	self class allInstVarNames collect: [ :each | self instVarNamed: each ]
]

{ #category : #accessing }
NYTBook >> isbn [

	^ isbn
]

{ #category : #accessing }
NYTBook >> isbn: anObject [

	isbn := anObject
]

{ #category : #accessing }
NYTBook >> rank [

	^ rank
]

{ #category : #accessing }
NYTBook >> rank: anObject [

	rank := anObject
]

{ #category : #accessing }
NYTBook >> title [

	^ title
]

{ #category : #accessing }
NYTBook >> title: anObject [

	title := anObject
]
