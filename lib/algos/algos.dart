import 'dart:collection';
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

class TreeNode {
  int val;
  TreeNode? left;
  TreeNode? right;
  TreeNode([this.val = 0, this.left, this.right]);
}

class Solution12 {
  int maxDepth(TreeNode? root) {
    if (root == null) {
      return 0;
    }
    var left = maxDepth(root.left);
    var right = maxDepth(root.right);
    return max(left, right) + 1;
  }
}

class Solution12b {
  int maxDepth(TreeNode? root) {
    if (root == null) {
      return 0;
    }
    Map<int, List<TreeNode?>> nodes = {
      0: [root]
    };
    for (var i = 0; i < nodes.keys.length; i++) {
      for (var j = 0; j < nodes[i]!.length; j++) {
        if (nodes[i + 1] == null) {
          nodes[i + 1] = [];
        }
        if (nodes[i]![j]?.left != null) {
          nodes[i + 1]!.add(nodes[i]![j]?.left);
        }
        if (nodes[i]![j]?.right != null) {
          nodes[i + 1]!.add(nodes[i]![j]?.right);
        }
      }
    }
    return nodes.keys.length - 1;
  }
}

class Solution13 {
  int cnt(TreeNode? nod) {
    if (nod == null) return 0;
    int l = cnt(nod.left);
    if (l == -1) return -1;
    int r = cnt(nod.right);
    if (r == -1) return -1;
    if ((r - l > 1) || (l - r > 1)) return -1;
    return (l >= r ? l + 1 : r + 1);
  }

  bool isBalanced(TreeNode? root) {
    return cnt(root) != -1;
  }
}

class Solution14 {
  double findMaxAverage(List<int> nums, int k) {
    double maxAvg = -99999;
    double sum = 0;
    int i = 0;
    int l = 0;
    for (i = 0; i < nums.length; i++) {
      sum += nums[i] / k;

      if (i - l + 1 == k) {
        maxAvg = max(maxAvg, sum);
        sum -= nums[l] / k;
        l++;
      }
    }

    return maxAvg;
  }
}

class Solution14b {
  double findMaxAverage(List<int> nums, int k) {
    int maxSum = 0;
    int sum = 0;
    for (int i = 0; i < k; i++) {
      sum += nums[i];
    }
    maxSum = sum;
    for (int i = k; i < nums.length; i++) {
      sum += nums[i] - nums[i - k];
      if (sum > maxSum) {
        maxSum = sum;
      }
    }
    return maxSum / k;
  }
}

class Solution15 {
  List<int> findErrorNums(List<int> nums) {
    int n = nums.length;
    int sum = (n * (n + 1) ~/ 2);
    int duplicate = -1, missing = -1;

    Set<int> set = {};
    for (int i = 0; i < n; i++) {
      if (!set.add(nums[i])) {
        duplicate = nums[i];
      }
      sum -= nums[i];
      print('SUM: $sum');
    }
    missing = sum + duplicate;
    return [duplicate, missing];
  }
}

class MyStack {
  Queue<int> queue1 = Queue<int>();
  Queue<int> queue2 = Queue<int>();

  MyStack() {}

  void push(int x) {
    queue1.add(x);
  }

  int pop() {
    while (queue1.length > 1) {
      queue2.add(queue1.removeFirst());
    }
    int popped = queue1.removeFirst();
    Queue<int> temp = queue1;
    queue1 = queue2;
    queue2 = temp;
    return popped;
  }

  int top() {
    while (queue1.length > 1) {
      queue2.add(queue1.removeFirst());
    }
    int top = queue1.first;
    queue2.add(queue1.removeFirst());
    Queue<int> temp = queue1;
    queue1 = queue2;
    queue2 = temp;
    return top;
  }

  bool empty() {
    return queue1.isEmpty && queue2.isEmpty;
  }
}

class MyStack2 {
  late Queue<int> q;
  MyStack() {
    q = Queue<int>();
  }

  void push(int x) {
    q.add(x);
  }

  int pop() {
    int sz = q.length;
    if (sz == 0) return 0;
    for (int i = 0; i < sz - 1; i++) {
      int val = q.removeFirst();
      q.add(val);
    }
    int val = q.removeFirst();
    return val;
  }

  int top() {
    int sz = q.length;
    if (sz == 0) return 0;
    for (int i = 0; i < sz - 1; i++) {
      int val = q.removeFirst();
      q.add(val);
    }
    int val = q.removeFirst();
    q.add(val);
    return val;
  }

  bool empty() {
    return q.isEmpty;
  }
}
