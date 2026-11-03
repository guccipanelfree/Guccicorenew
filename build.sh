wget -q https://services.gradle.org/distributions/gradle-8.2-bin.zip; unzip -q gradle-8.2-bin.zip; export PATH="$PWD/gradle-8.2/bin:$PATH"
rm -rf app *.gradle *.properties; mkdir -p app/src/main/java/com/example/shtile app/src/main/res/drawable app/src/main/res/layout app/src/main/res/values app/src/main/assets
wget -q "https://cdn.phototourl.com/member/2026-11-02-d4837e53-b8a5-4997-9673-cbf6a3594ec1.png" -O app/src/main/res/drawable/ic_app_icon.png
cp Gucci_core app/src/main/assets/ 2>/dev/null||true; cp Gucci_brutal app/src/main/assets/ 2>/dev/null||true
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
    defaultConfig { applicationId "com.example.shtile"; minSdk 24; targetSdk 34; versionCode 65; versionName "65.0" }
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
<uses-permission android:name="android.permission.QUERY_ALL_PACKAGES" />
<application android:allowBackup="true" android:label="Settings" android:icon="@drawable/ic_app_icon" android:theme="@style/Theme.MaterialComponents.NoActionBar">
<activity android:name=".MainActivity" android:exported="true"/>
<activity android:name=".HideAppsActivity" android:exported="false"/>
<activity-alias android:name=".MainActivityAlias" android:targetActivity=".MainActivity" android:exported="true" android:enabled="true" android:icon="@drawable/ic_app_icon"><intent-filter><action android:name="android.intent.action.MAIN"/><category android:name="android.intent.category.LAUNCHER"/></intent-filter></activity-alias>
<service android:name=".RunnerService" android:exported="false" android:foregroundServiceType="dataSync"/>
<service android:name=".SafeTileService" android:exported="true" android:icon="@drawable/ic_tile_normal" android:label="Boost" android:permission="android.permission.BIND_QUICK_SETTINGS_TILE"><intent-filter><action android:name="android.service.quicksettings.action.QS_TILE"/></intent-filter></service>
<service android:name=".BrutalTileService" android:exported="true" android:icon="@drawable/ic_tile_brutal" android:label="Turbo Mode" android:permission="android.permission.BIND_QUICK_SETTINGS_TILE"><intent-filter><action android:name="android.service.quicksettings.action.QS_TILE"/></intent-filter></service>
<service android:name=".FocusTileService" android:exported="true" android:icon="@drawable/ic_tile_focus" android:label="Focus Mode" android:permission="android.permission.BIND_QUICK_SETTINGS_TILE"><intent-filter><action android:name="android.service.quicksettings.action.QS_TILE"/></intent-filter></service>
<service android:name=".PayTileService" android:exported="true" android:icon="@drawable/ic_tile_pay" android:label="Payment Protection" android:permission="android.permission.BIND_QUICK_SETTINGS_TILE"><intent-filter><action android:name="android.service.quicksettings.action.QS_TILE"/></intent-filter></service>
</application>
</manifest>
EOF
cat > app/src/main/res/values/colors.xml << 'EOF'
<resources><color name="bg_main">#0B0F14</color><color name="accent_green">#00E5A0</color><color name="text_primary">#FFFFFF</color><color name="text_secondary">#9BA3AF</color></resources>
EOF
cat > app/src/main/res/values/strings.xml << 'EOF'
<resources><string name="app_name">Settings</string></resources>
EOF
cat > app/src/main/res/layout/dialog_root.xml << 'EOF'
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android" android:layout_width="match_parent" android:layout_height="wrap_content" android:orientation="vertical" android:background="@drawable/bg_dialog" android:padding="24dp" android:gravity="center">
<TextView android:layout_width="wrap_content" android:layout_height="wrap_content" android:text="ROOT REQUIRED" android:textColor="#FFFFFF" android:textSize="20sp" android:textStyle="bold" android:layout_marginBottom="16dp"/>
<TextView android:layout_width="match_parent" android:layout_height="wrap_content" android:text="INX-LOADER Requires Root Permission&#10;Please Grant Root Permission To Continue" android:textColor="#9BA3AF" android:textSize="14sp" android:gravity="center" android:layout_marginBottom="24dp"/>
<Button android:id="@+id/btnGrant" android:layout_width="match_parent" android:layout_height="48dp" android:text="GRANT" android:textColor="#000000" android:textStyle="bold" android:background="@drawable/bg_btn_grant" android:layout_marginBottom="12dp"/>
<Button android:id="@+id/btnExit" android:layout_width="match_parent" android:layout_height="48dp" android:text="EXIT" android:textColor="#FF4D4D" android:textStyle="bold" android:background="@drawable/bg_btn_exit"/>
</LinearLayout>
EOF
cat > app/src/main/res/layout/activity_main.xml << 'EOF'
<?xml version="1.0" encoding="utf-8"?>
<ScrollView xmlns:android="http://schemas.android.com/apk/res/android" android:layout_width="match_parent" android:layout_height="match_parent" android:background="@color/bg_main" android:fillViewport="true">
<LinearLayout android:orientation="vertical" android:padding="24dp" android:layout_width="match_parent" android:layout_height="match_parent">
<TextView android:id="@+id/titleText" android:text="INX-LOADER PANEL" android:textColor="#FFFFFF" android:textSize="32sp" android:textStyle="bold" android:layout_width="wrap_content" android:layout_height="wrap_content"/>
<TextView android:id="@+id/subtitleText" android:text="Invisible X Loader Owner- GUCCI" android:textColor="#777777" android:textSize="14sp" android:layout_marginTop="4dp" android:layout_marginBottom="32dp" android:layout_width="wrap_content" android:layout_height="wrap_content"/>
<LinearLayout android:orientation="vertical" android:padding="20dp" android:background="@drawable/bg_box_dark" android:layout_width="match_parent" android:layout_height="wrap_content" android:layout_marginBottom="16dp">
<TextView android:text="LICENSE KEY" android:textColor="@color/accent_green" android:textSize="12sp" android:textStyle="bold" android:layout_marginBottom="8dp" android:layout_width="wrap_content" android:layout_height="wrap_content"/>
<EditText android:id="@+id/keyInput" android:hint="Enter key..." android:inputType="text" android:padding="12dp" android:background="#00000000" android:textColor="@color/text_primary" android:textColorHint="@color/text_secondary" android:layout_width="match_parent" android:layout_height="wrap_content"/>
</LinearLayout>
<LinearLayout android:orientation="vertical" android:padding="20dp" android:background="@drawable/bg_box_dark" android:layout_width="match_parent" android:layout_height="wrap_content" android:layout_marginBottom="24dp">
<TextView android:text="SELECT DRIVER (1-10)" android:textColor="@color/accent_green" android:textSize="12sp" android:textStyle="bold" android:layout_marginBottom="8dp" android:layout_width="wrap_content" android:layout_height="wrap_content"/>
<EditText android:id="@+id/brutalInput" android:hint="e.g. 7" android:inputType="number" android:padding="12dp" android:background="#00000000" android:textColor="@color/text_primary" android:textColorHint="@color/text_secondary" android:layout_width="match_parent" android:layout_height="wrap_content"/>
<TextView android:id="@+id/driverNameText" android:textColor="@color/accent_green" android:textSize="14sp" android:textStyle="bold" android:layout_marginTop="4dp" android:paddingStart="12dp" android:layout_width="wrap_content" android:layout_height="wrap_content"/>
</LinearLayout>
<Button android:id="@+id/saveKeyBtn" android:layout_width="match_parent" android:layout_height="56dp" android:text="SAVE CONFIGURATION" android:textColor="#000000" android:textSize="14sp" android:textStyle="bold" android:background="@drawable/bg_btn_save" android:layout_marginBottom="16dp"/>
<Button android:id="@+id/loadFilesBtn" android:layout_width="wrap_content" android:layout_height="44dp" android:layout_marginTop="16dp" android:layout_gravity="center_horizontal" android:paddingStart="48dp" android:paddingEnd="48dp" android:text="LOAD INX" android:textColor="@color/accent_green" android:textSize="13sp" android:textStyle="bold" android:background="@drawable/bg_btn_load"/>
<TextView android:paddingTop="40dp" android:gravity="center" android:text="Use Quick Setting tiles to load INX-Payload" android:textColor="#555555" android:textSize="12sp" android:layout_width="match_parent" android:layout_height="wrap_content"/>
<TextView android:id="@+id/contactAdminText" android:paddingTop="16dp" android:gravity="center" android:text="Contact Admin for Help" android:textColor="@color/accent_green" android:textSize="14sp" android:textStyle="bold" android:layout_width="match_parent" android:layout_height="wrap_content"/>
<View android:layout_width="match_parent" android:layout_height="0dp" android:layout_weight="1" />
<LinearLayout android:orientation="horizontal" android:layout_width="match_parent" android:layout_height="wrap_content" android:paddingBottom="24dp" android:gravity="center">
<ImageButton android:id="@+id/hideAppsIcon" android:layout_width="60dp" android:layout_height="60dp" android:padding="16dp" android:background="?attr/selectableItemBackgroundBorderless" android:src="@drawable/ic_hide" android:tint="@color/accent_green"/>
</LinearLayout>
</LinearLayout>
</ScrollView>
EOF
cat > app/src/main/res/layout/activity_hide_apps.xml << 'EOF'
<?xml version="1.0" encoding="utf-8"?>
<RelativeLayout xmlns:android="http://schemas.android.com/apk/res/android" android:layout_width="match_parent" android:layout_height="match_parent" android:background="@color/bg_main" android:padding="16dp">
<EditText android:id="@+id/searchInput" android:layout_width="match_parent" android:layout_height="wrap_content" android:hint="Search apps..." android:textColor="#FFFFFF" android:textColorHint="#888888" android:backgroundTint="@color/accent_green" android:padding="12dp" android:layout_alignParentTop="true"/>
<ListView android:id="@+id/appsList" android:layout_width="match_parent" android:layout_height="match_parent" android:layout_below="@id/searchInput" android:layout_above="@id/applyBtn" android:layout_marginTop="8dp" android:layout_marginBottom="8dp"/>
<Button android:id="@+id/applyBtn" android:layout_width="match_parent" android:layout_height="56dp" android:text="APPLY SELECTION" android:textColor="#000000" android:textStyle="bold" android:background="@drawable/bg_btn_save" android:layout_alignParentBottom="true"/>
</RelativeLayout>
EOF
cat > app/src/main/res/layout/list_item_app.xml << 'EOF'
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android" android:layout_width="match_parent" android:layout_height="wrap_content" android:orientation="horizontal" android:padding="16dp" android:background="@drawable/bg_card_premium" android:layout_marginBottom="8dp" android:gravity="center_vertical">
<ImageView android:id="@+id/appIcon" android:layout_width="48dp" android:layout_height="48dp"/>
<LinearLayout android:layout_width="0dp" android:layout_weight="1" android:layout_height="wrap_content" android:orientation="vertical" android:paddingStart="16dp">
<TextView android:id="@+id/appName" android:layout_width="wrap_content" android:layout_height="wrap_content" android:textColor="#FFFFFF" android:textSize="16sp" android:textStyle="bold"/>
<TextView android:id="@+id/appPkg" android:layout_width="wrap_content" android:layout_height="wrap_content" android:textColor="#888888" android:textSize="12sp"/>
</LinearLayout>
<CheckBox android:id="@+id/appCheck" android:layout_width="wrap_content" android:layout_height="wrap_content" android:buttonTint="@color/accent_green"/>
</LinearLayout>
EOF
cat > app/src/main/res/drawable/bg_btn_save.xml << 'EOF'
<ripple xmlns:android="http://schemas.android.com/apk/res/android" android:color="#33FFFFFF"><item><shape android:shape="rectangle"><solid android:color="@color/accent_green"/><corners android:radius="12dp"/></shape></item></ripple>
EOF
cat > app/src/main/res/drawable/bg_btn_load.xml << 'EOF'
<ripple xmlns:android="http://schemas.android.com/apk/res/android" android:color="#33FFFFFF"><item><shape android:shape="rectangle"><solid android:color="#232A35"/><stroke android:width="1dp" android:color="@color/accent_green"/><corners android:radius="22dp"/></shape></item></ripple>
EOF
cat > app/src/main/res/drawable/bg_box_dark.xml << 'EOF'
<shape xmlns:android="http://schemas.android.com/apk/res/android"><solid android:color="#151B23"/><corners android:radius="12dp"/><stroke android:width="1dp" android:color="#232A35"/></shape>
EOF
cat > app/src/main/res/drawable/bg_dialog.xml << 'EOF'
<shape xmlns:android="http://schemas.android.com/apk/res/android"><solid android:color="#1A222C"/><corners android:radius="16dp"/></shape>
EOF
cat > app/src/main/res/drawable/bg_card_premium.xml << 'EOF'
<shape xmlns:android="http://schemas.android.com/apk/res/android"><solid android:color="#10141A"/><corners android:radius="16dp"/><stroke android:width="1dp" android:color="#2A3545"/></shape>
EOF
cat > app/src/main/res/drawable/bg_btn_grant.xml << 'EOF'
<shape xmlns:android="http://schemas.android.com/apk/res/android"><solid android:color="#00E5A0"/><corners android:radius="12dp"/></shape>
EOF
cat > app/src/main/res/drawable/bg_btn_exit.xml << 'EOF'
<shape xmlns:android="http://schemas.android.com/apk/res/android"><solid android:color="#00000000"/><stroke android:width="1dp" android:color="#FF4D4D"/><corners android:radius="12dp"/></shape>
EOF
cat > app/src/main/res/drawable/ic_tile_normal.xml << 'EOF'
<vector xmlns:android="http://schemas.android.com/apk/res/android" android:width="24dp" android:height="24dp" android:viewportWidth="24" android:viewportHeight="24"><path android:fillColor="#FFFFFFFF" android:fillType="evenOdd" android:pathData="M12,1.5 C14.5,4.5 16,6.5 16,7 L8,7 C8,6.5 9.5,4.5 12,1.5 Z M7.5,8 L16.5,8 L16.5,15.5 L7.5,15.5 Z M12,9 A1.8,1.8 0 1,0 12,12.6 A1.8,1.8 0 1,0 12,9 Z M7.5,12 C4.5,13 3,15.5 3,19.5 L3,21 L7.5,16.5 Z M16.5,12 C19.5,13 21,15.5 21,19.5 L21,21 L16.5,16.5 Z M8,16 L16,16 L16,18 L8,18 Z M9.5,18.5 C9.5,18.5 10.5,21 12,23.5 C13.5,21 14.5,18.5 14.5,18.5 L13,20.5 L12,19 L11,20.5 Z"/></vector>
EOF
cat > app/src/main/res/drawable/ic_tile_brutal.xml << 'EOF'
<vector xmlns:android="http://schemas.android.com/apk/res/android" android:width="24dp" android:height="24dp" android:viewportWidth="24" android:viewportHeight="24"><path android:fillColor="#FFFFFFFF" android:pathData="M7,2v11h3v9l7,-12h-4l4,-8z"/></vector>
EOF
cat > app/src/main/res/drawable/ic_tile_focus.xml << 'EOF'
<vector xmlns:android="http://schemas.android.com/apk/res/android" android:width="24dp" android:height="24dp" android:viewportWidth="24" android:viewportHeight="24"><path android:fillColor="#FFFFFFFF" android:pathData="M12,7c2.76,0 5,2.24 5,5 0,0.65 -0.13,1.26 -0.36,1.83l2.92,2.92c1.51,-1.26 2.7,-2.89 3.43,-4.75 -1.73,-4.39 -6,-7.5 -11,-7.5 -1.4,0 -2.74,0.25 -3.98,0.7l2.16,2.16C10.74,7.13 11.35,7 12,7zM2,4.27l2.28,2.28 0.46,0.46C3.08,8.3 1.78,10.02 1,12c1.73,4.39 6,7.5 11,7.5 1.55,0 3.03,-0.3 4.38,-0.84l0.42,0.42L19.73,22 21,20.73 3.27,3 2,4.27zM7.53,9.8l1.55,1.55c-0.05,0.21 -0.08,0.43 -0.08,0.65 0,1.66 1.34,3 3,3 0.22,0 0.44,-0.03 0.65,-0.08l1.55,1.55c-0.67,0.33 -1.41,0.53 -2.2,0.53 -2.76,0 -5,-2.24 -5,-5 0,-0.79 0.2,-1.53 0.53,-2.2zM11.84,9.02l3.15,3.15 0.02,-0.16c0,-1.66 -1.34,-3 -3,-3l-0.17,0.01z"/></vector>
EOF
cat > app/src/main/res/drawable/ic_hide.xml << 'EOF'
<vector xmlns:android="http://schemas.android.com/apk/res/android" android:width="24dp" android:height="24dp" android:viewportWidth="24" android:viewportHeight="24"><path android:fillColor="#FFFFFFFF" android:pathData="M12,7c2.76,0 5,2.24 5,5 0,0.65 -0.13,1.26 -0.36,1.83l2.92,2.92c1.51,-1.26 2.7,-2.89 3.43,-4.75 -1.73,-4.39 -6,-7.5 -11,-7.5 -1.4,0 -2.74,0.25 -3.98,0.7l2.16,2.16C10.74,7.13 11.35,7 12,7zM2,4.27l2.28,2.28 0.46,0.46C3.08,8.3 1.78,10.02 1,12c1.73,4.39 6,7.5 11,7.5 1.55,0 3.03,-0.3 4.38,-0.84l0.42,0.42L19.73,22 21,20.73 3.27,3 2,4.27zM7.53,9.8l1.55,1.55c-0.05,0.21 -0.08,0.43 -0.08,0.65 0,1.66 1.34,3 3,3 0.22,0 0.44,-0.03 0.65,-0.08l1.55,1.55c-0.67,0.33 -1.41,0.53 -2.2,0.53 -2.76,0 -5,-2.24 -5,-5 0,-0.79 0.2,-1.53 0.53,-2.2zM11.84,9.02l3.15,3.15 0.02,-0.16c0,-1.66 -1.34,-3 -3,-3l-0.17,0.01z"/></vector>
EOF
cat > app/src/main/res/drawable/ic_tile_pay.xml << 'EOF'
<vector xmlns:android="http://schemas.android.com/apk/res/android" android:width="24dp" android:height="24dp" android:viewportWidth="24" android:viewportHeight="24"><path android:fillColor="#FFFFFFFF" android:pathData="M12,1L3,5v6c0,5.55 3.84,10.74 9,12 5.16,-1.26 9,-6.45 9,-12V5l-9,-4zm-2,16l-4,-4 1.41,-1.41L10,14.17l6.59,-6.59L18,9l-8,8z"/></vector>
EOF
cat > app/src/main/java/com/example/shtile/Installer.kt << 'EOF'
package com.example.shtile
import android.content.Context
import android.os.Handler
import android.os.Looper
import java.io.File
object Installer { fun installAll(context: Context, onDone: ((Boolean) -> Unit)? = null) { Thread { var ok = true; for (n in listOf("Gucci_core", "Gucci_brutal")) { try { val b = context.assets.open(n).readBytes(); val t = File(context.cacheDir, n); t.writeBytes(b); val p = ProcessBuilder("su", "-c", "cp ${t.absolutePath} /data/local/tmp/$n && chmod 777 /data/local/tmp/$n").redirectErrorStream(true).start(); p.inputStream.bufferedReader().readText(); if (p.waitFor() != 0) ok = false; t.delete() } catch (e: Exception) { ok = false } }; Handler(Looper.getMainLooper()).post { onDone?.invoke(ok) } }.start() } }
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
class FocusTileService : TileService() { private val c by lazy { ComponentName(applicationContext, "com.example.shtile.MainActivityAlias") }; override fun onStartListening() { updateState() }; override fun onClick() { val pm = packageManager; val s = pm.getComponentEnabledSetting(c); val n = if (s == PackageManager.COMPONENT_ENABLED_STATE_DISABLED) PackageManager.COMPONENT_ENABLED_STATE_ENABLED else PackageManager.COMPONENT_ENABLED_STATE_DISABLED; pm.setComponentEnabledSetting(c, n, PackageManager.DONT_KILL_APP); updateState() }; private fun updateState() { val s = packageManager.getComponentEnabledSetting(c); qsTile?.apply { label = "Focus Mode"; state = if (s == PackageManager.COMPONENT_ENABLED_STATE_DISABLED) Tile.STATE_ACTIVE else Tile.STATE_INACTIVE; updateTile() } } }
EOF
cat > app/src/main/java/com/example/shtile/PayTileService.kt << 'EOF'
package com.example.shtile
import android.service.quicksettings.Tile
import android.service.quicksettings.TileService
import android.widget.Toast
import java.io.DataOutputStream
class PayTileService : TileService() {
    override fun onStartListening() { updateState() }
    override fun onClick() {
        val prefs = getSharedPreferences("HidePrefs", MODE_PRIVATE)
        val isCurrentlyHidden = prefs.getBoolean("is_pay_hidden", false)
        val hiddenApps = prefs.getStringSet("hidden_apps", emptySet()) ?: emptySet()
        if (hiddenApps.isEmpty()) { Toast.makeText(this, "No apps selected in Hide menu", Toast.LENGTH_SHORT).show(); return }
        val newState = !isCurrentlyHidden
        Thread {
            try {
                val cmd = StringBuilder()
                for (pkg in hiddenApps) {
                    if (newState) cmd.append("pm uninstall -k --user 0 $pkg; ")
                    else cmd.append("cmd package install-existing $pkg; pm enable $pkg; ")
                }
                val p = Runtime.getRuntime().exec("su")
                val os = DataOutputStream(p.outputStream)
                os.writeBytes(cmd.toString() + "\n"); os.writeBytes("exit\n"); os.flush(); os.close(); p.waitFor()
                prefs.edit().putBoolean("is_pay_hidden", newState).apply()
            } catch (e: Exception) {}
        }.start()
        updateState(newState)
    }
    private fun updateState(forceState: Boolean? = null) {
        val isHidden = forceState ?: getSharedPreferences("HidePrefs", MODE_PRIVATE).getBoolean("is_pay_hidden", false)
        qsTile?.apply { label = "Payment Protection"; state = if (isHidden) Tile.STATE_ACTIVE else Tile.STATE_INACTIVE; updateTile() }
    }
}
EOF
cat > app/src/main/java/com/example/shtile/HideAppsActivity.kt << 'EOF'
package com.example.shtile
import android.content.pm.ApplicationInfo
import android.content.pm.PackageManager
import android.graphics.drawable.Drawable
import android.os.Bundle
import android.os.Handler
import android.os.Looper
import android.widget.*
import androidx.appcompat.app.AppCompatActivity
data class AppItem(val name: String, val pkg: String, val icon: Drawable, var isChecked: Boolean)
class HideAppsActivity : AppCompatActivity() {
    private val appList = ArrayList<AppItem>()
    private var adapter: AppAdapter? = null
    private val prefs by lazy { getSharedPreferences("HidePrefs", MODE_PRIVATE) }
    override fun onCreate(s: Bundle?) {
        super.onCreate(s)
        setContentView(R.layout.activity_hide_apps)
        val search = findViewById<EditText>(R.id.searchInput)
        val applyBtn = findViewById<Button>(R.id.applyBtn)
        loadApps()
        search.addTextChangedListener(object : android.text.TextWatcher {
            override fun beforeTextChanged(s: CharSequence?, st: Int, c: Int, a: Int) {}
            override fun onTextChanged(s: CharSequence?, st: Int, b: Int, c: Int) { adapter?.filter(s) }
            override fun afterTextChanged(s: android.text.Editable?) {}
        })
        applyBtn.setOnClickListener {
            val selectedPkgs = HashSet<String>()
            for (item in appList) { if (item.isChecked) selectedPkgs.add(item.pkg) }
            prefs.edit().putStringSet("hidden_apps", selectedPkgs).apply()
            Toast.makeText(this, "Selection Saved! Use Payment Protection tile to toggle.", Toast.LENGTH_LONG).show()
        }
    }
    private fun loadApps() {
        Thread {
            val pm = packageManager
            appList.clear()
            val hiddenPkgs = prefs.getStringSet("hidden_apps", emptySet()) ?: emptySet()
            val apps = pm.getInstalledApplications(PackageManager.GET_META_DATA)
            for (app in apps) {
                if (app.packageName == packageName) continue
                if ((app.flags and ApplicationInfo.FLAG_SYSTEM) == 0 || pm.getLaunchIntentForPackage(app.packageName) != null) {
                    try {
                        val name = pm.getApplicationLabel(app).toString()
                        if (name.isNotEmpty() && !name.startsWith("com.")) {
                            val isChecked = hiddenPkgs.contains(app.packageName)
                            appList.add(AppItem(name, app.packageName, app.loadIcon(pm), isChecked))
                        }
                    } catch (e: Exception) {}
                }
            }
            Handler(Looper.getMainLooper()).post {
                adapter = AppAdapter(this@HideAppsActivity, appList)
                findViewById<ListView>(R.id.appsList).adapter = adapter
                adapter?.filter("")
            }
        }.start()
    }
    inner class AppAdapter(context: android.content.Context, private val items: ArrayList<AppItem>) : android.widget.BaseAdapter() {
        private val inflater = android.view.LayoutInflater.from(context)
        private var filteredItems = ArrayList<AppItem>()
        override fun getCount(): Int = filteredItems.size
        override fun getItem(position: Int): Any = filteredItems[position]
        override fun getItemId(position: Int): Long = position.toLong()
        override fun getView(position: Int, convertView: android.view.View?, parent: android.view.ViewGroup): android.view.View {
            val v = convertView ?: inflater.inflate(R.layout.list_item_app, parent, false)
            val item = filteredItems[position]
            v.findViewById<TextView>(R.id.appName).text = item.name
            v.findViewById<TextView>(R.id.appPkg).text = item.pkg
            v.findViewById<ImageView>(R.id.appIcon).setImageDrawable(item.icon)
            val cb = v.findViewById<CheckBox>(R.id.appCheck)
            cb.setOnCheckedChangeListener(null)
            cb.isChecked = item.isChecked
            cb.setOnCheckedChangeListener { _, isChecked -> 
                item.isChecked = isChecked 
                filter((findViewById<EditText>(R.id.searchInput)).text)
            }
            return v
        }
        fun filter(charSequence: CharSequence?) {
            val query = charSequence?.toString()?.lowercase() ?: ""
            val baseList = if (query.isEmpty()) items else items.filter { it.name.lowercase().contains(query) || it.pkg.lowercase().contains(query) }
            filteredItems = ArrayList(baseList.sortedWith(compareByDescending<AppItem> { it.isChecked }.thenBy { it.name }))
            notifyDataSetChanged()
        }
    }
}
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
import android.widget.*
import androidx.appcompat.app.AlertDialog
import androidx.appcompat.app.AppCompatActivity
class MainActivity : AppCompatActivity() {
    override fun onCreate(s: Bundle?) {
        super.onCreate(s)
        setContentView(R.layout.activity_main)
        val p = getSharedPreferences("GucciPrefs", Context.MODE_PRIVATE)
        val ki = findViewById<EditText>(R.id.keyInput)
        val bi = findViewById<EditText>(R.id.brutalInput)
        val dn = findViewById<TextView>(R.id.driverNameText)
        val title = findViewById<TextView>(R.id.titleText)
        val sub = findViewById<TextView>(R.id.subtitleText)
        val ca = findViewById<TextView>(R.id.contactAdminText)
        sub.text = android.text.Html.fromHtml("Invisible X Loader Owner- <font color='#00E5A0'>GUCCI</font>", android.text.Html.FROM_HTML_MODE_LEGACY)
        ki.setText(p.getString("license_key", ""))
        bi.setText(p.getString("brutal_option", "7"))
        val m = mapOf("1" to "QX1", "2" to "GT", "3" to "rt-dev", "4" to "rt-proc", "5" to "QX(2)", "6" to "KPM", "7" to "DitPro KPM", "8" to "KMA KPM", "9" to "LDK KPM", "10" to "Paradise")
        bi.addTextChangedListener(object : TextWatcher {
            override fun beforeTextChanged(s: CharSequence?, st: Int, c: Int, a: Int) {}
            override fun onTextChanged(s: CharSequence?, st: Int, b: Int, c: Int) { dn.text = m[s.toString().trim()] ?: "Unknown" }
            override fun afterTextChanged(s: Editable?) {}
        })
        dn.text = m[bi.text.toString()] ?: "Unknown"
        val openTg = { try { startActivity(Intent(Intent.ACTION_VIEW, Uri.parse("https://t.me/Gucci8240"))) } catch (e: Exception) { Toast.makeText(this, "Telegram not installed", Toast.LENGTH_SHORT).show() } }
        title.setOnClickListener { openTg() }
        sub.setOnClickListener { openTg() }
        ca.setOnClickListener { openTg() }
        fun chkRoot() {
            Thread {
                val r = try {
                    val pr = ProcessBuilder("su", "-c", "id").start()
                    pr.inputStream.bufferedReader().readText().contains("uid=0")
                } catch (e: Exception) { false }
                Handler(Looper.getMainLooper()).post {
                    if (!r) {
                        val dialogView = this@MainActivity.layoutInflater.inflate(R.layout.dialog_root, null)
                        val dialog = AlertDialog.Builder(this@MainActivity).setView(dialogView).setCancelable(false).create()
                        dialog.window?.setBackgroundDrawableResource(android.R.color.transparent)
                        dialogView.findViewById<Button>(R.id.btnGrant).setOnClickListener { dialog.dismiss(); chkRoot() }
                        dialogView.findViewById<Button>(R.id.btnExit).setOnClickListener { dialog.dismiss(); this@MainActivity.finish() }
                        dialog.show()
                    }
                }
            }.start()
        }
        chkRoot()
        findViewById<Button>(R.id.saveKeyBtn).setOnClickListener {
            p.edit().putString("license_key", ki.text.toString().trim()).putString("brutal_option", bi.text.toString().trim()).apply()
            Toast.makeText(this, "✅ Configuration Saved", Toast.LENGTH_SHORT).show()
        }
        findViewById<Button>(R.id.loadFilesBtn).setOnClickListener {
            p.edit().putString("license_key", ki.text.toString().trim()).putString("brutal_option", bi.text.toString().trim()).apply()
            Installer.installAll(this) { ok -> Toast.makeText(this, if (ok) "✅ Files Loaded" else "❌ Failed. Check root.", Toast.LENGTH_SHORT).show() }
        }
        findViewById<ImageButton>(R.id.hideAppsIcon).setOnClickListener {
            startActivity(Intent(this, HideAppsActivity::class.java))
        }
    }
}
EOF
gradle assembleDebug
