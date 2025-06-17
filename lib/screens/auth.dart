import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firebase = FirebaseAuth.instance;

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

  var _isLogin = false;

  void _submit() async {
    final isValid = _formKey.currentState!.validate();

    if (!isValid) {
      return;
    }

    _formKey.currentState!.save();

    try {
      if (_isLogin) {
        final userCredential = await _firebase.signInWithEmailAndPassword(email: _enteredEmail!, password: _enteredPassword!);
      } else {
        final userCredential = await _firebase.createUserWithEmailAndPassword(email: _enteredEmail!, password: _enteredPassword!);
        FirebaseFirestore.instance.collection("users").doc(userCredential.user!.uid).set({
          "email": _enteredEmail,
          "password": _enteredPassword,
          "username": _enteredUsername,
        });
      }
    } on FirebaseAuthException catch (error) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.message ?? 'Authentication failed')));
    }     
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: SingleChildScrollView(
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
                      if (!_isLogin) 
                        CircleAvatar(radius: 40,),
                      if (!_isLogin)
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
                        onSaved: (value) {
                          _enteredEmail = value!;
                        },
                      ),
                      if (!_isLogin) 
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
                          onSaved: (value) {
                            _enteredUsername = value!;
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
                        onSaved: (value) {
                          _enteredPassword = value!;
                        },
                      ),
                      SizedBox(height: 20,),
                      ElevatedButton(onPressed: _submit, child: Text('Sign Up'),),
                      TextButton(onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      }, child: Text(_isLogin ? 'Create a new account' : 'I already have an account')),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}