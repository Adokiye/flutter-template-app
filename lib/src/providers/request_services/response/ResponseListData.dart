

class ResponseListData {
  List<dynamic> data;
  String error;
  ResponseListData(this.data, this.error);
}

class FeaturedImage {
  String slug; // slug | id
  String url;
  FeaturedImage(this.slug, this.url);
}