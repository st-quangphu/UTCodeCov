import Foundation
import MUtility

public enum DecodableDefault {}

public protocol DecodableDefaultSource {
    associatedtype Value: Decodable
    static var defaultValue: Value { get }
}

public extension DecodableDefault {
    @propertyWrapper
    struct Wrapper<Source: DecodableDefaultSource> {
        public typealias Value = Source.Value
        public var wrappedValue = Source.defaultValue

        public init() {
            self.wrappedValue = Source.defaultValue
        }
    }
}

extension DecodableDefault.Wrapper: Decodable {
    public init(from decoder: Decoder) {
        do {
            let container = try decoder.singleValueContainer()
            wrappedValue = try container.decode(Value.self)
        } catch {
            wrappedValue = Source.defaultValue
            #if DEBUG
            Log.debug("PARSER ERROR: \(String(describing: error))")
            #endif
        }
    }
}

public extension KeyedDecodingContainer {
    func decode<T>(
        _ type: DecodableDefault.Wrapper<T>.Type,
        forKey key: Key
    ) throws -> DecodableDefault.Wrapper<T> {
        try decodeIfPresent(type, forKey: key) ?? .init()
    }
}

public extension DecodableDefault {
    typealias Source = DecodableDefaultSource
    typealias List = Decodable & ExpressibleByArrayLiteral
    typealias Map = Decodable & ExpressibleByDictionaryLiteral

    enum Sources {
        public enum True: Source {
            public static var defaultValue: Bool { true }
        }

        public enum False: Source {
            public static var defaultValue: Bool { false }
        }

        public enum ZeroInt: Source {
            public static var defaultValue: Int { 0 }
        }

        public enum ZeroFloat: Source {
            public static var defaultValue: Float { 0.0 }
        }

        public enum ZeroDouble: Source {
            public static var defaultValue: Double { 0.0 }
        }

        public enum EmptyString: Source {
            public static var defaultValue: String { "" }
        }

        public enum EmptyList<T: List>: Source {
            public static var defaultValue: T { [] }
        }

        public enum EmptyMap<T: Map>: Source {
            public static var defaultValue: T { [:] }
        }
    }
}

public extension DecodableDefault {
    typealias True = Wrapper<Sources.True>
    typealias False = Wrapper<Sources.False>
    typealias ZeroInt = Wrapper<Sources.ZeroInt>
    typealias ZeroFloat = Wrapper<Sources.ZeroFloat>
    typealias EmptyString = Wrapper<Sources.EmptyString>
    typealias EmptyList<T: List> = Wrapper<Sources.EmptyList<T>>
    typealias EmptyMap<T: Map> = Wrapper<Sources.EmptyMap<T>>
}

extension DecodableDefault.Wrapper: Equatable where Value: Equatable {}
extension DecodableDefault.Wrapper: Hashable where Value: Hashable {}

extension DecodableDefault.Wrapper: Encodable where Value: Encodable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(wrappedValue)
    }
}

// Example

struct Student: Decodable {
    var id: String
    @DecodableDefault.EmptyString var name: String
}

struct Teacher: Decodable {
    var id: String
    @DecodableDefault.EmptyString var name: String
}

struct Class: Decodable {
    var id: String
    @DecodableDefault.EmptyString var name: String
    @DecodableDefault.EmptyList var student: [Student]
    @DecodableDefault.ZeroInt var age: Int
    var teacher: Teacher?
}
