
import 'failour.dart';
import 'package:fpdart/fpdart.dart';
typedef FutureEither<T>=Future<Either<Failure,T>>;
typedef FutureVoid<T>=FutureEither<void>;