class Employee {}

class StoredEmployee {
  String key;
  Employee employee;

  StoredEmployee(this.key, this.employee);

  @override
  String toString() => employee.toString();
}

class SimpleHashtable {
  List<StoredEmployee?> hashtable = List.filled(10, null);

  void put(String key, Employee employee) {
    int hashedKey = _hashKey(key);
    if (_occupied(hashedKey)) {
      int stopIndex = hashedKey;
      if (hashedKey == hashtable.length - 1) {
        hashedKey = 0;
      } else {
        hashedKey++;
      }

      while (_occupied(hashedKey) && hashedKey != stopIndex) {
        hashedKey = (hashedKey + 1) % hashtable.length;
      }
    }

    if (_occupied(hashedKey)) {
      print("Sorry, there's already an employee at position $hashedKey");
    } else {
      hashtable[hashedKey] = StoredEmployee(key, employee);
    }
  }

  Employee? get(String key) {
    int hashedKey = _findKey(key);
    if (hashedKey == -1) {
      return null;
    }
    return hashtable[hashedKey]!.employee;
  }

  Employee? remove(String key) {
    int hashedKey = _findKey(key);
    if (hashedKey == -1) {
      return null;
    }

    Employee employee = hashtable[hashedKey]!.employee;
    hashtable[hashedKey] = null;
    return employee;
  }

  int _hashKey(String key) {
    return key.length % hashtable.length;
  }

  int _findKey(String key) {
    int hashedKey = _hashKey(key);
    if (hashtable[hashedKey] != null && hashtable[hashedKey]!.key == key) {
      return hashedKey;
    }

    int stopIndex = hashedKey;
    if (hashedKey == hashtable.length - 1) {
      hashedKey = 0;
    } else {
      hashedKey++;
    }

    while (hashedKey != stopIndex &&
        hashtable[hashedKey] != null &&
        hashtable[hashedKey]!.key != key) {
      hashedKey = (hashedKey + 1) % hashtable.length;
    }

    if (hashtable[hashedKey] != null && hashtable[hashedKey]!.key == key) {
      return hashedKey;
    } else {
      return -1;
    }
  }

  bool _occupied(int index) {
    return hashtable[index] != null;
  }

  void printHashtable() {
    for (int i = 0; i < hashtable.length; i++) {
      if (hashtable[i] == null) {
        print('empty');
      } else {
        print('Position $i: ${hashtable[i]}');
      }
    }
  }
}
