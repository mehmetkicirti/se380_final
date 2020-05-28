class FormOptions{
  static validatePassword(String value) {
    RegExp exp = new RegExp(r"^(((?=.*[a-z])(?=.*[A-Z]))|((?=.*[a-z])(?=.*[0-9]))|((?=.*[A-Z])(?=.*[0-9])))(?=.{6,})");
    if(!exp.hasMatch(value)){
      return "At least 1 upper and greater than 6 character";
    }
    return null;
  }
  static validateEmail(String value) {
    RegExp exp = new RegExp(r"^\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$");
    if(!exp.hasMatch(value)){
      return "Please enter a valid email";
    }
    return null;
  }
  static validateName(String value){
    RegExp exp = new RegExp(r"$[0-9]");
    if(value.isEmpty)
      return "Name is required";
    if(!exp.hasMatch(value) && value.length<=0)
      return "Should not start with number and greater than 0 character";
    return null;
  }
}