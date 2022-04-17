//
//  YLUserDefaults.swift
//  MJRefresh
//
//  Created by youzimu on 2022/4/11.
//

import Foundation

public class YLDefaultsKey {}

public final class Key<ValueType: Codable>: YLDefaultsKey {
    fileprivate let _key: String
    public init(_ key: String) {
        _key = key
    }
}

public final class YLDefaults {
    
    private var userDefaults: UserDefaults
    
    public static let shared = YLDefaults()
    
    public init(userDefaults: UserDefaults = UserDefaults.standard) {
        self.userDefaults = userDefaults
    }
    
    /// 清除
    public func yl_clear<ValueType>(_ key: Key<ValueType>) {
        userDefaults.set(nil, forKey: key._key)
        userDefaults.synchronize()
    }
    
    /// 查询
    public func yl_has<ValueType>(_ key: Key<ValueType>) -> Bool {
        return userDefaults.value(forKey: key._key) != nil
    }
    
    /// 取值
    /// - Returns: A `ValueType` or nil
    public func yl_get<ValueType>(for key: Key<ValueType>) -> ValueType? {
        if isSwiftCodableType(ValueType.self) || isFoundationCodableType(ValueType.self) {
            return userDefaults.value(forKey: key._key) as? ValueType
        }
        
        guard let data = userDefaults.data(forKey: key._key) else {
            return nil
        }
        
        do {
            let decoder = JSONDecoder()
            let decoded = try decoder.decode(ValueType.self, from: data)
            return decoded
        } catch {
            #if DEBUG
                print(error)
            #endif
        }

        return nil
        
    }
    
    /// 保存
    public func yl_set<ValueType>(_ value: ValueType, for key: Key<ValueType>) {
        if isSwiftCodableType(ValueType.self) || isFoundationCodableType(ValueType.self) {
            userDefaults.set(value, forKey: key._key)
            return
        }
        
        do {
            let encoder = JSONEncoder()
            let encoded = try encoder.encode(value)
            userDefaults.set(encoded, forKey: key._key)
            userDefaults.synchronize()
        } catch {
            #if DEBUG
                print(error)
            #endif
        }
    }
    
    /// 清理全部
    /// - Parameter type: Bundle.
    public func yl_removeAll(bundle : Bundle = Bundle.main) {
        guard let name = bundle.bundleIdentifier else { return }
        self.userDefaults.removePersistentDomain(forName: name)
    }
    
    /// 是否是swift 数据类型
    private func isSwiftCodableType<ValueType>(_ type: ValueType.Type) -> Bool {
        switch type {
        case is String.Type, is Bool.Type, is Int.Type, is Float.Type, is Double.Type:
            return true
        default:
            return false
        }
    }
    
    private func isFoundationCodableType<ValueType>(_ type: ValueType.Type) -> Bool {
        switch type {
        case is Date.Type:
            return true
        default:
            return false
        }
    }
    
}

// MARK: ValueType with RawRepresentable conformance
extension YLDefaults {
    /// Returns the value associated with the specified key.
    ///
    /// - Parameter key: The key.
    /// - Returns: A `ValueType` or nil if the key was not found.
    public func get<ValueType: RawRepresentable>(for key: Key<ValueType>) -> ValueType? where ValueType.RawValue: Codable {
        let convertedKey = Key<ValueType.RawValue>(key._key)
        if let raw = yl_get(for: convertedKey) {
            return ValueType(rawValue: raw)
        }
        return nil
    }

    /// Sets a value associated with the specified key.
    ///
    /// - Parameters:
    ///   - some: The value to set.
    ///   - key: The associated `Key<ValueType>`.
    public func set<ValueType: RawRepresentable>(_ value: ValueType, for key: Key<ValueType>) where ValueType.RawValue: Codable {
        let convertedKey = Key<ValueType.RawValue>(key._key)
        yl_set(value.rawValue, for: convertedKey)
    }
}
