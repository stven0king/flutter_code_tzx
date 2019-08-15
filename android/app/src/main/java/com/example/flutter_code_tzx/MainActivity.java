package com.example.flutter_code_tzx;

import android.content.Context;
import android.os.Bundle;
import io.flutter.app.FlutterActivity;
import io.flutter.plugins.FileProviderPlugin;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);
    FileProviderPlugin.registerWith(this.registrarFor(FileProviderPlugin.NAME), this);
  }
}
