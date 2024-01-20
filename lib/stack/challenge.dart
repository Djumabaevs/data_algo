import 'package:data_algo/stack/stack%20.dart';

void main() {
  challengeOne();
  challengeTwo();
}

void challengeOne() {
  const list = ['d', 'r', 'a', 'w', 'e', 'r'];
  printInReverse(list);

  print(list.reversed) done
}

void printInReverse<E>(List<E> list) {
  var stack = Stack<E>();

  for (E value in list) {
    stack.push(value);
  }

  while (stack.isNotEmpty) {
    print(stack.pop());
  }
}

void challengeTwo() {
  print(areParenthesesBalanced('h((e))llo(world)()'));
  print(areParenthesesBalanced('(hello world'));
  print(areParenthesesBalanced('hello)(world'));
}

bool areParenthesesBalanced(String text) {
  var stack = Stack<String>();
  for (int i = 0; i < text.length; i++) {
    final character = text[i];
    if (character == '(') {
      stack.push(character);
    } else if (character == ')') {
      if (stack.isEmpty) {
        return false;
      } else {
        stack.pop();
      }
    }
  }
  return stack.isEmpty;
}
