import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum PersonUrl { persons1, persons2 }

extension UrlString on PersonUrl {
  String get urlString {
    switch (this) {
      case PersonUrl.persons1:
        return 'api/persons1.json';

      case PersonUrl.persons2:
        return 'api/persons2.json';
    }
  }
}
