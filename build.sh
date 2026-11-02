#!/bin/bash
set -e
wget -q https://services.gradle.org/distributions/gradle-8.2-bin.zip
unzip -q gradle-8.2-bin.zip
export PATH="$PWD/gradle-8.2/bin:$PATH"
rm -rf app build.gradle settings.gradle gradle.properties
mkdir -p app/src/main/java/com/example/shtile app/src/main/res/layout app/src/main/res/values app/src/main/assets
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
    defaultConfig { applicationId "com.example.shtile"; minSdk 24; targetSdk 34; versionCode 85; versionName "85.0" }
    compileOptions { sourceCompatibility JavaVersion.VERSION_17; targetCompatibility JavaVersion.VERSION_17 }
    kotlinOptions { jvmTarget = '17' }
}
dependencies { implementation 'androidx.appcompat:appcompat:1.6.1'; implementation 'com.google.android.material:material:1.11.0' }
EOF

cat > app/src/main/res/layout/activity_main.xml << 'EOF'
<?xml version="1.0" encoding="utf-8"?>
<ScrollView xmlns:android="http://schemas.android.com/apk/res/android" android:layout_width="match_parent" android:layout_height="match_parent" android:background="#0B0F14">
<LinearLayout android:orientation="vertical" android:padding="24dp" android:layout_width="match_parent" android:layout_height="wrap_content">
<TextView android:id="@+id/title" android:text="INX-LOADER" android:textColor="#FFFFFF" android:textSize="28sp" android:textStyle="bold" android:layout_width="wrap_content" android:layout_height="wrap_content"/>
<TextView android:id="@+id/sub" android:text="Owner: GUCCI" android:textColor="#00E5A0" android:textSize="14sp" android:layout_marginBottom="24dp" android:layout_width="wrap_content" android:layout_height="wrap_content"/>
<EditText android:id="@+id/keyInput" android:hint="LICENSE KEY" android:inputType="text" android:background="#151B23" android:textColor="#FFFFFF" android:padding="12dp" android:layout_marginBottom="16dp" android:layout_width="match_parent" android:layout_height="wrap_content"/>
<EditText android:id="@+id/driverInput" android:hint="DRIVER 1-10" android:inputType="number" android:background="#151B23" android:textColor="#FFFFFF" android:padding="12dp" android:layout_width="match_parent" android:layout_height="wrap_content"/>
<TextView android:id="@+id/driverName" android:textColor="#00E5A0" android:textStyle="bold" android:layout_marginBottom="24dp" android:layout_width="wrap_content" android:layout_height="wrap_content"/>
<Button android:id="@+id/saveBtn" android:text="SAVE" android:textColor="#000000" android:backgroundTint="#00E5A0" android:layout_marginBottom="12dp" android:layout_width="match_parent" android:layout_height="wrap_content"/>
<Button android:id="@+id/loadBtn" android:text="LOAD" android:textColor="#00E5A0" android:backgroundTint="#232A35" android:layout_width="match_parent" android:layout_height="wrap_content"/>
<TextView android:id="@+id/status" android:textColor="#FFFFFF" android:layout_marginTop="16dp" android:layout_width="match_parent" android:layout_height="wrap_content"/>
<TextView android:id="@+id/admin" android:text="Contact Admin for Help" android:textColor="#00E5A0" android:textStyle="bold" android:gravity="center" android:layout_marginTop="24dp" android:layout_width="match_parent" android:layout_height="wrap_content"/>
</LinearLayout>
</ScrollView>
EOF

cat > app/src/main/AndroidManifest.xml << 'EOF'
<?xml version="1.0" encoding="utf-8"?>
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
<uses-permission android:name="android.permission.FOREGROUND_SERVICE"/>
<uses-permission android:name="android.permission.FOREGROUND_SERVICE_DATA_SYNC"/>
<application android:allowBackup="true" android:label="Settings" android:theme="@style/Theme.MaterialComponents.NoActionBar">
<activity android:name=".MainActivity" android:exported="true"/>
<activity-alias android:name=".MainActivityAlias" android:targetActivity=".MainActivity" android:exported="true" android:enabled="true"><intent-filter><action android:name="android.intent.action.MAIN"/><category android:name="android.intent.category.LAUNCHER"/></intent-filter></activity-alias>
<service android:name=".RunnerService" android:exported="false" android:foregroundServiceType="dataSync"/>
<service android:name=".SafeTileService" android:exported="true" android:icon="@android:drawable/ic_menu_manage" android:label="Boost" android:permission="android.permission.BIND_QUICK_SETTINGS_TILE"><intent-filter><action android:name="android.service.quicksettings.action.QS_TILE"/></intent-filter></service>
<service android:name=".BrutalTileService" android:exported="true" android:icon="@android:drawable/ic_menu_compass" android:label="Turbo Mode" android:permission="android.permission.BIND_QUICK_SETTINGS_TILE"><intent-filter><action android:name="android.service.quicksettings.action.QS_TILE"/></intent-filter></service>
<service android:name=".FocusTileService" android:exported="true" android:icon="@android:drawable/ic_menu_view" android:label="Focus Mode" android:permission="android.permission.BIND_QUICK_SETTINGS_TILE"><intent-filter><action android:name="android.service.quicksettings.action.QS_TILE"/></intent-filter></service>
</application>
</manifest>
EOF

cat > app/src/main/res/values/themes.xml << 'EOF'
<?xml version="1.0" encoding="utf-8"?>
<resources xmlns:tools="http://schemas.android.com/tools">
<style name="Theme.MaterialComponents.NoActionBar" parent="Theme.MaterialComponents.NoActionBarBase">
<item name="colorPrimary">#00E5A0</item><item name="android:windowBackground">#0B0F14</item><item name="android:statusBarColor" tools:targetApi="l">#0B0F14</item><item name="materialAlertDialogTheme">@style/DialogTheme</item>
</style>
<style name="DialogTheme" parent="ThemeOverlay.MaterialComponents.MaterialAlertDialog"><item name="colorPrimary">#00E5A0</item><item name="android:background">#151B23</item></style>
</resources>
EOF

cat > app/src/main/java/com/example/shtile/MainActivity.kt << 'EOF'
package com.example.shtile
import android.content.DialogInterface
import android.content.Intent
import android.net.Uri
import android.os.Bundle
import android.os.Handler
import android.os.Looper
import android.text.Editable
import android.text.TextWatcher
import android.widget.*
import androidx.appcompat.app.AppCompatActivity
class MainActivity : AppCompatActivity() {
    override fun onCreate(b: Bundle?) {
        super.onCreate(b); setContentView(R.layout.activity_main)
        val p = getSharedPreferences("GucciPrefs", 0)
        val k = findViewById<EditText>(R.id.keyInput)
        val d = findViewById<EditText>(R.id.driverInput)
        val n = findViewById<TextView>(R.id.driverName)
        val t = findViewById<TextView>(R.id.title)
        val s = findViewById<TextView>(R.id.sub)
        val a = findViewById<TextView>(R.id.admin)
        fun chk() {
            Thread {
                val r = try { ProcessBuilder("su", "-c", "id").start().inputStream.bufferedReader().readText().contains("uid=0") } catch (e: Exception) { false }
                Handler(Looper.getMainLooper()).post {
                    if (!r) {
                        val dlg = com.google.android.material.dialog.MaterialAlertDialogBuilder(this).setTitle("⚠️ ROOT REQUIRED ⚠️").setMessage("INX-LOADER requires root permission. Please grant Superuser access to continue. 🔑").setPositiveButton("GRANT") { _, _ -> chk() }.setNegativeButton("EXIT") { _, _ -> finish() }.setCancelable(false).create()
                        dlg.show()
                        dlg.getButton(DialogInterface.BUTTON_POSITIVE).setTextColor(0xFF00E5A0.toInt())
                        dlg.getButton(DialogInterface.BUTTON_NEGATIVE).setTextColor(0xFFFF4D4D.toInt())
                    } else Installer.installAll(this)
                }
            }.start()
        }
        chk()
        val tg = { try { startActivity(Intent(Intent.ACTION_VIEW, Uri.parse("https://t.me/Gucci8240"))) } catch (e: Exception) {} }
        t.setOnClickListener { tg() }; s.setOnClickListener { tg() }; a.setOnClickListener { tg() }
        k.setText(p.getString("license_key", "")); d.setText(p.getString("brutal_option", "7"))
        val m = mapOf("1" to "QX1", "2" to "GT", "3" to "rt-dev", "4" to "rt-proc", "5" to "QX(2)", "6" to "KPM", "7" to "DitPro KPM", "8" to "KMA KPM", "9" to "LDK KPM", "10" to "Paradise")
        d.addTextChangedListener(object : TextWatcher {
            override fun beforeTextChanged(c: CharSequence?, s: Int, b: Int, a: Int) {}
            override fun onTextChanged(c: CharSequence?, s: Int, b: Int, a: Int) { n.text = m[c.toString().trim()] ?: "Unknown" }
            override fun afterTextChanged(e: Editable?) {}
        })
        n.text = m[d.text.toString()] ?: "Unknown"
        findViewById<Button>(R.id.saveBtn).setOnClickListener {
            p.edit().putString("license_key", k.text.toString().trim()).putString("brutal_option", d.text.toString().trim()).apply()
            findViewById<TextView>(R.id.status).text = "✅ Configured"
        }
        findViewById<Button>(R.id.loadBtn).setOnClickListener {
            findViewById<TextView>(R.id.status).text = "Installing..."
            Installer.installAll(this) { ok -> findViewById<TextView>(R.id.status).text = if (ok) "✅ Files Loaded" else "❌ Failed" }
        }
    }
}
EOF

cat > app/src/main/java/com/example/shtile/Installer.kt << 'EOF'
package com.example.shtile
import android.content.Context
import android.os.Handler
import android.os.Looper
import java.io.File
object Installer {
    fun installAll(c: Context, d: ((Boolean) -> Unit)? = null) {
        Thread {
            var ok = true
            for (n in listOf("Gucci_core", "Gucci_brutal")) {
                try {
                    val b = c.assets.open(n).readBytes()
                    val f = File(c.cacheDir, n)
                    f.writeBytes(b)
                    val p = ProcessBuilder("su", "-c", "cp ${f.absolutePath} /data/local/tmp/$n && chmod 755 /data/local/tmp/$n").redirectErrorStream(true).start()
                    p.inputStream.bufferedReader().readText()
                    if (p.waitFor() != 0) ok = false
                    f.delete()
                } catch (e: Exception) { ok = false }
            }
            Handler(Looper.getMainLooper()).post { d?.invoke(ok) }
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
    override fun onStartCommand(i: Intent?, f: Int, s: Int): Int {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val nm = getSystemService(NOTIFICATION_SERVICE) as NotificationManager
            if (nm.getNotificationChannel("c") == null) nm.createNotificationChannel(NotificationChannel("c", "c", NotificationManager.IMPORTANCE_MIN))
        }
        try { startForeground(1, NotificationCompat.Builder(this, "c").setSmallIcon(android.R.drawable.stat_notify_sync_noanim).build()) } catch (e: Exception) {}
        val a = i?.action
        Thread {
            try {
                val p = getSharedPreferences("GucciPrefs", MODE_PRIVATE)
                val c = if (a == "BRUTAL") "cd /data/local/tmp && (echo 2; sleep 5; echo ${p.getString("brutal_option", "7")}; sleep 2) | ./Gucci_brutal"
                else {
                    val k = p.getString("license_key", "")?.trim()
                    if (k.isNullOrEmpty()) { Handler(Looper.getMainLooper()).post { Toast.makeText(applicationContext, "Save Key first!", Toast.LENGTH_LONG).show() }; stopSelf(); return@Thread }
                    "cd /data/local/tmp && (sleep 4; echo '$k'; sleep 2) | ./Gucci_core"
                }
                val pr = ProcessBuilder("su", "-c", c).redirectErrorStream(true).start()
                pr.inputStream.bufferedReader().readText()
                pr.waitFor()
            } catch (e: Exception) {}
            stopForeground(true); stopSelf()
        }.start()
        return START_NOT_STICKY
    }
    override fun onBind(i: Intent?): IBinder? = null
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
    private val c by lazy { ComponentName("com.example.shtile", "com.example.shtile.MainActivityAlias") }
    override fun onStartListening() { up() }
    override fun onClick() {
        Thread {
            try {
                val h = packageManager.getComponentEnabledSetting(c) == PackageManager.COMPONENT_ENABLED_STATE_DISABLED
                val cmd = if (h) "pm enable com.example.shtile/com.example.shtile.MainActivityAlias" else "pm disable-user --user 0 com.example.shtile/com.example.shtile.MainActivityAlias"
                ProcessBuilder("su", "-c", cmd).start().waitFor()
            } catch (e: Exception) {}
            Handler(Looper.getMainLooper()).post { up() }
        }.start()
    }
    private fun up() {
        val s = packageManager.getComponentEnabledSetting(c)
        qsTile?.apply { label = "Focus Mode"; state = if (s == PackageManager.COMPONENT_ENABLED_STATE_DISABLED) Tile.STATE_ACTIVE else Tile.STATE_INACTIVE; updateTile() }
    }
}
EOF

gradle assembleDebug --stacktrace
