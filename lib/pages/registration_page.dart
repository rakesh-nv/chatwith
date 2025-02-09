import 'package:flutter/material.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  double? _deviceHeight;
  double? _deviceWidth;

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: SignupPageUI(),
      ),
    );
  }

  Widget SignupPageUI() {
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
      child: Container(
        height: _deviceHeight! * 0.10,
        width: _deviceHeight! * 0.10,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(500),
          color: Colors.transparent,
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage('https://i.pravatar.cc/150?img=15'),
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

  Widget _passwordTextField() {
    return TextFormField(
      autocorrect: false,
      obscureText: true,
      style: TextStyle(color: Colors.white),
      validator: (_input) {
        return _input?.length != 0 ? null : 'Pleas Enter a valid password';
      },
      onSaved: (_input) {
        setState(() {});
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
    return Container(
      height: _deviceWidth!* 0.12,
      width: _deviceWidth,
      child: MaterialButton(
        onPressed: () {
        },
        color: Colors.blue,
        child: Text(
          "login",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  Widget _backToLoginButton(){
    return GestureDetector(
      onTap: () {

      },
      child: Container(
        height: _deviceHeight! * 0.06,
        width: _deviceWidth,
        child:Icon(Icons.arrow_back,size: 40,),
      ),
    );
  }
}
