import 'package:twipe_flutter_core/utils/eloquent/collection/collection.dart';
import 'package:twipe_flutter_core/utils/eloquent/model/model.dart';

abstract class CollectionController<T extends Model> extends Collection<T> {
  CollectionController(String id) : super(id);
}
