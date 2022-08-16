//
//  WeatherDataStoreAccessor.swift
//  MService
//
//  Created by Quang Phu C. M. on 7/28/22.
//

import MModels
import MError
import MUtility

public protocol WeatherDataStoreAccessorType {
    func getBookmarks() -> DataStoreAccessResult.Many<WeatherDTO>
    func saveToBookmark(weather: WeatherDTO) -> DataStoreAccessResult.Void
    func isBookmarked(weather: WeatherDTO) -> Bool
    func deteleBookmark(weather: WeatherDTO) -> DataStoreAccessResult.Void
    func saveHistorySearch(keySearch: String)
    func getHistorySearch() -> [String]
}

public class WeatherDataStoreAccessor {
    struct UserDefaultsKeys {
        static let keywordSearchHistory = "KEYWORD_SEARCH_HISTORY"
    }

    let dbAccessor: CoreDataAccessor

    public init(dbAccesor: CoreDataAccessor) {
        self.dbAccessor = dbAccesor
    }
}

extension WeatherDataStoreAccessor: WeatherDataStoreAccessorType {

    public func deteleBookmark(weather: WeatherDTO) -> DataStoreAccessResult.Void {
        do {
            try dbAccessor.deleteOne(dto: weather, type: WeatherDTO.self)
            return .success(())
        } catch {
            return .failure(MError(error: error))
        }
    }

    public func getBookmarks() -> DataStoreAccessResult.Many<WeatherDTO> {
        do {
            let items = try dbAccessor.fetchAll(type: WeatherDTO.self)
            return .success(items)
        } catch {
            return .failure(MError(error: error))
        }
    }

    public func saveToBookmark(weather: WeatherDTO) -> DataStoreAccessResult.Void {
        do {
            try dbAccessor.writeOne(dto: weather, type: WeatherDTO.self)
            return .success(())
        } catch {
            return .failure(MError(error: error))
        }
    }

    public func isBookmarked(weather: WeatherDTO) -> Bool {
        do {
            // swiftlint:disable first_where
            let item = try dbAccessor.filter(
                weather.uniquePredicate,
                type: WeatherDTO.self
            ).first
            let saved = item != nil
            return saved
        } catch {
            return false
        }
    }

    public func saveHistorySearch(keySearch: String) {
        var keySearchs: [String] = UserDefaultAccessor.shared.getObjects(
            type: String.self,
            key: UserDefaultsKeys.keywordSearchHistory
        )

        keySearchs.insert(keySearch, at: 0)
        keySearchs = keySearchs.removeDuplicates()
        keySearchs = Array(keySearchs.prefix(5))

        UserDefaultAccessor.shared.saveObjects( keySearchs, forKey: UserDefaultsKeys.keywordSearchHistory)
    }

    public func getHistorySearch() -> [String] {
        let keySearchs = UserDefaultAccessor.shared.getObjects(
            type: String.self,
            key: UserDefaultsKeys.keywordSearchHistory)
        return keySearchs
    }
}
