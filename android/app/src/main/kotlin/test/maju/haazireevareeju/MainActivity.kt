package test.maju.haazireevareeju

import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant
import io.flutter.plugin.common.MethodChannel;
import kotlinx.coroutines.*

class MainActivity : FlutterActivity() {
    private val CHANNEL = "haaziree/test"
    private val SCOPE = CoroutineScope(Job() + Dispatchers.IO)

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);

        MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler(
                        { call, result ->
                            SCOPE.launch {
                                withContext(Dispatchers.IO) {
                                    SCOPE.launch {
                                        withContext(Dispatchers.Main) {
                                            result.success("YOLO")
                                        }
                                    }
                                }
                            }
                        }
                )
    }
}
