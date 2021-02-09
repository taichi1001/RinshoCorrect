package com.taichi1001.template

import io.flutter.embedding.android.FlutterActivity
import android.view.WindowManager.LayoutParams;

class MainActivity: FlutterActivity() {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        getWindow().addFlags(LayoutParams.FLAG_SECURE); 
    }
}
