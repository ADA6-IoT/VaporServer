//
//  File.swift
//  AppleAcademyChallenge6
//
//  Created by Apple Coding machine on 10/17/25.
//

import Foundation

protocol DIContainerProtocol {
    func register<T>(_ type: T.Type, factory: @escaping () -> T)
    func resolve<T>(_ type: T.Type) -> T
}

@preconcurrency
final class DIContainer: DIContainerProtocol, @unchecked Sendable {
    // MARK: - Singletone
    static let shared = DIContainer()
    
    // MARK: - Properties
    private var factories: [String: () -> Any] = [:]
    private var singletons: [String: Any] = [:]
    
    // MARK: - Init
    private init() {}
    
    /// 의존성 등록(매번 새로운 인스턴스 생성)
    func register<T>(_ type: T.Type, factory: @escaping () -> T) {
        let key = String(describing: type)
        factories[key] = factory
    }
    
    /// 싱글톤 의존성 등록(한 번만 생성)
    func registerSingleton<T>(_ type: T.Type, factory: @escaping () -> T) {
        let key = String(describing: type)
        factories[key] = factory
        
        // 싱글톤은 나중에 첫 resolve 시점에 생성
    }
    
    /// 이미 생성된 인스턴스를 싱글톤으로 등록
    func registerInstance<T>(_ type: T.Type, instance: T) {
        let key = String(describing: type)
        singletons[key] = instance
    }
    
    
    func resolve<T>(_ type: T.Type) -> T {
        let key = String(describing: type)
        
        // 이미 생성된 싱글톤이 있는지 확인
        if let singleton = singletons[key] as? T {
            return singleton
        }
        
        guard let factory = factories[key] else {
            fatalError("\(key) 존재하지 않아요")
        }
        
        guard let instance = factory() as? T else {
            fatalError("Faield to cast \(key)")
        }
        
        if factories[key] != nil && singletons[key] == nil {
            singletons[key] = instance
        }
        
        return instance
    }
    
    func reset() {
        factories.removeAll()
        singletons.removeAll()
    }
}

@propertyWrapper
struct Injected<T> {
    private let container: DIContainer
    
    var wrappedValue: T {
        container.resolve(T.self)
    }
    
    init(container: DIContainer = .shared) {
        self.container = container
    }
}
