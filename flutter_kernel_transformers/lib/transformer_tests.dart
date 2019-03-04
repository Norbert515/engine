// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library track_widget_constructor_locations;

import 'package:kernel/ast.dart';
import 'package:kernel/class_hierarchy.dart';
import 'package:kernel_transformer/src/program_transformer.dart';
import 'package:meta/meta.dart';


/// Rewrites all widget constructors and constructor invocations to add a
/// parameter specifying the location the constructor was called from.
///
/// The creation location is stored as a private field named `_location`
/// on the base widget class and flowed through the constructors using a named
/// parameter.
class TestTransformer implements ProgramTransformer {


  /// Transform the given [program].
  ///
  /// It is safe to call this method on a delta program generated as part of
  /// performing a hot reload.
  @override
  void transform(Component program) {

    // Libraries
    final List<Library> libraries = program.libraries;
    print("These are the libraries:\n");
    libraries.forEach((it) {
      print("Name: ${it.name}\n");
      print("Location: ${it.location.toString()}\n");
      print("Uri: ${it.importUri.toString()}");
      print("Debug toString: ${it.toString()}");
    });

    ClassHierarchy classHierarchy = ClassHierarchy(
      program,
      onAmbiguousSupertypes: (Class cls, Supertype a, Supertype b) { },
    );
    for (Library library in libraries) {
      if (library.isExternal) {
        continue;
      }
      for (Class class_ in library.classes) {
        print("Class to string: ${class_.toString()}");
        print("Class location ${class_.location.toString()}");
        for(Procedure procedure in class_.procedures) {
          print("Procedure: ${procedure.toString()}");
          print("Procedure location: ${procedure.location.toString()}");
          print("Procedure name: ${procedure.name}");
        }
      }
    }


  }


}

