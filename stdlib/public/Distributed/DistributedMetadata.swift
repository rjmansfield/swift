//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2020-2021 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import Swift

/// Get the parameter count from a mangled method name.
///
/// - Returns: May return a negative number to signal a decoding error.
@available(SwiftStdlib 5.7, *)
public // SPI Distributed
func _getParameterCount(mangledMethodName name: String) -> Int32 {
  let nameUTF8 = Array(name.utf8)
  return nameUTF8.withUnsafeBufferPointer { nameUTF8 in
    return __getParameterCount(
        nameUTF8.baseAddress!, UInt(nameUTF8.endIndex))
  }
}

@available(SwiftStdlib 5.7, *)
@_silgen_name("swift_func_getParameterCount")
public // SPI Distributed
func __getParameterCount(
    _ typeNameStart: UnsafePointer<UInt8>,
    _ typeNameLength: UInt
) -> Int32

/// Write the Metadata of all the mangled methods name's
/// parameters into the provided buffer.
///
/// - Returns: the actual number of types written,
///            or negative value to signify an error
@available(SwiftStdlib 5.7, *)
public // SPI Distributed
func _getParameterTypeInfo(
  mangledMethodName name: String,
  genericEnv: UnsafeRawPointer?, // GenericEnvironmentDescriptor *
  genericArguments: UnsafeRawPointer?,
  into typesBuffer: Builtin.RawPointer, length typesLength: Int
) -> Int32 {
  let nameUTF8 = Array(name.utf8)
  return nameUTF8.withUnsafeBufferPointer { nameUTF8 in
    return __getParameterTypeInfo(
        nameUTF8.baseAddress!, UInt(nameUTF8.endIndex),
        genericEnv, genericArguments, typesBuffer, typesLength)
  }
}

/// - Returns: the actual number of types written,
///             or a negative value to signal decoding error.
@available(SwiftStdlib 5.7, *)
@_silgen_name("swift_func_getParameterTypeInfo")
public // SPI Distributed
func __getParameterTypeInfo(
    _ typeNameStart: UnsafePointer<UInt8>, _ typeNameLength: UInt,
    _ genericEnv: UnsafeRawPointer?, // GenericEnvironmentDescriptor *
    _ genericArguments: UnsafeRawPointer?,
    _ types: Builtin.RawPointer, _ typesLength: Int
) -> Int32

@available(SwiftStdlib 5.7, *)
public // SPI Distributed
func _getReturnTypeInfo(
  mangledMethodName name: String,
  genericEnv: UnsafeRawPointer?, // GenericEnvironmentDescriptor *
  genericArguments: UnsafeRawPointer?
) -> Any.Type? {
  let nameUTF8 = Array(name.utf8)
  return nameUTF8.withUnsafeBufferPointer { nameUTF8 in
    return __getReturnTypeInfo(nameUTF8.baseAddress!, UInt(nameUTF8.endIndex),
                               genericEnv, genericArguments)
  }
}

@available(SwiftStdlib 5.7, *)
@_silgen_name("swift_func_getReturnTypeInfo")
public // SPI Distributed
func __getReturnTypeInfo(
    _ typeNameStart: UnsafePointer<UInt8>,
    _ typeNameLength: UInt,
    _ genericEnv: UnsafeRawPointer?, // GenericEnvironmentDescriptor *
    _ genericArguments: UnsafeRawPointer?
) -> Any.Type?


/// Retrieve a generic environment descriptor associated with
/// the given distributed target
@available(SwiftStdlib 5.7, *)
@_silgen_name("swift_distributed_getGenericEnvironment")
public // SPI Distributed
func _getGenericEnvironmentOfDistributedTarget(
    _ targetNameStart: UnsafePointer<UInt8>,
    _ targetNameLength: UInt
) -> UnsafeRawPointer?

@available(SwiftStdlib 5.7, *)
@_silgen_name("swift_distributed_getWitnessTables")
public // SPI Distributed
func _getWitnessTablesFor(
  environment: UnsafeRawPointer,
  genericArguments: UnsafeRawPointer
) -> (UnsafeRawPointer, Int)

@available(SwiftStdlib 5.7, *)
@_silgen_name("swift_distributed_makeDistributedTargetAccessorNotFoundError")
internal // SPI Distributed
func _makeDistributedTargetAccessorNotFoundError(
  _ targetNameStart: UnsafePointer<UInt8>,
  _ targetNameLength: UInt
) -> Error {
  let name = String(decodingCString: targetNameStart, as: Unicode.UTF8.self)
  return ExecuteDistributedTargetError(message: "Could not find distributed accessor for target \(name)")
}
