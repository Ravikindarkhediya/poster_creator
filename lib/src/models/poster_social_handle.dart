/// A social media handle shown on the poster.
class PosterSocialHandle {
  /// Platform key: 'facebook', 'instagram', 'whatsapp', 'phone'
  final String platform;
  final String value;

  const PosterSocialHandle({required this.platform, required this.value});

  factory PosterSocialHandle.facebook(String handle) =>
      PosterSocialHandle(platform: 'facebook', value: handle);
  factory PosterSocialHandle.instagram(String handle) =>
      PosterSocialHandle(platform: 'instagram', value: handle);
  factory PosterSocialHandle.whatsapp(String number) =>
      PosterSocialHandle(platform: 'whatsapp', value: number);
  factory PosterSocialHandle.phone(String number) =>
      PosterSocialHandle(platform: 'phone', value: number);
}
