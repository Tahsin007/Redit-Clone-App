import 'package:fpdart/fpdart.dart';
import 'package:redit_clone/core/utils/failure.dart';

typedef FutureEither<T> = Future<Either<Failure,T>>;
typedef FutureVoid = FutureEither<void>;