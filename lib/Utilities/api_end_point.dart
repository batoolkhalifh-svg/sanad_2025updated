
class APIEndPoint{
  static const String baseServerURL = "https://sanad.alfarid.info";
  static const String _baseURL = "$baseServerURL/api";



  //=========================== api User ====================================
  static const String home = "$_baseURL/home";
  static const String login = "$_baseURL/login";
  static const String registration = "$_baseURL/register";
  static const String forgotPassword = "$_baseURL/forgetpassword";
  static const String updateProfile = "$_baseURL/profile-update";
  static const String currentUserData = "$_baseURL/user-data";
  static const String categories = "$_baseURL/categories";
  static String coursesByCategoryId(int? id) => "$_baseURL/courses?category_id=${id ?? ""}&lang=ar";
  static const String instructors = "$_baseURL/instructors";
  static const String myCourses = "$_baseURL/courses-user";
  static String coursesSearchable(String? text) => "$_baseURL/courses?title=$text";
  static String courseDetails(int id) => "$_baseURL/course-details?course_id=$id&lang=ar";
  static const String notifications = "$_baseURL/notices";
  static const String settings = "$_baseURL/settings";
  static const String contactUs = "$_baseURL/inquiries";
  static const String changePassword = "$_baseURL/change_password";
  static const String joinCourse = "$_baseURL/joined-courses";
  static const String removeAccount = "$_baseURL/remove-acount";
  static const String joinedCourses = "$_baseURL/joined-courses";
  static String createPayment = "$_baseURL/create-payment";
  static const String payCourse = "$_baseURL/pay-course";


}




