import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../application/blocs/auth_bloc/auth_bloc.dart';
import '../../application/blocs/auth_bloc/auth_event.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              BlocProvider.of<AuthBloc>(context).add(AuthLoggedOut());
            },
          ),
        ],
      ),
      body: const Text("W E A T H E R   H O M E",
          style: TextStyle(
              color: Colors.blueAccent, fontSize: 40, fontFamily: "Poppins")),
    );
  }
}
