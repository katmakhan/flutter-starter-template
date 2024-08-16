class dm_testimonials {
  String? tsImgurl;
  String? tsHead;
  String? tskey;

  dm_testimonials({this.tsImgurl, this.tsHead});

  dm_testimonials.fromJson(Map<dynamic, dynamic> json) {
    tsImgurl = json['ts_imgurl'];
    tsHead = json['ts_head'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ts_imgurl'] = this.tsImgurl;
    data['ts_head'] = this.tsHead;
    return data;
  }
}
