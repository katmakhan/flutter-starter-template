import 'package:app_name/Helpers/conversions.dart';

class dm_reg_user {
  String? rgName;
  String? rgImage;
  String? rgEmail;
  String? rgMob;
  String? rgDate;
  String? rgTime;
  dynamic rgTimeinmill;
  double? rgLivePandl;
  double? rgPrevPandl;
  double? rgLiveBal;
  double? rgPrevBal;
  String? rgRefferedBy;
  String? rgBrokername;

  dm_reg_user(
      {this.rgName,
      this.rgImage,
      this.rgEmail,
      this.rgMob,
      this.rgDate,
      this.rgTime,
      this.rgTimeinmill,
      this.rgLivePandl,
      this.rgPrevPandl,
      this.rgLiveBal,
      this.rgPrevBal,
      this.rgRefferedBy,
      this.rgBrokername});

  dm_reg_user.fromJson(Map<dynamic, dynamic> json) {
    rgName = json['rg_name'];
    rgImage = json['rg_image'];
    rgEmail = json['rg_email'];
    rgMob = json['rg_mob'];
    rgDate = json['rg_date'];
    rgTime = json['rg_time'];
    rgTimeinmill = json['rg_timeinmill'];
    rgLivePandl = convertToDouble(json['rg_live_pandl']);
    rgPrevPandl = convertToDouble(json['rg_prev_pandl']);
    rgLiveBal = convertToDouble(json['rg_live_bal']);
    rgPrevBal = convertToDouble(json['rg_prev_bal']);
    rgRefferedBy = json['rg_reffered_by'];
    rgBrokername = json['rg_brokername'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rg_name'] = this.rgName;
    data['rg_image'] = this.rgImage;
    data['rg_email'] = this.rgEmail;
    data['rg_mob'] = this.rgMob;
    data['rg_date'] = this.rgDate;
    data['rg_time'] = this.rgTime;
    data['rg_timeinmill'] = this.rgTimeinmill;
    data['rg_live_pandl'] = this.rgLivePandl;
    data['rg_prev_pandl'] = this.rgPrevPandl;
    data['rg_live_bal'] = this.rgLiveBal;
    data['rg_prev_bal'] = this.rgPrevBal;
    data['rg_reffered_by'] = this.rgRefferedBy;
    data['rg_brokername'] = this.rgBrokername;
    return data;
  }
}
