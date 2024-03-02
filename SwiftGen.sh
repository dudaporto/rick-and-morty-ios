BASE_PATH="RickAndMorty/Sources/Generated"

mkdir -p "$BASE_PATH"
touch "${BASE_PATH}/ColorSet.swift"
touch "${BASE_PATH}/ImageSet.swift"
touch "${BASE_PATH}/Strings.swift"

swiftgen
