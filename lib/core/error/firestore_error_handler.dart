import 'package:firebase_core/firebase_core.dart';
import 'package:ya_perfume/core/error/error_model.dart';

abstract final class FirestoreErrorHandler {
  static ErrorModel? handle(FirebaseException exception) {
    if (exception.plugin != 'cloud_firestore') {
      return null;
    }
    final message = switch (exception.code) {
      'cancelled' => 'تم إلغاء العملية.',
      'unknown' => 'حدث خطأ غير معروف أثناء الوصول للبيانات.',
      'invalid-argument' => 'البيانات المرسلة غير صحيحة.',
      'deadline-exceeded' => 'انتهت مهلة الطلب. حاول مرة أخرى.',
      'not-found' => 'البيانات المطلوبة غير موجودة.',
      'already-exists' => 'البيانات موجودة بالفعل.',
      'permission-denied' => 'ليس لديك صلاحية لتنفيذ العملية.',
      'resource-exhausted' => 'الخدمة وصلت لحد الاستخدام المتاح. حاول لاحقًا.',
      'failed-precondition' => 'تعذر تنفيذ العملية بسبب إعدادات الخدمة.',
      'aborted' => 'تعذر إكمال العملية. حاول مرة أخرى.',
      'out-of-range' => 'القيمة المطلوبة خارج النطاق المسموح.',
      'unimplemented' => 'هذه العملية غير مدعومة.',
      'internal' => 'حدث خطأ داخلي في الخدمة. حاول لاحقًا.',
      'unavailable' => 'الخدمة غير متاحة حاليًا. حاول مرة أخرى.',
      'data-loss' => 'حدث خطأ في سلامة البيانات.',
      'unauthenticated' => 'يلزم تسجيل الدخول لتنفيذ العملية.',
      _ => null,
    };

    if (message == null) {
      return null;
    }

    return ErrorModel(code: exception.code, message: message);
  }
}
