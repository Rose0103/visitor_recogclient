class recordInfo{
  recordInfo(this.datetime, this.mainpersonName,this.idCardNo, this.cellphoneNo,this.visitor,this.visitorReason,this.visitType,this.selected);
  String datetime="";    //时间
  String mainpersonName=""; //主来访人姓名
  String idCardNo="";  //身份证号
  String cellphoneNo="";//手机号码
  String visitor="";  //拜访对象
  String visitorReason=""; //拜访事由
  String visitType="1"; //1，现场登记 2.预约访问
  bool  selected=false; //是否选中
}