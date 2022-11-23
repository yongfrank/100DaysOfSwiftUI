//
//  File.swift
//  
//
//  Created by Frank Chu on 10/14/22.
//

import Vapor

// Detects the environment from CommandLine.arguments. Invokes detect(from:).
var env: Environment = try Environment.detect()

/// Core type representing a Vapor application.
/// `public init(_ environment: Environment = .development,_ eventLoopGroupProvider: EventLoopGroupProvider = .createNew)`
let app = Application(env)

defer { app.shutdown() }

/// `    public func get<Response>(_ path: PathComponent..., use closure: @escaping (Request) throws -> Response) -> Route`
app.get { req in "Hello Vapor!" }

/// Starts the Application using the `start()` method, then waits for any running tasks to complete If your application is started without arguments, the default argument is used.
try app.run()
