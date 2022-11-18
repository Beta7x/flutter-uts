class OnboardingContents {
  final String title;
  final String image;
  final String desc;

  OnboardingContents({
    required this.title,
    required this.image,
    required this.desc,
  });
}

List<OnboardingContents> contents = [
  OnboardingContents(
    title: "Track Your work and get the result",
    image: "assets/images/Saly-12.png",
    desc: "Remember to keep track of your professional accomplishments.",
  ),
  OnboardingContents(
    title: "Stay organized with team",
    image: "assets/images/Saly-13.png",
    desc:
        "But understanding the contributions our colleagues make to our teams and companies.",
  ),
  OnboardingContents(
    title: "Get notified when work happens",
    image: "assets/images/Saly-14.png",
    desc:
        "Take control of notifications, collaborate live or on your own time.",
  ),
];
