package com.mq.visitor_idcard;

import androidx.annotation.NonNull;

import android.app.Activity;
import android.app.PendingIntent;
import android.content.Context;
import android.content.Intent;
import android.hardware.usb.UsbDevice;
import android.hardware.usb.UsbManager;

import android.util.Base64;
import android.util.Log;
import android.widget.Toast;

import com.zkteco.android.IDReader.IDPhotoHelper;
import com.zkteco.android.IDReader.OutPhoto;
import com.zkteco.android.IDReader.WLTService;
import com.zkteco.android.biometric.core.device.ParameterHelper;
import com.zkteco.android.biometric.core.device.TransportType;
import com.zkteco.android.biometric.core.utils.LogHelper;
import com.zkteco.android.biometric.module.idcard.IDCardReader;
import com.zkteco.android.biometric.module.idcard.IDCardReaderExceptionListener;
import com.zkteco.android.biometric.module.idcard.IDCardReaderFactory;
import com.zkteco.android.biometric.module.idcard.exception.IDCardReaderException;
import com.zkteco.android.biometric.module.idcard.meta.IDCardInfo;
import com.zkteco.android.biometric.module.idcard.meta.IDPRPCardInfo;

import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.CountDownLatch;
import java.util.concurrent.TimeUnit;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;
import sun.misc.BASE64Encoder;

/** VisitorIdcardPlugin */
public class VisitorIdcardPlugin implements FlutterPlugin, MethodCallHandler,ActivityAware  {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private MethodChannel channel;
    private static final int VID = 1024;    //IDR VID
    private static final int PID = 50010;     //IDR PID
    private IDCardReader idCardReader = null;
    private boolean bopen = false;
    private boolean bStoped = false;
    private int mReadCount = 0;
    private CountDownLatch countdownLatch = null;
    private  String retmsg = "";
    private Thread t;
    private String base64;
    private int dev;//????????????????????????


    static Activity activity;
    private UsbManager musbManager = null;
    private final String ACTION_USB_PERMISSION = "com.mq.visitor_idcard.USB_PERMISSION";


    ///activity ????????????
    @Override
    public void onAttachedToActivity(ActivityPluginBinding activityPluginBinding) {
        Log.e("onAttachedToActivity", "onAttachedToActivity");
        activity = activityPluginBinding.getActivity();
    }

    @Override
    public void onDetachedFromActivityForConfigChanges() {
        Log.e("onDetachedFromActiv", "onDetachedFromActivityForConfigChanges");

    }

    @Override
    public void onReattachedToActivityForConfigChanges(ActivityPluginBinding activityPluginBinding) {
        Log.e("onReattachedToActivity", "onReattachedToActivityForConfigChanges");
    }

    @Override
    public void onDetachedFromActivity() {
        Log.e("onDetachedFromActivity", "onDetachedFromActivity");
    }


    private void RequestDevicePermission() {
        musbManager = (UsbManager)activity.getSystemService(Context.USB_SERVICE);
        for (UsbDevice device : musbManager.getDeviceList().values()) {
            if (device.getVendorId() == VID && device.getProductId() == PID) {
                Intent intent = new Intent(ACTION_USB_PERMISSION);
                PendingIntent pendingIntent = PendingIntent.getBroadcast(activity.getApplicationContext(), 0, intent, 0);
                musbManager.requestPermission(device, pendingIntent);
            }
        }
    }

    public void readIDcard() {
        retmsg="";
        dev = 0;
        RequestDevicePermission();
        OpenDevice();
    }

    public void OpenDevice() {
        if (bopen) {
            Toast.makeText(activity.getApplicationContext(), "??????????????????", Toast.LENGTH_SHORT).show();
            return ;
        }
        try {
            startIDCardReader();
            IDCardReaderExceptionListener listener = new IDCardReaderExceptionListener() {
                @Override
                public void OnException() {
                    //???????????????????????????
                    CloseDevice();
                    Toast.makeText(activity.getApplicationContext(), "????????????????????????????????????", Toast.LENGTH_SHORT).show();
                };
            };
            idCardReader.open(0);
            idCardReader.setIdCardReaderExceptionListener(listener);
            bStoped = false;
            mReadCount = 0;
            System.out.println("??????????????????");
            System.out.println("????????????");
            bopen = true;
            countdownLatch = new CountDownLatch(1);
            t = new Thread(new Runnable() {
                @Override
                public void run() {
                    while (!bStoped) {
                        try {
                            t.sleep(950);
                        } catch (InterruptedException e) {
                            e.printStackTrace();
                        }
                        boolean ret = false;
                        final long nTickstart = System.currentTimeMillis();
                        try {
                            idCardReader.findCard(0);
                            idCardReader.selectCard(0);
                        }catch (IDCardReaderException e) {
                            //continue;
                        }
                        try {
                            Thread.sleep(50);
                        } catch (InterruptedException e) {
                            e.printStackTrace();
                        }
                        int retType = 0;
                        try {
                            retType = idCardReader.readCardEx(0, 0);
                        }
                        catch (IDCardReaderException e) {
                            Toast.makeText(activity.getApplicationContext(), "??????????????????????????????" + e.getMessage(), Toast.LENGTH_SHORT).show();
                        }
                        if (retType == 1 || retType == 2 || retType == 3)
                        {
                            final long nTickUsed = (System.currentTimeMillis()-nTickstart);
                            final int final_retType = retType;
                            System.out.println("???????????????" + (++mReadCount) + "???" + "????????????" + nTickUsed + "??????");
                            if (final_retType == 1) {
                                final IDCardInfo idCardInfo = idCardReader.getLastIDCardInfo();
                                //??????adb
                                String strName = idCardInfo.getName();
                                //??????
                                String strNation = idCardInfo.getNation();
                                //????????????
                                String strBorn = idCardInfo.getBirth();
                                //??????
                                String strAddr = idCardInfo.getAddress();
                                //????????????
                                String strID = idCardInfo.getId();
                                //????????????
                                String strEffext = idCardInfo.getValidityTime();
                                //????????????
                                String strIssueAt = idCardInfo.getDepart();
                                System.out.println("???????????????"  + mReadCount + ",?????????"+  nTickUsed +  "??????, ???????????????????????????,?????????" + strName +
                                        "????????????" + strNation + "????????????" + strAddr + ",???????????????" + strID);
                                retmsg =  strName+"||"+strID+"||"+strAddr;
                                if (idCardInfo.getPhotolength() > 0) {
                                    byte[] buf = new byte[WLTService.imgLength];
                                    if (1 == WLTService.wlt2Bmp(idCardInfo.getPhoto(), buf)) {
//                                        OutPhoto.saveImage(IDPhotoHelper.Bgr2Bitmap(buf));
                                        base64 = OutPhoto.bitmapToBase64(IDPhotoHelper.Bgr2Bitmap(buf));
                                    }
                                }
                            }
                            else if (final_retType == 2)
                            {
                                final IDPRPCardInfo idprpCardInfo = idCardReader.getLastPRPIDCardInfo();
                                //?????????
                                String strCnName = idprpCardInfo.getCnName();
                                //?????????
                                String strEnName = idprpCardInfo.getEnName();
                                //??????/??????????????????
                                String strCountry = idprpCardInfo.getCountry() + "/" + idprpCardInfo.getCountryCode();//??????/??????????????????
                                //????????????
                                String strBorn = idprpCardInfo.getBirth();
                                //????????????
                                String strID = idprpCardInfo.getId();
                                //????????????
                                String strEffext = idprpCardInfo.getValidityTime();
                                //????????????
                                String strIssueAt = "?????????";
                                System.out.println("???????????????"  + mReadCount + ",?????????"+  nTickUsed +  "??????, ??????????????????????????????,????????????" + strCnName + ",????????????" +
                                        strEnName + "????????????" + strCountry + ",????????????" + strID);
                                retmsg =  strCnName+"||"+strID;
                                if (idprpCardInfo.getPhotolength() > 0) {
                                    byte[] buf = new byte[WLTService.imgLength];
                                    if (1 == WLTService.wlt2Bmp(idprpCardInfo.getPhoto(), buf)) {
                                        base64 = Base64.encodeToString(buf,Base64.NO_WRAP);
                                        System.out.println(base64);
                                    }
                                }
                            }else{
                                final IDCardInfo idCardInfo = idCardReader.getLastIDCardInfo();
                                //??????
                                String strName = idCardInfo.getName();
                                //??????,????????????????????????
                                String strNation = "";
                                //????????????
                                String strBorn = idCardInfo.getBirth();
                                //??????
                                String strAddr = idCardInfo.getAddress();
                                //????????????
                                String strID = idCardInfo.getId();
                                //????????????
                                String strEffext = idCardInfo.getValidityTime();
                                //????????????
                                String strIssueAt = idCardInfo.getDepart();
                                //????????????
                                String strPassNum = idCardInfo.getPassNum();
                                //????????????
                                int visaTimes = idCardInfo.getVisaTimes();
                                System.out.println("???????????????"  + mReadCount + ",?????????"+  nTickUsed +  "??????, ??????????????????????????????,?????????" + strName +
                                        "????????????" + strAddr + ",???????????????" + strID + "?????????????????????" + strPassNum +
                                        ",???????????????" + visaTimes);
                                retmsg =  strName+"||"+strID+"||"+strAddr;
                                if (idCardInfo.getPhotolength() > 0) {
                                    byte[] buf = new byte[WLTService.imgLength];
                                    if (1 == WLTService.wlt2Bmp(idCardInfo.getPhoto(), buf)) {
                                        base64 = Base64.encodeToString(buf,Base64.NO_WRAP);
                                        System.out.println(base64);
                                    }
                                }
                            }
                        }
                        else{
                            ++mReadCount;
                        }
                    }
                    countdownLatch.countDown();
                }
            });
            t.start();

            // for(int i=0;i<10000;i++) {
            //   System.out.println("haoshicaozuo:"+i);
            //   if(bStoped&&!bopen) break;
            //   for (int j = 0; j < 100000000; j++) { // ???????????????????????????
            //    }
            // }

            // try {
            //   t.join(10000);
            //   CloseDevice();
            // }catch (Exception e){
            //    e.printStackTrace();
            //  }
        }catch (IDCardReaderException e) {
            System.out.println("??????????????????");
            RequestDevicePermission();
            OpenDevice();
        }
    }

    private void startIDCardReader() {
        if (null != idCardReader) {
            IDCardReaderFactory.destroy(idCardReader);
            idCardReader = null;
        }
        // Define output log level
        LogHelper.setLevel(Log.VERBOSE);
        // Start fingerprint sensor
        Map idrparams = new HashMap();
        idrparams.put(ParameterHelper.PARAM_KEY_VID, VID);
        idrparams.put(ParameterHelper.PARAM_KEY_PID, PID);
        idCardReader = IDCardReaderFactory.createIDCardReader(activity.getApplicationContext(), TransportType.USB, idrparams);
        idCardReader.setLibusbFlag(true);
    }

    private void CloseDevice() {
        if (!bopen) {
            return;
        }
        bStoped = true;
        mReadCount = 0;
        if (null != countdownLatch) {
            try {
                countdownLatch.await(1, TimeUnit.SECONDS);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
        }
        try {
            idCardReader.close(0);
        } catch (IDCardReaderException e) {
            e.printStackTrace();
        }
        bopen = false;
    }

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        channel = new MethodChannel(flutterPluginBinding.getFlutterEngine().getDartExecutor(), "visitor_idcard");
        channel.setMethodCallHandler(this);
    }

    // This static function is optional and equivalent to onAttachedToEngine. It supports the old
    // pre-Flutter-1.12 Android projects. You are encouraged to continue supporting
    // plugin registration via this function while apps migrate to use the new Android APIs
    // post-flutter-1.12 via https://flutter.dev/go/android-project-migration.
    //
    // It is encouraged to share logic between onAttachedToEngine and registerWith to keep
    // them functionally equivalent. Only one of onAttachedToEngine or registerWith will be called
    // depending on the user's project. onAttachedToEngine or registerWith must both be defined
    // in the same class.


    public static void registerWith(Registrar registrar) {
        final MethodChannel channel = new MethodChannel(registrar.messenger(), "visitor_idcard");
        channel.setMethodCallHandler(new VisitorIdcardPlugin());
        activity = registrar.activity();
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        if (call.method.equals("getPlatformVersion")) {
            result.success("Android " + android.os.Build.VERSION.RELEASE);
        }else if (call.method.equals("readIDcard")){
            try {
                readIDcard();
                result.success(retmsg);
                retmsg = "";
            } catch (Exception e) {
                result.error("error:", e.getMessage(), e);
            }
        } else if (call.method.equals("getIDCardInfo")){
            try {
                result.success(retmsg);
                retmsg = "";
            } catch (Exception e) {
                result.error("error:", e.getMessage(), e);
            }
        } else if (call.method.equals("toBase64")){
            try {
                result.success(base64);
                retmsg = "";
            } catch (Exception e) {
                result.error("error:", e.getMessage(), e);
            }
        } else if (call.method.equals("stopreadIDcard")){
            try {
                CloseDevice();
                result.success("stop success");
            } catch (Exception e) {
                result.error("error", e.getMessage(), e);
            }
        } else {
            result.notImplemented();
        }
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        channel.setMethodCallHandler(null);
    }
}
