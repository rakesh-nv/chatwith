import 'dart:io';

import 'package:chatwith/services/cloud_storage_service.dart';
import 'package:chatwith/services/db_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';

import 'package:chatwith/services/media_service.dart';
import 'package:chatwith/services/navigation_service.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  double? _deviceHeight;
  double? _deviceWidth;

  final _formKey = GlobalKey<FormState>();
  AuthProvider? _auth;

  String? _name;
  String? _email;
  String? _password;
  File? _image;

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: ChangeNotifierProvider<AuthProvider>.value(
          value: AuthProvider.instance,
          child: registrationPageUI(),
        ),
      ),
    );
  }

  Widget registrationPageUI() {
    return Builder(
      builder: (BuildContext context) {
        _auth = Provider.of<AuthProvider>(context);
        return Container(
          //color: Colors.red,
          height: _deviceHeight! * 0.75,
          padding: EdgeInsets.symmetric(horizontal: _deviceWidth! * 0.10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _headingWidget(),
              _inputForm(),
              _RegisterButton(),
              _backToLoginButton()
            ],
          ),
        );
      },
    );
  }

  Widget _headingWidget() {
    return Container(
      //color: Colors.blue,
      height: _deviceHeight! * 0.12,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Let's get going!",
            style: TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            "pleas enter your details",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w200,
            ),
          ),
        ],
      ),
    );
  }

  Widget _inputForm() {
    return Container(
      //color: Colors.green,
      height: _deviceHeight! * 0.48,
      child: Form(
        key: _formKey,
        onChanged: () {
          _formKey.currentState!.save();
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _imageSelectorWidget(),
            // SizedBox(height: 10),
            _nameTextField(),
            _emailTextField(),
            _passwordTextField()
          ],
        ),
      ),
    );
  }

  Widget _imageSelectorWidget() {
    return Align(
      child: GestureDetector(
        onTap: () async {
          XFile? _imageFile =
              await MediaService.instance.getImageFromLibraray();
          setState(() {
            _image = File(_imageFile!.path);
          });
        },
        child: Container(
          height: _deviceHeight! * 0.10,
          width: _deviceHeight! * 0.10,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(500),
            color: Colors.transparent,
            image: _image != null
                ? DecorationImage(image: FileImage(_image!), fit: BoxFit.cover)
                : DecorationImage(
                    image: NetworkImage('https://i.pravatar.cc/150?img=15'),
                    fit: BoxFit.cover,
                  ),
          ),
        ),
      ),
    );
  }

  Widget _nameTextField() {
    return TextFormField(
      autocorrect: false,
      style: TextStyle(color: Colors.white),
      validator: (_input) {
        return _input?.length != 0 ? null : 'Pleas Enter a Name';
      },
      onSaved: (_input) {
        setState(() {});
      },
      cursorColor: Colors.white,
      decoration: InputDecoration(
        hintText: 'Name',
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    );
  }

  Widget _emailTextField() {
    return TextFormField(
      autocorrect: false,
      style: TextStyle(color: Colors.white),
      validator: (_input) {
        return _input?.length != 0 && _input!.contains("@")
            ? null
            : 'Pleas Enter a valid Email';
      },
      onSaved: (_input) {
        setState(() {
          _email = _input;
        });
      },
      cursorColor: Colors.white,
      decoration: InputDecoration(
        hintText: 'Email',
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    );
  }

  Widget _passwordTextField() {
    return TextFormField(
      autocorrect: false,
      obscureText: true,
      style: TextStyle(color: Colors.white),
      validator: (_input) {
        return _input?.length != 0 ? null : 'Pleas Enter a valid password';
      },
      onSaved: (_input) {
        setState(() {
          _password = _input;
        });
      },
      cursorColor: Colors.white,
      decoration: InputDecoration(
        hintText: 'Password',
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    );
  }

  Widget _RegisterButton() {
    return _auth?.status != AuthStatus.Authenticating
        ? Container(
            height: _deviceWidth! * 0.12,
            width: _deviceWidth,
            child: MaterialButton(
              onPressed: () {
                if (_formKey.currentState!.validate() && _image != null) {
                  _auth?.registerUserWithEmailAndPassword(
                    _email!,
                    _password!,
                    (String _uid) async {
                      var _result = await CloudStorageService.instance
                          .uploadUserImage(_uid, _image!);
                      var _imageURL = await _result!.ref.getDownloadURL();
                      await DBService.instance
                          .createUserInDB(_uid, _name!, _email!, _imageURL);
                    },
                  );
                }
              },
              color: Colors.blue,
              child: Text(
                "Register",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          )
        : Align(
            alignment: Alignment.center,
            child: CircularProgressIndicator(),
          );
  }

  Widget _backToLoginButton() {
    return GestureDetector(
      onTap: () {
        NavigationService.instance.goBack();
      },
      child: Container(
        height: _deviceHeight! * 0.06,
        width: _deviceWidth,
        child: Icon(
          Icons.arrow_back,
          size: 40,
        ),
      ),
    );
  }
}
