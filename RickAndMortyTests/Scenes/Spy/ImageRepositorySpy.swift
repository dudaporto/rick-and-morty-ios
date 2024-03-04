import class UIKit.UIImage

@testable import RickAndMorty

final class ImageRepositorySpy: ImageRepositoryProtocol {
    private(set) var callLoadCount = 0
    private(set) var calledImageUrlPath: String?
    
    func load(for receiver: ImageReceiver, imageUrlPath: String) {
        callLoadCount += 1
        calledImageUrlPath = imageUrlPath
        receiver.setImage(UIImage())
    }
}
