import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:my_weather_app/presentation/screens/auth_screens/login_screen.dart';
import 'package:my_weather_app/presentation/screens/auth_screens/register_screen.dart';
import 'package:my_weather_app/presentation/screens/home_screen.dart';
import 'package:my_weather_app/presentation/screens/loading_screen.dart';

import 'application/blocs/auth_bloc/auth_bloc.dart';
import 'application/blocs/auth_bloc/auth_event.dart';
import 'application/blocs/auth_bloc/auth_state.dart';
import 'firebase_options.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc()..add(AuthStarted()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Weather App with BLoC',
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashToAuth(),
          '/login': (context) => LoginScreen(),
          '/register': (context) => RegisterScreen(),
        },
      ),
    );
  }
}

class SplashToAuth extends StatefulWidget {
  const SplashToAuth({super.key});

  @override
  _SplashToAuthState createState() => _SplashToAuthState();
}

class _SplashToAuthState extends State<SplashToAuth> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      BlocProvider.of<AuthBloc>(context).add(AuthStarted());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthAuthenticated) {
          return HomeScreen();
        } else if (state is AuthUnauthenticated) {
          return LoginScreen();
        } else if (state is AuthLoading || state is AuthInitial) {
          return const LoadingScreen();
        } else if (state is AuthFailure) {
          return Scaffold(
              body: Center(
                  child: Text('Authentication Failure: ${state.error}')));
        } else {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }
}
