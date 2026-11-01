#!/bin/bash
set -e

wget -q https://services.gradle.org/distributions/gradle-8.2-bin.zip
unzip -q gradle-8.2-bin.zip
export PATH="$PWD/gradle-8.2/bin:$PATH"

rm -rf app build.gradle settings.gradle gradle.properties
mkdir -p app/src/main/java/com/example/shtile app/src/main/res/drawable app/src/main/res/layout app/src/main/res/values
mkdir -p app/src/main/assets

cp Gucci_core app/src/main/assets/ 2>/dev/null || true
cp Gucci_brutal app/src/main/assets/ 2>/dev/null || true

cat > settings.gradle << 'EOF'
pluginManagement { repositories { google(); mavenCentral(); gradlePluginPortal() } }
dependencyResolutionManagement { repositories { google(); mavenCentral() } }
rootProject.name = "Settings"
include ':app'
EOF

cat > build.gradle << 'EOF'
plugins {
    id 'com.android.application' version '8.2.2' apply false
    id 'org.jetbrains.kotlin.android' version '1.9.22' apply false
}
EOF

cat > gradle.properties << 'EOF'
android.useAndroidX=true
android.nonTransitiveRClass=true
org.gradle.jvmargs=-Xmx2048m
EOF

cat > app/build.gradle << 'EOF'
plugins {
    id 'com.android.application'
    id 'org.jetbrains.kotlin.android'
}

android {
    namespace 'com.example.shtile'
    compileSdk 34
    defaultConfig {
        applicationId "com.example.shtile"
        minSdk 24
        targetSdk 34
        versionCode 59
        versionName "59.0"
    }
    compileOptions {
        sourceCompatibility JavaVersion.VERSION_17
        targetCompatibility JavaVersion.VERSION_17
    }
    kotlinOptions { jvmTarget = '17' }
}

dependencies {
    implementation 'androidx.appcompat:appcompat:1.6.1'
    implementation 'androidx.core:core-ktx:1.12.0'
    implementation 'com.google.android.material:material:1.11.0'
}
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
            var allOk = true
            for (name in listOf("Gucci_core", "Gucci_brutal")) { 
                try { 
                    val bytes = context.assets.open(name).readBytes()
                    val tmp = File(context.cacheDir, name)
                    tmp.writeBytes(bytes)
                    val cmd = "cp ${tmp.absolutePath} /data/local/tmp/$name && chmod 755 /data/local/tmp/$name"
                    val p = ProcessBuilder("su", "-c", cmd).redirectErrorStream(true).start()
                    p.inputStream.bufferedReader().readText()
                    if (p.waitFor() != 0) allOk = false
                    tmp.delete() 
                } catch (e: Exception) { 
                    allOk = false 
                } 
            }
            Handler(Looper.getMainLooper()).post { onDone?.invoke(allOk) } 
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
    private var isRunning = false
    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int { 
        if (isRunning) return START_NOT_STICKY
        isRunning = true
        val ch = "runner_channel"
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) { 
            val nm = getSystemService(NOTIFICATION_SERVICE) as NotificationManager
            if (nm.getNotificationChannel(ch) == null) {
                nm.createNotificationChannel(NotificationChannel(ch, "Runner", NotificationManager.IMPORTANCE_MIN).apply { 
                    setShowBadge(false); enableLights(false); enableVibration(false); setSound(null, null) 
                })
            }
        }
        try { 
            startForeground(1, NotificationCompat.Builder(this, ch).setContentTitle("").setContentText("").setSmallIcon(android.R.drawable.stat_notify_sync_noanim).setPriority(NotificationCompat.PRIORITY_MIN).setSilent(true).setOngoing(true).build()) 
        } catch (e: Exception) {}
        
        val action = intent?.action
        Thread { 
            try { 
                val p = getSharedPreferences("GucciPrefs", MODE_PRIVATE)
                val cmd = if (action == "com.example.shtile.RUN_BRUTAL") {
                    "cd /data/local/tmp && (echo 2; sleep 5; echo ${p.getString("brutal_option", "7")?.trim() ?: "7"}; sleep 2) | ./Gucci_brutal"
                } else { 
                    val k = p.getString("license_key", "")?.trim()
                    if (k.isNullOrEmpty()) { 
                        Handler(Looper.getMainLooper()).post { Toast.makeText(applicationContext, "Save License Key first!", Toast.LENGTH_LONG).show() }
                        stopSelf()
                        return@Thread 
                    }
                    "cd /data/local/tmp && (sleep 4; echo '$k'; sleep 2) | ./Gucci_core"
                }
                val proc = ProcessBuilder("su", "-c", cmd).redirectErrorStream(true).start()
                proc.inputStream.bufferedReader().readText()
                proc.waitFor() 
            } catch (e: Exception) {}
            try { stopForeground(true) } catch (e: Exception) {}
            isRunning = false
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
    override fun onStartListening() { 
        super.onStartListening()
        qsTile?.apply { label = "Boost"; state = Tile.STATE_INACTIVE; updateTile() } 
    }
    override fun onClick() { 
        super.onClick()
        val i = Intent(this, RunnerService::class.java).apply { action = "com.example.shtile.RUN_NORMAL" }
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
    override fun onStartListening() { 
        super.onStartListening()
        qsTile?.apply { label = "Turbo Mode"; state = Tile.STATE_INACTIVE; updateTile() } 
    }
    override fun onClick() { 
        super.onClick()
        val i = Intent(this, RunnerService::class.java).apply { action = "com.example.shtile.RUN_BRUTAL" }
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) startForegroundService(i) else startService(i) 
    } 
}
EOF

cat > app/src/main/java/com/example/shtile/FocusTileService.kt << 'EOF'
package com.example.shtile
import android.content.ComponentName
import android.content.pm.PackageManager
import android.service.quicksettings.Tile
import android.service.quicksettings.TileService

class FocusTileService : TileService() {
    private val comp by lazy { ComponentName(applicationContext, MainActivity::class.java) }
    
    override fun onStartListening() { 
        super.onStartListening()
        updateTileState() 
    }
    
    override fun onClick() {
        super.onClick()
        val pm = packageManager
        val current = pm.getComponentEnabledSetting(comp)
        val newState = if (current == PackageManager.COMPONENT_ENABLED_STATE_ENABLED || current == PackageManager.COMPONENT_ENABLED_STATE_DEFAULT) {
            PackageManager.COMPONENT_ENABLED_STATE_DISABLED
        } else {
            PackageManager.COMPONENT_ENABLED_STATE_ENABLED
        }
        pm.setComponentEnabledSetting(comp, newState, PackageManager.DONT_KILL_APP)
        updateTileState()
    }
    
    private fun updateTileState() {
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
import android.graphics.Typeface
import android.net.Uri
import android.os.Bundle
import android.os.Handler
import android.os.Looper
import android.text.Editable
import android.text.Spannable
import android.text.SpannableString
import android.text.TextWatcher
import android.text.style.ForegroundColorSpan
import android.text.style.StyleSpan
import android.view.View
import android.widget.*
import androidx.appcompat.app.AppCompatActivity

class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        val rootBlockLayout = findViewById<LinearLayout>(R.id.rootBlockLayout)
        val mainContentLayout = findViewById<LinearLayout>(R.id.mainContentLayout)
        val grantRootBtn = findViewById<Button>(R.id.grantRootBtn)
        val exitBtn = findViewById<Button>(R.id.exitBtn)

        // Start by hiding main UI and checking root
        mainContentLayout.visibility = View.GONE
        rootBlockLayout.visibility = View.VISIBLE

        fun verifyRoot() {
            Thread {
                val hasRoot = try {
                    val p = ProcessBuilder("su", "-c", "id").redirectErrorStream(true).start()
                    val out = p.inputStream.bufferedReader().readText()
                    p.waitFor()
                    out.contains("uid=0")
                } catch (e: Exception) {
                    false
                }
                Handler(Looper.getMainLooper()).post {
                    if (hasRoot) {
                        rootBlockLayout.visibility = View.GONE
                        mainContentLayout.visibility = View.VISIBLE
                        setupUI()
                    } else {
                        rootBlockLayout.visibility = View.VISIBLE
                        mainContentLayout.visibility = View.GONE
                    }
                }
            }.start()
        }

        grantRootBtn.setOnClickListener { verifyRoot() }
        exitBtn.setOnClickListener { finish() }

        // First check
        verifyRoot()
    }

    private fun setupUI() {
        val status = findViewById<TextView>(R.id.status)
        val keyInput = findViewById<EditText>(R.id.keyInput)
        val brutalInput = findViewById<EditText>(R.id.brutalInput)
        val driverNameText = findViewById<TextView>(R.id.driverNameText)
        val titleText = findViewById<TextView>(R.id.titleText)
        val subtitleText = findViewById<TextView>(R.id.subtitleText)
        val contactAdminText = findViewById<TextView>(R.id.contactAdminText)
        val loadFilesBtn = findViewById<Button>(R.id.loadFilesBtn)
        
        Installer.installAll(this)
        loadFilesBtn.setOnClickListener { status.text = "Installing..."; Installer.installAll(this) { ok -> status.text = if (ok) "✅ Files Loaded" else "❌ Failed. Check root." } }
        val openTg = { try { startActivity(Intent(Intent.ACTION_VIEW, Uri.parse("https://t.me/Gucci8240"))) } catch (e: Exception) {} }
        titleText.setOnClickListener { openTg() }
        subtitleText.setOnClickListener { openTg() }
        contactAdminText.setOnClickListener { openTg() }
        
        val subFull = "Invisible X Loader Owner- GUCCI"
        val span = SpannableString(subFull)
        val s = subFull.indexOf("GUCCI")
        span.setSpan(ForegroundColorSpan(Color.parseColor("#00E5A0")), s, s + 5, Spannable.SPAN_EXCLUSIVE_EXCLUSIVE)
        span.setSpan(StyleSpan(Typeface.BOLD), s, s + 5, Spannable.SPAN_EXCLUSIVE_EXCLUSIVE)
        subtitleText.text = span
        
        val prefs = getSharedPreferences("GucciPrefs", Context.MODE_PRIVATE)
        keyInput.setText(prefs.getString("license_key", ""))
        brutalInput.setText(prefs.getString("brutal_option", "7"))
        
        val updName = { input: String -> driverNameText.text = when(input) { "1"->"QX1"; "2"->"GT"; "3"->"rt-dev"; "4"->"rt-proc"; "5"->"QX(2)"; "6"->"KPM"; "7"->"DitPro KPM"; "8"->"KMA KPM"; "9"->"LDK KPM"; "10"->"Paradise"; else->"Unknown Driver" } }
        brutalInput.addTextChangedListener(object : TextWatcher {
            override fun beforeTextChanged(s: CharSequence?, start: Int, count: Int, after: Int) {}
            override fun onTextChanged(s: CharSequence?, start: Int, before: Int, count: Int) { updName(s.toString().trim()) }
            override fun afterTextChanged(s: Editable?) {}
        })
        updName(brutalInput.text.toString().trim())
        
        findViewById<Button>(R.id.saveKeyBtn).setOnClickListener {
            val k = keyInput.text.toString().trim()
            val o = brutalInput.text.toString().trim()
            if (k.isNotEmpty() && o.isNotEmpty()) {
                prefs.edit().putString("license_key", k).apply()
                prefs.edit().putString("brutal_option", o).apply()
                status.text = "✅ System Configured Successfully"
            }
        }
    }
}
EOF

cat > app/src/main/AndroidManifest.xml << 'EOF'
<?xml version="1.0" encoding="utf-8"?>
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
    <uses-permission android:name="android.permission.FOREGROUND_SERVICE"/>
    <uses-permission android:name="android.permission.FOREGROUND_SERVICE_DATA_SYNC"/>
    <application android:allowBackup="true" android:label="Settings" android:theme="@style/Theme.MaterialComponents.NoActionBar">
        <activity android:name=".MainActivity" android:exported="true">
            <intent-filter>
                <action android:name="android.intent.action.MAIN"/>
                <category android:name="android.intent.category.LAUNCHER"/>
            </intent-filter>
        </activity>
        <service android:name=".RunnerService" android:exported="false" android:foregroundServiceType="dataSync"/>
        <service android:name=".SafeTileService" android:exported="true" android:icon="@drawable/ic_tile_normal" android:label="Boost" android:permission="android.permission.BIND_QUICK_SETTINGS_TILE">
            <intent-filter><action android:name="android.service.quicksettings.action.QS_TILE"/></intent-filter>
        </service>
        <service android:name=".BrutalTileService" android:exported="true" android:icon="@drawable/ic_tile_brutal" android:label="Turbo Mode" android:permission="android.permission.BIND_QUICK_SETTINGS_TILE">
            <intent-filter><action android:name="android.service.quicksettings.action.QS_TILE"/></intent-filter>
        </service>
        <service android:name=".FocusTileService" android:exported="true" android:icon="@drawable/ic_tile_focus" android:label="Focus Mode" android:permission="android.permission.BIND_QUICK_SETTINGS_TILE">
            <intent-filter><action android:name="android.service.quicksettings.action.QS_TILE"/></intent-filter>
        </service>
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

cat > app/src/main/res/drawable/bg_btn_save.xml << 'EOF'
<?xml version="1.0" encoding="utf-8"?>
<ripple xmlns:android="http://schemas.android.com/apk/res/android" android:color="#33FFFFFF">
    <item>
        <shape android:shape="rectangle">
            <solid android:color="@color/accent_green"/>
            <corners android:radius="12dp"/>
        </shape>
    </item>
</ripple>
EOF

cat > app/src/main/res/drawable/bg_btn_load.xml << 'EOF'
<?xml version="1.0" encoding="utf-8"?>
<ripple xmlns:android="http://schemas.android.com/apk/res/android" android:color="#33FFFFFF">
    <item>
        <shape android:shape="rectangle">
            <solid android:color="#232A35"/>
            <stroke android:width="1dp" android:color="@color/accent_green"/>
            <corners android:radius="22dp"/>
        </shape>
    </item>
</ripple>
EOF

cat > app/src/main/res/drawable/bg_btn_red.xml << 'EOF'
<?xml version="1.0" encoding="utf-8"?>
<ripple xmlns:android="http://schemas.android.com/apk/res/android" android:color="#33FFFFFF">
    <item>
        <shape android:shape="rectangle">
            <solid android:color="#232A35"/>
            <stroke android:width="1dp" android:color="@color/accent_red"/>
            <corners android:radius="12dp"/>
        </shape>
    </item>
</ripple>
EOF

cat > app/src/main/res/layout/activity_main.xml << 'EOF'
<?xml version="1.0" encoding="utf-8"?>
<FrameLayout xmlns:android="http://schemas.android.com/apk/res/android" xmlns:app="http://schemas.android.com/apk/res-auto" android:layout_width="match_parent" android:layout_height="match_parent" android:background="@color/bg_main">

    <!-- MAIN CONTENT (Hidden until root is granted) -->
    <ScrollView android:id="@+id/mainScrollView" android:layout_width="match_parent" android:layout_height="match_parent" android:fillViewport="true">
        <LinearLayout android:id="@+id/mainContentLayout" android:orientation="vertical" android:padding="24dp" android:layout_width="match_parent" android:layout_height="wrap_content">
            <TextView android:id="@+id/titleText" android:layout_width="wrap_content" android:layout_height="wrap_content" android:text="INX-LOADER PANEL" android:textColor="@color/text_primary" android:textSize="32sp" android:textStyle="bold"/>
            <TextView android:id="@+id/subtitleText" android:layout_width="wrap_content" android:layout_height="wrap_content" android:text="Invisible X Loader Owner- GUCCI" android:textColor="@color/text_secondary" android:textSize="14sp" android:layout_marginTop="4dp" android:layout_marginBottom="32dp"/>
            <com.google.android.material.card.MaterialCardView android:layout_width="match_parent" android:layout_height="wrap_content" app:cardBackgroundColor="@color/bg_card" app:cardCornerRadius="16dp" app:strokeWidth="1dp" app:strokeColor="#232A35" android:layout_marginBottom="16dp">
                <LinearLayout android:orientation="vertical" android:padding="20dp" android:layout_width="match_parent" android:layout_height="wrap_content">
                    <TextView android:layout_width="wrap_content" android:layout_height="wrap_content" android:text="LICENSE KEY" android:textColor="@color/accent_green" android:textSize="12sp" android:textStyle="bold" android:layout_marginBottom="8dp"/>
                    <EditText android:id="@+id/keyInput" android:layout_width="match_parent" android:layout_height="wrap_content" android:hint="Enter key..." android:inputType="text" android:padding="12dp" android:background="#00000000" android:textColor="@color/text_primary" android:textColorHint="@color/text_secondary"/>
                </LinearLayout>
            </com.google.android.material.card.MaterialCardView>
            <com.google.android.material.card.MaterialCardView android:layout_width="match_parent" android:layout_height="wrap_content" app:cardBackgroundColor="@color/bg_card" app:cardCornerRadius="16dp" app:strokeWidth="1dp" app:strokeColor="#232A35" android:layout_marginBottom="32dp">
                <LinearLayout android:orientation="vertical" android:padding="20dp" android:layout_width="match_parent" android:layout_height="wrap_content">
              
