Class {
	#name : #BookReviewModel,
	#superclass : #Object,
	#instVars : [
		'inventory'
	],
	#category : #NYTimes
}

{ #category : #accessing }
BookReviewModel >> getItems: aKey [
	(aKey class name = 'NYTBook')	ifTrue: [ ^aKey getData ].
	(aKey class name = 'Dictionary') ifTrue: [ ^ inventory keys ].
	(aKey class name = 'ByteString') ifTrue: [ ^inventory at: aKey ].
	^ Array new.
]

{ #category : #accessing }
BookReviewModel >> presenterForModelObject: aModel [

	(aModel respondsTo: #at:ifAbsent:) ifTrue: [ 
		^ SpListPresenter new
			  items: (self getItems: aModel);
			  yourself ]
]
