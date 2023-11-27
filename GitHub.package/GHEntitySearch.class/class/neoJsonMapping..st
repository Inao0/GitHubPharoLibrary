accessing
neoJsonMapping: mapper
	super neoJsonMapping: mapper.
	mapper for: self do: [ :mapping |
		(mapping mapInstVar: #items) valueSchema: #ArrayOfRepos.
	].

	mapper for: #ArrayOfRepos customDo: [ :mapping |
		mapping listOfElementSchema: GHRepository
	].