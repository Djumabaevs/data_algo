import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class Node<T> {
  final T value;
  final Node<T>? next;

  Node(this.value, this.next);

  @override
  String toString() {
    StringBuffer buffer = StringBuffer();
    Node<T>? currentNode = this;
    while (true) {
      buffer.write(currentNode?.value);
      currentNode = currentNode?.next;
      if (currentNode == null) break;
      buffer.write('->');
    }
    return buffer.toString();
  }
}

int fibonachi(int n, [Map<int, int>? memo]) {
  print('fibonachi($n)');
  memo ??= {};
  if (n <= 1) return n;
  if (!memo.containsKey(n)) {
    memo[n] = fibonachi(n - 1, memo) + fibonachi(n - 2, memo);
  }
  return memo[n]!;
}

int fibonachiLinear(int n) {
  if (n <= 1) return n;
  int first = 1;
  int second = 2;
  for (int i = 3; i <= n; i++) {
    int temp = first + second;
    first = second;
    second = temp;
  }
  return second;
}
