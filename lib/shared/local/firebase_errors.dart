class Errors {
  static String show(String errorCode) {
    switch (errorCode) {
      case 'email-already-in-use':
        return "This e-mail address is already in use, please use a different e-mail address.";
      case 'invalid-email':
        return "The email address is badly formatted.";
      case 'wrong-password':
        return "Email or Password is incorrect";
      case 'user-not-found':
        return "Email or Password is incorrect";
      default:
        return 'An error occurred';
    }
  }
}