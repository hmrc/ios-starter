//
//  AppDelegate+Injection.swift
//  Starter
//
//  Created by Mark Webb on 03/11/2020.
//

import Resolver
import ios_core_library

extension Resolver: ResolverRegistering {
    static let uiTestMock = Resolver(parent: main)

    public static func registerAllServices() {
        #if ENABLE_UITUNNEL
        if MobileCore.config.uiTests.areRunning {
            Resolver.root = Resolver.uiTestMock
            registerMockServices()
        }
        #endif

        registerServices()
    }
}
