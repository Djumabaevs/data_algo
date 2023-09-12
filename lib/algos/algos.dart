import 'dart:math';

class Solution {
  int lengthOfLongestSubstring(String s) {
    var input = s;
    Set<String> letters = {};
    var maxSubString = 0;
    for (int i = 0; i < input.length; i++) {
      while (letters.contains(input[i])) {
        letters.remove(letters.first);
      }
      letters.add(input[i]);
      if (letters.length > maxSubString) {
        maxSubString = letters.length;
      }
    }
    print('$letters, ${maxSubString}');
    return maxSubString;
  }
}

class Solution2 {
  static var fb = <int, int>{0: 1, 1: 1};
  int climbStairs(int n) {
    if (n < 1) return 0;
    return fibonacci(n);
  }

  int fibonacci(int i) {
    fb[i] ??= fibonacci(i - 1) + fibonacci(i - 2);
    return fb[i]!;
  }
}

class Solution3 {
  int maxProfit(List<int> prices) {
    int profit = 0;
    int minPrice = prices.first;
    for (int i = 0; i < prices.length; i++) {
      minPrice = min(minPrice, prices[i]);
      profit = max(profit, prices[i] - minPrice);
    }
    return profit;
  }
}

class ListNode {
  int val;
  ListNode? next;
  ListNode([this.val = 0, this.next]);
}

class Solution4 {
  bool isPalindrome(ListNode? head) {
    final values = <int>[];
    while (head != null) {
      values.add(head.val);
      head = head.next;
    }
    return values.join('') == values.reversed.join('');
  }
}

class Solution5 {
  bool isPalindrome(int x) {
    if (x < 0) return false;
    String reversed = x.toString().split('').reversed.join();
    int y = int.parse(reversed);
    if (x == y) {
      return true;
    }
    return false;
  }
}

class Solution6 {
  bool isPalindrome(String s) {
    s = s.toLowerCase().replaceAll(RegExp('[^A-Za-z0-9]'), '');
    if (s.isEmpty) {
      return true;
    }
    if (s.length == 1) {
      return true;
    }
    int left = 0;
    int right = s.length - 1;

    while (s[left] == s[right]) {
      if (left + 1 == right) {
        return true;
      }
      left++;
      right--;
      if (left == right) {
        return true;
      }
    }

    return false;
  }
}

class Solution7 {
  bool isAnagram(String s, String t) {
    List<String> s1 = s.split('');
    List<String> s2 = t.split('');
    s1.sort();
    s2.sort();
    bool result = true;
    if (s.length != s2.length) {
      result = false;
    } else {
      for (int i = 0; i < s.length; i++) {
        if (s1[i] != s2[i]) {
          result = false;
          break;
        }
      }
    }
    return result;
  }
}

class Solution7b {
  bool isAnagram(String s, String t) {
    if (s == t) return true;
    if (s.length != t.length) return false;
    Map<String, int> map = {};
    for (var i = 0; i < s.length; i++) {
      map[s[i]] = (map[s[i]] ?? 0) + 1;
    }

    for (var j = 0; j < t.length; j++) {
      try {
        map[t[j]] = map[t[j]]! - 1;
      } catch (e) {
        return false;
      }
    }

    for (int c in map.values) {
      if (c != 0) return false;
    }
    return true;
  }
}

class Solution8 {
  bool isValid(String s) {
    final Map<String, String> bracketMap = {
      ')': '(',
      '}': '{',
      ']': '[',
    };

    final List<String> stack = [];
    for (var char in s.split('')) {
      if (bracketMap.containsValue(char)) {
        stack.add(char);
      } else if (bracketMap.containsKey(char)) {
        if (stack.isEmpty || stack.removeLast() != bracketMap[char]) {
          return false;
        }
      }
    }
    return stack.isEmpty;
  }
}

class Solution8b {
  bool isValid(String s) {
    Map myMap = {")": "(", "]": "[", "}": "{"};
    var mylist = [];

    for (var e in s.split('')) {
      if (myMap.containsKey(e)) {
        if (mylist.isNotEmpty && mylist.last == myMap[e]) {
          mylist.removeLast();
        } else {
          return false;
        }
      } else {
        mylist.add(e);
      }
    }
    return mylist.isEmpty;
  }
}

class Stack<T> {
  final List<T> _items = [];

  void push(T item) {
    _items.add(item);
  }

  T pop() {
    if (_items.isEmpty) {
      throw StateError('Stack is empty.');
    }
    return _items.removeLast();
  }

  bool get isEmpty => _items.isEmpty;

  T get last => _items.last;
}

class Solution8c {
  List<String> open = ['(', '{', '['];
  List<String> close = [')', '}', ']'];

  bool isSameTypeParentheses(String openString, String closeString) {
    return open.indexWhere((element) => element == openString) ==
        close.indexWhere((element) => element == closeString);
  }

  bool isValid(String s) {
    bool allGood = false;
    List<String> input = s.split('');
    Stack<String> openList = Stack();
    for (int i = 0; i < input.length; i++) {
      if (input[i].isOpen()) {
        openList.push(input[i]);
      } else {
        if (openList.isEmpty) {
          return false;
        }
        if (isSameTypeParentheses(openList.last, input[i])) {
          openList.pop();
        } else {
          return false;
        }
      }
    }
    if (openList.isEmpty) {
      allGood = true;
    }
    return allGood;
  }
}

extension StringExtensions on String {
  isOpen() {
    return ['(', '{', '['].contains(this);
  }

  isClose() {
    return [')', '}', ']'].contains(this);
  }
}

class Solution8d {
  bool isValid(String s) {
    final map = {
      '(': ')',
      '{': '}',
      '[': ']',
    };
    final stack = Stack2<String>();
    bool isDifferent = true;
    if (s.length == 1 || map.containsValue(s[0]) || s.length % 2 != 0) {
      return false;
    }

    for (var i = 0; i < s.length; i++) {
      if (map.containsKey(s[i])) {
        stack.push(s[i]);
      } else if (stack.isNotEmpty && map[stack.peek] == s[i]) {
        stack.pop();
      } else {
        isDifferent = false;
      }
    }
    if (stack.isEmpty && isDifferent) {
      return true;
    } else {
      return false;
    }
  }
}

class Stack2<E> {
  final _list = <E>[];

  void push(E value) => _list.add(value);

  E pop() => _list.removeLast();

  E get peek => _list.last;

  bool get isEmpty => _list.isEmpty;
  bool get isNotEmpty => _list.isNotEmpty;

  @override
  String toString() => _list.toString();
}

class Solution9 {
  void merge(List<int> nums1, int m, List<int> nums2, int n) {
    List<int> copy = List.from(nums1.sublist(0, m));

    int i = 0;
    int j = 0;

    for (int k = 0; k < m + n; k++) {
      if (i < m && (j >= n || copy[i] <= nums2[j])) {
        nums1[k] = copy[i];
        i++;
      } else {
        nums1[k] = nums2[j];
        j++;
      }
    }
  }
}

class Solution9b {
  void merge(List<int> nums1, int m, List<int> nums2, int n) {
    nums1.removeRange(m, nums1.length);
    nums2.removeRange(n, nums2.length);
    nums1.addAll(nums2);
    nums1.sort();
  }
}

class Solution9c {
  void merge(List<int> nums1, int m, List<int> nums2, int n) {
    final in1 = nums1.reversed.skip(nums1.length - m).iterator;
    final in2 = nums2.reversed.iterator;
    bool in1HasNext = in1.moveNext();
    bool in2HasNext = in2.moveNext();

    // don't need index check if i > 0 because
    // nums1.length == in1.length + in2.length
    // and merge is finished once in2 empty (in2HasNext)
    for (var i = nums1.length - 1; in2HasNext; i--) {
      if (in1HasNext && in1.current > in2.current) {
        nums1[i] = in1.current;
        in1HasNext = in1.moveNext();
      } else {
        nums1[i] = in2.current;
        in2HasNext = in2.moveNext();
      }
    }
  }
}

class Solution10 {
  ListNode? deleteDuplicates(ListNode? head) {
    if (head == null) {
      return null;
    }
    var cur = head;
    while (cur != null && cur.next != null) {
      if (cur.val == cur.next!.val) {
        cur.next = cur.next!.next;
      } else {
        cur = cur.next!;
      }
    }
    return head;
  }
}

class Solution11 {
  ListNode? middleNode(ListNode? head) {
    ListNode? fast = head;
    ListNode? slow = head;
    while (fast != null && fast.next != null) {
      fast = fast.next?.next;
      slow = slow?.next;
    }
    return slow;
  }
}
