import 'package:go_router/go_router.dart';
import 'package:myrecipediary/routing/route_error_screen.dart';
import '../features/authentication/presentation/forgot_password.dart';
import '../features/authentication/presentation/login.dart';
import '../features/authentication/presentation/register.dart';
import '../features/onboarding/onboarding_screen/onboarding_screen.dart';
import '../features/onboarding/splash_screen.dart';
import 'app_routes.dart';

GoRouter goRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
        path: '/',
        name: AppRoutes.root,
        builder: (context, state) => const SplashScreen()),
    GoRoute(
      path: AppRoutes.onboarding,
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: AppRoutes.login,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: AppRoutes.register,
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: AppRoutes.forgotPassword,
      builder: (context, state) => const ForgotPasswordScreen(),
    ),
    // GoRoute(
    //   path: AppRoutes.dashboard,
    //   builder: (context, state) => const Dashboard(),
    // ),
    // GoRoute(
    //   path: AppRoutes.changePassword,
    //   builder: (context, state) => const ChangePasswordScreen(),
    // ),

  ],
  errorBuilder: (context, state) => RouteErrorScreen(
    errorMsg: state.error.toString(),
  ),
);