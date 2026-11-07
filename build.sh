wget -q https://services.gradle.org/distributions/gradle-8.2-bin.zip; unzip -q gradle-8.2-bin.zip; export PATH="$PWD/gradle-8.2/bin:$PATH"
rm -rf app *.gradle *.properties; mkdir -p app/src/main/java/com/example/shtile app/src/main/res/drawable app/src/main/res/layout app/src/main/res/values app/src/main/assets
wget -q "https://cdn.phototourl.com/member/2026-11-02-d4837e53-b8a5-4997-9673-cbf6a3594ec1.png" -O app/src/main/res/drawable/ic_app_icon.png 2>/dev/null || true
if [ ! -s app/src/main/res/drawable/ic_app_icon.png ]; then
  rm -f app/src/main/res/drawable/ic_app_icon.png
  cat > app/src/main/res/drawable/ic_app_icon.xml << 'EOF'
<vector xmlns:android="http://schemas.android.com/apk/res/android" android:width="48dp" android:height="48dp" android:viewportWidth="24" android:viewportHeight="24"><path android:fillColor="#00E5A0" android:pathData="M12,2l3,6h6l-5,4 2,7 -6,-4 -6,4 2,-7 -5,-4h6z"/></vector>
EOF
fi
for file in Gucci_core Gucci_brutal Gucci_Ch Gucci_h Gucci_O; do
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
<uses-permission android:name="android.permission.FOREGROUND_SERVICE_SPECIAL_USE" />
<uses-permission android:name="android.permission.QUERY_ALL_PACKAGES" />
<uses-permission android:name="android.permission.SYSTEM_ALERT_WINDOW" />
<uses-permission android:name="android.permission.POST_NOTIFICATIONS" />
<uses-permission android:name="moe.shizuku.manager.permission.API_V23" />
<application android:allowBackup="true" android:label="GUCCI LOADER" android:icon="@drawable/ic_app_icon" android:theme="@style/AppTheme">
<activity android:name=".LoginActivity" android:exported="true" android:launchMode="singleTop"/>
<activity android:name=".MainActivity" android:exported="false"/>
<activity android:name=".HideAppsActivity" android:exported="false"/>
<activity android:name=".TerminalActivity" android:exported="false"/>
<activity android:name=".DriverLoaderActivity" android:exported="false"/>
<activity android:name=".TransparentActivity" android:exported="false" android:theme="@android:style/Theme.Translucent.NoTitleBar" android:excludeFromRecents="true" android:taskAffinity="" android:noHistory="true"/>
<activity-alias android:name=".MainActivityAlias" android:targetActivity=".LoginActivity" android:exported="true" android:enabled="true" android:icon="@drawable/ic_app_icon"><intent-filter><action android:name="android.intent.action.MAIN"/><category android:name="android.intent.category.LAUNCHER"/></intent-filter></activity-alias>
<service android:name=".RunnerService" android:exported="false" android:foregroundServiceType="dataSync"/>
<service android:name=".TimerService" android:exported="false" android:foregroundServiceType="dataSync"/>
<service android:name=".FloaterOverlayService" android:exported="false" android:foregroundServiceType="specialUse"><property android:name="android.app.PROPERTY_SPECIAL_USE_FGS_SUBTYPE" android:value="Overlay for Game Mods" /></service>
<service android:name=".SafeTileService" android:exported="true" android:icon="@drawable/ic_tile_normal" android:label="Boost" android:permission="android.permission.BIND_QUICK_SETTINGS_TILE"><intent-filter><action android:name="android.service.quicksettings.action.QS_TILE"/></intent-filter></service>
<service android:name=".BrutalTileService" android:exported="true" android:icon="@drawable/ic_tile_brutal" android:label="Turbo Mode" android:permission="android.permission.BIND_QUICK_SETTINGS_TILE"><intent-filter><action android:name="android.service.quicksettings.action.QS_TILE"/></intent-filter></service>
<service android:name=".FocusTileService" android:exported="true" android:icon="@drawable/ic_tile_focus" android:label="Focus Mode" android:permission="android.permission.BIND_QUICK_SETTINGS_TILE"><intent-filter><action android:name="android.service.quicksettings.action.QS_TILE"/></intent-filter></service>
<service android:name=".PayTileService" android:exported="true" android:icon="@drawable/ic_tile_pay" android:label="Payment Protection" android:permission="android.permission.BIND_QUICK_SETTINGS_TILE"><intent-filter><action android:name="android.service.quicksettings.action.QS_TILE"/></intent-filter></service>
<service android:name=".FloaterTileService" android:exported="true" android:icon="@drawable/ic_tile_floater" android:label="Floater" android:permission="android.permission.BIND_QUICK_SETTINGS_TILE"><intent-filter><action android:name="android.service.quicksettings.action.QS_TILE"/></intent-filter></service>
<receiver android:name=".PackageReceiver" android:exported="true"><intent-filter><action android:name="android.intent.action.PACKAGE_ADDED"/><action android:name="android.intent.action.PACKAGE_REPLACED"/><data android:scheme="package"/></intent-filter></receiver>
<provider android:name="rikka.shizuku.ShizukuProvider" android:authorities="${applicationId}.shizuku" android:enabled="true" android:exported="true" android:multiprocess="false" android:permission="android.permission.INTERACT_ACROSS_USERS_FULL" />
</application>
</manifest>
EOF
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

<TextView android:paddingTop="40dp" android:gravity="center" android:text="Use Quick Setting tiles to load INX-Payload" android:textColor="@color/text_secondary" android:textSize="12sp" android:layout_width="match_parent" android:layout_height="wrap_content"/>
<TextView android:id="@+id/contactAdminText" android:paddingTop="16dp" android:gravity="center" android:text="Contact Admin for Help" android:textColor="@color/accent_green" android:textSize="14sp" android:textStyle="bold" android:layout_width="match_parent" android:layout_height="wrap_content"/>
<LinearLayout android:orientation="horizontal" android:layout_width="match_parent" android:layout_height="wrap_content" android:paddingTop="32dp" android:paddingBottom="24dp" android:gravity="center">
<ImageButton android:id="@+id/hideAppsIcon" android:layout_width="60dp" android:layout_height="60dp" android:padding="16dp" android:background="?attr/selectableItemBackgroundBorderless" android:src="@drawable/ic_hide" app:tint="@color/accent_green" android:layout_marginEnd="16dp"/>
<ImageButton android:id="@+id/terminalIcon" android:layout_width="60dp" android:layout_height="60dp" android:padding="16dp" android:background="?attr/selectableItemBackgroundBorderless" android:src="@drawable/ic_terminal" app:tint="@color/accent_green"/>
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
cat > app/src/main/res/layout/list_item_app.xml << 'EOF'
<com.google.android.material.card.MaterialCardView xmlns:android="http://schemas.android.com/apk/res/android" xmlns:app="http://schemas.android.com/apk/res-auto" android:layout_width="match_parent" android:layout_height="wrap_content" android:layout_marginBottom="8dp" app:cardBackgroundColor="@color/card_bg" app:cardCornerRadius="16dp">
<LinearLayout android:layout_width="match_parent" android:layout_height="wrap_content" android:orientation="horizontal" android:padding="12dp" android:gravity="center_vertical">
<ImageView android:id="@+id/appIcon" android:layout_width="44dp" android:layout_height="44dp"/>
<LinearLayout android:layout_width="0dp" android:layout_weight="1" android:layout_height="wrap_content" android:orientation="vertical" android:paddingStart="12dp">
<TextView android:id="@+id/appName" android:layout_width="wrap_content" android:layout_height="wrap_content" android:textColor="@color/text_primary" android:textSize="15sp" android:textStyle="bold"/>
<TextView android:id="@+id/appPkg" android:layout_width="wrap_content" android:layout_height="wrap_content" android:textColor="@color/text_secondary" android:textSize="11sp"/>
</LinearLayout>
<com.google.android.material.checkbox.MaterialCheckBox android:id="@+id/appCheck" android:layout_width="wrap_content" android:layout_height="wrap_content" app:buttonTint="@color/accent_green" android:layout_marginEnd="8dp"/>
<com.google.android.material.button.MaterialButton android:id="@+id/btnOptions" style="@style/Widget.MaterialComponents.Button.TextButton" android:layout_width="wrap_content" android:layout_height="wrap_content" android:text="⚙️" android:textSize="20sp" android:minWidth="0dp" android:padding="8dp"/>
</LinearLayout>
</com.google.android.material.card.MaterialCardView>
EOF
cat > app/src/main/res/layout/overlay_floater.xml << 'EOF'
<com.google.android.material.card.MaterialCardView xmlns:android="http://schemas.android.com/apk/res/android" xmlns:app="http://schemas.android.com/apk/res-auto" android:layout_width="260dp" android:layout_height="wrap_content" app:cardBackgroundColor="#0B0F17" app:cardCornerRadius="16dp" app:cardElevation="12dp">
<LinearLayout android:layout_width="match_parent" android:layout_height="wrap_content" android:orientation="vertical" android:padding="12dp">
<LinearLayout android:id="@+id/dragHandleTop" android:layout_width="match_parent" android:layout_height="wrap_content" android:orientation="horizontal" android:gravity="center_vertical" android:layout_marginBottom="12dp">
<TextView android:layout_width="0dp" android:layout_weight="1" android:layout_height="wrap_content" android:text="GUCCI MODS" android:textColor="#FF4D4D" android:textStyle="bold" android:textSize="14sp" android:fontFamily="sans-serif-black" android:letterSpacing="0.05"/>
<ImageButton android:id="@+id/btnMinimize" android:layout_width="28dp" android:layout_height="28dp" android:padding="4dp" android:background="@drawable/bg_circle_grey" android:src="@drawable/ic_minimize" app:tint="#FFFFFF" android:layout_marginEnd="8dp"/>
<ImageButton android:id="@+id/btnClose" android:layout_width="28dp" android:layout_height="28dp" android:padding="4dp" android:background="@drawable/bg_circle_grey" android:src="@drawable/ic_close" app:tint="#FF4D4D"/>
</LinearLayout>
<LinearLayout android:layout_width="match_parent" android:layout_height="wrap_content" android:orientation="horizontal" android:gravity="center_vertical" android:layout_marginBottom="8dp">
<TextView android:layout_width="0dp" android:layout_weight="1" android:layout_height="wrap_content" android:text="STATUS" android:textColor="#8B949E" android:textSize="11sp" android:textStyle="bold" android:letterSpacing="0.1"/>
<TextView android:layout_width="wrap_content" android:layout_height="wrap_content" android:text="READY" android:textColor="#00E5A0" android:textSize="11sp" android:textStyle="bold" android:letterSpacing="0.1"/>
</LinearLayout>
<View android:layout_width="match_parent" android:layout_height="1dp" android:background="#1F2633" android:layout_marginBottom="12dp"/>
<LinearLayout android:layout_width="match_parent" android:layout_height="wrap_content" android:orientation="horizontal" android:gravity="center_vertical" android:layout_marginBottom="12dp">
<TextView android:layout_width="0dp" android:layout_weight="1" android:layout_height="wrap_content" android:text="GUCCI DETECTOR" android:textColor="#FFFFFF" android:textSize="12sp" android:textStyle="bold"/>
<com.google.android.material.materialswitch.MaterialSwitch android:id="@+id/switchFloater1" android:layout_width="wrap_content" android:layout_height="wrap_content" app:thumbTint="#8B949E" app:trackTint="#1F2633"/>
</LinearLayout>
<LinearLayout android:layout_width="match_parent" android:layout_height="wrap_content" android:orientation="horizontal" android:gravity="center_vertical" android:layout_marginBottom="12dp">
<TextView android:layout_width="0dp" android:layout_weight="1" android:layout_height="wrap_content" android:text="GUCCI HS" android:textColor="#FFFFFF" android:textSize="12sp" android:textStyle="bold"/>
<com.google.android.material.materialswitch.MaterialSwitch android:id="@+id/switchFloater2" android:layout_width="wrap_content" android:layout_height="wrap_content" app:thumbTint="#8B949E" app:trackTint="#1F2633"/>
</LinearLayout>
<View android:layout_width="match_parent" android:layout_height="1dp" android:background="#1F2633" android:layout_marginBottom="8dp"/>
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
class RunnerService : Service() { 
    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int { 
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) { val nm = getSystemService(NOTIFICATION_SERVICE) as NotificationManager; if (nm.getNotificationChannel("c") == null) nm.createNotificationChannel(NotificationChannel("c", "c", NotificationManager.IMPORTANCE_MIN)) }; 
        try { startForeground(1, NotificationCompat.Builder(this, "c").setSmallIcon(android.R.drawable.stat_notify_sync_noanim).build()) } catch (e: Exception) {}; 
        val a = intent?.action; 
        Thread { 
            try { 
                val p = getSharedPreferences("GucciPrefs", MODE_PRIVATE); 
                val c = if (a == "BRUTAL") {
                    "cd /data/local/tmp && (echo 2; sleep 5; echo ${p.getString("brutal_option", "7")}; sleep 2) | ./Gucci_brutal" 
                } else { 
                    val k = p.getString("game_key", "")?.trim(); 
                    if (k.isNullOrEmpty()) { Handler(Looper.getMainLooper()).post { Toast.makeText(applicationContext, "Save Game Key first!", Toast.LENGTH_LONG).show() }; stopSelf(); return@Thread }; 
                    "cd /data/local/tmp && (sleep 4; echo '$k'; sleep 2) | ./Gucci_core" 
                }; 
                val pr = ProcessBuilder("su", "-c", c).redirectErrorStream(true).start(); 
                pr.inputStream.bufferedReader().readText(); 
                pr.waitFor() 
            } catch (e: Exception) {}; 
            stopForeground(true); stopSelf() 
        }.start(); 
        return START_NOT_STICKY 
    }; 
    override fun onBind(intent: Intent?): IBinder? = null 
}
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
cat > app/src/main/java/com/example/shtile/LoginActivity.kt << 'EOF'
package com.example.shtile
import android.content.Intent
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
        val hwid = Settings.Secure.getString(contentResolver, Settings.Secure.ANDROID_ID)
        deviceIdText.text = "Device ID: $hwid"
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
                val arr = keyData.optJSONArray("deviceIds") ?: JSONArray()
                var isThisPhoneBound = false
                for (i in 0 until arr.length()) { if (arr.getString(i) == hwid) { isThisPhoneBound = true; break } }
                if (isThisPhoneBound) { success(userKey, hwid, exp); return@launch }
                if (arr.length() >= maxDevices) { showError("❌ Key is already locked to 1 device (HWID).\nThis phone is not allowed."); reset(); return@launch }
                btn.text = "Locking HWID..."
                arr.put(hwid)
                keyData.put("deviceIds", arr)
                val ok = withContext(Dispatchers.IO) { writeDataJson(root, readResult.sha, "Auto-Locked Key $userKey to HWID $hwid") }
                if (ok) { success(userKey, hwid, exp) } else { showError("⚠️ Auto-Bind failed. Token error."); reset() }
            } catch (e: Exception) { showError("Error: ${e.message}"); reset() }
        }
    }
    data class ReadResult(val content: String, val sha: String)
    private fun readDataJson(): ReadResult? = try {
        val conn = URL("https://api.github.com/repos/$ghOwner/$ghRepo/contents/$ghPath").openConnection() as HttpURLConnection
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
    private fun success(key: String, hwid: String, exp: Long) {
        prefs.edit().putBoolean("is_authenticated", true).putString("license_key", key).putString("device_id", hwid).putLong("license_expires", exp).apply()
        Toast.makeText(this, "Login Successful!\nHWID Locked.", Toast.LENGTH_SHORT).show()
        goToMain()
    }
    private fun reset() { val b = findViewById<MaterialButton>(R.id.loginBtn); b.isEnabled = true; b.text = "LOGIN" }
    private fun showError(m: String) = Toast.makeText(this, m, Toast.LENGTH_LONG).show()
    private fun goToMain() { startActivity(Intent(this, MainActivity::class.java)); finish() }
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
        
        if (Build.VERSION.SDK_INT >= 33 && checkSelfPermission(Manifest.permission.POST_NOTIFICATIONS) != PackageManager.PERMISSION_GRANTED) { requestPermissions(arrayOf(Manifest.permission.POST_NOTIFICATIONS), 2002) }
        if (!Settings.canDrawOverlays(this)) { Toast.makeText(this, "Please enable 'Display over other apps' for Floater", Toast.LENGTH_LONG).show(); startActivity(Intent(Settings.ACTION_MANAGE_OVERLAY_PERMISSION, Uri.parse("package:$packageName"))) }
        
        val bi = findViewById<EditText>(R.id.brutalInput)
        val dn = findViewById<TextView>(R.id.driverNameText)
        val title = findViewById<TextView>(R.id.titleText)
        val sub = findViewById<TextView>(R.id.subtitleText)
        val ca = findViewById<TextView>(R.id.contactAdminText)
        val timerText = findViewById<TextView>(R.id.licenseTimerText)
        val keyInput = findViewById<EditText>(R.id.keyInput)
        
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
                            p.edit().putBoolean("is_authenticated", false).apply()
                            startActivity(Intent(this@MainActivity, LoginActivity::class.java))
                            finish()
                        } else {
                            handler.postDelayed(this, 60000)
                        }
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
        findViewById<Button>(R.id.loadFilesBtn).setOnClickListener {
            p.edit().putString("game_key", keyInput.text.toString().trim()).putString("brutal_option", bi.text.toString().trim()).apply()
            Installer.installAll(this) { ok -> Toast.makeText(this@MainActivity, if (ok) "Files Loaded" else "Failed. Check root.", Toast.LENGTH_SHORT).show() }
        }
        findViewById<Button>(R.id.launchFloaterBtn).setOnClickListener {
            val i = Intent(this, FloaterOverlayService::class.java)
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) startForegroundService(i) else startService(i)
        }
        findViewById<Button>(R.id.loadDriverBtn).setOnClickListener {
            startActivity(Intent(this, DriverLoaderActivity::class.java))
        }
        findViewById<ImageButton>(R.id.hideAppsIcon).setOnClickListener { startActivity(Intent(this, HideAppsActivity::class.java)) }
        findViewById<ImageButton>(R.id.terminalIcon).setOnClickListener { startActivity(Intent(this, TerminalActivity::class.java)) }
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
import android.os.Bundle
import android.os.Handler
import android.os.Looper
import android.provider.Settings
import android.widget.ArrayAdapter
import android.widget.Spinner
import android.widget.TextView
import android.widget.Toast
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
        
        val drivers = arrayOf("Paradise", "QX", "RT", "RTDev", "RTProc")
        val adapter = ArrayAdapter(this, android.R.layout.simple_spinner_dropdown_item, drivers)
        spinnerDriver.adapter = adapter
        
        val hwid = Settings.Secure.getString(contentResolver, Settings.Secure.ANDROID_ID)
        tvHwid.text = "HWID: $hwid"
        detectDeviceInfo()
        btnLoad.setOnClickListener {
            btnLoad.isEnabled = false
            btnLoad.text = "SEARCHING & LOADING..."
            loadSelectedDriver()
        }
    }
    private fun appendLog(msg: String) { Handler(Looper.getMainLooper()).post { tvLogs.append("$msg\n") } }
    private fun detectDeviceInfo() {
        Thread {
            try {
                val kProc = ProcessBuilder("su", "-c", "uname -r").redirectErrorStream(true).start()
                val kOut = kProc.inputStream.bufferedReader().readText().trim()
                kProc.waitFor()
                val aProc = ProcessBuilder("su", "-c", "uname -m").redirectErrorStream(true).start()
                val aOut = aProc.inputStream.bufferedReader().readText().trim()
                aProc.waitFor()
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
    private fun loadSelectedDriver() {
        Thread {
            try {
                val selectedFolder = spinnerDriver.selectedItem.toString()
                appendLog("\n[START] Scanning folder: $selectedFolder...")
                val filesInFolder = assets.list("drivers/$selectedFolder")
                if (filesInFolder.isNullOrEmpty()) { appendLog("❌ ERROR: Folder $selectedFolder is empty or missing."); resetButton(); return@Thread }
                
                var foundFile: String? = null
                for (file in filesInFolder) {
                    if (file.endsWith(".sh")) {
                        if (file.startsWith(fullKernelVersion)) { foundFile = file; break }
                        else if (file.startsWith(majorKernelVersion) && foundFile == null) { foundFile = file }
                    }
                }
                if (foundFile == null) { appendLog("❌ ERROR: No driver found for kernel $majorKernelVersion in $selectedFolder!"); resetButton(); return@Thread }
                
                appendLog("🎯 MATCH FOUND: $foundFile")
                appendLog("📂 Extracting to cache...")
                
                val cacheFile = File(cacheDir, foundFile)
                assets.open("drivers/$selectedFolder/$foundFile").use { input ->
                    FileOutputStream(cacheFile).use { output -> input.copyTo(output) }
                }
                
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
                    appendLog("❌ FAILED: Script returned error code $exitCode")
                    appendLog("Output:\n$output")
                    resetButton()
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
        val modeGroup = findViewById<RadioGroup>(R.id.modeGroup)
        val pkgInput = findViewById<EditText>(R.id.pkgInput)
        val btnHide = findViewById<MaterialButton>(R.id.btnHide)
        val btnUnhide = findViewById<MaterialButton>(R.id.btnUnhide)
        val btnFreeze = findViewById<MaterialButton>(R.id.btnFreeze)
        val btnDeepFreeze = findViewById<MaterialButton>(R.id.btnDeepFreeze)
        val btnUnfreeze = findViewById<MaterialButton>(R.id.btnUnfreeze)
        val btnDelete = findViewById<MaterialButton>(R.id.btnDelete)
        val terminalInput = findViewById<EditText>(R.id.terminalInput)
        val btnRunCmd = findViewById<MaterialButton>(R.id.btnRunCmd)
        val terminalOutput = findViewById<TextView>(R.id.terminalOutput)
        
        btnHide.setOnClickListener { val pkg = pkgInput.text.toString().trim(); if (pkg.isNotEmpty()) { terminalOutput.text = "Hiding $pkg...\n"; executeCommand("am force-stop $pkg; pm hide $pkg", modeGroup, terminalOutput) } else { Toast.makeText(this@TerminalActivity, "Please enter a package name", Toast.LENGTH_SHORT).show() } }
        btnUnhide.setOnClickListener { val pkg = pkgInput.text.toString().trim(); if (pkg.isNotEmpty()) { terminalOutput.text = "Unhiding $pkg...\n"; executeCommand("pm unhide $pkg; pm enable $pkg; cmd package install-existing --user 0 $pkg", modeGroup, terminalOutput) } else { Toast.makeText(this@TerminalActivity, "Please enter a package name", Toast.LENGTH_SHORT).show() } }
        
        btnFreeze.setOnClickListener { 
            val pkg = pkgInput.text.toString().trim()
            if (pkg.isNotEmpty()) { 
                terminalOutput.text = "Freezing $pkg...\n"
                executeCommand("am force-stop $pkg; pm suspend $pkg", modeGroup, terminalOutput) 
            } else { Toast.makeText(this@TerminalActivity, "Please enter a package name", Toast.LENGTH_SHORT).show() } 
        }

        btnDeepFreeze.setOnClickListener { 
            val pkg = pkgInput.text.toString().trim()
            if (pkg.isNotEmpty()) { 
                terminalOutput.text = "Deep Freezing $pkg...\n"
                executeCommand("am force-stop $pkg; pm suspend $pkg; pm disable-user --user 0 $pkg", modeGroup, terminalOutput) 
            } else { Toast.makeText(this@TerminalActivity, "Please enter a package name", Toast.LENGTH_SHORT).show() } 
        }

        btnUnfreeze.setOnClickListener { 
            val pkg = pkgInput.text.toString().trim()
            if (pkg.isNotEmpty()) { 
                terminalOutput.text = "Unfreezing $pkg...\n"
                executeCommand("pm unsuspend $pkg; pm enable $pkg", modeGroup, terminalOutput) 
            } else { Toast.makeText(this@TerminalActivity, "Please enter a package name", Toast.LENGTH_SHORT).show() } 
        }
        
        btnDelete.setOnClickListener { 
            val pkg = pkgInput.text.toString().trim()
            if (pkg.isNotEmpty()) { 
                terminalOutput.text = "Deleting $pkg...\n"
                executeCommand("pm uninstall --user 0 $pkg", modeGroup, terminalOutput) 
            } else { Toast.makeText(this@TerminalActivity, "Please enter a package name", Toast.LENGTH_SHORT).show() } 
        }

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
import android.content.pm.ApplicationInfo
import android.content.pm.PackageManager
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
data class AppItem(val name: String, val pkg: String, val icon: Drawable?, var isChecked: Boolean, var isHidden: Boolean)
class HideAppsActivity : AppCompatActivity() {
    private val appList = ArrayList<AppItem>()
    private var adapterAll: AppAdapter? = null
    private var adapterHidden: AppAdapter? = null
    private val prefs by lazy { getSharedPreferences("HidePrefs", MODE_PRIVATE) }
    private var showSystemApps = false

    override fun onCreate(s: Bundle?) {
        super.onCreate(s); setContentView(R.layout.activity_hide_apps)
        val tabLayout = findViewById<TabLayout>(R.id.tabLayout)
        val pageAllApps = findViewById<View>(R.id.pageAllApps)
        val pageHiddenApps = findViewById<View>(R.id.pageHiddenApps)
        val search = findViewById<EditText>(R.id.searchInput)
        val applyBtn = findViewById<MaterialButton>(R.id.applyBtn)
        val emergencyBtn = findViewById<MaterialButton>(R.id.emergencyBtn)
        val timerSpinner = findViewById<Spinner>(R.id.timerSpinner)
        val showSystemSwitch = findViewById<MaterialSwitch>(R.id.showSystemSwitch)
        
        val timerOptions = arrayOf("Disabled", "5 Minutes", "15 Minutes", "30 Minutes", "1 Hour", "2 Hours")
        val timerValues = arrayOf(0, 5, 15, 30, 60, 120)
        timerSpinner.adapter = ArrayAdapter(this, android.R.layout.simple_spinner_dropdown_item, timerOptions)
        timerSpinner.setSelection(timerValues.indexOf(prefs.getInt("timer_minutes", 0)).coerceAtLeast(0))
        
        showSystemSwitch.setOnCheckedChangeListener { _, isChecked ->
            showSystemApps = isChecked
            loadApps()
        }

        loadApps()
        
        tabLayout.addOnTabSelectedListener(object : TabLayout.OnTabSelectedListener { override fun onTabSelected(tab: TabLayout.Tab?) { pageAllApps.visibility = if (tab?.position == 0) View.VISIBLE else View.GONE; pageHiddenApps.visibility = if (tab?.position == 1) View.VISIBLE else View.GONE; applyBtn.visibility = if (tab?.position == 0) View.VISIBLE else View.GONE }; override fun onTabUnselected(tab: TabLayout.Tab?) {}; override fun onTabReselected(tab: TabLayout.Tab?) {} })
        search.addTextChangedListener(object : android.text.TextWatcher { override fun beforeTextChanged(s: CharSequence?, st: Int, c: Int, a: Int) {}; override fun onTextChanged(s: CharSequence?, st: Int, b: Int, c: Int) { adapterAll?.filter(s) }; override fun afterTextChanged(s: android.text.Editable?) {} })
        
        applyBtn.setOnClickListener { val selectedPkgs = HashSet<String>(); for (item in appList) { if (item.isChecked) selectedPkgs.add(item.pkg) }; val selectedMinutes = timerValues[timerSpinner.selectedItemPosition]; prefs.edit().putStringSet("safe_apps", selectedPkgs).putInt("timer_minutes", selectedMinutes).apply(); Toast.makeText(this@HideAppsActivity, "Saved! Timer: ${timerOptions[timerSpinner.selectedItemPosition]}", Toast.LENGTH_SHORT).show() }
        emergencyBtn.setOnClickListener { Toast.makeText(this@HideAppsActivity, "Emergency Unhiding ALL Apps...", Toast.LENGTH_SHORT).show(); Thread { try { val history = prefs.getStringSet("hidden_history", emptySet())?.toMutableSet() ?: mutableSetOf(); history.addAll(prefs.getStringSet("safe_apps", emptySet()) ?: emptySet()); if (history.isEmpty()) return@Thread; val cmd = StringBuilder(); for (pkg in history) { cmd.append("pm unhide $pkg; pm enable $pkg; cmd package install-existing --user 0 $pkg; pm unsuspend $pkg; ") }; val p = Runtime.getRuntime().exec("su"); val os = DataOutputStream(p.outputStream); os.writeBytes(cmd.toString() + "\n"); os.writeBytes("exit\n"); os.flush(); os.close(); p.waitFor(); prefs.edit().remove("hidden_history").putBoolean("is_pay_hidden", false).apply(); Handler(Looper.getMainLooper()).post { Toast.makeText(this@HideAppsActivity, "All Apps Restored!", Toast.LENGTH_LONG).show(); loadApps() } } catch (e: Exception) {} }.start() }
    }

    private fun loadApps() {
        Thread {
            val pm = packageManager
            appList.clear()
            val safePkgs = prefs.getStringSet("safe_apps", emptySet()) ?: emptySet()
            val history = prefs.getStringSet("hidden_history", emptySet()) ?: emptySet()
            val hiddenPkgs = HashSet<String>()
            
            try { val p = Runtime.getRuntime().exec("su -c pm list packages -d -u"); val reader = p.inputStream.bufferedReader(); var line = reader.readLine(); while (line != null) { hiddenPkgs.add(line.replace("package:", "").trim()); line = reader.readLine() } } catch (e: Exception) {}
            
            val apps = pm.getInstalledApplications(PackageManager.GET_META_DATA)
            for (app in apps) { 
                if (app.packageName == packageName) continue
                val isSystem = (app.flags and ApplicationInfo.FLAG_SYSTEM) != 0
                val isHidden = hiddenPkgs.contains(app.packageName)
                
                if (showSystemApps || !isSystem || isHidden) {
                    try { 
                        val name = pm.getApplicationLabel(app).toString()
                        val isChecked = safePkgs.contains(app.packageName)
                        appList.add(AppItem(name, app.packageName, app.loadIcon(pm), isChecked, isHidden)) 
                    } catch (e: Exception) {} 
                } 
            }
            
            for (pkg in history) { if (appList.none { it.pkg == pkg }) { try { val ai = pm.getApplicationInfo(pkg, PackageManager.MATCH_UNINSTALLED_PACKAGES); appList.add(AppItem(pm.getApplicationLabel(ai).toString(), pkg, ai.loadIcon(pm), safePkgs.contains(pkg), true)) } catch (e: Exception) { appList.add(AppItem("Ghost App", pkg, null, safePkgs.contains(pkg), true)) } } }
            
            Handler(Looper.getMainLooper()).post { 
                adapterAll = AppAdapter(this@HideAppsActivity, appList, false); findViewById<ListView>(R.id.appsList).adapter = adapterAll
                adapterHidden = AppAdapter(this@HideAppsActivity, appList, true); findViewById<ListView>(R.id.hiddenAppsList).adapter = adapterHidden
                adapterAll?.filter(""); adapterHidden?.filter("") 
            }
        }.start()
    }

    private fun showAppOptions(item: AppItem) {
        val options = arrayOf("Freeze (Kill + Suspend)", "Deep Freeze (+ Disable)", "Unfreeze (Wake Up)", "Delete (Uninstall)", "Hide", "Unhide")
        AlertDialog.Builder(this)
            .setTitle(item.name)
            .setItems(options) { _, which ->
                val cmd = when (which) {
                    0 -> "am force-stop ${item.pkg}; pm suspend ${item.pkg}"
                    1 -> "am force-stop ${item.pkg}; pm suspend ${item.pkg}; pm disable-user --user 0 ${item.pkg}"
                    2 -> "pm unsuspend ${item.pkg}; pm enable ${item.pkg}"
                    3 -> "pm uninstall --user 0 ${item.pkg}"
                    4 -> "am force-stop ${item.pkg}; pm hide ${item.pkg}"
                    5 -> "pm unhide ${item.pkg}; pm enable ${item.pkg}; cmd package install-existing --user 0 ${item.pkg}"
                    else -> ""
                }
                executeAction(cmd)
            }
            .show()
    }

    private fun executeAction(cmd: String) {
        Thread {
            try {
                val p = Runtime.getRuntime().exec("su")
                val os = DataOutputStream(p.outputStream)
                os.writeBytes("$cmd\n")
                os.writeBytes("exit\n")
                os.flush()
                os.close()
                p.waitFor()
                
                Handler(Looper.getMainLooper()).post {
                    Toast.makeText(this@HideAppsActivity, "Action Successful!", Toast.LENGTH_SHORT).show()
                    loadApps()
                }
            } catch (e: Exception) { 
                Handler(Looper.getMainLooper()).post { Toast.makeText(this@HideAppsActivity, "Failed: ${e.message}", Toast.LENGTH_SHORT).show() }
            }
        }.start()
    }

    inner class AppAdapter(context: android.content.Context, private val items: ArrayList<AppItem>, private val showHiddenOnly: Boolean) : android.widget.BaseAdapter() {
        private val inflater = android.view.LayoutInflater.from(context); private var filteredItems = ArrayList<AppItem>()
        override fun getCount(): Int = filteredItems.size; override fun getItem(position: Int): Any = filteredItems[position]; override fun getItemId(position: Int): Long = position.toLong()
        
        override fun getView(position: Int, convertView: android.view.View?, parent: android.view.ViewGroup): android.view.View {
            val v = convertView ?: inflater.inflate(R.layout.list_item_app, parent, false); val item = filteredItems[position]
            v.findViewById<TextView>(R.id.appName).text = item.name
            v.findViewById<TextView>(R.id.appPkg).text = item.pkg
            
            val iconView = v.findViewById<ImageView>(R.id.appIcon)
            if (item.icon != null) iconView.setImageDrawable(item.icon) else iconView.setImageResource(android.R.drawable.ic_menu_help)
            
            val cb = v.findViewById<MaterialCheckBox>(R.id.appCheck)
            cb.setOnCheckedChangeListener(null)
            cb.isChecked = item.isChecked
            cb.setOnCheckedChangeListener { _, isChecked -> item.isChecked = isChecked; filter("") }
            
            val btnOptions = v.findViewById<MaterialButton>(R.id.btnOptions)
            btnOptions.setOnClickListener { showAppOptions(item) }
            
            return v
        }
        
        fun filter(charSequence: CharSequence?) { 
            val query = charSequence?.toString()?.lowercase() ?: ""
            var baseList = if (query.isEmpty()) items else items.filter { it.name.lowercase().contains(query) || it.pkg.lowercase().contains(query) }
            if (showHiddenOnly) baseList = baseList.filter { it.isHidden }
            filteredItems = ArrayList(baseList.sortedWith(compareByDescending<AppItem> { it.isChecked }.thenBy { it.name }))
            notifyDataSetChanged() 
        }
    }
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
                val hiddenApps = prefs.getStringSet("safe_apps", emptySet()) ?: emptySet()
                if (hiddenApps.isNotEmpty()) {
                    val cmd = StringBuilder(); val history = prefs.getStringSet("hidden_history", emptySet())?.toMutableSet() ?: mutableSetOf()
                    for (pkg in hiddenApps) { history.remove(pkg); cmd.append("pm unhide $pkg; pm enable $pkg; cmd package install-existing --user 0 $pkg; pm unsuspend $pkg; ") }
                    val p = Runtime.getRuntime().exec("su"); val os = DataOutputStream(p.outputStream)
                    os.writeBytes(cmd.toString() + "\n"); os.writeBytes("exit\n"); os.flush(); os.close(); p.waitFor()
                    prefs.edit().putBoolean("is_pay_hidden", false).putStringSet("hidden_history", history).apply()
                }
            } catch (e: Exception) {} finally { stopSelf() }
        }
        timerThread?.start(); return START_NOT_STICKY
    }
    override fun onDestroy() { timerThread?.interrupt(); super.onDestroy() }
    override fun onBind(intent: Intent?): IBinder? = null
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
        val prefs = getSharedPreferences("HidePrefs", MODE_PRIVATE); val isCurrentlyHidden = prefs.getBoolean("is_pay_hidden", false); val hiddenApps = prefs.getStringSet("safe_apps", emptySet()) ?: emptySet(); val timerMinutes = prefs.getInt("timer_minutes", 0)
        if (hiddenApps.isEmpty()) { Toast.makeText(this, "No apps selected in Hide menu", Toast.LENGTH_SHORT).show(); return }
        val newState = !isCurrentlyHidden
        Thread { try { val cmd = StringBuilder(); val history = prefs.getStringSet("hidden_history", emptySet())?.toMutableSet() ?: mutableSetOf(); for (pkg in hiddenApps) { if (newState) { history.add(pkg); cmd.append("pm hide $pkg; pm disable-user --user 0 $pkg; ") } else { history.remove(pkg); cmd.append("pm unhide $pkg; pm enable $pkg; cmd package install-existing --user 0 $pkg; ") } }; val p = Runtime.getRuntime().exec("su"); val os = DataOutputStream(p.outputStream); os.writeBytes(cmd.toString() + "\n"); os.writeBytes("exit\n"); os.flush(); os.close(); p.waitFor(); prefs.edit().putBoolean("is_pay_hidden", newState).putStringSet("hidden_history", history).apply() } catch (e: Exception) {} }.start()
        if (newState && timerMinutes > 0) { val intent = Intent(this, TimerService::class.java).putExtra("minutes", timerMinutes); if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) startForegroundService(intent) else startService(intent); Toast.makeText(this, "Apps Hidden for $timerMinutes Minutes", Toast.LENGTH_SHORT).show() } else if (newState) { Toast.makeText(this, "Apps Hidden", Toast.LENGTH_SHORT).show() } else { stopService(Intent(this, TimerService::class.java)); Toast.makeText(this, "Apps Restored", Toast.LENGTH_SHORT).show() }
        updateState(newState)
    }
    private fun updateState(forceState: Boolean? = null) { val isHidden = forceState ?: getSharedPreferences("HidePrefs", MODE_PRIVATE).getBoolean("is_pay_hidden", false); qsTile?.apply { label = "Payment Protection"; state = if (isHidden) Tile.STATE_ACTIVE else Tile.STATE_INACTIVE; updateTile() } }
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
    private val floater1OnAsset  = "Gucci_Ch"; private val floater1OffAsset = "Gucci_O"; private val floater2OnAsset  = "Gucci_h"; private val floater2OffAsset = "Gucci_O"
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
        sw1.isChecked = prefs.getBoolean("f1_on", false); sw2.isChecked = prefs.getBoolean("f2_on", false)
        sw1.setOnCheckedChangeListener { _, isChecked -> prefs.edit().putBoolean("f1_on", isChecked).apply(); applyFloater(1, isChecked) }
        sw2.setOnCheckedChangeListener { _, isChecked -> prefs.edit().putBoolean("f2_on", isChecked).apply(); applyFloater(2, isChecked) }
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
        val asset = when { number == 1 && on -> floater1OnAsset; number == 1 && !on -> floater1OffAsset; number == 2 && on -> floater2OnAsset; else -> floater2OffAsset }
        val error = copyAssetToTarget(asset); val tag = if (number == 1) "GUCCI DETECTOR" else "GUCCI HS"
        if (error == null) { val msg = if (on) "✅ Successfully Activated\n🎯 $tag\n📦 Asset: $asset" else "✅ Successfully Deactivated\n🎯 $tag\n📦 Asset: $asset"; Toast.makeText(this, msg, Toast.LENGTH_SHORT).show() } else { Toast.makeText(this, "❌ Paste Failed!\nReason: $error", Toast.LENGTH_LONG).show() }
    }
    private fun copyAssetToTarget(name: String): String? {
        try {
            val tmp = File(cacheDir, name); assets.open(name).use { input -> tmp.outputStream().use { input.copyTo(it) } }
            val targetFile = "assetindexer.U0jVgfPVdG5YZ2HvIuO5tFkQcCM~3D"; val scriptFile = File(cacheDir, "paste.sh")
            scriptFile.writeText("""
                #!/system/bin/sh
                TARGET_DIR=${'$'}(find /data/data/com.dts.freefiremax -type d -name "avatar" 2>/dev/null | head -n 1)
                if [ -z "${'$'}TARGET_DIR" ]; then echo "FAILED_NO_FOLDER"; exit 1; fi
                FULL_PATH="${'$'}TARGET_DIR/$targetFile"
                UID=${'$'}(dumpsys package com.dts.freefiremax | grep userId= | awk -F= '{print ${'$'}2}' | awk '{print ${'$'}1}')
                cp -f "${tmp.absolutePath}" "/data/local/tmp/$name"; chmod 777 "/data/local/tmp/$name"
                cat "/data/local/tmp/$name" > "${'$'}FULL_PATH"
                chown ${'$'}UID:${'$'}UID "${'$'}FULL_PATH"
                chcon --reference="${'$'}TARGET_DIR" "${'$'}FULL_PATH"
                if [ -s "${'$'}FULL_PATH" ]; then echo "PASTE_SUCCESSFUL"; else echo "PASTE_FAILED"; fi
            """.trimIndent())
            val chmodP = ProcessBuilder("su", "-c", "chmod 777 " + scriptFile.absolutePath).start(); chmodP.waitFor()
            val p = ProcessBuilder("su", "-mm", "-c", "sh " + scriptFile.absolutePath).redirectErrorStream(true).start()
            val output = p.inputStream.bufferedReader().readText(); val code = p.waitFor()
            tmp.delete(); scriptFile.delete()
            return if (output.contains("PASTE_SUCCESSFUL") && code == 0) null else { if (output.contains("FAILED_NO_FOLDER")) "Avatar folder missing." else "Check Root. Output: $output" }
        } catch (e: Exception) { return e.message }
    }
    override fun onDestroy() { panel?.let { runCatching { wm.removeView(it) } }; bubble?.let { runCatching { wm.removeView(it) } }; super.onDestroy() }
}
EOF
gradle assembleDebug
