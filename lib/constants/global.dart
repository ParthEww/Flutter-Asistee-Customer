class Global {
  static String appName = "App name";

  static const double kButtonHeight = 48;
  static const double kBookContainerHeight = 242;
  static const int otpSeconds = 120 + 1;

  static final RegExp emailRegex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
  static final digitRegex = RegExp(r'^\d+$');
}
