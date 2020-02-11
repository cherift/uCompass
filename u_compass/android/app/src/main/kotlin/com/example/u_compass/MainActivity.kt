package com.example.u_compass

import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant
import io.mapwize.mapwizesdk.core.MapwizeConfiguration
import android.content.Intent
import io.flutter.plugin.common.MethodChannel
import androidx.core.content.ContextCompat.getSystemService
import android.icu.lang.UCharacter.GraphemeClusterBreak.T
import com.mapbox.mapboxsdk.Mapbox


class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)

        val config = MapwizeConfiguration.Builder(this, "cd8ac2e88bc7c9cc62e93934e0abbb2e").build()
        MapwizeConfiguration.start(config)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "test")
                .setMethodCallHandler { call, result ->
                    Mapbox.getInstance(this, "pk.mapwize")

                    val config = MapwizeConfiguration.Builder(this, "cd8ac2e88bc7c9cc62e93934e0abbb2e").build()
                    MapwizeConfiguration.start(config)

                    result.success("suess")
                    val intent = Intent(this, MapActivity::class.java)
                    startActivity(intent)
                }
    }
}
