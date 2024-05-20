// import 'package:flutter_riverpod/flutter_riverpod.dart';

// final authenticatorProvider = Provider<Authenticator>((ref) {
//   final userInfoStorage = ref.watch(firebaseInformationProvider);
//   final db = ref.watch(dbProvider);
//   final auth = ref.watch(firebaseAuthProvider);
//   return Authenticator(
//     userInfoStorage: userInfoStorage,
//     db: db,
//     auth: auth,
//   );
// });

// final authChangesFutureProvider =
//     FutureProvider<Map<String, dynamic>?>((ref) async {
//   final user = ref.watch(authChangesProvider).value;

//   if (user != null) {
//     final userProfileData = await ref
//         .watch(authStateNotifierProvider.notifier)
//         .getUserAuthChanges(user.uid);
//     return userProfileData;
//   } else {
//     return null;
//   }
// });
