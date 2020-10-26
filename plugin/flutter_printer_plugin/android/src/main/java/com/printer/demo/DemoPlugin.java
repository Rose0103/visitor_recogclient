package com.printer.demo;

import android.annotation.SuppressLint;
import android.app.Activity;
import android.app.PendingIntent;
import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.hardware.usb.UsbDevice;
import android.hardware.usb.UsbManager;
import android.os.Handler;
import android.os.Message;
import android.support.annotation.NonNull;
import android.util.Log;
import android.widget.Toast;

import com.printer.demo.global.GlobalContants;
import com.printer.sdk.Barcode;
import com.printer.sdk.PrinterConstants;
import com.printer.sdk.PrinterInstance;
import com.printer.sdk.usb.USBPort;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.embedding.engine.plugins.activity.ActivityAware;
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/** DemoPlugin */
public class DemoPlugin implements FlutterPlugin, MethodCallHandler, ActivityAware {

  private static UsbDevice mUSBDevice;
  public static PrinterInstance myPrinter;
  public static String devicesName = "未知设备";
  private static String devicesAddress;
  public static boolean isConnected = false;// 连接状态
  private static final String ACTION_USB_PERMISSION = "com.android.usb.USB_PERMISSION";
  private int interfaceType = 0;
  private Context mContext;
  private IntentFilter bluDisconnectFilter;
  private static boolean hasRegDisconnectReceiver = false;
  static Activity activity;
  private List<UsbDevice> deviceList;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    final MethodChannel channel = new MethodChannel(flutterPluginBinding.getFlutterEngine().getDartExecutor(), "demo");
    channel.setMethodCallHandler(new DemoPlugin());
  }
  ///activity 生命周期
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
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "demo");
    channel.setMethodCallHandler(new DemoPlugin());
    activity = registrar.activity();
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    if (call.method.equals("getQRPrinter")) {
      new QRPrinter((HashMap) call.arguments);
    }else if (call.method.equals("connectdevice")) {
      UsbManager manager = (UsbManager) activity.getSystemService(Context.USB_SERVICE);
      connectdevice(manager);
    } else {
      result.notImplemented();
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
  }

  // 用于接受连接状态消息的 Handler
  private Handler mHandler = new Handler() {
    @SuppressLint("ShowToast")
    @Override
    public void handleMessage(Message msg) {
      switch (msg.what) {
        case PrinterConstants.Connect.SUCCESS:
          isConnected = true;
          GlobalContants.ISCONNECTED = isConnected;
          GlobalContants.DEVICENAME = devicesName;
          //if (interfaceType == 0) {
          //  PrefUtils.setString(mContext, GlobalContants.DEVICEADDRESS, devicesAddress);
          //  bluDisconnectFilter = new IntentFilter();
          //  bluDisconnectFilter.addAction(BluetoothDevice.ACTION_ACL_DISCONNECTED);
          //  mContext.registerReceiver(myReceiver, bluDisconnectFilter);
          //  hasRegDisconnectReceiver = true;
          //}
          // TOTO 暂时将TSPL指令设置参数的设置放在这
          // if (setPrinterTSPL(myPrinter)) {
          // if (interfaceType == 0) {
          // Toast.makeText(mContext,
          // R.string.settingactivitty_toast_bluetooth_set_tspl_successful,
          // 0)
          // .show();
          // } else if (interfaceType == 1) {
          // Toast.makeText(mContext,
          // R.string.settingactivity_toast_usb_set_tspl_succefful,
          // 0).show();
          // }
          // }
          break;
        case PrinterConstants.Connect.FAILED:
          isConnected = false;

          //Toast.makeText(mContext, R.string.conn_failed, Toast.LENGTH_SHORT).show();
          //XLog.i(TAG, "ZL at SettingActivity Handler() 连接失败!");
          break;
        case PrinterConstants.Connect.CLOSED:
          isConnected = false;
          GlobalContants.ISCONNECTED = isConnected;
          GlobalContants.DEVICENAME = devicesName;
          //Toast.makeText(mContext, R.string.conn_closed, Toast.LENGTH_SHORT).show();
          //XLog.i(TAG, "ZL at SettingActivity Handler() 连接关闭!");
          break;
        case PrinterConstants.Connect.NODEVICE:
          isConnected = false;
          //Toast.makeText(mContext, R.string.conn_no, Toast.LENGTH_SHORT).show();
          break;
        // case 10:
        // if (setPrinterTSPL(myPrinter)) {
        // Toast.makeText(mContext, "蓝牙连接设置TSPL指令成功", 0).show();
        // }
        default:
          break;
      }

    }

  };

  private final BroadcastReceiver mUsbReceiver = new BroadcastReceiver() {
    @SuppressLint("NewApi")
    public void onReceive(Context context, Intent intent) {
      String action = intent.getAction();
//      Log.w(TAG, "receiver action: " + action);

      if (ACTION_USB_PERMISSION.equals(action)) {
        synchronized (this) {
          activity.getApplicationContext().unregisterReceiver(mUsbReceiver);
          UsbDevice device = (UsbDevice) intent.getParcelableExtra(UsbManager.EXTRA_DEVICE);
          if (intent.getBooleanExtra(UsbManager.EXTRA_PERMISSION_GRANTED, false)
                  && mUSBDevice.equals(device)) {
            myPrinter.openConnection();
          } else {
            mHandler.obtainMessage(PrinterConstants.Connect.FAILED).sendToTarget();
//            Log.e(TAG, "permission denied for device " + device);
          }
        }
      }
    }
  };

  @SuppressLint({ "InlinedApi", "NewApi" })
  public void connectdevice(UsbManager manager)
  {
    doDiscovery(manager);
    if (deviceList.isEmpty()) {
      Toast.makeText(activity.getApplicationContext(), "Printer Not Connected", Toast.LENGTH_SHORT).show();
      return;
    }
    mUSBDevice = deviceList.get(0);
    if (mUSBDevice == null) {
      mHandler.obtainMessage(PrinterConstants.Connect.FAILED).sendToTarget();
      return;
    }
    myPrinter = PrinterInstance.getPrinterInstance(activity.getApplicationContext(), mUSBDevice, mHandler);
    devicesName = mUSBDevice.getDeviceName();
    devicesAddress = "vid: " + mUSBDevice.getVendorId() + "  pid: " + mUSBDevice.getProductId();
    UsbManager mUsbManager = (UsbManager) activity.getApplicationContext().getSystemService(Context.USB_SERVICE);
    if (mUsbManager.hasPermission(mUSBDevice)) {
      myPrinter.openConnection();
    } else {
      // 没有权限询问用户是否授予权限
      PendingIntent pendingIntent = PendingIntent.getBroadcast(activity.getApplicationContext(), 0, new Intent(ACTION_USB_PERMISSION), 0);
      IntentFilter filter = new IntentFilter(ACTION_USB_PERMISSION);
      filter.addAction(UsbManager.ACTION_USB_DEVICE_ATTACHED);
      filter.addAction(UsbManager.ACTION_USB_DEVICE_DETACHED);
      activity.getApplicationContext().registerReceiver(mUsbReceiver, filter);
      mUsbManager.requestPermission(mUSBDevice, pendingIntent); // 该代码执行后，系统弹出一个对话框
    }
  }

  public void QRPrinter(String content,String time,String name,String count,String visName){
    int width = 10;
    int height = 76;
    PrinterInstance.mPrinter.setPrinter(PrinterConstants.Command.ALIGN, PrinterConstants.Command.ALIGN_CENTER);
    PrinterInstance.mPrinter.setFont(0, 2, 2, 0, 0);
    PrinterInstance.mPrinter
            .printText("通行证");
    PrinterInstance.mPrinter.setPrinter(
            PrinterConstants.Command.PRINT_AND_WAKE_PAPER_BY_LINE, 3);
    PrinterInstance.mPrinter.setFont(0, 0, 1, 0, 0);
    PrinterInstance.mPrinter
            .printText("欢迎使用敏智访客系统！");
    PrinterInstance.mPrinter.setPrinter(
            PrinterConstants.Command.PRINT_AND_WAKE_PAPER_BY_LINE, 2);
    PrinterInstance.mPrinter.setPrinter(PrinterConstants.Command.ALIGN, PrinterConstants.Command.ALIGN_LEFT);
    PrinterInstance.mPrinter
            .printText("拜访时间： "+time);
    PrinterInstance.mPrinter.setPrinter(
            PrinterConstants.Command.PRINT_AND_WAKE_PAPER_BY_LINE, 2);
    PrinterInstance.mPrinter
            .printText("受访人：  "+name);
    PrinterInstance.mPrinter.setPrinter(
            PrinterConstants.Command.PRINT_AND_WAKE_PAPER_BY_LINE, 2);
    PrinterInstance.mPrinter
            .printText("同行人数： "+count);
    PrinterInstance.mPrinter.setPrinter(
            PrinterConstants.Command.PRINT_AND_WAKE_PAPER_BY_LINE, 2);
    if(content==null||content==""){
      PrinterInstance.mPrinter
              .printText("主来访人：  "+visName);
    }else{
      PrinterInstance.mPrinter.setPrinter(PrinterConstants.Command.ALIGN, PrinterConstants.Command.ALIGN_CENTER);
      Barcode barcode = new Barcode(PrinterConstants.BarcodeType.QRCODE, width, height, 4, content);
      PrinterInstance.mPrinter.printBarCode(barcode);
    }
    PrinterInstance.mPrinter.setPrinter(
            PrinterConstants.Command.PRINT_AND_WAKE_PAPER_BY_LINE, 1);
  }

  @SuppressLint("NewApi")
  private void doDiscovery(UsbManager manager) {
    HashMap<String, UsbDevice> devices = manager.getDeviceList();
    deviceList = new ArrayList<UsbDevice>();
    for (UsbDevice device : devices.values()) {
      if (USBPort.isUsbPrinter(device)) {
        deviceList.add(device);
      }
    }

  }

  private class QRPrinter  {
    QRPrinter(HashMap args) {
      String content = (String) args.get("content");
      SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
      String time = df.format(new Date());
      String name = (String) args.get("name");
      String count = (String) args.get("count");
      String visName = (String) args.get("visitname");
      QRPrinter(content,time,name,count,visName);
      myPrinter.cutPaper(66, 50);
    }
  }
}
