import Foundation

protocol Coordinator: class {
    func start()
}

extension Coordinator {
    func coordinate(to coordinator: Coordinator) {
        coordinator.start()
    }
}
