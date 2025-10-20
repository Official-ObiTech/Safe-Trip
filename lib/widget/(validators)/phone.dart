bool isValidPhone(String phone, {int min = 11, int max = 11}){
  return RegExp(r"^\d+$").hasMatch(phone.trim()) && phone.trim().length >= min && phone.trim().length <= max;
}