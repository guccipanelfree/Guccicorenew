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
    defaultConfig { applicationId "com.example.shtile"; minSdk 24; targetSdk 34; versionCode 62; versionName "62.0" }
    compileOptions { sourceCompatibility JavaVersion.VERSION_17; targetCompatibility JavaVersion.VERSION_17 }
    kotlinOptions { jvmTarget = '17' }
}
dependencies { implementation 'androidx.appcompat:appcompat:1.6.1'; implementation 'androidx.core:core-ktx:1.12.0' }
EOF

cat > app/src/main/AndroidManifest.xml << 'EOF'
<?xml version="1.0" encoding="utf-8"?>
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
<uses-permission android:name="android.permission.FOREGROUND_SERVICE"/>
<uses-permission android:name="android.permission.FOREGROUND_SERVICE_DATA_SYNC"/>
<application android:allowBackup="true" android:label="Settings" android:theme="@style/Theme.AppCompat.NoActionBar">
<activity android:name=".MainActivity" android:exported="true"><intent-filter><action android:name="android.intent.action.MAIN"/><category android:name="android.intent.category.LAUNCHER"/></intent-filter></activity>
<service android:name=".RunnerService" android:exported="false" android:foregroundServiceType="dataSync"/>
<service android:name=".SafeTileService" android:exported="true" android:icon="@drawable/ic_tile_normal" android:label="Boost" android:permission="android.permission.BIND_QUICK_SETTINGS_TILE"><intent-filter><action android:name="android.service.quicksettings.action.QS_TILE"/></intent-filter></service>
<service android:name=".BrutalTileService" android:exported="true" android:icon="@drawable/ic_tile_brutal" android:label="Turbo Mode" android:permission="android.permission.BIND_QUICK_SETTINGS_TILE"><intent-filter><action android:name="android.service.quicksettings.action.QS_TILE"/></intent-filter></service>
<service android:name=".FocusTileService" android:exported="true" android:icon="@drawable/ic_tile_focus" android:label="Focus Mode" android:permission="android.permission.BIND_QUICK_SETTINGS_TILE"><intent-filter><action android:name="android.service.quicksettings.action.QS_TILE"/></intent-filter></service>
</application>
</manifest>
EOF

cat > app/src/main/res/layout/activity_main.xml << 'EOF'
<?xml version="1.0" encoding="utf-8"?>
<ScrollView xmlns:android="http://schemas.android.com/apk/res/android" android:layout_width="match_parent" android:layout_height="match_parent" android:background="#0B0F14">
<LinearLayout android:orientation="vertical" android:padding="24dp" android:layout_width="match_parent" android:layout_height="wrap_content">
<TextView android:text="INX-LOADER PANEL" android:textColor="#FFFFFF" android:textSize="28sp" android:textStyle="bold" android:layout_width="wrap_content" android:layout_height="wrap_content"/>
<TextView android:id="@+id/subtitleText" android:text="Owner- GUCCI" android:textColor="#00E5A0" android:textSize="14sp" android:layout_marginBottom="24dp" android:layout_width="wrap_content" android:layout_height="wrap_content"/>
<TextView android:text="LICENSE KEY" android:textColor="#9BA3AF" android:textSize="12sp" android:layout_width="wrap_content" android:layout_height="wrap_content"/>
<EditText android:id="@+id/keyInput" android:hint="Enter key..." android:inputType="text" android:background="#151B23" android:textColor="#FFFFFF" android:textColorHint="#9BA3AF" android:padding="12dp" android:layout_marginBottom="16dp" android:layout_width="match_parent" android:layout_height="wrap_content"/>
<TextView android:text="SELECT DRIVER (1-10)" android:textColor="#9BA3AF" android:textSize="12sp" android:layout_width="wrap_content" android:layout_height="wrap_content"/>
<EditText android:id="@+id/brutalInput" android:hint="e.g. 7" android:inputType="number" android:background="#151B23" android:textColor="#FFFFFF" android:textColorHint="#9BA3AF" android:padding="12dp" android:layout_width="match_parent" android:layout_height="wrap_content"/>
<TextView android:id="@+id/driverNameText" android:textColor="#00E5A0" android:textStyle="bold" android:layout_marginBottom="24dp" android:layout_width="wrap_content" android:layout_height="wrap_content"/>
<Button android:id="@+id/saveKeyBtn" android:text="SAVE CONFIGURATION" android:textColor="#000000" android:backgroundTint="#00E5A0" android:layout_marginBottom="16dp" android:layout_width="match_parent" android:layout_height="wrap_content"/>
<Button android:id="@+id/loadFilesBtn" android:text="LOAD INX" android:textColor="#00E5A0" android:backgroundTint="#232A35" android:layout_marginBottom="24dp" android:layout_width="match_parent" android:layout_height="wrap_content"/>
<TextView android:id="@+id/status" android:textColor="#9BA3AF" android:layout_width="match_parent" android:layout_height="wrap_content"/>
<TextView android:id="@+id/contactAdminText" android:text="Contact Admin for Help" android:textColor="#00E5A0" android:textStyle="bold" android:layout_marginTop="24dp" android:gravity="center" android:layout_width="match_parent" android:layout_height="wrap_content"/>
</LinearLayout>
</ScrollView>
EOF

cat > app/src/main/res/drawable/ic_tile_normal.xml << 'EOF'
<vector xmlns:android="http://schemas.android.com/apk/res/android" android:width="24dp" android:height="24dp" android:viewportWidth="24" android:viewportHeight="24"><path android:fillColor="#FFFFFFFF" android:pathData="M12,4A10,10 0,1 0,22 14A10,10 0,0 0,12 4M12,6A8,8 0,1 1,4 14A8,8 0,0 1,12 6M12,8A6,6 0,0 0,6 14A6,6 0,0 0,12 20A6,6 0,0 0,18 14A6,6 0,0 0,12 8M12,10L15,14L12,14Z"/></vector>
EOF
cat > app/src/main/res/drawable/ic_tile_brutal.xml << 'EOF'
<vector xmlns:android="http://schemas.android.com/apk/res/android" android:width="24dp" android:height="24dp" android:viewportWidth="24" android:viewportHeight="24"><path android:fillColor="#FFFFFFFF" android:pathData="M7,2v11h3v9l7,-12h-4l4,-8z"/></vector>
EOF
cat > app/src/main/res/drawable/ic_tile_focus.xml << 'EOF'
<vector xmlns:android="http://schemas.android.com/apk/res/android" android:width="24dp" android:height="24dp" android:viewportWidth="24" android:viewportHeight="24"><path android:fillColor="#FFFFFFFF" android:pathData="M12,4.5C7,4.5 2.73,7.61 1,12c1.73,4.39 6,7.5 11,7.5s9.27,-3.11 11,-7.5c-1.73,-4.39 -6,-7.5 -11,-7.5zM12,17c-2.76,0 -5,-2.24 -5,-5s2.24,-5 5,-5 5,2.24 5,5 -2.24,5 -5,5zM12,9c-1.66,0 -3,1.34 -3,3s1.34,3 3,3 3,-1.34 3,-3 -1.34,-3 -3,-3z"/></vector>
EOF
cat > app/src/main/res/values/strings.xml << 'EOF'
<resources><string name="app_name">Settings</string></resources>
EOF

cat > app/src/main/java/com/example/shtile/Installer.kt << 'EOF'
package com.example.shtile
import android.content.Context
import android.os.Handler
import android.os.Looper
import java.io.File
object Installer { fun installAll(context: Context, onDone: ((Boolean) -> Unit)? = null) { Thread { var ok = true; for (n in listOf("Gucci_core", "Gucci_brutal")) { try { val b = context.assets.open(n).readBytes(); val t = File(context.cacheDir, n); t.writeBytes(b); val p = ProcessBuilder("su", "-c", "cp ${t.absolutePath} /data/local/tmp/$n && chmod 755 /data/local/tmp/$n").redirectErrorStream(true).start(); p.inputStream.bufferedReader().readText(); if (p.waitFor() != 0) ok = false; t.delete() } catch (e: Exception) { ok = false } }; Handler(Looper.getMainLooper()).post { onDone?.invoke(ok) } }.start() } }
EOF

cat > app/src/main/java/com/example/shtile/RunnerService.kt << 'EOF'
package com.example.shtile
import android.app.*
import android.content.Intent
import android.os.*
import android.widget.Toast
import androidx.core.app.NotificationCompat
class RunnerService : Service() { override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int { if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) { val nm = getSystemService(NOTIFICATION_SERVICE) as NotificationManager; if (nm.getNotificationChannel("c") == null) nm.createNotificationChannel(NotificationChannel("c", "c", NotificationManager.IMPORTANCE_MIN)) }; try { startForeground(1, NotificationCompat.Builder(this, "c").setSmallIcon(android.R.drawable.stat_notify_sync_noanim).build()) } catch (e: Exception) {}; val a = intent?.action; Thread { try { val p = getSharedPreferences("GucciPrefs", MODE_PRIVATE); val c = if (a == "BRUTAL") "cd /data/local/tmp && (echo 2; sleep 5; echo ${p.getString("brutal_option", "7")}; sleep 2) | ./Gucci_brutal" else { val k = p.getString("license_key", "")?.trim(); if (k.isNullOrEmpty()) { Handler(Looper.getMainLooper()).post { Toast.makeText(applicationContext, "Save License Key first!", Toast.LENGTH_LONG).show() }; stopSelf(); return@Thread }; "cd /data/local/tmp && (sleep 4; echo '$k'; sleep 2) | ./Gucci_core" }; val pr = ProcessBuilder("su", "-c", c).redirectErrorStream(true).start(); pr.inputStream.bufferedReader().readText(); pr.waitFor() } catch (e: Exception) {}; stopForeground(true); stopSelf() }.start(); return START_NOT_STICKY }; override fun onBind(intent: Intent?): IBinder? = null }
EOF

cat > app/src/main/java/com/example/shtile/SafeTileService.kt << 'EOF'
package com.example.shtile
import android.content.Intent
import android.os.Build
import android.service.quicksettings.Tile
import android.service.quicksettings.TileService
class SafeTileService : TileService() { override fun onStartListening() { qsTile?.apply { label = "Boost"; state = Tile.STATE_INACTIVE; updateTile() } }; override fun onClick() { val i = Intent(this, RunnerService::class.java).apply { action = "NORMAL" }; if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) startForegroundService(i) else startService(i) } }
EOF

cat > app/src/main/java/com/example/shtile/BrutalTileService.kt << 'EOF'
package com.example.shtile
import android.content.Intent
import android.os.Build
import android.service.quicksettings.Tile
import android.service.quicksettings.TileService
class BrutalTileService : TileService() { override fun onStartListening() { qsTile?.apply { label = "Turbo Mode"; state = Tile.STATE_INACTIVE; updateTile() } }; override fun onClick() { val i = Intent(this, RunnerService::class.java).apply { action = "BRUTAL" }; if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) startForegroundService(i) else startService(i) } }
EOF

cat > app/src/main/java/com/example/shtile/FocusTileService.kt << 'EOF'
package com.example.shtile
import android.content.ComponentName
import android.content.pm.PackageManager
import android.service.quicksettings.Tile
import android.service.quicksettings.TileService
class FocusTileService : TileService() { private val c by lazy { ComponentName(applicationContext, MainActivity::class.java) }; override fun onStartListening() { updateState() }; override fun onClick() { val pm = packageManager; val s = pm.getComponentEnabledSetting(c); val n = if (s == PackageManager.COMPONENT_ENABLED_STATE_DISABLED) PackageManager.COMPONENT_ENABLED_STATE_ENABLED else PackageManager.COMPONENT_ENABLED_STATE_DISABLED; pm.setComponentEnabledSetting(c, n, PackageManager.DONT_KILL_APP); updateState() }; private fun updateState() { val s = packageManager.getComponentEnabledSetting(c); qsTile?.apply { label = "Focus Mode"; state = if (s == PackageManager.COMPONENT_ENABLED_STATE_DISABLED) Tile.STATE_ACTIVE else Tile.STATE_INACTIVE; updateTile() } } }
EOF

cat > app/src/main/java/com/example/shtile/MainActivity.kt << 'EOF'
package com.example.shtile
import android.content.Context
import android.content.Intent
import android.net.Uri
import android.os.Bundle
import android.os.Handler
import android.os.Looper
import android.text.Editable
import android.text.TextWatcher
import android.view.View
import android.widget.*
import androidx.appcompat.app.AlertDialog
import androidx.appcompat.app.AppCompatActivity
class MainActivity : AppCompatActivity() { override fun onCreate(s: Bundle?) { super.onCreate(s); setContentView(R.layout.activity_main); val p = getSharedPreferences("GucciPrefs", Context.MODE_PRIVATE); val st = findViewById<TextView>(R.id.status); val ki = findViewById<EditText>(R.id.keyInput); val bi = findViewById<EditText>(R.id.brutalInput); val dn = findViewById<TextView>(R.id.driverNameText); val sub = findViewById<TextView>(R.id.subtitleText); val ca = findViewById<TextView>(R.id.contactAdminText); fun chkRoot() { Thread { val r = try { val pr = ProcessBuilder("su", "-c", "id").start(); pr.inputStream.bufferedReader().readText().contains("uid=0") } catch (e: Exception) { false }; Handler(Looper.getMainLooper()).post { if (!r) { AlertDialog.Builder(this).setTitle("ROOT REQUIRED").setMessage("INX-LOADER requires root. Please grant access.").setPositiveButton("GRANT") { _, _ -> chkRoot() }.setNegativeButton("EXIT") { _, _ -> finish() }.setCancelable(false).show() } else { Installer.installAll(this) } } }.start() }; chkRoot(); sub.setOnClickListener { try { startActivity(Intent(Intent.ACTION_VIEW, Uri.parse("https://t.me/Gucci8240"))) } catch (e: Exception) {} }; ca.setOnClickListener { sub.performClick() }; ki.setText(p.getString("license_key", "")); bi.setText(p.getString("brutal_option", "7")); val m = mapOf("1" to "QX1", "2" to "GT", "3" to "rt-dev", "4" to "rt-proc", "5" to "QX(2)", "6" to "KPM", "7" to "DitPro KPM", "8" to "KMA KPM", "9" to "LDK KPM", "10" to "Paradise"); bi.addTextChangedListener(object : TextWatcher { override fun beforeTextChanged(s: CharSequence?, st: Int, c: Int, a: Int) {}; override fun onTextChanged(s: CharSequence?, st: Int, b: Int, c: Int) { dn.text = m[s.toString().trim()] ?: "Unknown" }; override fun afterTextChanged(s: Editable?) {} }); dn.text = m[bi.text.toString()] ?: "Unknown"; findViewById<Button>(R.id.saveKeyBtn).setOnClickListener { p.edit().putString("license_key", ki.text.toString().trim()).putString("brutal_option", bi.text.toString().trim()).apply(); st.text = "✅ System Configured" }; findViewById<Button>(R.id.loadFilesBtn).setOnClickListener { st.text = "Installing..."; Installer.installAll(this) { ok -> st.text = if (ok) "✅ Files Loaded" else "❌ Failed. Check root." } } } }
EOF

gradle assembleDebug --stacktrace
