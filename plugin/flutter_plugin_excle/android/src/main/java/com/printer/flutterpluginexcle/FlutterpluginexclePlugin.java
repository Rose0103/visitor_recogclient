package com.printer.flutterpluginexcle;

import android.os.Environment;
import android.support.annotation.NonNull;
import android.util.Log;

import com.out.email.MailUtil;
import com.out.excle.ExportExcel;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/** FlutterpluginexclePlugin */
public class FlutterpluginexclePlugin implements FlutterPlugin, MethodCallHandler {
    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        final MethodChannel channel = new MethodChannel(flutterPluginBinding.getFlutterEngine().getDartExecutor(), "flutterpluginexcle");
        channel.setMethodCallHandler(new FlutterpluginexclePlugin());
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
        final MethodChannel channel = new MethodChannel(registrar.messenger(), "flutterpluginexcle");
        channel.setMethodCallHandler(new FlutterpluginexclePlugin());
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        if (call.method.equals("getPlatformVersion")) {
            result.success("Android " + android.os.Build.VERSION.RELEASE);
        } else if(call.method.equals("outExcel")){
            new OutExcel((HashMap) call.arguments);
        } else {
            result.notImplemented();
        }
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    }

    public void outExcel(String to,String bo,String fileName,String title,Object[] rowName,List<Object[]> content){
        try {
            String excelPath = getExcelDir()+ File.separator+fileName+".xls";
            System.out.println(excelPath);
            File file = new File(excelPath);
            ExportExcel exportExcel = new ExportExcel(title,rowName,content);
            OutputStream out = new FileOutputStream(file);
            exportExcel.export(out);
            new MailUtil().send(to,bo,excelPath, new MailUtil.SendCallBack() {
                @Override
                public void back(boolean isSuccess) {
                    System.out.println(isSuccess);
                }
            });
        }catch (Exception e){
            e.printStackTrace();
        }
    }

    //获取sd卡的路径
    public static String getExcelDir() {
        // SD卡指定文件夹
        String sdcardPath = Environment.getExternalStorageDirectory().toString();
        File dir = new File(sdcardPath + File.separator + "visit");
        if (dir.exists()) {
            return dir.toString();
        } else {
            dir.mkdirs();
            Log.e("BAG", "保存路径不存在,");
            return dir.toString();
        }
    }

    private class OutExcel  {
        OutExcel(HashMap args) {
            String fileName = (String) args.get("fileName");
            String title = (String) args.get("title");
            List<String> rowNames = (ArrayList) args.get("rowName");
            Object[] rowName = rowNames.toArray();
            List<List> contents = (ArrayList) args.get("content");
            List<Object[]> content = new ArrayList<>();
            for(int i=0;i<contents.size();i++){
                content.add(contents.get(i).toArray());
            }
            String to = (String) args.get("to");
            outExcel(to,fileName,fileName,title,rowName,content);
        }
    }


}
