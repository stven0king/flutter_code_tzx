package io.flutter.plugins;

import android.annotation.TargetApi;
import android.content.Context;
import android.os.Build;
import android.os.Environment;
import android.util.Log;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;


/**
 * Created by Tanzhenxing
 * Date: 2019-07-24 20:42
 * Description:
 */
public class FileProviderPlugin implements MethodChannel.MethodCallHandler {
    public final static String NAME = "plugins.flutter.io/file_plugin";
    private final Registrar mRegistrar;
    private Context application;
    public FileProviderPlugin(Registrar mRegistrar, Context context) {
        this.mRegistrar = mRegistrar;
        this.application = context.getApplicationContext();
    }

    public static void registerWith(Registrar registrar, Context context) {
        MethodChannel channel =
                new MethodChannel(registrar.messenger(), NAME);
        FileProviderPlugin instance = new FileProviderPlugin(registrar, context);
        channel.setMethodCallHandler(instance);
    }

    @TargetApi(Build.VERSION_CODES.FROYO)
    @Override
    public void onMethodCall(MethodCall methodCall, Result result) {
        String path;
        switch (methodCall.method) {
            case "getExternalStorageDirectory":
                path = Environment.getExternalStorageDirectory().getAbsolutePath();
                System.out.println("getExternalStorageDirectory" + path);
                result.success(path);
                break;
            case "getCacheDir":
                path = application.getCacheDir().getAbsolutePath();
                System.out.println("getCacheDir:" + path);
                result.success(path);
                break;
            case "getFilesDir":
                path = application.getFilesDir().getAbsolutePath();
                System.out.println("getFilesDir:" + path);
                result.success(path);
                break;
            case "getExternalStoragePublicDirectory":
                path = Environment.getExternalStoragePublicDirectory(methodCall.arguments.toString()).getAbsolutePath();
                System.out.println("getExternalStoragePublicDirectory" + path + "  " + methodCall.arguments.toString());
                result.success(path);
                break;
        }
    }
}
