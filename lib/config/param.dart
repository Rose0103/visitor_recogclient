import 'dart:async';

import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:visitor_recogclient/model/httpmodel/employ.dart';

String serverIP="www.njzyit.com:8760";
//String serviceUrltest = "http://$serverIP/";  //测试环境
bool openIDcordRecog=true;
bool openFaceRecog=true;
Timer countTimer;//倒计时
Timer countTimers;//倒计时
Timer countDownTimer;//倒计时
String imagesrc;
bool isselect = false;
bool facebol = false;
String userIds = '';
bool openQRrecog=true;
bool autologin=true;
double painterWidgetWidth=400;
double painterWidgetHeiht=400;
String fullPicPath="";
String facePicPath="";
Face detectFace;
String fullLight;
String leftfaceLight;
String rightfaceLight;
String featureBase64;
int floaststaytime=3;//提示信息相关
String deviceNo = '824FB21A41B0CB278F61CE43D125A1B8';//设备号湖南敏求
// String deviceNo = '824FB21A41B0CB278F61CE43D125A1B7';//设备号鲜之醇
// String deviceNo = '5d45f9d5d9573116471e52f9ac924caa';//设备号湖南邮政
// String serviceURL="https://visit.eetcm.com/";
String serviceURL="https://visit.yangguangshitang.com/";
String acceptEmails = "";
String tenantCode='';
String token='';
bool isvis = false;//是否加载预约信息
bool isRZ = false;//判断认证是否成功
String aaa;//身份证扫描结果
int count;//允许的最大打印次数
int tableindex;
FlatButton deleteflatButton;
FlatButton updateflatButton;
bool isadd = false;//是否添加过主来访人
List rowName = ["编号","来访时间","主来访人","身份证号","家庭住址","手机号","拜访对象","拜访事由","类型"];//excle表头
List<EmployModelData> sarchList;
bool none = false; //地址显示
String toBase64 = "";//人脸图片
ImageProvider imagecontainer;//人脸图片
Widget image;
String visitMethod;//拜访方式