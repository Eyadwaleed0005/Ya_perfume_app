import 'package:firebase_core/firebase_core.dart';
import 'package:ya_perfume/core/error/error_model.dart';
import 'package:ya_perfume/core/error/firestore_error_handler.dart';

abstract final class FirebaseErrorHandler {
  static ErrorModel handle(Object exception) {
    if (exception is FirebaseException) {
      final firestoreError = FirestoreErrorHandler.handle(exception);

      if (firestoreError != null) {
        return firestoreError;
      }

      final message = switch (exception.code) {
        'no-app' => 'لم يتم تهيئة خدمة Firebase.',
        'duplicate-app' => 'تم تهيئة خدمة Firebase أكثر من مرة.',
        'invalid-app-argument' => 'إعدادات Firebase غير صحيحة.',
        'network-request-failed' =>
          'تعذر الاتصال بالخدمة. تحقق من اتصال الإنترنت.',
        _ => 'حدث خطأ غير متوقع. حاول مرة أخرى.',
      };

      return ErrorModel(code: exception.code, message: message);
    }

    return const ErrorModel(
      code: 'unexpected-error',
      message: 'حدث خطأ غير متوقع. حاول مرة أخرى.',
    );
  }
}
