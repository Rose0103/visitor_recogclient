
 var servicePath = {
  //根据设备id登录
  'loginBydeviceID':  'api/authority/anno/loginTerminal',
  //现场登记
  'postsiteregistration': 'api/visitor/interviewRecord/onSiteRegistration',
  //获取现场登记记录
  'getsiteregistration':'api/visitor/interviewRecord/getOnSiteRegistration',
  //根据人员id获取预约信息
  'getinfobyuserid':'api/visitor/interviewRecord/getInterviewRecord',
  //获取预约详情
  'getdetailinfo':'api/visitor/interviewRecord/getInterviewRecordDetail',
  //根据身份证号查询员工信息
  'getuserinfobyidcard':'api/admin/user/getEmployeeByIdCard',
  //更改认证状态为完成
  'postvisitstatus':'api/visitor/interviewRecord/operation',
  //认证
  'approve':'api/visitor/interviewRecord/approve',
  //根据二维码查询预约人员信息
  'getuserinfobyQRauthen':'api/visitor/interviewRecord/getByCode',
  //搜索人脸
  'searchFace':'api/admin/userFace/searchFace',
   //获取在职员工基本信息
   'getOnWorkEmployeeList':'api/hr/employee/getOnWorkEmployeeList',
  //现场登记提交
  'onSiteRegistration':'api/visitor/interviewRecord/onSiteRegistration',
 };
