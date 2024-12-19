import 'dart:math';

extension ListExtension<T> on List<T>? {
  bool get isNull => this == null;

  bool get isNullOrEmpty => isNull || this!.isEmpty;

  bool get isNotNullOrEmpty => !isNullOrEmpty;

  /// 随机获取元素
  T? get random {
    if (isNullOrEmpty) return null;
    return this![Random().nextInt(this!.length)];
  }

  /// 获取指定元素
  T? item(int index) {
    if (isNullOrEmpty) return null;
    if (index < 0 || index >= this!.length) return null;
    return this![index];
  }

  /// 删除指定元素
  T? removeSafeAt(int index) {
    if (isNullOrEmpty) return null;
    if (index < 0 || index >= this!.length) return null;
    return this!.removeAt(index);
  }

  /// 插入指定元素
  bool insertSafe(int index, T element) {
    if (isNull) return false;
    if (index < 0 || index >= this!.length) return false;
    this!.insert(index, element);
    return true;
  }

  /// 插入指定元素到列表头部
  bool insertHead(T element) {
    if (isNull) return false;
    this!.insert(0, element);
    return true;
  }

  /// 插入指定元素到列表尾部
  bool insertTail(T element) {
    if (isNull) return false;
    this!.insert(this!.length, element);
    return true;
  }

  List<T> copy() {
    if (isNullOrEmpty) return [];
    return List<T>.generate(this!.length, (i) => this![i]);
  }
}
