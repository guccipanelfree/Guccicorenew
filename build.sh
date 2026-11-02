#!/bin/bash
set -e

wget -q https://services.gradle.org/distributions/gradle-8.2-bin.zip
unzip -q gradle-8.2-bin.zip
export PATH="$PWD/gradle-8.2/bin:$PATH"

rm -rf app build.gradle settings.gradle gradle.properties
mkdir -p app/src/main/java/com/example/shtile app/src/main/res/drawable app/src/main/res/layout app/src/main/res/values app/src/main/assets
cp Gucci_core app/src/main/assets/ 2>/dev/null || true
cp Gucci_brutal app/src/main/assets/ 2>/dev/null || true

cat > settings.gradle << 'EOF'
pluginManagement { repositories { google(); mavenCentral(); gradlePluginPortal() } }
dependencyResolutionManagement { repositories { google(); mavenCentral() } }
rootProject.name = "Settings"
include ':app'
EOF

cat > build.gradle << 'EOF'
plugins { id 'com.android.application' version '8.2.2' apply false; id 'org.jetbrains.kotlin.android' version '1.9.22' apply false }
EOF

cat > gradle.properties << 'EOF'
android.useAndroidX=true
android.nonTransitiveRClass=true
org.gradle.jvmargs=-Xmx2048m
EOF

cat > app/build.gradle << 'EOF'
plugins { id 'com.android.application'; id 'org.jetbrains.kotlin.android' }
android {
    namespace 'com.example.shtile'
    compileSdk 34
    defaultConfig { applicationId "com.example.shtile"; minSdk 24; targetSdk 34; versionCode 80; versionName "80.0" }
    compileOptions { sourceCompatibility JavaVersion.VERSION_17; targetCompatibility JavaVersion.VERSION_17 }
    kotlinOptions { jvmTarget = '17' }
}
dependencies { implementation 'androidx.appcompat:appcompat:1.6.1'; implementation 'androidx.core:core-ktx:1.12.0'; implementation 'com.google.android.material:material:1.11.0' }
EOF

cat > app/src/main/AndroidManifest.xml << 'EOF'
<?xml version="1.0" encoding="utf-8"?>
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
<uses-permission android:name="android.permission.FOREGROUND_SERVICE"/>
<uses-permission android:name="android.permission.FOREGROUND_SERVICE_DATA_SYNC"/>
<application android:allowBackup="true" android:label="Settings" android:icon="@drawable/ic_app_icon" android:theme="@style/Theme.MaterialComponents.NoActionBar">
<activity android:name=".MainActivity" android:exported="true"/>
<activity-alias android:name=".MainActivityAlias" android:targetActivity=".MainActivity" android:exported="true" android:enabled="true" android:icon="@drawable/ic_app_icon"><intent-filter><action android:name="android.intent.action.MAIN"/><category android:name="android.intent.category.LAUNCHER"/></intent-filter></activity-alias>
<service android:name=".RunnerService" android:exported="false" android:foregroundServiceType="dataSync"/>
<service android:name=".SafeTileService" android:exported="true" android:icon="@drawable/ic_tile_normal" android:label="Boost" android:permission="android.permission.BIND_QUICK_SETTINGS_TILE"><intent-filter><action android:name="android.service.quicksettings.action.QS_TILE"/></intent-filter></service>
<service android:name=".BrutalTileService" android:exported="true" android:icon="@drawable/ic_tile_brutal" android:label="Turbo Mode" android:permission="android.permission.BIND_QUICK_SETTINGS_TILE"><intent-filter><action android:name="android.service.quicksettings.action.QS_TILE"/></intent-filter></service>
<service android:name=".FocusTileService" android:exported="true" android:icon="@drawable/ic_tile_focus" android:label="Focus Mode" android:permission="android.permission.BIND_QUICK_SETTINGS_TILE"><intent-filter><action android:name="android.service.quicksettings.action.QS_TILE"/></intent-filter></service>
</application>
</manifest>
EOF

cat > app/src/main/res/values/colors.xml << 'EOF'
<?xml version="1.0" encoding="utf-8"?>
<resources>
<color name="bg_main">#0B0F14</color>
<color name="bg_card">#151B23</color>
<color name="accent_green">#00E5A0</color>
<color name="accent_red">#FF4D4D</color>
<color name="text_primary">#FFFFFF</color>
<color name="text_secondary">#9BA3AF</color>
</resources>
EOF

cat > app/src/main/res/values/themes.xml << 'EOF'
<?xml version="1.0" encoding="utf-8"?>
<resources xmlns:tools="http://schemas.android.com/tools">
<style name="Theme.MaterialComponents.NoActionBar" parent="Theme.MaterialComponents.NoActionBarBase">
<item name="colorPrimary">@color/accent_green</item>
<item name="colorSecondary">@color/accent_green</item>
<item name="android:windowBackground">@color/bg_main</item>
<item name="android:statusBarColor" tools:targetApi="l">@color/bg_main</item>
<item name="android:navigationBarColor" tools:targetApi="l">@color/bg_main</item>
<item name="materialAlertDialogTheme">@style/CustomDialogTheme</item>
</style>
<style name="CustomDialogTheme" parent="ThemeOverlay.MaterialComponents.MaterialAlertDialog">
<item name="colorPrimary">@color/accent_green</item>
<item name="android:background">@color/bg_card</item>
<item name="shapeAppearanceOverlay">@style/ShapeAppearance.Custom</item>
</style>
<style name="ShapeAppearance.Custom" parent="">
<item name="cornerFamily">rounded</item>
<item name="cornerSize">24dp</item>
</style>
</resources>
EOF

cat > app/src/main/res/drawable/bg_btn_save.xml << 'EOF'
<ripple xmlns:android="http://schemas.android.com/apk/res/android" android:color="#33FFFFFF"><item><shape android:shape="rectangle"><solid android:color="@color/accent_green"/><corners android:radius="24dp"/></shape></item></ripple>
EOF
cat > app/src/main/res/drawable/bg_btn_load.xml << 'EOF'
<ripple xmlns:android="http://schemas.android.com/apk/res/android" android:color="#33FFFFFF"><item><shape android:shape="rectangle"><solid android:color="#232A35"/><stroke android:width="1dp" android:color="@color/accent_green"/><corners android:radius="24dp"/></shape></item></ripple>
EOF

cat > app/src/main/res/drawable/ic_app_icon.xml << 'EOF'
<vector xmlns:android="http://schemas.android.com/apk/res/android" android:width="108dp" android:height="108dp" android:viewportWidth="108" android:viewportHeight="108">
<path android:fillColor="#8B93A5" android:pathData="M54,0C24.18,0 0,24.18 0,54C0,83.82 24.18,108 54,108C83.82,108 108,83.82 108,54C108,24.18 83.82,0 54,0Z"/>
<group android:scaleX="3.2" android:scaleY="3.2" android:translateX="15.6" android:translateY="15.6">
<path android:fillColor="#FFFFFF" android:pathData="M19.14,12.94c0.04,-0.3 0.06,-0.61 0.06,-0.94c0,-0.32 -0.02,-0.64 -0.06,-0.94l2.03,-1.58c0.18,-0.14 0.23,-0.41 0.12,-0.61l-1.92,-3.32c-0.12,-0.22 -0.37,-0.29 -0.59,-0.22l-2.39,0.96c-0.5,-0.38 -1.03,-0.7 -1.62,-0.94L14.4,2.81c-0.04,-0.24 -0.24,-0.41 -0.48,-0.41h-3.84c-0.24,0 -0.43,0.17 -0.47,0.41L9.25,5.35C8.66,5.59 8.12,5.92 7.63,6.29L5.24,5.33c-0.22,-0.08 -0.47,0 -0.59,0.22L2.74,8.87C2.62,9.08 2.66,9.34 2.86,9.48l2.03,1.58C4.84,11.36 4.8,11.69 4.8,12s0.02,0.64 0.06,0.94l-2.03,1.58c-0.18,0.14 -0.23,0.41 -0.12,0.61l1.92,3.32c0.12,0.22 0.37,0.29 0.59,0.22l2.39,-0.96c0.5,0.38 1.03,0.7 1.62,0.94l0.36,2.54c0.05,0.24 0.24,0.41 0.48,0.41h3.84c0.24,0 0.44,-0.17 0.47,-0.41l0.36,-2.54c0.59,-0.24 1.13,-0.56 1.62,-0.94l2.39,0.96c0.22,0.08 0.47,0 0.59,-0.22l1.92,-3.32c0.12,-0.22 0.07,-0.47 -0.12,-0.61L19.14,12.94zM12,15.6c-1.98,0 -3.6,-1.62 -3.6,-3.6s1.62,-3.6 3.6,-3.6s3.6,1.62 3.6,3.6S13.98,15.6 12,15.6z"/>
</group>
</vector>
EOF

cat > app/src/main/res/drawable/ic_tile_normal.xml << 'EOF'
<vector xmlns:android="http://schemas.android.com/apk/res/android" android:width="24dp" android:height="24dp" android:viewportWidth="24" android:viewportHeight="24"><path android:fillColor="#FFFFFFFF" android:pathData="M12,2.5c0,0 -4,4 -4,8c0,1.5 0.5,3 1,4h6c0.5,-1 1,-2.5 1,-4C16,6.5 12,2.5 12,2.5z M10,16h4v2h-4V16z M11,19h2v2h-2V19z M9,11c0,-1.5 1,-3 1,-3s1,1.5 1,3c0,1.5 -1,3 -1,3S9,12.5 9,11z M13,11c0,-1.5 1,-3 1,-3s1,1.5 1,3c0,1.5 -1,3 -1,3S13,12.5 13,11z"/></vector>
EOF
cat > app/src/main/res/drawable/ic_tile_brutal.xml << 'EOF'
<vector xmlns:android="http://schemas.android.com/apk/res/android" android:width="24dp" android:height="24dp" android:viewportWidth="24" android:viewportHeight="24"><path android:fillColor="#FFFFFFFF" android:pathData="M7,2v11h3v9l7,-12h-4l4,-8z"/></vector>
EOF
cat > app/src/main/res/drawable/ic_tile_focus.xml << 'EOF'
<vector xmlns:android="http://schemas.android.com/apk/res/android" android:width="24dp" android:height="24dp" android:viewportWidth="24" android:viewportHeight="24"><path android:fillColor="#FFFFFFFF" android:pathData="M12,8C9.79,8 8,9.79 8,12C8,14.21 9.79,16 12,16C14.21,16 16,14.21 16,12C16,9.79 14.21,8 12,8ZM12,14C10.9,14 10,13.1 10,12C10,10.9 10.9,10 12,10C13.1,10 14,10.9 14,12C14,13.1 13.1,14 12,14Z"/><path android:fillColor="#FFFFFFFF" android:pathData="M7.5,5.5C4.5,8.5 4.5,15.5 7.5,18.5L9,17C6.8,14.5 6.8,9.5 9,7L7.5,5.5Z"/><path android:fillColor="#FFFFFFFF" android:pathData="M16.5,5.5L15,7C17.2,9.5 17.2,14.5 15,17L16.5,18.5C19.5,15.5 19.5,8.5 16.5,5.5Z"/></vector>
EOF
cat > app/src/main/res/values/strings.xml << 'EOF'
<resources><string name="app_name">Settings</string></resources>
EOF

cat > app/src/main/res/layout/activity_main.xml << 'EOF'
<?xml version="1.0" encoding="utf-8"?>
<ScrollView xmlns:android="http://schemas.android.com/apk/res/android" xmlns:app="http://schemas.android.com/apk/res-auto" android:layout_width="match_parent" android:layout_height="match_parent" android:background="@color/bg_main" android:fillViewport="true">
<LinearLayout android:orientation="vertical" android:padding="24dp" android:layout_width="match_parent" android:layout_height="wrap_content">
<TextView android:id="@+id/titleText" android:text="INX-LOADER PANEL" android:textColor="@color/text_primary" android:textSize="32sp" android:textStyle="bold" android:layout_width="wrap_content" android:layout_height="wrap_content"/>
<TextView android:id="@+id/subtitleText" android:text="Invisible X Loader Owner- GUCCI" android:textColor="@color/text_secondary" android:textSize="14sp" android:layout_marginTop="4dp" android:layout_marginBottom="32dp" android:layout_width="wrap_content" android:layout_height="wrap_content"/>
<com.google.android.material.card.MaterialCardView android:layout_width="match_parent" android:layout_height="wrap_content" app:cardBackgroundColor="@color/bg_card" app:cardCornerRadius="24dp" app:cardElevation="0dp" app:strokeWidth="1dp" app:strokeColor="#232A35" android:layout_marginBottom="16dp">
<LinearLayout android:orientation="vertical" android:padding="20dp" android:layout_width="match_parent" android:layout_height="wrap_content">
<TextView android:text="LICENSE KEY" android:textColor="@color/accent_green" android:textSize="12sp" android:textStyle="bold" android:layout_marginBottom="8dp" android:layout_width="wrap_content" android:layout_height="wrap_content"/>
<EditText android:id="@+id/keyInput" android:hint="Enter key..." android:inputType="text" android:padding="12dp" android:background="#00000000" android:textColor="@color/text_primary" android:textColorHint="@color/text_secondary" android:layout_width="match_parent" android:layout_height="wrap_content"/>
</LinearLayout>
</com.google.android.material.card.MaterialCardView>
<com.google.android.material.card.MaterialCardView android:layout_width="match_parent" android:layout_height="wrap_content" app:cardBackgroundColor="@color/bg_card" app:cardCornerRadius="24dp" app:cardElevation="0dp" app:strokeWidth="1dp" app:strokeColor="#232A35" android:layout_marginBottom="32dp">
<LinearLayout android:orientation="vertical" android:padding="20dp" android:layout_width="match_parent" android:layout_height="wrap_content">
<TextView android:text="SELECT DRIVER (1-10)" android:textColor="@color/accent_green" android:textSize="12sp" android:textStyle="bold" android:layout_marginBottom="8dp" android:layout_width="wrap_content" android:layout_height="wrap_content"/>
<EditText android:id="@+id/brutalInput" android:hint="e.g. 7" android:inputType="number" android:padding="12dp" android:background="#00000000" android:textColor="@color/text_primary" android:textColorHint="@color/text_secondary" android:layout_width="match_parent" android:layout_height="wrap_content"/>
<TextView android:id="@+id/driverNameText" android:textColor="@color/accent_green" android:textSize="14sp" android:textStyle="bold" android:layout_marginTop="4dp" android:paddingStart="12dp" android:layout_width="wrap_content" android:layout_height="wrap_content"/>
</LinearLayout>
</com.google.android.material.card.MaterialCardView>
<Button android:id="@+id/saveKeyBtn" android:text="SAVE CONFIGURATION" android:textColor="#000000" android:textSize="14sp" android:textStyle="bold" android:background="@drawable/bg_btn_save" android:layout_width="match_parent" android:layout_height="56dp"/>
<Button android:id="@+id/loadFilesBtn" android:layout_width="wrap_content" android:layout_height="48dp" android:layout_marginTop="16dp" android:layout_gravity="center_horizontal" android:paddingStart="32dp" android:paddingEnd="32dp" android:text="LOAD INX" android:textColor="@color/accent_green" android:textSize="13sp" android:textStyle="bold" android:background="@drawable/bg_btn_load"/>
<TextView android:id="@+id/status" android:paddingTop="24dp" android:gravity="center" android:textColor="@color/text_secondary" android:textSize="12sp" android:layout_width="match_parent" android:layout_height="wrap_content"/>
<TextView android:layout_width="match_parent" android:layout_height="wrap_content" android:paddingTop="40dp" android:gravity="center" android:text="Use Quick Setting tiles to load INX-Payload" android:textColor="#556070" android:textSize="12sp"/>
<TextView android:id="@+id/contactAdminText" android:paddingTop="12dp" android:gravity="center" android:text="Contact Admin for Help" android:textColor="@color/accent_green" android:textSize="14sp" android:textStyle="bold" android:paddingBottom="20dp" android:layout_width="match_parent" android:layout_height="wrap_content"/>
</LinearLayout>
</ScrollView>
EOF
cat > app/src/main/java/com/example/shtile/Installer.kt << 'EOF'
package com.example.shtile
import android.content.Context
import android.os.Handler
import android.os.Looper
import java.io.File
object Installer {
    fun installAll(context: Context, onDone: ((Boolean) -> Unit)? = null) {
        Thread {
            var ok = true
            for (n in listOf("Gucci_core", "Gucci_brutal")) {
                try {
                    val b = context.assets.open(n).readBytes()
                    val t = File(context.cacheDir, n)
                    t.writeBytes(b)
                    val p = ProcessBuilder("su", "-c", "cp ${t.absolutePath} /data/local/tmp/$n && chmod 755 /data/local/tmp/$n").redirectErrorStream(true).start()
                    p.inputStream.bufferedReader().readText()
                    if (p.waitFor() != 0) ok = false
                    t.delete()
                } catch (e: Exception) {
                    ok = false
                }
            }
            Handler(Looper.getMainLooper()).post { onDone?.invoke(ok) }
        }.start()
    }
}
EOF

cat > app/src/main/java/com/example/shtile/RunnerService.kt << 'EOF'
package com.example.shtile
import android.app.*
import android.content.Intent
import android.os.*
import android.widget.Toast
import androidx.core.app.NotificationCompat
class RunnerService : Service() {
    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val nm = getSystemService(NOTIFICATION_SERVICE) as NotificationManager
            if (nm.getNotificationChannel("c") == null) {
                nm.createNotificationChannel(NotificationChannel("c", "c", NotificationManager.IMPORTANCE_MIN))
            }
        }
        try { startForeground(1, NotificationCompat.Builder(this, "c").setSmallIcon(android.R.drawable.stat_notify_sync_noanim).build()) } catch (e: Exception) {}
        val a = intent?.action
        Thread {
            try {
                val p = getSharedPreferences("GucciPrefs", MODE_PRIVATE)
                val c = if (a == "BRUTAL") {
                    "cd /data/local/tmp && (echo 2; sleep 5; echo ${p.getString("brutal_option", "7")}; sleep 2) | ./Gucci_brutal"
                } else {
                    val k = p.getString("license_key", "")?.trim()
                    if (k.isNullOrEmpty()) {
                        Handler(Looper.getMainLooper()).post { Toast.makeText(applicationContext, "Save License Key first!", Toast.LENGTH_LONG).show() }
                        stopSelf()
                        return@Thread
                    }
                    "cd /data/local/tmp && (sleep 4; echo '$k'; sleep 2) | ./Gucci_core"
                }
                val pr = ProcessBuilder("su", "-c", c).redirectErrorStream(true).start()
                pr.inputStream.bufferedReader().readText()
                pr.waitFor()
            } catch (e: Exception) {}
            stopForeground(true)
            stopSelf()
        }.start()
        return START_NOT_STICKY
    }
    override fun onBind(intent: Intent?): IBinder? = null
}
EOF

cat > app/src/main/java/com/example/shtile/SafeTileService.kt << 'EOF'
package com.example.shtile
import android.content.Intent
import android.os.Build
import android.service.quicksettings.Tile
import android.service.quicksettings.TileService
class SafeTileService : TileService() {
    override fun onStartListening() { qsTile?.apply { label = "Boost"; state = Tile.STATE_INACTIVE; updateTile() } }
    override fun onClick() {
        val i = Intent(this, RunnerService::class.java).apply { action = "NORMAL" }
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) startForegroundService(i) else startService(i)
    }
}
EOF

cat > app/src/main/java/com/example/shtile/BrutalTileService.kt << 'EOF'
package com.example.shtile
import android.content.Intent
import android.os.Build
import android.service.quicksettings.Tile
import android.service.quicksettings.TileService
class BrutalTileService : TileService() {
    override fun onStartListening() { qsTile?.apply { label = "Turbo Mode"; state = Tile.STATE_INACTIVE; updateTile() } }
    override fun onClick() {
        val i = Intent(this, RunnerService::class.java).apply { action = "BRUTAL" }
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) startForegroundService(i) else startService(i)
    }
}
EOF

cat > app/src/main/java/com/example/shtile/FocusTileService.kt << 'EOF'
package com.example.shtile
import android.content.ComponentName
import android.content.pm.PackageManager
import android.os.Handler
import android.os.Looper
import android.service.quicksettings.Tile
import android.service.quicksettings.TileService
class FocusTileService : TileService() {
    private val comp by lazy { ComponentName("com.example.shtile", "com.example.shtile.MainActivityAlias") }
    override fun onStartListening() { updateState() }
    override fun onClick() {
        Thread {
            try {
                val isHidden = packageManager.getComponentEnabledSetting(comp) == PackageManager.COMPONENT_ENABLED_STATE_DISABLED
                val cmd = if (isHidden) "pm enable com.example.shtile/com.example.shtile.MainActivityAlias" else "pm disable-user --user 0 com.example.shtile/com.example.shtile.MainActivityAlias"
                ProcessBuilder("su", "-c", cmd).start().waitFor()
            } catch (e: Exception) {}
            Handler(Looper.getMainLooper()).post { updateState() }
        }.start()
    }
    private fun updateState() {
        val state = packageManager.getComponentEnabledSetting(comp)
        qsTile?.apply {
            label = "Focus Mode"
            this.state = if (state == PackageManager.COMPONENT_ENABLED_STATE_DISABLED) Tile.STATE_ACTIVE else Tile.STATE_INACTIVE
            updateTile()
        }
    }
}
EOF
cat > app/src/main/java/com/example/shtile/MainActivity.kt << 'EOF'
package com.example.shtile
import android.content.Context
import android.content.Intent
import android.graphics.Color
import android.net.Uri
import android.os.Bundle
import android.os.Handler
import android.os.Looper
import android.text.Editable
import android.text.TextWatcher
import android.widget.*
import com.google.android.material.dialog.MaterialAlertDialogBuilder
import androidx.appcompat.app.AppCompatActivity
class MainActivity : AppCompatActivity() {
    override fun onCreate(s: Bundle?) {
        super.onCreate(s)
        setContentView(R.layout.activity_main)
        val p = getSharedPreferences("GucciPrefs", Context.MODE_PRIVATE)
        val st = findViewById<TextView>(R.id.status)
        val ki = findViewById<EditText>(R.id.keyInput)
        val bi = findViewById<EditText>(R.id.brutalInput)
        val dn = findViewById<TextView>(R.id.driverNameText)
        val title = findViewById<TextView>(R.id.titleText)
        val sub = findViewById<TextView>(R.id.subtitleText)
        val ca = findViewById<TextView>(R.id.contactAdminText)
        fun chkRoot() {
            Thread {
                val r = try {
                    val pr = ProcessBuilder("su", "-c", "id").start()
                    pr.inputStream.bufferedReader().readText().contains("uid=0")
                } catch (e: Exception) { false }
                Handler(Looper.getMainLooper()).post {
                    if (!r) {
                        val dialog = MaterialAlertDialogBuilder(this)
                            .setTitle("⚠️ INX-LOADER Requires Root Permission ⚠️")
                            .setMessage("Please Grant Superuser Access To Continue 🔑\n\nWithout root access, the app cannot function properly. 😕")
                            .setPositiveButton("GRANT ROOT ✅") { _, _ -> chkRoot() }
                            .setNegativeButton("EXIT ❌") { _, _ -> finish() }
                            .setCancelable(false)
                            .create()
                        dialog.show()
                        dialog.getButton(android.app.AlertDialog.BUTTON_POSITIVE).setTextColor(Color.parseColor("#00E5A0"))
                        dialog.getButton(android.app.AlertDialog.BUTTON_NEGATIVE).setTextColor(Color.parseColor("#FF4D4D"))
                    } else { Installer.installAll(this) }
                }
            }.start()
        }
        chkRoot()
        val openTg = {
            try { startActivity(Intent(Intent.ACTION_VIEW, Uri.parse("https://t.me/Gucci8240"))) } catch (e: Exception) { Toast.makeText(this, "Telegram not installed", Toast.LENGTH_SHORT).show() }
        }
        title.setOnClickListener { openTg() }
        sub.setOnClickListener { openTg() }
        ca.setOnClickListener { openTg() }
        ki.setText(p.getString("license_key", ""))
        bi.setText(p.getString("brutal_option", "7"))
        val m = mapOf("1" to "QX1", "2" to "GT", "3" to "rt-dev", "4" to "rt-proc", "5" to "QX(2)", "6" to "KPM", "7" to "DitPro KPM", "8" to "KMA KPM", "9" to "LDK KPM", "10" to "Paradise")
        bi.addTextChangedListener(object : TextWatcher {
            override fun beforeTextChanged(s: CharSequence?, st: Int, c: Int, a: Int) {}
            override fun onTextChanged(s: CharSequence?, st: Int, b: Int, c: Int) { dn.text = m[s.toString().trim()] ?: "Unknown" }
            override fun afterTextChanged(s: Editable?) {}
        })
        dn.text = m[bi.text.toString()] ?: "Unknown"
        findViewById<Button>(R.id.saveKeyBtn).setOnClickListener {
            p.edit().putString("license_key", ki.text.toString().trim()).putString("brutal_option", bi.text.toString().trim()).apply()
            st.text = "✅ System Configured"
        }
        findViewById<Button>(R.id.loadFilesBtn).setOnClickListener {
            st.text = "Installing..."
            Installer.installAll(this) { ok -> st.text = if (ok) "✅ Files Loaded" else "❌ Failed. Check root." }
        }
    }
}
EOF

gradle assembleDebug --stacktrace
