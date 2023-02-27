import 'dart:math' as math;

export 'models/report.dart';
export 'models/team.dart';

typedef Json = Map<String, dynamic>;

class Cubit<T> {
  T data;
  Cubit(this.data);
}

class Stat {
  num _min, _max;
  double _average;
  int _count;
  num _sum;

  num get min => _min;
  num get max => _max;
  double get average => _average;

  Stat({num? min, num? max, double? average})
      : _min = min ?? double.infinity,
        _max = max ?? double.negativeInfinity,
        _average = average ?? 0.0,
        _count = 0,
        _sum = 0.0;

  void updateWithValue(num value) {
    _min = math.min(_min, value);
    _max = math.max(_max, value);
    _count++;
    _sum += value;
    _average = _sum / _count;
  }
}

class Rate {
  int _trueCount, _falseCount;

  Rate({int? trueCount, int? falseCount})
      : _trueCount = trueCount ?? 0,
        _falseCount = falseCount ?? 0;

  double get trueRate => _trueCount / (_trueCount + _falseCount);
  double get falseRate => _falseCount / (_trueCount + _falseCount);

  void updateWithValue(bool value) {
    if (value) {
      _trueCount++;
    } else {
      _falseCount++;
    }
  }
}
