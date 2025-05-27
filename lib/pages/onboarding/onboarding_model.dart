class OnboardingModel {
  final String imgPath;
  final String title;
  final String description;
  bool isActive;

  OnboardingModel({
    required this.imgPath,
    required this.title,
    required this.description,
    this.isActive = false,
  });

  static List<OnboardingModel> getOnboardingList() {
    return [
      OnboardingModel(
        imgPath: "assets/images/png/onboard_img_1.png",
        title: "AppStrings.onboardingTitle1.tr",
        description: "AppStrings.onboardingDesc1.tr",
        isActive: true,
      ),
      OnboardingModel(
        imgPath: "assets/images/png/onboard_img_2.png",
        title: "AppStrings.onboardingTitle2.tr",
        description: "AppStrings.onboardingDesc2.tr",
      ),
      OnboardingModel(
        imgPath: "assets/images/png/onboard_img_3.png",
        title: "AppStrings.onboardingTitle3.tr",
        description: "AppStrings.onboardingDesc3.tr",
      ),
    ];
  }
}
