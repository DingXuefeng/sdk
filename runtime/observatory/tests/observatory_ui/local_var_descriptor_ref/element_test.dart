// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:html';
import 'package:test/test.dart';
import 'package:observatory/src/elements/local_var_descriptors_ref.dart';
import '../mocks.dart';

main() {
  LocalVarDescriptorsRefElement.tag.ensureRegistration();

  const isolate = const IsolateRefMock();
  const localVar = const LocalVarDescriptorsRefMock();
  test('instantiation', () {
    final e = new LocalVarDescriptorsRefElement(isolate, localVar);
    expect(e, isNotNull, reason: 'element correctly created');
    expect(e.isolate, equals(isolate));
    expect(e.localVar, equals(localVar));
  });
  test('elements created after attachment', () async {
    final e = new LocalVarDescriptorsRefElement(isolate, localVar);
    document.body.append(e);
    await e.onRendered.first;
    expect(e.children.length, isNonZero, reason: 'has elements');
    e.remove();
    await e.onRendered.first;
    expect(e.children.length, isZero, reason: 'is empty');
  });
}
