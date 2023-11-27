accessing
getPharoTopic: github

	| firstPage totalResults numberOfPages |
	firstPage := github 
		get: '/search/repositories?q=topic:pharo&per_page=100';
		responseAs: GHEntitySearch.
		
	totalResults := firstPage totalCount min: 1000.
	numberOfPages := (totalResults -1) // 100 + 1.
	
	^ (1 to: numberOfPages) flatCollect: [ :i |
		(github 
			get: '/search/repositories?q=topic:pharo&per_page=100&page=' , i printString;
			responseAs: GHEntitySearch) items
		 ]