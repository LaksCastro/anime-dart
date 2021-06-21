class EpisodeDetails {
  final String id;
  final String animeId;
  final String label;
  final String url;
  final String urlHd;
  final String urlFullHd;
  final String imageUrl;
  final Map<String, String> imageHttpHeaders;
  final double stats;

  EpisodeDetails({
    this.id,
    this.animeId,
    this.label,
    this.url,
    this.urlHd,
    this.urlFullHd,
    this.imageUrl,
    this.imageHttpHeaders,
    this.stats,
  });
}
