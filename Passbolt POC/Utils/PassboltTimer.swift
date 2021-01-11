import Foundation

class PassboltTimer {

    private var startDate: Date?

    func start() {
        startDate = Date()
    }

    func stopAndReturnDuration() -> Double {
        guard let startDate = self.startDate else {
            return -1
        }
        let stopDate = Date()
        let duration = stopDate.timeIntervalSince(startDate)
        self.startDate = nil
        return duration
    }
}
