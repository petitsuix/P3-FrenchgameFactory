import Foundation

extension Collection {

    /// Returns the element at the specified index if it's within bounds, otherwise nil
    ///
    ///        [1, 2, 3, 4][safe: 4] -> nil
    ///        [1, 2, 3, 4][safe: 1] -> 2
    ///
    /// - Parameter index: The position of the element we want to be returned.
    subscript(safe index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
