package com.example.flutternative

import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val channel = "com.example.flutternative"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channel).setMethodCallHandler { call, result ->
            // This method is invoked on the main thread.
            if (call.method == "getMessageFromNativeCode") {
                val message = getMessage()
                if (message.isNotEmpty()) {
                    result.success(message)
                } else {
                    result.error(
                        "UNAVAILABLE",
                        "Message from Kotlin code is empty",
                        null
                    )
                    result.notImplemented()
                }
            }
        }
    }

    private fun getMessage(): String {
        return "Message from Kotlin code"
    }
}
