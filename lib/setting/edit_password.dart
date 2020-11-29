import 'package:flutter/material.dart';
import 'package:my_cab_driver/controllers/user_data_provider.dart';
import 'package:my_cab_driver/models/edit_password_model.dart';
import 'package:my_cab_driver/widgets/exception_dialog.dart';
import 'package:my_cab_driver/widgets/loading_dialog.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class EditPassword extends StatefulWidget {
  @override
  _EditPasswordState createState() => _EditPasswordState();
}

class _EditPasswordState extends State<EditPassword> {
  EditPasswordModel _model = new EditPasswordModel();
  GlobalKey<FormState> _formKKey = new GlobalKey<FormState>();
  UserDataProvider _userDataProvider;
  final String _url =
      "https://gardentaxi.net/Back_End/public/api/driver/send_reset_password";

  Future<void> _changePassword(BuildContext context) async {
    if (this._formKKey.currentState.validate()) {
      try {
        loadingDialog(context);

        http.Response res = await http.post(this._url,
            body: this._model.toMap(this._userDataProvider.token));

        if (res.statusCode == 200) {
          Navigator.pop(context);
          Navigator.pop(context);
        } else {
          Navigator.pop(context);
          exceptionDialog(context);
        }
      } catch (e) {
        Navigator.pop(context);
      }
    }
  }

  @override
  void didChangeDependencies() {
    this._userDataProvider = Provider.of(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text("تعديل كلمة السر"), backgroundColor: Colors.green),
      body: Form(
        key: this._formKKey,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          children: [
            TextFormField(
              obscureText: true,
              onChanged: (String value) => this._model.oldPassword = value,
              validator: this._model.validatePassword,
              decoration: _inputDecoration("Old Password"),
            ),
            this._sizedBox(),
            TextFormField(
                obscureText: true,
                onChanged: (String value) => this._model.newPassword = value,
                validator: this._model.validatePassword,
                decoration: this._inputDecoration("New Password")),
            this._sizedBox(),
            TextFormField(
                obscureText: true,
                onChanged: (String value) =>
                    this._model.confirmPassword = value,
                validator: this._model.validateConfirmPassword,
                decoration: this._inputDecoration("Confirm Password")),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => this._changePassword(context),
        backgroundColor: Colors.green,
        label: Text(
          "Change Password",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  SizedBox _sizedBox({double p = 1.0}) => SizedBox(height: 30.0 * p);

  InputDecoration _inputDecoration(String value) {
    return InputDecoration(
      labelText: "$value",
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.green),
      ),
    );
  }
}
