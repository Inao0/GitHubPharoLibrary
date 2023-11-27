as yet unclassified
metacelloLoadString

	| ciDescriptor specs onConflict onUpgrade |
	ciDescriptor := STON fromString: (self getContentAtPath: '.smalltalk.ston') content.
	specs := ciDescriptor compatibleLoadSpecs first.

	onConflict := specs onConflict 
		ifNil: [ '' ]
		ifNotNil: [ :aValue | 'onConflict: ' , aValue asSymbol printString, ';' ].

	onUpgrade := specs onUpgrade 
		ifNil: [ '' ]
		ifNotNil: [ :aValue | 'onUpgrade: ' , aValue asSymbol printString  , ';' ].

	^ 'Metacello new
	 	baseline:''{baselineName}'';
	 	repository: ''github://{owner}/{repoName}:{defaultBranch}/{directory}'';
		{onConflict}
		{onUpgrade}
 		load: {load}' 
			format: { 
				#baselineName -> specs baseline.
				#owner -> (self owner at: #login).
				#repoName -> self name.
				#defaultBranch -> self defaultBranch.
				#directory -> specs directory.
				#onConflict -> onConflict.
				#onUpgrade -> onUpgrade. 
				#load -> specs load printString
			 } asDictionary.