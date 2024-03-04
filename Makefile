generate:
	xcodegen
	bash ./SwiftGen.sh
	bash ./apollo-generate.sh
	open RickAndMorty.xcodeproj