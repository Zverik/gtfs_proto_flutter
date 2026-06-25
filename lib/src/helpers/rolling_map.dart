extension RollingMap<E> on Iterable<E> {
  Iterable<T> rollingMap<T>(T init, T toElement(T prev, E e)) =>
      RollingMappedIterable<E, T>(this, init, toElement);
}

typedef T _RollingTransformation<S, T>(T prev, S value);

class RollingMappedIterable<S, T> extends Iterable<T> {
  final Iterable<S> _iterable;
  final T _init;
  final _RollingTransformation<S, T> _f;

  factory RollingMappedIterable(
    Iterable<S> iterable,
    T init,
    T function(T prev, S value),
  ) {
    return RollingMappedIterable<S, T>._(iterable, init, function);
  }

  RollingMappedIterable._(this._iterable, this._init, this._f);

  @override
  Iterator<T> get iterator =>
      RollingMappedIterator<S, T>(_iterable.iterator, _init, _f);

  // Length related functions are independent of the mapping.
  @override
  int get length => _iterable.length;
  @override
  bool get isEmpty => _iterable.isEmpty;

  // Index based lookup can be done before transforming.
  @override
  T get first => _f(_init, _iterable.first);
  @override
  T get single => _f(_init, _iterable.single);
}

class RollingMappedIterator<S, T> implements Iterator<T> {
  T? _current;
  T _prev;
  final Iterator<S> _iterator;
  final _RollingTransformation<S, T> _f;

  RollingMappedIterator(this._iterator, this._prev, this._f);

  @override
  bool moveNext() {
    if (_iterator.moveNext()) {
      _current = _f(_prev, _iterator.current);
      _prev = _current!; // issues when T is nullable
      return true;
    }
    _current = null;
    return false;
  }

  @override
  T get current => _current as T;
}
