package test.maju.haazireevareeju

import android.app.PendingIntent
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.hardware.usb.UsbConstants
import android.hardware.usb.UsbManager
import androidx.annotation.NonNull
import io.flutter.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant
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
                                    val res = ByteArray(64)
                                    val csw = ByteArray(64)
                                    val usbManager = applicationContext.getSystemService(android.content.Context.USB_SERVICE) as UsbManager
                                    val device = usbManager.deviceList.values.firstOrNull { it.vendorId == 0x2009 && it.productId == 0x7638 }!!
                                    val pi = PendingIntent.getBroadcast(applicationContext, 0, Intent("ch.serverbox.android.USB"), 0)
                                    applicationContext.registerReceiver(
                                            object : BroadcastReceiver() {
                                                override fun onReceive(applicationContext: Context, intent: Intent) {
                                                    applicationContext.unregisterReceiver(this)
                                                }
                                            },
                                            IntentFilter("ch.serverbox.android.USB")
                                    )
                                    usbManager.requestPermission(device, pi)
                                    val usbInterface = device.getInterface(0)
                                    val endPoints = (0 until usbInterface.endpointCount)
                                            .map { usbInterface.getEndpoint(it) }
                                            .filter { it.type == UsbConstants.USB_ENDPOINT_XFER_BULK }
                                    val inEndPoint = endPoints.firstOrNull { it.direction == UsbConstants.USB_DIR_IN }!!
                                    val outEndpoint = endPoints.firstOrNull { it.direction == UsbConstants.USB_DIR_OUT }!!
                                    val maxInSize = inEndPoint.maxPacketSize
                                    val maxOutSize = outEndpoint.maxPacketSize
                                    val cbw = byteArrayOf(0x55, 0x53, 0x42, 0x43, 0x28, 0x2B, 0x18, 0x89.toByte(), 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x0A, 0xEF.toByte(), 0x11, 0x00, 0x00, 0x18, *ByteArray(11))
                                    val cmd = byteArrayOf(0x55, 0xAA.toByte(), 0x50, 0x01, *ByteArray(18), 0x50, 0x01)
                                    val usbDeviceConnection = usbManager.openDevice(device)
                                    usbDeviceConnection.claimInterface(usbInterface, true)

                                    val r1 = usbDeviceConnection.bulkTransfer(outEndpoint, cbw, 31, 3000)
                                    val r2 = usbDeviceConnection.bulkTransfer(outEndpoint, cmd, 24, 3000)
                                    val r3 = usbDeviceConnection.bulkTransfer(inEndPoint, csw, 13, 3000)
                                    cbw[0x0c] = 0x80.toByte()
                                    cbw[0x10] = 0x12.toByte()
                                    val r4 = usbDeviceConnection.bulkTransfer(outEndpoint, cbw, 31, 3000)
                                    val r5 = usbDeviceConnection.bulkTransfer(inEndPoint, res, 24, 3000)
                                    val r6 = usbDeviceConnection.bulkTransfer(inEndPoint, csw, 13, 3000)

                                    val r7 = usbDeviceConnection.releaseInterface(usbInterface)
                                    usbDeviceConnection.close()

                                    SCOPE.launch {
                                        withContext(Dispatchers.Main) {
                                            result.success("$r1, $r2, $r3, $r4, $r5, $r6, $r7")
                                        }
                                    }
                                }
                            }
                        }
                )
    }
}
