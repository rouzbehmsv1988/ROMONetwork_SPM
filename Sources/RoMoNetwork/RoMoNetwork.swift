
import Combine
import Foundation

public class RoMoNetwork<T: Decodable> {
    deinit {
        cancellableData = nil
    }
    public static var shared: RoMoNetwork<T> {
        return RoMoNetwork<T>()
    }
    
   private var cancellableData: AnyCancellable?
    func requestPublisher(_ endpoint: Endpoint) -> AnyPublisher<T, Error> {
        if #available(macOS 10.15, *) {
            return APIClient().fetchData(endpoint.request).eraseToAnyPublisher()
        } else {
            // Fallback on earlier versions
        }
    }
    
    func request(_ endpoint: Endpoint, completionHandler: @escaping (_ data: T?, _ error: Error?) -> Void) {
        cancellableData = requestPublisher(endpoint).mapError({(error) -> Error in
            NSLog(error.localizedDescription)
            return error
        }).sink(receiveCompletion: { completion
            in
            switch completion {
                case .failure(let error): completionHandler(nil, error)
                case .finished: NSLog("failed to load data")
                               }
        }, receiveValue: {value in
            completionHandler(value, nil)
        })

    }
}

