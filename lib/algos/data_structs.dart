class MyHashMap<K, V> {
  List<_Bucket<K, V>> _buckets;
  int _size;
  int _count = 0;
  static const double _loadFactor = 0.7;

  MyHashMap({int initialSize = 16}) : _size = initialSize {
    _buckets = List.generate(_size, (index) => _Bucket<K, V>());
  }

  // Get the value associated with a key
  V? get(K key) {
    var index = _getIndex(key);
    return _buckets[index].get(key);
  }

  // Set a key-value pair
  void put(K key, V value) {
    if (_count / _size >= _loadFactor) {
      _resize();
    }

    var index = _getIndex(key);
    if (_buckets[index].put(key, value)) _count++;
  }

  // Remove a key-value pair by key
  void remove(K key) {
    var index = _getIndex(key);
    if (_buckets[index].remove(key)) _count--;
  }

  // Computes the index in the bucket array where this key-value pair should reside
  int _getIndex(K key) {
    return key.hashCode % _size;
  }

  // Resizes the bucket array and redistributes the entries
  void _resize() {
    _size = _size * 2;
    var oldBuckets = _buckets;
    _buckets = List.generate(_size, (index) => _Bucket<K, V>());
    _count = 0;

    for (var bucket in oldBuckets) {
      for (var entry in bucket.entries) {
        put(entry.key, entry.value);
      }
    }
  }
}

class _Bucket<K, V> {
  final List<_Entry<K, V>> entries = [];

  V? get(K key) {
    for (var entry in entries) {
      if (entry.key == key) {
        return entry.value;
      }
    }
    return null;
  }

  bool put(K key, V value) {
    for (var entry in entries) {
      if (entry.key == key) {
        entry.value = value;
        return false;
      }
    }
    entries.add(_Entry(key, value));
    return true;
  }

  bool remove(K key) {
    for (int i = 0; i < entries.length; i++) {
      if (entries[i].key == key) {
        entries.removeAt(i);
        return true;
      }
    }
    return false;
  }
}

class _Entry<K, V> {
  K key;
  V value;

  _Entry(this.key, this.value);
}
