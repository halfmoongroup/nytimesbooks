Class {
	#name : #NYTimesBookReviewPresenter,
	#superclass : #SpMillerColumnPresenter,
	#instVars : [
		'nytBookModel',
		'presenter'
	],
	#category : #NYTimes
}

{ #category : #accessing }
NYTimesBookReviewPresenter >> itemsForKey: aKey [

	(aKey isNull) ifTrue: [^ nytBookModel keys  ].
	(self nytBookModel includes: aKey) 
		ifTrue: [ ^ (nytBookModel at: aKey) collect: [:each | each title]].
	^ Array new
	
]

{ #category : #accessing }
NYTimesBookReviewPresenter >> nytBookModel [

	^ nytBookModel
]

{ #category : #accessing }
NYTimesBookReviewPresenter >> nytBookModel: anObject [

	nytBookModel := anObject
]
