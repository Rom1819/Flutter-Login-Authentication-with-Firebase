import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'login_screen.dart';

import 'home_screen.dart';
import '../models/authentication.dart';

class SignupScreen extends StatefulWidget {

  static const routeName = 'signup';

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController _passwordController = new TextEditingController();

  Map<String, String> _authData = {
    'email' : '',
    'password' : ''
  };

  _showErrorDialog(String msg)
  {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('An Error Occurred!'),
          content: Text(msg),
          actions: <Widget>[
            FlatButton(
                onPressed: ()
                {
                  Navigator.of(ctx).pop();
                },
                child: Text('OK')
            ),
          ],
        )
    );
  }

  Future <void> _submit() async
  {
    if(!_formKey.currentState.validate())
      {
        return;
      }
    _formKey.currentState.save();

    try{
      await Provider.of<Authentication>(context, listen: false).signUp(
          _authData['email'],
          _authData['password']
      );
      Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);

    } catch(error)
    {
      var errorMessage = 'Authentication Failed. Please Try Again.';
      _showErrorDialog(errorMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
        actions: <Widget>[
          FlatButton(
            child: Row(
              children: <Widget>[
                Text('Login'),
                Icon(Icons.person),
              ],
            ),
            textColor: Colors.white,
            onPressed: ()
            {
              Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
            },
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      Colors.limeAccent,
                      Colors.redAccent,
                    ]
                )
            ),
          ),
          Center(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                height: 300,
                width: 300,
                padding: EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        // Email
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Email'),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value){
                            if(value.isEmpty || !value.contains('@'))
                            {
                              return 'Invalid Email';
                            }
                            return null;
                          },
                          onSaved: (value)
                          {
                            _authData['email'] = value;
                          },
                        ),
                        // Password
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Password'),
                          obscureText: true,
                          controller: _passwordController,
                          validator: (value)
                          {
                            if(value.isEmpty || value.length <= 6)
                            {
                              return 'Invalid Password';
                            }
                            return null;
                          },
                          onSaved: (value)
                          {
                            _authData['password'] = value;
                          },
                        ),
                        // Confirm Password
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Confirm Password'),
                          obscureText: true,
                          validator: (value)
                          {
                            if(value.isEmpty || value != _passwordController.text)
                            {
                              return 'Invalid Password';
                            }
                            return null;
                          },
                          onSaved: (value)
                          {

                          },
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        RaisedButton(
                          child: Text(
                            'Submit',
                          ),
                          onPressed: ()
                          {
                            _submit();
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          color: Colors.white,
                          textColor: Colors.blueGrey,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
