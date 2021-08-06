"
API for getting NYTimes book reviews. 

 getNYTCategories - will retrieve the list of categories that are used to classify books being reviewed by the NYTimes
 
 getBookList: aCategory - pull the most recent list of books that have been reviewed for a category

 getAllBookLists - return the most recent book reviews in all categories listed. The resulting dictionary will have a key for each category which has a non-zero lenght list of book reviews. 




"
Class {
	#name : #BookReviewList,
	#superclass : #Object,
	#instVars : [
		'inventory',
		'categoryList'
	],
	#classInstVars : [
		'apiKey'
	],
	#category : #NYTimes
}

{ #category : #accessing }
BookReviewList class >> apiKey [

	^ apiKey
]

{ #category : #accessing }
BookReviewList class >> apiKey: anObject [

	apiKey := anObject
]

{ #category : #accessing }
BookReviewList >> bookNamesForCategory: aKey [

	aKey ifNotNil:  [ 
		(inventory keys includes: aKey)
		ifTrue: [ ^(inventory at: aKey) collect: [ :each | each  ] ]
		ifFalse: [ ^Array new ]].
	^ inventory  keys . 
	
	
]

{ #category : #accessing }
BookReviewList >> getAllBookLists [

	| list items|
	inventory ifNil: [ 
		inventory := Dictionary new.
		list := self getNYTCategories.
		list do: [ :category | 
			items := self getBookList: category.
			items isEmpty
				ifFalse: [ inventory at: category put: items ] ] ].
	^ inventory
]

{ #category : #accessing }
BookReviewList >> getBookList: aCategory [

	| response data  bookList  |
	response  := ZnClient new
			url: 
			'https://api.nytimes.com/svc/books/v3/lists/current/', 
				(ZnPercentEncoder new encode: aCategory), 
				'.json?api-key=', (KeyManager bookReviewKey );
		get; response. 

	response isSuccess
		ifTrue: [ 
			data := NeoJSONReader fromString: response contents.
			bookList := ((data at: 'results') at: 'books') collect: [ :each | 
				        NYTBook new fromData: each ] ]
		ifFalse: [ bookList := Array new ].
	^ bookList
]

{ #category : #accessing }
BookReviewList >> getItems: aKey [

	(aKey class name = 'NYTBook')	ifTrue: [ ^aKey getData ].
	(aKey class name = 'Dictionary') ifTrue: [ ^ inventory keys ].
	(aKey class name = 'ByteString') ifTrue: [ ^inventory at: aKey ].
	^ Array new.
	
]

{ #category : #'model access' }
BookReviewList >> getNYTCategories [

	| response data  key |
	key := KeyManager bookReviewKey.
	categoryList ifNil: [ 
		response := ZnClient new
			     url:'https://api.nytimes.com/svc/books/v3/lists/names.json?api-key=',key;
			            get;
			            response.
		data := NeoJSONReader fromString: response contents.
		categoryList := (data at: 'results') collect: [ :each | 
			                each at: 'display_name' ] ].

	^ categoryList
]

{ #category : #accessing }
BookReviewList >> inventory [

	^ inventory
]

{ #category : #accessing }
BookReviewList >> inventory: anObject [

	inventory := anObject
]
