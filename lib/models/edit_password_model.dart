class EditPasswordModel {
  String _oldPassword, _newPassword, _confirmPassword;

  EditPasswordModel() {
    this._oldPassword = "";
    this._newPassword = "";
    this._confirmPassword = "";
  }

  Map<String, dynamic> toMap(String token) => Map<String, dynamic>.from({
        "api_token": "$token",
        "password_old": this._oldPassword,
        "password_new": this._newPassword
      });

  String validatePassword(String value) {
    if (value.length >= 6) return null;
    return "كلمة السر قصيرة";
  }

  String validateConfirmPassword(String value) {
    if (this._confirmPassword == this._newPassword &&
        this.validatePassword(this._newPassword) == null) return null;
    return "كلمة السر غير متطابقتان";
  }

  String get oldPassword => this._oldPassword;

  set oldPassword(String value) {
    this._oldPassword = value;
  }

  String get confirmPassword => this._confirmPassword;

  set confirmPassword(String value) {
    this._confirmPassword = value;
  }

  String get newPassword => this._newPassword;

  set newPassword(String value) {
    this._newPassword = value;
  }
}
