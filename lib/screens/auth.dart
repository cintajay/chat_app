import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();

  String? _enteredEmail;
  String? _enteredUsername;
  String? _enteredPassword;

  void _submit() {
    _formKey.currentState!.validate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 36,),
            Image.asset(
              'assets/images/chat.png',
              width: 200,
            ),
            SizedBox(height: 20,),
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).colorScheme.onPrimary, 
              ),
              margin: EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  //crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CircleAvatar(radius: 40,),
                    TextButton.icon(onPressed: () {}, label: Text('Add Image'), icon: Icon(Icons.photo),),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Email Address',
                      ),
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                      textCapitalization: TextCapitalization.none,
                      validator: (value) {
                        if (value == null ||
                            value.trim().isEmpty ||
                            !value.contains('@')) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Username'),
                      enableSuggestions: false,
                      validator: (value) {
                        if (value == null ||
                            value.trim().isEmpty ||
                            value.trim().length < 4) {
                          return 'Please enter at least 4 characters.';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Password'),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.trim().length < 6) {
                          return 'Password must be at least 6 characters long.';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20,),
                    ElevatedButton(onPressed: _submit, child: Text('Sign Up'),),
                    TextButton(onPressed: () {}, child: Text('I already have an account')),
                    SizedBox(height: 20,)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}