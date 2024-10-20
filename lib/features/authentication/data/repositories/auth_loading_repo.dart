import 'package:flutter_riverpod/flutter_riverpod.dart';

final isRegistering = StateProvider<bool>((ref) => false);
final isLoginIn= StateProvider<bool>((ref) => false);
final isAccountDeleting = StateProvider<bool>((ref) => false);
final isPasswordUpdating = StateProvider<bool>((ref) => false);