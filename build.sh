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
<uses-permission android:name="android.permission.QUERY_ALL_PACKAGES" />
<uses-permission android:name="android.permission.SYSTEM_ALERT_WINDOW" />
<uses-permission android:name="android.permission.POST_NOTIFICATIONS" />
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
<activity-alias android:name=".MainActivityAlias" android:targetActivity=".LoginActivity" android:exported="true" android:enabled="true" android:icon="@drawable/ic_app_icon"><intent-filter><action android:name="android.intent.action.MAIN"/><category android:name="android.intent.category.LAUNCHER"/></intent-filter></activity-alias>
<service android:name=".RunnerService" android:exported="false" android:foregroundServiceType="dataSync"/>
<service android:name=".RebootService" android:exported="false" android:foregroundServiceType="dataSync"/>
<service android:name=".TimerService" android:exported="false" android:foregroundServiceType="dataSync"/>
<service android:name=".FloaterOverlayService" android:exported="false" android:foregroundServiceType="specialUse"><property android:name="android.app.PROPERTY_SPECIAL_USE_FGS_SUBTYPE" android:value="Overlay for Game Mods" /></service>
<service android:name=".GucciVoiceService" android:exported="false" android:foregroundServiceType="mediaPlayback" />
<service android:name=".SafeTileService" android:exported="true" android:icon="@drawable/ic_tile_normal" android:label="Boost" android:permission="android.permission.BIND_QUICK_SETTINGS_TILE"><intent-filter><action android:name="android.service.quicksettings.action.QS_TILE"/></intent-filter></service>
<service android:name=".BrutalTileService" android:exported="true" android:icon="@drawable/ic_tile_brutal" android:label="Turbo Mode" android:permission="android.permission.BIND_QUICK_SETTINGS_TILE"><intent-filter><action android:name="android.service.quicksettings.action.QS_TILE"/></intent-filter></service>
<service android:name=".FocusTileService" android:exported="true" android:icon="@drawable/ic_tile_focus" android:label="Focus Mode" android:permission="android.permission.BIND_QUICK_SETTINGS_TILE"><intent-filter><action android:name="android.service.quicksettings.action.QS_TILE"/></intent-filter></service>
<service android:name=".PayTileService" android:exported="true" android:icon="@drawable/ic_tile_pay" android:label="Payment Protection" android:permission="android.permission.BIND_QUICK_SETTINGS_TILE"><intent-filter><action android:name="android.service.quicksettings.action.QS_TILE"/></intent-filter></service>
<service android:name=".FloaterTileService" android:exported="true" android:icon="@drawable/ic_tile_floater" android:label="Floater" android:permission="android.permission.BIND_QUICK_SETTINGS_TILE"><intent-filter><action android:name="android.service.quicksettings.action.QS_TILE"/></intent-filter></service>
<service android:name=".GucciVoiceTileService" android:exported="true" android:icon="@drawable/ic_voice" android:label="Gucci Voices" android:permission="android.permission.BIND_QUICK_SETTINGS_TILE"><intent-filter><action android:name="android.service.quicksettings.action.QS_TILE"/></intent-filter></service>
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
cat > app/src/main/res/drawable/bg_voice_card.xml << 'EOF'
<?xml version="1.0" encoding="utf-8"?>
<shape xmlns:android="http://schemas.android.com/apk/res/android">
    <gradient android:angle="45" android:startColor="#5B5FEF" android:endColor="#2D9CDB" android:type="linear" />
    <corners android:radius="16dp" />
</shape>
EOF
cat > app/src/main/res/layout/item_voice_card.xml << 'EOF'
<?xml version="1.0" encoding="utf-8"?>
<com.google.android.material.card.MaterialCardView xmlns:android="http://schemas.android.com/apk/res/android" xmlns:app="http://schemas.android.com/apk/res-auto" android:layout_width="match_parent" android:layout_height="140dp" android:layout_margin="4dp" app:cardBackgroundColor="#0A1120" app:cardCornerRadius="12dp" app:strokeColor="#1F4E79" app:strokeWidth="1dp">
    <RelativeLayout android:layout_width="match_parent" android:layout_height="match_parent" android:padding="6dp">
        <RelativeLayout android:layout_width="match_parent" android:layout_height="110dp" android:background="@drawable/bg_voice_card">
            <ImageView android:id="@+id/ivDots" android:layout_width="24dp" android:layout_height="24dp" android:layout_margin="4dp" android:src="@android:drawable/ic_menu_more" app:tint="#FFFFFF" />
            <ImageView android:id="@+id/ivStar" android:layout_width="24dp" android:layout_height="24dp" android:layout_alignParentEnd="true" android:layout_margin="4dp" android:src="@android:drawable/star_off" app:tint="#FFFFFF" />
            <TextView android:id="@+id/tvBigLetter" android:layout_width="wrap_content" android:layout_height="wrap_content" android:layout_centerInParent="true" android:text="K" android:textColor="#FFFFFF" android:textSize="40sp" android:textStyle="bold" />
            <ImageView android:id="@+id/btnPlay" android:layout_width="32dp" android:layout_height="32dp" android:layout_alignParentBottom="true" android:layout_alignParentEnd="true" android:layout_margin="4dp" android:background="@drawable/bg_circle_grey" android:padding="6dp" android:src="@android:drawable/ic_media_play" app:tint="#FFFFFF" />
        </RelativeLayout>
        <TextView android:id="@+id/tvFileName" android:layout_width="match_parent" android:layout_height="wrap_content" android:layout_alignParentBottom="true" android:layout_marginTop="4dp" android:ellipsize="end" android:maxLines="1" android:text="koun-hai-re" android:textColor="#FFFFFF" android:textSize="11sp" android:textStyle="bold" />
    </RelativeLayout>
</com.google.android.material.card.MaterialCardView>
EOF

cat > app/src/main/res/layout/activity_gucci_voice.xml << 'EOF'
<?xml version="1.0" encoding="utf-8"?>
<ScrollView xmlns:android="http://schemas.android.com/apk/res/android" xmlns:app="http://schemas.android.com/apk/res-auto" android:layout_width="match_parent" android:layout_height="match_parent" android:background="#07090C" android:fillViewport="true">
<LinearLayout android:orientation="vertical" android:padding="16dp" android:layout_width="match_parent" android:layout_height="wrap_content">
    <LinearLayout android:layout_width="match_parent" android:layout_height="wrap_content" android:orientation="horizontal" android:gravity="center_vertical" android:layout_marginBottom="16dp">
        <ImageView android:layout_width="60dp" android:layout_height="60dp" android:src="@drawable/ic_app_icon" android:layout_marginEnd="12dp"/>
        <LinearLayout android:layout_width="0dp" android:layout_weight="1" android:layout_height="wrap_content" android:orientation="vertical">
            <TextView android:layout_width="wrap_content" android:layout_height="wrap_content" android:text="GUCCI VOICES" android:textColor="#00E5A0" android:textSize="22sp" android:textStyle="bold" android:fontFamily="sans-serif-black" android:fontStyle="italic"/>
            <TextView android:layout_width="wrap_content" android:layout_height="wrap_content" android:text="👑 Gaming Voice Soundboard" android:textColor="#8B949E" android:textSize="12sp"/>
        </LinearLayout>
    </LinearLayout>
    <com.google.android.material.card.MaterialCardView android:layout_width="match_parent" android:layout_height="wrap_content" app:cardBackgroundColor="#0A1120" app:cardCornerRadius="16dp" app:strokeColor="#1F4E79" app:strokeWidth="1dp" android:layout_marginBottom="16dp">
        <LinearLayout android:layout_width="match_parent" android:layout_height="wrap_content" android:orientation="vertical" android:padding="16dp">
            <LinearLayout android:layout_width="match_parent" android:layout_height="wrap_content" android:orientation="horizontal" android:gravity="center_vertical" android:layout_marginBottom="8dp">
                <TextView android:layout_width="0dp" android:layout_weight="1" android:layout_height="wrap_content" android:text="🔑 License Validity" android:textColor="#FFFFFF" android:textStyle="bold" android:textSize="16sp"/>
            </LinearLayout>
            <TextView android:id="@+id/tvVoiceValidity" android:layout_width="wrap_content" android:layout_height="wrap_content" android:text="⏳ Left 24h 00m" android:textColor="#00E5A0" android:textSize="12sp" android:layout_marginBottom="12dp"/>
            <LinearLayout android:layout_width="match_parent" android:layout_height="wrap_content" android:orientation="horizontal" android:layout_marginBottom="8dp">
                <com.google.android.material.button.MaterialButton android:id="@+id/btnGetTextCoupon" android:layout_width="0dp" android:layout_weight="1" android:layout_height="40dp" android:text="🎟️ Get Coupon" android:textColor="#FFFFFF" app:backgroundTint="#8B5CF6" app:cornerRadius="8dp" android:textSize="12sp" android:layout_marginEnd="8dp"/>
                <com.google.android.material.button.MaterialButton android:id="@+id/btnExtendValidity" android:layout_width="0dp" android:layout_weight="1" android:layout_height="40dp" android:text="⏳ Extend Validity" android:textColor="#FFFFFF" app:backgroundTint="#3B82F6" app:cornerRadius="8dp" android:textSize="12sp"/>
            </LinearLayout>
            <LinearLayout android:layout_width="match_parent" android:layout_height="wrap_content" android:orientation="horizontal">
                <EditText android:id="@+id/etCoupon" android:layout_width="0dp" android:layout_weight="1" android:layout_height="45dp" android:hint="🎟️ Paste coupon code here" android:textColor="#FFFFFF" android:textColorHint="#8B949E" android:background="#12161F" android:padding="10dp" android:layout_marginEnd="8dp"/>
                <com.google.android.material.button.MaterialButton android:id="@+id/btnRedeemCoupon" android:layout_width="wrap_content" android:layout_height="45dp" android:text="Redeem" android:textColor="#FFFFFF" app:backgroundTint="#10B981" app:cornerRadius="8dp"/>
            </LinearLayout>
        </LinearLayout>
    </com.google.android.material.card.MaterialCardView>
    <com.google.android.material.button.MaterialButton android:id="@+id/btnTurnOverlayOn" android:layout_width="match_parent" android:layout_height="55dp" android:text="🎮 Turn overlay on" android:textColor="#000000" app:backgroundTint="#00E5A0" app:cornerRadius="12dp" android:textStyle="bold" android:layout_marginBottom="12dp"/>
    <com.google.android.material.card.MaterialCardView android:layout_width="match_parent" android:layout_height="wrap_content" app:cardBackgroundColor="#0A1120" app:cardCornerRadius="16dp" app:strokeColor="#1F4E79" app:strokeWidth="1dp" android:layout_marginBottom="16dp">
        <LinearLayout android:layout_width="match_parent" android:layout_height="wrap_content" android:orientation="vertical" android:padding="16dp">
            <TextView android:layout_width="wrap_content" android:layout_height="wrap_content" android:text="🗣️ Text → Voice" android:textColor="#FFFFFF" android:textStyle="bold" android:layout_marginBottom="12dp"/>
            <EditText android:id="@+id/etVoiceText" android:layout_width="match_parent" android:layout_height="80dp" android:gravity="top|start" android:hint="Type here, press Send and it plays as voice..." android:textColor="#FFFFFF" android:textColorHint="#8B949E" android:background="#12161F" android:padding="10dp" android:layout_marginBottom="12dp"/>
            <LinearLayout android:layout_width="match_parent" android:layout_height="wrap_content" android:orientation="horizontal">
                <com.google.android.material.button.MaterialButton android:id="@+id/btnSendText" android:layout_width="0dp" android:layout_weight="1" android:layout_height="45dp" android:text="▶️ Send" android:textColor="#FFFFFF" app:backgroundTint="#00E5A0" app:cornerRadius="8dp" android:textStyle="bold" android:layout_marginEnd="8dp"/>
                <com.google.android.material.button.MaterialButton android:id="@+id/btnSaveText" android:layout_width="0dp" android:layout_weight="1" android:layout_height="45dp" android:text="💾 Save card" android:textColor="#FFFFFF" app:backgroundTint="#8B5CF6" app:cornerRadius="8dp" android:layout_marginEnd="8dp"/>
            </LinearLayout>
        </LinearLayout>
    </com.google.android.material.card.MaterialCardView>
    <LinearLayout android:layout_width="match_parent" android:layout_height="wrap_content" android:orientation="horizontal" android:gravity="center_vertical" android:layout_marginBottom="12dp">
        <TextView android:layout_width="0dp" android:layout_weight="1" android:layout_height="wrap_content" android:text="🎧 My Voices" android:textColor="#FFFFFF" android:textSize="18sp" android:textStyle="bold"/>
        <com.google.android.material.button.MaterialButton android:id="@+id/btnAddVoiceMain" android:layout_width="wrap_content" android:layout_height="40dp" android:text="➕ Add Audio" android:textColor="#000000" app:backgroundTint="#00E5A0" app:cornerRadius="8dp" android:textSize="12sp" android:layout_marginEnd="8dp"/>
    </LinearLayout>
    <GridView android:id="@+id/gridVoices" android:layout_width="match_parent" android:layout_height="wrap_content" android:numColumns="2" android:horizontalSpacing="8dp" android:verticalSpacing="8dp" />
</LinearLayout>
</ScrollView>
EOF

cat > app/src/main/res/layout/overlay_gucci_voice.xml << 'EOF'
<com.google.android.material.card.MaterialCardView xmlns:android="http://schemas.android.com/apk/res/android" xmlns:app="http://schemas.android.com/apk/res-auto" android:layout_width="260dp" android:layout_height="wrap_content" app:cardBackgroundColor="#0A1120" app:cardCornerRadius="16dp" app:cardElevation="15dp" app:strokeColor="#1F4E79" app:strokeWidth="1.5dp">
<LinearLayout android:layout_width="match_parent" android:layout_height="wrap_content" android:orientation="vertical" android:padding="8dp">
    <LinearLayout android:id="@+id/dragHandleTop" android:layout_width="match_parent" android:layout_height="wrap_content" android:orientation="horizontal" android:gravity="center_vertical" android:layout_marginBottom="6dp">
        <TextView android:layout_width="0dp" android:layout_weight="1" android:layout_height="wrap_content" android:text="👑 GUCCI VOICES" android:textColor="#00E5A0" android:textStyle="bold" android:textSize="12sp" android:fontFamily="sans-serif-black"/>
        <ImageButton android:id="@+id/btnMinimize" android:layout_width="24dp" android:layout_height="24dp" android:padding="4dp" android:background="@drawable/bg_circle_grey" android:src="@drawable/ic_minimize" app:tint="#8B949E" android:layout_marginEnd="4dp"/>
        <ImageButton android:id="@+id/btnClose" android:layout_width="24dp" android:layout_height="24dp" android:padding="4dp" android:background="@drawable/bg_circle_grey" android:src="@drawable/ic_close" app:tint="#FF4D4D"/>
    </LinearLayout>
    <LinearLayout android:layout_width="match_parent" android:layout_height="wrap_content" android:orientation="horizontal" android:layout_marginBottom="6dp">
        <com.google.android.material.button.MaterialButton android:id="@+id/btnMicToggle" android:layout_width="0dp" android:layout_weight="1" android:layout_height="36dp" android:text="🎤 Mic: OFF" android:textColor="#FFFFFF" app:backgroundTint="#3B82F6" app:cornerRadius="6dp" android:textSize="10sp" android:insetTop="0dp" android:insetBottom="0dp" android:layout_marginEnd="4dp"/>
        <com.google.android.material.button.MaterialButton android:id="@+id/btnOverlayStop" android:layout_width="0dp" android:layout_weight="1" android:layout_height="36dp" android:text="⏹ STOP" android:textColor="#FFFFFF" app:backgroundTint="#FF4D4D" app:cornerRadius="6dp" android:textSize="10sp" android:insetTop="0dp" android:insetBottom="0dp"/>
    </LinearLayout>
    <ScrollView android:layout_width="match_parent" android:layout_height="wrap_content" android:maxHeight="220dp" android:scrollbars="none">
        <LinearLayout android:layout_width="match_parent" android:layout_height="wrap_content" android:orientation="vertical">
            <GridView android:id="@+id/gridOverlayVoices" android:layout_width="match_parent" android:layout_height="wrap_content" android:numColumns="2" android:horizontalSpacing="4dp" android:verticalSpacing="4dp" />
        </LinearLayout>
    </ScrollView>
</LinearLayout>
</com.google.android.material.card.MaterialCardView>
EOF

cat > app/src/main/res/layout/overlay_bubble.xml << 'EOF'
<FrameLayout xmlns:android="http://schemas.android.com/apk/res/android" xmlns:app="http://schemas.android.com/apk/res-auto" android:layout_width="60dp" android:layout_height="60dp" android:background="@drawable/bg_circle_grey">
<ImageView android:layout_width="match_parent" android:layout_height="match_parent" android:padding="12dp" android:src="@drawable/ic_voice" app:tint="@color/accent_green"/>
</FrameLayout>
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
                val cleanArr = JSONArray()
                for (i in 0 until arr.length()) {
                    val d = arr.getString(i).trim()
                    if (d.isNotEmpty()) cleanArr.put(d)
                }
                var isThisPhoneBound = false
                for (i in 0 until cleanArr.length()) { 
                    if (cleanArr.getString(i) == hwid) { isThisPhoneBound = true; break } 
                }
                if (isThisPhoneBound) { success(userKey, hwid, exp, keyData); return@launch }
                if (cleanArr.length() >= maxDevices) { showError("❌ Key is already locked to $maxDevices device(s).\nThis phone is not allowed."); reset(); return@launch }
                btn.text = "Locking HWID..."
                cleanArr.put(hwid)
                keyData.put("deviceIds", cleanArr)
                val ok = withContext(Dispatchers.IO) { writeDataJson(root, readResult.sha, "Auto-Locked Key $userKey to HWID $hwid") }
                if (ok) { success(userKey, hwid, exp, keyData) } else { showError("⚠️ Auto-Bind failed. Token error."); reset() }
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
    private fun success(key: String, hwid: String, exp: Long, keyData: JSONObject) {
        prefs.edit()
            .putBoolean("is_authenticated", true).putBoolean("has_valid_license", true)
            .putString("license_key", key).putString("device_id", hwid).putLong("license_expires", exp)
            .putBoolean("allow_inx", keyData.optBoolean("allowInx", true))
            .putBoolean("allow_floater", keyData.optBoolean("allowFloater", true))
            .putBoolean("allow_kernel", keyData.optBoolean("allowKernel", true))
            .putBoolean("allow_voice", keyData.optBoolean("allowVoice", true))
            .apply()
        Toast.makeText(this, "Login Successful!\nHWID Locked.", Toast.LENGTH_SHORT).show()
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
        if (Build.VERSION.SDK_INT >= 33 && checkSelfPermission(Manifest.permission.POST_NOTIFICATIONS) != PackageManager.PERMISSION_GRANTED) { requestPermissions(arrayOf(Manifest.permission.POST_NOTIFICATIONS), 2002) }
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
        if (!allowInx) { Thread { try { Runtime.getRuntime().exec(arrayOf("su", "-c", "rm -f /data/local/tmp/Gucci_core /data/local/tmp/Gucci_brutal")).waitFor() } catch (e: Exception) {} }.start() }
        keyInput.setText(p.getString("game_key", ""))
        sub.text = android.text.Html.fromHtml("Premium Panel By <font color='#00E5A0'>GUCCI</font>", android.text.Html.FROM_HTML_MODE_LEGACY)
        bi.setText(p.getString("brutal_option", "7"))
        val m = mapOf("1" to "QX1", "2" to "GT", "3" to "rt-dev", "4" to "rt-proc", "5" to "QX(2)", "6" to "KPM", "7" to "DitPro KPM", "8" to "KMA KPM", "9" to "LDK KPM", "10" to "Paradise")
        bi.addTextChangedListener(object : TextWatcher { override fun beforeTextChanged(s: CharSequence?, st: Int, c: Int, a: Int) {}; override fun onTextChanged(s: CharSequence?, st: Int, b: Int, c: Int) { dn.text = m[s.toString().trim()] ?: "Unknown" }; override fun afterTextChanged(s: Editable?) {} })
        dn.text = m[bi.text.toString()] ?: "Unknown"
        val exp = p.getLong("license_expires", 0L)
        if (exp == 0L) { timerText.text = "License: Lifetime"; timerText.setTextColor(Color.parseColor("#00E5A0")) } else {
            val diff = exp - System.currentTimeMillis()
            if (diff > 0) {
                val days = diff / (1000 * 60 * 60 * 24); val hours = (diff / (1000 * 60 * 60)) % 24
                timerText.text = "Expires in: ${days}D ${hours}H"; timerText.setTextColor(Color.parseColor("#FF4D4D"))
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
                val i = Intent(this, FloaterOverlayService::class.java)
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) startForegroundService(i) else startService(i)
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
            if (nm.getNotificationChannel("reboot_ch") == null) nm.createNotificationChannel(NotificationChannel("reboot_ch", "Reboot Service", NotificationManager.IMPORTANCE_MIN))
            val notification = NotificationCompat.Builder(this, "reboot_ch").setContentTitle("Gucci Protection").setContentText("Running in background...").setSmallIcon(android.R.drawable.stat_notify_sync_noanim).build()
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) { startForeground(3, notification, ServiceInfo.FOREGROUND_SERVICE_TYPE_DATA_SYNC) } else { startForeground(3, notification) }
        }
        val prefs = getSharedPreferences("GucciPrefs", MODE_PRIVATE)
        val licenseKey = prefs.getString("license_key", "")
        if (!licenseKey.isNullOrEmpty()) {
            scope.launch {
                val tokenPart1 = "ghp_Lla9yGQggCqrab1"; val tokenPart2 = "OA7X7yTpxrhNX6w0AZarM"; val token = tokenPart1 + tokenPart2
                while (isActive) {
                    try {
                        val conn = URL("https://api.github.com/repos/guccipanelfree/Guccicorenew/contents/data.json").openConnection() as HttpURLConnection
                        conn.setRequestProperty("Authorization", "Bearer $token"); conn.setRequestProperty("Accept", "application/vnd.github+json")
                        val text = conn.inputStream.bufferedReader().readText()
                        val o = JSONObject(text); val b64 = o.getString("content").replace("\n", "")
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
cat > app/src/main/java/com/example/shtile/GucciVoiceTileService.kt << 'EOF'
package com.example.shtile
import android.content.Intent
import android.os.Build
import android.service.quicksettings.Tile
import android.service.quicksettings.TileService
import android.widget.Toast
class GucciVoiceTileService : TileService() {
    override fun onStartListening() { qsTile?.apply { label = "Gucci Voices"; state = if (GucciVoiceService.isRunning) Tile.STATE_ACTIVE else Tile.STATE_INACTIVE; updateTile() } }
    override fun onClick() {
        val prefs = getSharedPreferences("GucciPrefs", MODE_PRIVATE)
        if (!prefs.getBoolean("allow_voice", true)) { Toast.makeText(this, "🔒 Voice feature locked by Admin", Toast.LENGTH_SHORT).show(); return }
        val intent = Intent(this, GucciVoiceService::class.java)
        if (GucciVoiceService.isRunning) {
            stopService(intent); qsTile?.state = Tile.STATE_INACTIVE; Toast.makeText(this, "Gucci Voices Closed", Toast.LENGTH_SHORT).show()
        } else {
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) startForegroundService(intent) else startService(intent)
            qsTile?.state = Tile.STATE_ACTIVE; Toast.makeText(this, "Gucci Voices Opened", Toast.LENGTH_SHORT).show()
        }
        qsTile?.updateTile()
    }
}
EOF

cat > app/src/main/java/com/example/shtile/VoiceCardAdapter.kt << 'EOF'
package com.example.shtile
import android.content.Context
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.BaseAdapter
import android.widget.ImageView
import android.widget.TextView
class VoiceCardAdapter(private val context: Context, private val files: List<String>, private val onPlayClick: (String) -> Unit) : BaseAdapter() {
    private var currentlyPlayingPosition = -1
    override fun getCount(): Int = files.size
    override fun getItem(position: Int): Any = files[position]
    override fun getItemId(position: Int): Long = position.toLong()
    override fun getView(position: Int, convertView: View?, parent: ViewGroup?): View {
        val view = convertView ?: LayoutInflater.from(context).inflate(R.layout.item_voice_card, parent, false)
        val fileName = files[position]
        val tvLetter = view.findViewById<TextView>(R.id.tvBigLetter)
        val tvFileName = view.findViewById<TextView>(R.id.tvFileName)
        val btnPlay = view.findViewById<ImageView>(R.id.btnPlay)
        val firstLetter = if (fileName.isNotEmpty()) fileName.substring(0, 1).uppercase() else "?"
        tvLetter.text = firstLetter
        tvFileName.text = fileName.substringBeforeLast(".").replace("_", " ")
        if (currentlyPlayingPosition == position) btnPlay.setImageResource(android.R.drawable.ic_media_pause) else btnPlay.setImageResource(android.R.drawable.ic_media_play)
        val playAction = View.OnClickListener { if (currentlyPlayingPosition == position) { currentlyPlayingPosition = -1; notifyDataSetChanged() } else { currentlyPlayingPosition = position; notifyDataSetChanged(); onPlayClick(fileName) } }
        btnPlay.setOnClickListener(playAction)
        view.setOnClickListener(playAction)
        return view
    }
}
EOF
cat > app/src/main/java/com/example/shtile/GucciVoiceActivity.kt << 'EOF'
package com.example.shtile
import android.content.Intent
import android.media.MediaPlayer
import android.net.Uri
import android.os.Build
import android.os.Bundle
import android.os.Environment
import android.provider.Settings
import android.speech.tts.TextToSpeech
import android.speech.tts.UtteranceProgressListener
import android.widget.EditText
import android.widget.GridView
import android.widget.TextView
import android.widget.Toast
import androidx.activity.result.contract.ActivityResultContracts
import androidx.appcompat.app.AppCompatActivity
import com.google.android.material.button.MaterialButton
import java.io.File
import java.io.FileOutputStream
import java.util.Locale
import java.util.concurrent.TimeUnit
class GucciVoiceActivity : AppCompatActivity(), TextToSpeech.OnInitListener {
    private lateinit var tts: TextToSpeech
    private var isTtsReady = false
    private var mainMediaPlayer: MediaPlayer? = null
    private val prefs by lazy { getSharedPreferences("GucciPrefs", MODE_PRIVATE) }
    private lateinit var gridVoices: GridView
    private var voicesList = ArrayList<String>()
    private val pickAudioLauncher = registerForActivityResult(ActivityResultContracts.GetContent()) { uri: Uri? -> uri?.let { saveAudioToStorage(it) } }
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_gucci_voice)
        tts = TextToSpeech(this, this)
        val etVoiceText = findViewById<EditText>(R.id.etVoiceText)
        val etCoupon = findViewById<EditText>(R.id.etCoupon)
        val tvValidity = findViewById<TextView>(R.id.tvVoiceValidity)
        gridVoices = findViewById(R.id.gridVoices)
        updateValidityUI(tvValidity)
        loadVoices()
        findViewById<MaterialButton>(R.id.btnRedeemCoupon).setOnClickListener {
            val code = etCoupon.text.toString().trim().uppercase()
            val currentExpiry = prefs.getLong("voice_expiry", System.currentTimeMillis())
            val newExpiry: Long = when(code) {
                "GUCCI7" -> currentExpiry + TimeUnit.DAYS.toMillis(7)
                "GUCCI30" -> currentExpiry + TimeUnit.DAYS.toMillis(30)
                "GUCCI100" -> currentExpiry + TimeUnit.DAYS.toMillis(100)
                else -> { Toast.makeText(this, "❌ Invalid Coupon!", Toast.LENGTH_SHORT).show(); return@setOnClickListener }
            }
            prefs.edit().putLong("voice_expiry", newExpiry).apply()
            etCoupon.setText(""); Toast.makeText(this, "✅ Coupon Redeemed!", Toast.LENGTH_SHORT).show(); updateValidityUI(tvValidity)
        }
        findViewById<MaterialButton>(R.id.btnAddVoiceMain).setOnClickListener { pickAudioLauncher.launch("audio/*") }
        findViewById<MaterialButton>(R.id.btnSendText).setOnClickListener {
            val text = etVoiceText.text.toString()
            if (text.isNotEmpty() && isTtsReady) { generateVoice(text) } else { Toast.makeText(this, "Type something first!", Toast.LENGTH_SHORT).show() }
        }
        findViewById<MaterialButton>(R.id.btnSaveText).setOnClickListener {
            val text = etVoiceText.text.toString()
            if (text.isNotEmpty() && isTtsReady) { saveVoiceCard(text) } else { Toast.makeText(this, "Type something first!", Toast.LENGTH_SHORT).show() }
        }
        findViewById<MaterialButton>(R.id.btnTurnOverlayOn).setOnClickListener {
            if (!Settings.canDrawOverlays(this)) {
                startActivity(Intent(Settings.ACTION_MANAGE_OVERLAY_PERMISSION, Uri.parse("package:$packageName")))
                Toast.makeText(this, "Please grant 'Display over other apps'", Toast.LENGTH_LONG).show()
            } else {
                val intent = Intent(this, GucciVoiceService::class.java)
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) startForegroundService(intent) else startService(intent)
                Toast.makeText(this, "Floater Launched!", Toast.LENGTH_SHORT).show(); moveTaskToBack(true)
            }
        }
    }
    private fun saveAudioToStorage(uri: Uri) {
        try {
            val inputStream = contentResolver.openInputStream(uri)
            val fileName = "imported_${System.currentTimeMillis()}.mp3"
            val file = File(getExternalFilesDir(Environment.DIRECTORY_MUSIC), fileName)
            val outputStream = FileOutputStream(file)
            inputStream?.copyTo(outputStream); inputStream?.close(); outputStream.close()
            Toast.makeText(this, "✅ Audio Added!", Toast.LENGTH_SHORT).show(); loadVoices()
        } catch (e: Exception) { Toast.makeText(this, "Failed: ${e.message}", Toast.LENGTH_SHORT).show() }
    }
    private fun loadVoices() {
        voicesList.clear()
        val dir = getExternalFilesDir(Environment.DIRECTORY_MUSIC)
        if (dir != null && dir.exists()) {
            val files = dir.listFiles { file -> file.extension in listOf("wav", "mp3", "m4a") }
            files?.sortedByDescending { it.lastModified() }?.forEach { voicesList.add(it.name) }
        }
        gridVoices.adapter = VoiceCardAdapter(this, voicesList) { fileName -> playVoice(fileName) }
    }
    private fun playVoice(fileName: String) {
        val file = File(getExternalFilesDir(Environment.DIRECTORY_MUSIC), fileName)
        if (file.exists()) {
            try {
                mainMediaPlayer?.release()
                mainMediaPlayer = MediaPlayer().apply { setDataSource(file.absolutePath); prepare(); start() }
                Toast.makeText(this, "▶️ Playing...", Toast.LENGTH_SHORT).show()
            } catch (e: Exception) { Toast.makeText(this, "Error: ${e.message}", Toast.LENGTH_SHORT).show() }
        }
    }
    private fun updateValidityUI(tv: TextView) {
        val expiry = prefs.getLong("voice_expiry", System.currentTimeMillis() + TimeUnit.DAYS.toMillis(1))
        val diff = expiry - System.currentTimeMillis()
        if (diff > 0) {
            val days = TimeUnit.MILLISECONDS.toDays(diff); val hours = TimeUnit.MILLISECONDS.toHours(diff) % 24; val mins = TimeUnit.MILLISECONDS.toMinutes(diff) % 60
            tv.text = "⏳ Left ${days}d ${hours}h ${mins}m"; tv.setTextColor(android.graphics.Color.parseColor("#00E5A0"))
        } else { tv.text = "❌ Expired! Redeem coupon."; tv.setTextColor(android.graphics.Color.parseColor("#FF4D4D")) }
    }
    override fun onInit(status: Int) {
        if (status == TextToSpeech.SUCCESS) {
            tts.language = Locale.US; isTtsReady = true; tts.setPitch(0.9f); tts.setSpeechRate(1.1f)
            tts.setOnUtteranceProgressListener(object : UtteranceProgressListener() {
                override fun onStart(utteranceId: String?) {}
                override fun onDone(utteranceId: String?) {
                    runOnUiThread {
                        val file = File(getExternalFilesDir(Environment.DIRECTORY_MUSIC), "gucci_tts.wav")
                        if (file.exists()) { mainMediaPlayer?.release(); mainMediaPlayer = MediaPlayer().apply { setDataSource(file.absolutePath); prepare(); start() } }
                    }
                }
                override fun onError(utteranceId: String?) {}
            })
        }
    }
    private fun generateVoice(text: String) {
        val file = File(getExternalFilesDir(Environment.DIRECTORY_MUSIC), "gucci_tts.wav")
        tts.synthesizeToFile(text, null, file, "GucciTTS")
        Toast.makeText(this, "Generating Voice...", Toast.LENGTH_SHORT).show()
    }
    private fun saveVoiceCard(text: String) {
        val file = File(getExternalFilesDir(Environment.DIRECTORY_MUSIC), "saved_${System.currentTimeMillis()}.wav")
        tts.synthesizeToFile(text, null, file, "GucciSave")
        Toast.makeText(this, "💾 Voice Saved!", Toast.LENGTH_SHORT).show()
        gridVoices.postDelayed({ loadVoices() }, 1500)
    }
    override fun onDestroy() { tts.stop(); tts.shutdown(); mainMediaPlayer?.release(); super.onDestroy() }
}
EOF
cat > app/src/main/java/com/example/shtile/GucciVoiceService.kt << 'EOF'
package com.example.shtile
import android.app.*
import android.content.Context
import android.content.Intent
import android.graphics.PixelFormat
import android.media.AudioAttributes
import android.media.AudioManager
import android.media.MediaPlayer
import android.os.Build
import android.os.Environment
import android.os.IBinder
import android.view.Gravity
import android.view.LayoutInflater
import android.view.MotionEvent
import android.view.View
import android.view.WindowManager
import android.widget.*
import androidx.appcompat.view.ContextThemeWrapper
import com.google.android.material.button.MaterialButton
import java.io.DataOutputStream
import java.io.File
import rikka.shizuku.Shizuku
class GucciVoiceService : Service() {
    companion object { var isRunning = false }
    private lateinit var windowManager: WindowManager
    private var overlayView: View? = null
    private var bubbleView: View? = null
    private var mediaPlayer: MediaPlayer? = null
    private var voiceList = ArrayList<String>()
    private lateinit var overlayParams: WindowManager.LayoutParams
    private lateinit var audioManager: AudioManager
    private var isMicMode = false 
    override fun onCreate() {
        super.onCreate()
        isRunning = true
        val prefs = getSharedPreferences("GucciPrefs", MODE_PRIVATE)
        if (!prefs.getBoolean("allow_voice", true)) { stopSelf(); return }
        audioManager = getSystemService(Context.AUDIO_SERVICE) as AudioManager
        val channelId = "gucci_voice_channel"
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val nm = getSystemService(NOTIFICATION_SERVICE) as NotificationManager
            val channel = NotificationChannel(channelId, "Gucci Voices", NotificationManager.IMPORTANCE_MIN)
            nm.createNotificationChannel(channel)
            val notification = Notification.Builder(this, channelId).setContentTitle("Gucci Voices Active").setSmallIcon(android.R.drawable.ic_btn_speak_now).build()
            startForeground(1, notification)
        }
        windowManager = getSystemService(WINDOW_SERVICE) as WindowManager
        showOverlay()
    }
    private fun showOverlay() {
        val themedContext = ContextThemeWrapper(this, R.style.AppTheme)
        val v = LayoutInflater.from(themedContext).inflate(R.layout.overlay_gucci_voice, null)
        overlayParams = WindowManager.LayoutParams(
            WindowManager.LayoutParams.WRAP_CONTENT, WindowManager.LayoutParams.WRAP_CONTENT,
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) WindowManager.LayoutParams.TYPE_APPLICATION_OVERLAY else WindowManager.LayoutParams.TYPE_PHONE,
            WindowManager.LayoutParams.FLAG_NOT_FOCUSABLE, PixelFormat.TRANSLUCENT
        )
        overlayParams.gravity = Gravity.TOP or Gravity.START; overlayParams.x = 100; overlayParams.y = 200
        windowManager.addView(v, overlayParams)
        overlayView = v
        setupDrag(v.findViewById(R.id.dragHandleTop), v)
        val grid = v.findViewById<GridView>(R.id.gridOverlayVoices)
        loadVoices()
        grid.adapter = VoiceCardAdapter(this, voiceList) { fileName -> playVoiceOverlay(fileName) }
        val btnMicToggle = v.findViewById<MaterialButton>(R.id.btnMicToggle)
        btnMicToggle.setOnClickListener {
            isMicMode = !isMicMode
            if (isMicMode) {
                btnMicToggle.text = "🎤 Mic: ON (Call)"; btnMicToggle.setBackgroundColor(android.graphics.Color.parseColor("#00E5A0"))
                applyRootMicRouting(true); Toast.makeText(this, "🎤 Mic Mode ON: Use Earpiece/Headset!", Toast.LENGTH_LONG).show()
            } else {
                btnMicToggle.text = "🎤 Mic: OFF"; btnMicToggle.setBackgroundColor(android.graphics.Color.parseColor("#3B82F6"))
                applyRootMicRouting(false); Toast.makeText(this, "🔊 Speaker Mode ON", Toast.LENGTH_SHORT).show()
            }
        }
        v.findViewById<MaterialButton>(R.id.btnOverlayStop).setOnClickListener { mediaPlayer?.let { if (it.isPlaying) { it.stop(); it.release() } } }
        v.findViewById<ImageButton>(R.id.btnClose).setOnClickListener { stopSelf() }
        v.findViewById<ImageButton>(R.id.btnMinimize).setOnClickListener { minimize() }
    }
    private fun applyRootMicRouting(enableMic: Boolean) {
        Thread {
            try {
                if (enableMic) {
                    audioManager.mode = AudioManager.MODE_IN_COMMUNICATION
                    audioManager.isSpeakerphoneOn = false; audioManager.isBluetoothScoOn = false
                    executeRootOrShizuku("settings put system volume_music 0; settings put system volume_voice 15")
                } else {
                    audioManager.mode = AudioManager.MODE_NORMAL; audioManager.isSpeakerphoneOn = true
                    executeRootOrShizuku("settings put system volume_music 10")
                }
            } catch (e: Exception) {}
        }.start()
    }
    private fun executeRootOrShizuku(cmd: String) {
        try {
            val hasRoot = ProcessBuilder("su", "-c", "id").start().inputStream.bufferedReader().readText().contains("uid=0")
            if (hasRoot) {
                val p = Runtime.getRuntime().exec("su"); val os = DataOutputStream(p.outputStream)
                os.writeBytes("$cmd\n"); os.writeBytes("exit\n"); os.flush(); os.close(); p.waitFor()
            } else if (Shizuku.pingBinder() && Shizuku.checkSelfPermission() == android.content.pm.PackageManager.PERMISSION_GRANTED) {
                val method = Shizuku::class.java.getDeclaredMethod("newProcess", Array<String>::class.java, Array<String>::class.java, String::class.java)
                method.isAccessible = true; val process = method.invoke(null, arrayOf("sh", "-c", cmd), null, null) as Process; process.waitFor()
            }
        } catch (e: Exception) {}
    }
    private fun loadVoices() {
        voiceList.clear()
        val dir = getExternalFilesDir(Environment.DIRECTORY_MUSIC)
        if (dir != null && dir.exists()) { val files = dir.listFiles { file -> file.extension in listOf("wav", "mp3", "m4a") }; files?.sortedByDescending { it.lastModified() }?.forEach { voiceList.add(it.name) } }
    }
    private fun playVoiceOverlay(fileName: String) {
        val file = File(getExternalFilesDir(Environment.DIRECTORY_MUSIC), fileName)
        if (file.exists()) { 
            try {
                mediaPlayer?.release()
                mediaPlayer = MediaPlayer().apply { 
                    setDataSource(file.absolutePath)
                    if (isMicMode) {
                        setAudioAttributes(AudioAttributes.Builder().setUsage(AudioAttributes.USAGE_VOICE_COMMUNICATION).setContentType(AudioAttributes.CONTENT_TYPE_SPEECH).build())
                    } else {
                        setAudioAttributes(AudioAttributes.Builder().setUsage(AudioAttributes.USAGE_MEDIA).setContentType(AudioAttributes.CONTENT_TYPE_MUSIC).build())
                    }
                    prepare(); start() 
                } 
            } catch (e: Exception) {}
        }
    }
    private fun minimize() {
        overlayView?.let { runCatching { windowManager.removeView(it) } }; overlayView = null
        val themedContext = ContextThemeWrapper(this, R.style.AppTheme)
        val b = LayoutInflater.from(themedContext).inflate(R.layout.overlay_bubble, null)
        val params = WindowManager.LayoutParams(120, 120, if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) WindowManager.LayoutParams.TYPE_APPLICATION_OVERLAY else WindowManager.LayoutParams.TYPE_PHONE, WindowManager.LayoutParams.FLAG_NOT_FOCUSABLE, PixelFormat.TRANSLUCENT)
        params.gravity = Gravity.TOP or Gravity.START; params.x = 100; params.y = 200
        var isDragging = false; var initialX = 0; var initialY = 0; var initialTouchX = 0f; var initialTouchY = 0f
        b.setOnTouchListener { _, event ->
            when (event.action) {
                MotionEvent.ACTION_DOWN -> { initialX = params.x; initialY = params.y; initialTouchX = event.rawX; initialTouchY = event.rawY; isDragging = false; true }
                MotionEvent.ACTION_MOVE -> { val dx = event.rawX - initialTouchX; val dy = event.rawY - initialTouchY; if (Math.abs(dx) > 10 || Math.abs(dy) > 10) isDragging = true; if (isDragging) { params.x = initialX + dx.toInt(); params.y = initialY + dy.toInt(); windowManager.updateViewLayout(b, params) }; true }
                MotionEvent.ACTION_UP -> { if (!isDragging) { runCatching { windowManager.removeView(b) }; bubbleView = null; showOverlay() }; true }
                else -> false
            }
        }
        bubbleView = b; windowManager.addView(b, params)
    }
    private fun setupDrag(handle: View, rootView: View) {
        handle.setOnTouchListener(object : View.OnTouchListener {
            var initialX = 0; var initialY = 0; var initialTouchX = 0f; var initialTouchY = 0f
            override fun onTouch(v: View, event: MotionEvent): Boolean {
                when (event.action) {
                    MotionEvent.ACTION_DOWN -> { initialX = overlayParams.x; initialY = overlayParams.y; initialTouchX = event.rawX; initialTouchY = event.rawY; return true }
                    MotionEvent.ACTION_MOVE -> { overlayParams.x = initialX + (event.rawX - initialTouchX).toInt(); overlayParams.y = initialY + (event.rawY - initialTouchY).toInt(); windowManager.updateViewLayout(rootView, overlayParams); return true }
                }
                return false
            }
        })
    }
    override fun onDestroy() { 
        isRunning = false; applyRootMicRouting(false); mediaPlayer?.release()
        overlayView?.let { runCatching { windowManager.removeView(it) } }; bubbleView?.let { runCatching { windowManager.removeView(it) } }
        super.onDestroy() 
    }
    override fun onBind(intent: Intent?): IBinder? = null
}
EOF
gradle assembleDebug
