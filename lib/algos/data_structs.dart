import 'dart:convert';

import 'package:flutter/foundation.dart';

class MyHashMap<K, V> {
  List<_Bucket<K, V>> _buckets;
  int _size;
  int _count = 0;
  static const double _loadFactor = 0.7;

  MyHashMap({
    required this._buckets,
    required this._size,
    required this._count,
  }) : _size = initialSize {
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

  MyHashMap<K, V> copyWith({
    List<_Bucket<K, V>>? _buckets,
    int? _size,
    int? _count,
  }) {
    return MyHashMap<K, V>(
      _buckets: _buckets ?? this._buckets,
      _size: _size ?? this._size,
      _count: _count ?? this._count,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_buckets': _buckets.map((x) => x.toMap()).toList(),
      '_size': _size,
      '_count': _count,
    };
  }

  factory MyHashMap.fromMap(Map<String, dynamic> map) {
    return MyHashMap<K, V>(
      _buckets: List<_Bucket<K, V>>.from(
          map['_buckets']?.map((x) => _Bucket<K, V>.fromMap(x))),
      _size: map['_size']?.toInt() ?? 0,
      _count: map['_count']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory MyHashMap.fromJson(String source) =>
      MyHashMap.fromMap(json.decode(source));

  @override
  String toString() =>
      'MyHashMap(_buckets: $_buckets, _size: $_size, _count: $_count)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MyHashMap<K, V> &&
        listEquals(other._buckets, _buckets) &&
        other._size == _size &&
        other._count == _count;
  }

  @override
  int get hashCode => _buckets.hashCode ^ _size.hashCode ^ _count.hashCode;
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
