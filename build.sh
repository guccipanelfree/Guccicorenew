cat > build.sh << 'E'
#!/usr/bin/env bash
set -e
echo "════════════════════════════════════"
echo "   INX-LOADER BUILD START"
echo "════════════════════════════════════"

# ── Gradle 8.2 ──
if [ ! -d "gradle-8.2" ]; then
    echo "[1/4] Downloading Gradle 8.2..."
    wget -q https://services.gradle.org/distributions/gradle-8.2-bin.zip
    unzip -q gradle-8.2-bin.zip
fi
export PATH="$PWD/gradle-8.2/bin:$PATH"
gradle --version | grep -E "Gradle|JVM" || true

# ── Clean & scaffold ──
echo "[2/4] Scaffolding project..."
rm -rf app *.gradle *.properties
A=app/src/main
J=$A/java/com/example/shtile
R=$A/res
mkdir -p $J $R/drawable $R/layout $R/values $A/assets

# ── App icon (with vector fallback) ──
wget -q "https://cdn.phototourl.com/member/2026-11-02-d4837e53-b8a5-4997-9673-cbf6a3594ec1.png" -O $R/drawable/ic_app_icon.png 2>/dev/null || true
if [ ! -s $R/drawable/ic_app_icon.png ]; then
    echo "[i] CDN icon unreachable → using vector fallback"
    rm -f $R/drawable/ic_app_icon.png
    cat > $R/drawable/ic_app_icon.xml << 'EOF'
<vector xmlns:android="http://schemas.android.com/apk/res/android" android:width="108dp" android:height="108dp" android:viewportWidth="108" android:viewportHeight="108"><path android:fillColor="#00E5A0" android:pathData="M54,16 L84,32 L84,60 C84,78 70,92 54,96 C38,92 24,78 24,60 L24,32 Z"/><path android:fillColor="#07090C" android:pathData="M54,30 L70,38 L70,58 C70,70 62,78 54,80 C46,78 38,70 38,58 L38,38 Z"/><path android:fillColor="#00E5A0" android:pathData="M44,52 L52,60 L68,44 L72,48 L52,68 L40,56 Z"/></vector>
EOF
fi

# ── Payload files (optional but required for full features) ──
if [ -f "Gucci_core" ] && [ -f "Gucci_brutal" ]; then
    cp Gucci_core $A/assets/
    cp Gucci_brutal $A/assets/
    echo "[i] Payload files copied into assets/"
else
    echo "[!] WARNING: Gucci_core / Gucci_brutal missing in repo root!"
    echo "    App will build but LOAD INX / Tiles will have no payload."
fi
E
echo "✅ build.sh chunk A written"
cat >> build.sh << 'E'

# ── Gradle config ──
cat > settings.gradle << 'EOF'
pluginManagement{repositories{google();mavenCentral();gradlePluginPortal()}}
dependencyResolutionManagement{repositories{google();mavenCentral()}}
rootProject.name="Settings";include':app'
EOF
cat > build.gradle << 'EOF'
plugins{id'com.android.application' version'8.2.2' apply false;id'org.jetbrains.kotlin.android' version'1.9.22' apply false}
EOF
cat > gradle.properties << 'EOF'
android.useAndroidX=true
android.nonTransitiveRClass=true
org.gradle.jvmargs=-Xmx2048m
EOF
cat > app/build.gradle << 'EOF'
plugins{id'com.android.application';id'org.jetbrains.kotlin.android'}
android{namespace'com.example.shtile';compileSdk 34;defaultConfig{applicationId"com.example.shtile";minSdk 24;targetSdk 34;versionCode 85;versionName"85.0"};compileOptions{sourceCompatibility JavaVersion.VERSION_17;targetCompatibility JavaVersion.VERSION_17};kotlinOptions{jvmTarget='17'}}
dependencies{implementation'androidx.appcompat:appcompat:1.6.1';implementation'androidx.core:core-ktx:1.12.0';implementation'com.google.android.material:material:1.11.0';implementation'dev.rikka.shizuku:api:13.1.5';implementation'dev.rikka.shizuku:provider:13.1.5'}
EOF

# ── Manifest ──
cat > $A/AndroidManifest.xml << 'EOF'
<?xml version="1.0" encoding="utf-8"?>
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
<uses-permission android:name="android.permission.INTERNET"/><uses-permission android:name="android.permission.ACCESS_NETWORK_STATE"/><uses-permission android:name="android.permission.FOREGROUND_SERVICE"/><uses-permission android:name="android.permission.FOREGROUND_SERVICE_DATA_SYNC"/><uses-permission android:name="android.permission.QUERY_ALL_PACKAGES"/><uses-permission android:name="moe.shizuku.manager.permission.API_V23"/>
<application android:allowBackup="true" android:label="Settings" android:icon="@drawable/ic_app_icon" android:theme="@style/Theme.Material3.Dark.NoActionBar" android:usesCleartextTraffic="true">
<activity android:name=".MainActivity" android:exported="true"/><activity android:name=".HideAppsActivity" android:exported="false"/><activity android:name=".TerminalActivity" android:exported="false"/>
<activity-alias android:name=".MainActivityAlias" android:targetActivity=".MainActivity" android:exported="true" android:enabled="true" android:icon="@drawable/ic_app_icon"><intent-filter><action android:name="android.intent.action.MAIN"/><category android:name="android.intent.category.LAUNCHER"/></intent-filter></activity-alias>
<service android:name=".RunnerService" android:exported="false" android:foregroundServiceType="dataSync"/><service android:name=".TimerService" android:exported="false" android:foregroundServiceType="dataSync"/>
<service android:name=".SafeTileService" android:exported="true" android:icon="@drawable/ic_tile_normal" android:label="Boost" android:permission="android.permission.BIND_QUICK_SETTINGS_TILE"><intent-filter><action android:name="android.service.quicksettings.action.QS_TILE"/></intent-filter></service>
<service android:name=".BrutalTileService" android:exported="true" android:icon="@drawable/ic_tile_brutal" android:label="Turbo Mode" android:permission="android.permission.BIND_QUICK_SETTINGS_TILE"><intent-filter><action android:name="android.service.quicksettings.action.QS_TILE"/></intent-filter></service>
<service android:name=".FocusTileService" android:exported="true" android:icon="@drawable/ic_tile_focus" android:label="Focus Mode" android:permission="android.permission.BIND_QUICK_SETTINGS_TILE"><intent-filter><action android:name="android.service.quicksettings.action.QS_TILE"/></intent-filter></service>
<service android:name=".PayTileService" android:exported="true" android:icon="@drawable/ic_tile_pay" android:label="Payment Protection" android:permission="android.permission.BIND_QUICK_SETTINGS_TILE"><intent-filter><action android:name="android.service.quicksettings.action.QS_TILE"/></intent-filter></service>
<receiver android:name=".PackageReceiver" android:exported="true"><intent-filter><action android:name="android.intent.action.PACKAGE_ADDED"/><action android:name="android.intent.action.PACKAGE_REPLACED"/><data android:scheme="package"/></intent-filter></receiver>
<provider android:name="rikka.shizuku.ShizukuProvider" android:authorities="${applicationId}.shizuku" android:enabled="true" android:exported="true" android:multiprocess="false" android:permission="android.permission.INTERACT_ACROSS_USERS_FULL"/>
</application></manifest>
EOF

# ── Values + simple drawables ──
cat > $R/values/colors.xml << 'EOF'
<resources><color name="bg_main">#07090C</color><color name="accent_green">#00E5A0</color><color name="accent_red">#FF4D4D</color><color name="text_primary">#FFFFFF</color><color name="text_secondary">#8B949E</color><color name="card_bg">#12161F</color><color name="card_stroke">#1F2633</color><color name="pill_bg">#1A2430</color><color name="pill_stroke">#2A3545</color></resources>
EOF
cat > $R/values/strings.xml << 'EOF'
<resources><string name="app_name">Settings</string></resources>
EOF
cat > $R/drawable/bg_box_dark.xml << 'EOF'
<shape xmlns:android="http://schemas.android.com/apk/res/android"><solid android:color="#151B23"/><corners android:radius="12dp"/><stroke android:width="1dp" android:color="#232A35"/></shape>
EOF
cat > $R/drawable/bg_pill.xml << 'EOF'
<shape xmlns:android="http://schemas.android.com/apk/res/android"><solid android:color="@color/pill_bg"/><corners android:radius="20dp"/><stroke android:width="1dp" android:color="@color/pill_stroke"/></shape>
EOF
echo "✅ build.sh chunk B written"
cat >> build.sh << 'E'

# ── Vector icons ──
cat > $R/drawable/ic_terminal.xml << 'EOF'
<vector xmlns:android="http://schemas.android.com/apk/res/android" android:width="24dp" android:height="24dp" android:viewportWidth="24" android:viewportHeight="24"><path android:fillColor="#FFFFFFFF" android:pathData="M20,4H4C2.89,4 2.01,4.89 2.01,6L2,18c0,1.11 0.89,2 2,2h16c1.11,0 2,-0.89 2,-2V6C22,4.89 21.11,4 20,4zM20,18H4v-6h16V18zM20,8H4V6h16V8zM6.5,13.5l2.5,2.5l-2.5,2.5L5,17l1.5,-1.5L5,14L6.5,13.5zM11,18h6v-1.5h-6V18z"/></vector>
EOF
cat > $R/drawable/ic_tile_normal.xml << 'EOF'
<vector xmlns:android="http://schemas.android.com/apk/res/android" android:width="24dp" android:height="24dp" android:viewportWidth="24" android:viewportHeight="24"><path android:fillColor="#FFFFFFFF" android:fillType="evenOdd" android:pathData="M12,1.5 C14.5,4.5 16,6.5 16,7 L8,7 C8,6.5 9.5,4.5 12,1.5 Z M7.5,8 L16.5,8 L16.5,15.5 L7.5,15.5 Z M12,9 A1.8,1.8 0 1,0 12,12.6 A1.8,1.8 0 1,0 12,9 Z M7.5,12 C4.5,13 3,15.5 3,19.5 L3,21 L7.5,16.5 Z M16.5,12 C19.5,13 21,15.5 21,19.5 L21,21 L16.5,16.5 Z M8,16 L16,16 L16,18 L8,18 Z M9.5,18.5 C9.5,18.5 10.5,21 12,23.5 C13.5,21 14.5,18.5 14.5,18.5 L13,20.5 L12,19 L11,20.5 Z"/></vector>
EOF
cat > $R/drawable/ic_tile_brutal.xml << 'EOF'
<vector xmlns:android="http://schemas.android.com/apk/res/android" android:width="24dp" android:height="24dp" android:viewportWidth="24" android:viewportHeight="24"><path android:fillColor="#FFFFFFFF" android:pathData="M7,2v11h3v9l7,-12h-4l4,-8z"/></vector>
EOF
cat > $R/drawable/ic_tile_focus.xml << 'EOF'
<vector xmlns:android="http://schemas.android.com/apk/res/android" android:width="24dp" android:height="24dp" android:viewportWidth="24" android:viewportHeight="24"><path android:fillColor="#FFFFFFFF" android:pathData="M12,7c2.76,0 5,2.24 5,5 0,0.65 -0.13,1.26 -0.36,1.83l2.92,2.92c1.51,-1.26 2.7,-2.89 3.43,-4.75 -1.73,-4.39 -6,-7.5 -11,-7.5 -1.4,0 -2.74,0.25 -3.98,0.7l2.16,2.16C10.74,7.13 11.35,7 12,7zM2,4.27l2.28,2.28 0.46,0.46C3.08,8.3 1.78,10.02 1,12c1.73,4.39 6,7.5 11,7.5 1.55,0 3.03,-0.3 4.38,-0.84l0.42,0.42L19.73,22 21,20.73 3.27,3 2,4.27zM7.53,9.8l1.55,1.55c-0.05,0.21 -0.08,0.43 -0.08,0.65 0,1.66 1.34,3 3,3 0.22,0 0.44,-0.03 0.65,-0.08l1.55,1.55c-0.67,0.33 -1.41,0.53 -2.2,0.53 -2.76,0 -5,-2.24 -5,-5 0,-0.79 0.2,-1.53 0.53,-2.2zM11.84,9.02l3.15,3.15 0.02,-0.16c0,-1.66 -1.34,-3 -3,-3l-0.17,0.01z"/></vector>
EOF
cat > $R/drawable/ic_hide.xml << 'EOF'
<vector xmlns:android="http://schemas.android.com/apk/res/android" android:width="24dp" android:height="24dp" android:viewportWidth="24" android:viewportHeight="24"><path android:fillColor="#FFFFFFFF" android:pathData="M12,7c2.76,0 5,2.24 5,5 0,0.65 -0.13,1.26 -0.36,1.83l2.92,2.92c1.51,-1.26 2.7,-2.89 3.43,-4.75 -1.73,-4.39 -6,-7.5 -11,-7.5 -1.4,0 -2.74,0.25 -3.98,0.7l2.16,2.16C10.74,7.13 11.35,7 12,7zM2,4.27l2.28,2.28 0.46,0.46C3.08,8.3 1.78,10.02 1,12c1.73,4.39 6,7.5 11,7.5 1.55,0 3.03,-0.3 4.38,-0.84l0.42,0.42L19.73,22 21,20.73 3.27,3 2,4.27zM7.53,9.8l1.55,1.55c-0.05,0.21 -0.08,0.43 -0.08,0.65 0,1.66 1.34,3 3,3 0.22,0 0.44,-0.03 0.65,-0.08l1.55,1.55c-0.67,0.33 -1.41,0.53 -2.2,0.53 -2.76,0 -5,-2.24 -5,-5 0,-0.79 0.2,-1.53 0.53,-2.2zM11.84,9.02l3.15,3.15 0.02,-0.16c0,-1.66 -1.34,-3 -3,-3l-0.17,0.01z"/></vector>
EOF
cat > $R/drawable/ic_tile_pay.xml << 'EOF'
<vector xmlns:android="http://schemas.android.com/apk/res/android" android:width="24dp" android:height="24dp" android:viewportWidth="24" android:viewportHeight="24"><path android:fillColor="#FFFFFFFF" android:pathData="M12,1L3,5v6c0,5.55 3.84,10.74 9,12 5.16,-1.26 9,-6.45 9,-12V5l-9,-4zm-2,16l-4,-4 1.41,-1.41L10,14.17l6.59,-6.59L18,9l-8,8z"/></vector>
EOF

# ── Layouts (small) ──
cat > $R/layout/dialog_root.xml << 'EOF'
<com.google.android.material.card.MaterialCardView xmlns:android="http://schemas.android.com/apk/res/android" xmlns:app="http://schemas.android.com/apk/res-auto" android:layout_width="match_parent" android:layout_height="wrap_content" app:cardBackgroundColor="@color/card_bg" app:cardCornerRadius="24dp" app:strokeWidth="1dp" app:strokeColor="@color/card_stroke"><LinearLayout android:layout_width="match_parent" android:layout_height="wrap_content" android:orientation="vertical" android:padding="32dp" android:gravity="center"><TextView android:layout_width="wrap_content" android:layout_height="wrap_content" android:text="ROOT / ADB REQUIRED" android:textColor="@color/text_primary" android:textSize="22sp" android:textStyle="bold" android:layout_marginBottom="12dp"/><TextView android:layout_width="match_parent" android:layout_height="wrap_content" android:text="INX-LOADER requires Root Permission or Shizuku (ADB) to function properly." android:textColor="@color/text_secondary" android:textSize="15sp" android:gravity="center" android:layout_marginBottom="32dp"/><com.google.android.material.button.MaterialButton android:id="@+id/btnGrant" android:layout_width="match_parent" android:layout_height="56dp" android:text="GRANT ROOT" android:textColor="#000000" app:backgroundTint="@color/accent_green" app:cornerRadius="16dp" android:layout_marginBottom="12dp" android:textStyle="bold"/><com.google.android.material.button.MaterialButton android:id="@+id/btnShizuku" android:layout_width="match_parent" android:layout_height="56dp" android:text="USE SHIZUKU (ADB)" app:backgroundTint="@android:color/transparent" app:strokeColor="@color/accent_green" app:strokeWidth="1dp" app:cornerRadius="16dp" android:textColor="@color/accent_green" android:textStyle="bold" android:layout_marginBottom="12dp"/><com.google.android.material.button.MaterialButton android:id="@+id/btnExit" android:layout_width="match_parent" android:layout_height="56dp" android:text="EXIT" app:backgroundTint="@android:color/transparent" app:strokeColor="@color/accent_red" app:strokeWidth="1dp" app:cornerRadius="16dp" android:textColor="@color/accent_red" android:textStyle="bold"/></LinearLayout></com.google.android.material.card.MaterialCardView>
EOF
cat > $R/layout/list_item_app.xml << 'EOF'
<com.google.android.material.card.MaterialCardView xmlns:android="http://schemas.android.com/apk/res/android" xmlns:app="http://schemas.android.com/apk/res-auto" android:layout_width="match_parent" android:layout_height="wrap_content" android:layout_marginBottom="8dp" app:cardBackgroundColor="@color/card_bg" app:cardCornerRadius="16dp" app:cardElevation="3dp" app:strokeWidth="1dp" app:strokeColor="@color/card_stroke"><LinearLayout android:layout_width="match_parent" android:layout_height="wrap_content" android:orientation="horizontal" android:padding="12dp" android:gravity="center_vertical"><ImageView android:id="@+id/appIcon" android:layout_width="44dp" android:layout_height="44dp"/><LinearLayout android:layout_width="0dp" android:layout_weight="1" android:layout_height="wrap_content" android:orientation="vertical" android:paddingStart="12dp"><TextView android:id="@+id/appName" android:layout_width="wrap_content" android:layout_height="wrap_content" android:textColor="@color/text_primary" android:textSize="15sp" android:textStyle="bold"/><TextView android:id="@+id/appPkg" android:layout_width="wrap_content" android:layout_height="wrap_content" android:textColor="@color/text_secondary" android:textSize="11sp"/></LinearLayout><com.google.android.material.checkbox.MaterialCheckBox android:id="@+id/appCheck" android:layout_width="wrap_content" android:layout_height="wrap_content" app:buttonTint="@color/accent_green" android:layout_marginEnd="8dp"/><com.google.android.material.materialswitch.MaterialSwitch android:id="@+id/appSwitch" android:layout_width="wrap_content" android:layout_height="wrap_content"/></LinearLayout></com.google.android.material.card.MaterialCardView>
EOF
echo "✅ build.sh chunk C written (icons + small layouts)"
cat >> build.sh << 'E'

# ── Layouts (large) ──
cat > $R/layout/activity_main.xml << 'EOF'
<ScrollView xmlns:android="http://schemas.android.com/apk/res/android" xmlns:app="http://schemas.android.com/apk/res-auto" android:layout_width="match_parent" android:layout_height="match_parent" android:background="@color/bg_main" android:fillViewport="true"><LinearLayout android:orientation="vertical" android:padding="24dp" android:layout_width="match_parent" android:layout_height="match_parent"><TextView android:id="@+id/titleText" android:text="INX-LOADER" android:textColor="@color/text_primary" android:textSize="36sp" android:fontFamily="sans-serif-black" android:letterSpacing="0.02" android:layout_width="wrap_content" android:layout_height="wrap_content"/><LinearLayout android:layout_width="match_parent" android:layout_height="wrap_content" android:orientation="horizontal" android:gravity="center_vertical" android:layout_marginTop="-4dp" android:layout_marginBottom="28dp"><TextView android:id="@+id/subtitleText" android:text="Premium Panel By GUCCI" android:textColor="@color/accent_green" android:textSize="14sp" android:fontFamily="sans-serif-medium" android:layout_width="wrap_content" android:layout_height="wrap_content"/><View android:layout_width="0dp" android:layout_height="0dp" android:layout_weight="1"/><TextView android:id="@+id/statusBadge" android:layout_width="wrap_content" android:layout_height="wrap_content" android:text="● INITIALIZING" android:textColor="@color/text_secondary" android:textSize="10sp" android:textStyle="bold" android:paddingStart="10dp" android:paddingEnd="10dp" android:paddingTop="5dp" android:paddingBottom="5dp" android:background="@drawable/bg_pill"/></LinearLayout><com.google.android.material.card.MaterialCardView android:layout_width="match_parent" android:layout_height="wrap_content" app:cardBackgroundColor="@color/card_bg" app:cardCornerRadius="20dp" app:cardElevation="6dp" app:strokeWidth="1dp" app:strokeColor="@color/card_stroke" android:layout_marginBottom="16dp"><LinearLayout android:orientation="vertical" android:padding="20dp" android:layout_width="match_parent" android:layout_height="wrap_content"><TextView android:text="LICENSE KEY" android:textColor="@color/accent_green" android:textSize="11sp" android:textStyle="bold" android:letterSpacing="0.12" android:layout_marginBottom="8dp" android:layout_width="wrap_content" android:layout_height="wrap_content"/><EditText android:id="@+id/keyInput" android:hint="Enter license..." android:inputType="text" android:padding="12dp" android:background="#00000000" android:textColor="@color/text_primary" android:textColorHint="@color/text_secondary" android:layout_width="match_parent" android:layout_height="wrap_content"/></LinearLayout></com.google.android.material.card.MaterialCardView><com.google.android.material.card.MaterialCardView android:layout_width="match_parent" android:layout_height="wrap_content" app:cardBackgroundColor="@color/card_bg" app:cardCornerRadius="20dp" app:cardElevation="6dp" app:strokeWidth="1dp" app:strokeColor="@color/card_stroke" android:layout_marginBottom="24dp"><LinearLayout android:orientation="vertical" android:padding="20dp" android:layout_width="match_parent" android:layout_height="wrap_content"><TextView android:text="SELECT DRIVER (1-10)" android:textColor="@color/accent_green" android:textSize="11sp" android:textStyle="bold" android:letterSpacing="0.12" android:layout_marginBottom="8dp" android:layout_width="wrap_content" android:layout_height="wrap_content"/><EditText android:id="@+id/brutalInput" android:hint="e.g. 7" android:inputType="number" android:padding="12dp" android:background="#00000000" android:textColor="@color/text_primary" android:textColorHint="@color/text_secondary" android:layout_width="match_parent" android:layout_height="wrap_content"/><TextView android:id="@+id/driverNameText" android:textColor="@color/accent_green" android:textSize="14sp" android:textStyle="bold" android:layout_marginTop="4dp" android:paddingStart="12dp" android:layout_width="wrap_content" android:layout_height="wrap_content"/></LinearLayout></com.google.android.material.card.MaterialCardView><com.google.android.material.button.MaterialButton android:id="@+id/saveKeyBtn" android:layout_width="match_parent" android:layout_height="60dp" android:text="SAVE CONFIGURATION" android:textColor="#000000" app:backgroundTint="@color/accent_green" app:cornerRadius="16dp" android:layout_marginBottom="16dp" android:textStyle="bold"/><com.google.android.material.button.MaterialButton android:id="@+id/loadFilesBtn" style="@style/Widget.MaterialComponents.Button.OutlinedButton" android:layout_width="wrap_content" android:layout_height="50dp" android:layout_marginTop="8dp" android:layout_gravity="center_horizontal" android:paddingStart="48dp" android:paddingEnd="48dp" android:text="LOAD INX" android:textColor="@color/accent_green" app:strokeColor="@color/accent_green" app:cornerRadius="25dp"/><TextView android:paddingTop="40dp" android:gravity="center" android:text="Use Quick Setting tiles to load INX-Payload" android:textColor="@color/text_secondary" android:textSize="12sp" android:layout_width="match_parent" android:layout_height="wrap_content"/><TextView android:id="@+id/contactAdminText" android:paddingTop="16dp" android:gravity="center" android:text="Contact Admin for Help" android:textColor="@color/accent_green" android:textSize="14sp" android:textStyle="bold" android:layout_width="match_parent" android:layout_height="wrap_content"/><View android:layout_width="match_parent" android:layout_height="0dp" android:layout_weight="1"/><LinearLayout android:orientation="horizontal" android:layout_width="match_parent" android:layout_height="wrap_content" android:paddingBottom="24dp" android:gravity="center"><ImageButton android:id="@+id/hideAppsIcon" android:layout_width="60dp" android:layout_height="60dp" android:padding="16dp" android:background="?attr/selectableItemBackgroundBorderless" android:src="@drawable/ic_hide" app:tint="@color/accent_green" android:layout_marginEnd="16dp"/><ImageButton android:id="@+id/terminalIcon" android:layout_width="60dp" android:layout_height="60dp" android:padding="16dp" android:background="?attr/selectableItemBackgroundBorderless" android:src="@drawable/ic_terminal" app:tint="@color/accent_green"/></LinearLayout></LinearLayout></ScrollView>
EOF
cat > $R/layout/activity_hide_apps.xml << 'EOF'
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android" xmlns:app="http://schemas.android.com/apk/res-auto" android:layout_width="match_parent" android:layout_height="match_parent" android:orientation="vertical" android:background="@color/bg_main" android:padding="16dp"><com.google.android.material.tabs.TabLayout android:id="@+id/tabLayout" android:layout_width="match_parent" android:layout_height="wrap_content" app:tabIndicatorColor="@color/accent_green" app:tabTextColor="@color/text_secondary" app:tabSelectedTextColor="@color/text_primary" app:tabIndicatorFullWidth="true" android:layout_marginBottom="16dp"><com.google.android.material.tabs.TabItem android:text="Manage Apps"/><com.google.android.material.tabs.TabItem android:text="Hidden &amp; Emergency"/></com.google.android.material.tabs.TabLayout><FrameLayout android:layout_width="match_parent" android:layout_height="0dp" android:layout_weight="1"><LinearLayout android:id="@+id/pageAllApps" android:layout_width="match_parent" android:layout_height="match_parent" android:orientation="vertical" android:visibility="visible"><com.google.android.material.textfield.TextInputLayout style="@style/Widget.MaterialComponents.TextInputLayout.OutlinedBox" android:layout_width="match_parent" android:layout_height="wrap_content" app:boxStrokeColor="@color/accent_green" app:hintTextColor="@color/accent_green" android:layout_marginBottom="12dp"><com.google.android.material.textfield.TextInputEditText android:id="@+id/searchInput" android:layout_width="match_parent" android:layout_height="wrap_content" android:hint="Search all apps..." android:textColor="@color/text_primary" android:textColorHint="@color/text_secondary" android:inputType="text"/></com.google.android.material.textfield.TextInputLayout><ListView android:id="@+id/appsList" android:layout_width="match_parent" android:layout_height="0dp" android:layout_weight="1" android:divider="@null" android:dividerHeight="0dp"/><LinearLayout android:layout_width="match_parent" android:layout_height="wrap_content" android:orientation="horizontal" android:layout_marginTop="12dp" android:gravity="center_vertical" android:background="@drawable/bg_box_dark" android:padding="12dp"><TextView android:layout_width="wrap_content" android:layout_height="wrap_content" android:text="Auto-Unhide Timer: " android:textColor="@color/accent_green" android:textSize="14sp" android:textStyle="bold"/><Spinner android:id="@+id/timerSpinner" android:layout_width="match_parent" android:layout_height="40dp" android:backgroundTint="@color/accent_green"/></LinearLayout></LinearLayout><LinearLayout android:id="@+id/pageHiddenApps" android:layout_width="match_parent" android:layout_height="match_parent" android:orientation="vertical" android:visibility="gone"><com.google.android.material.button.MaterialButton android:id="@+id/emergencyBtn" style="@style/Widget.MaterialComponents.Button.OutlinedButton" android:layout_width="match_parent" android:layout_height="56dp" android:text="🚨 EMERGENCY UNHIDE ALL" app:strokeColor="@color/accent_red" android:textColor="@color/accent_red" android:textSize="14sp" app:cornerRadius="16dp" android:layout_marginBottom="16dp" android:textStyle="bold"/><ListView android:id="@+id/hiddenAppsList" android:layout_width="match_parent" android:layout_height="0dp" android:layout_weight="1" android:divider="@null" android:dividerHeight="0dp"/></LinearLayout></FrameLayout><com.google.android.material.button.MaterialButton android:id="@+id/applyBtn" android:layout_width="match_parent" android:layout_height="60dp" android:layout_marginTop="16dp" android:text="APPLY FOR TILE" android:textColor="#000000" app:backgroundTint="@color/accent_green" app:cornerRadius="16dp" android:textStyle="bold"/></LinearLayout>
EOF
cat > $R/layout/activity_terminal.xml << 'EOF'
<LinearLayout xmlns:android="http://schemas.android.com/apk/res/android" xmlns:app="http://schemas.android.com/apk/res-auto" android:layout_width="match_parent" android:layout_height="match_parent" android:orientation="vertical" android:background="@color/bg_main" android:padding="16dp"><com.google.android.material.card.MaterialCardView android:layout_width="match_parent" android:layout_height="wrap_content" app:cardBackgroundColor="@color/card_bg" app:cardCornerRadius="16dp" app:cardElevation="6dp" app:strokeWidth="1dp" app:strokeColor="@color/card_stroke" android:layout_marginBottom="16dp"><LinearLayout android:layout_width="match_parent" android:layout_height="wrap_content" android:orientation="vertical" android:padding="16dp"><TextView android:layout_width="wrap_content" android:layout_height="wrap_content" android:text="Execution Mode" android:textColor="@color/accent_green" android:textStyle="bold" android:layout_marginBottom="8dp"/><RadioGroup android:id="@+id/modeGroup" android:layout_width="match_parent" android:layout_height="wrap_content" android:orientation="horizontal" android:layout_marginBottom="16dp"><RadioButton android:id="@+id/radioRoot" android:layout_width="wrap_content" android:layout_height="wrap_content" android:text="Root" android:textColor="@color/text_primary" android:checked="true"/><RadioButton android:id="@+id/radioShizuku" android:layout_width="wrap_content" android:layout_height="wrap_content" android:text="Shizuku" android:textColor="@color/text_primary" android:layout_marginStart="8dp"/></RadioGroup><TextView android:layout_width="wrap_content" android:layout_height="wrap_content" android:text="App Hider/Unhider" android:textColor="@color/accent_green" android:textStyle="bold" android:layout_marginBottom="8dp"/><EditText android:id="@+id/pkgInput" android:layout_width="match_parent" android:layout_height="48dp" android:hint="Enter Package Name..." android:background="@drawable/bg_box_dark" android:padding="12dp" android:textColor="@color/text_primary" android:textColorHint="@color/text_secondary" android:layout_marginBottom="12dp"/><LinearLayout android:layout_width="match_parent" android:layout_height="wrap_content" android:orientation="horizontal"><com.google.android.material.button.MaterialButton android:id="@+id/btnHide" android:layout_width="0dp" android:layout_weight="1" android:layout_height="48dp" android:text="HIDE APP" app:backgroundTint="@color/accent_red" android:textColor="#FFFFFF" android:textStyle="bold" android:layout_marginEnd="8dp"/><com.google.android.material.button.MaterialButton android:id="@+id/btnUnhide" android:layout_width="0dp" android:layout_weight="1" android:layout_height="48dp" android:text="UNHIDE APP" app:backgroundTint="@color/accent_green" android:textColor="#000000" android:textStyle="bold"/></LinearLayout></LinearLayout></com.google.android.material.card.MaterialCardView><com.google.android.material.card.MaterialCardView android:layout_width="match_parent" android:layout_height="0dp" android:layout_weight="1" app:cardBackgroundColor="@color/card_bg" app:cardCornerRadius="16dp" app:cardElevation="6dp" app:strokeWidth="1dp" app:strokeColor="@color/card_stroke" android:layout_marginBottom="16dp"><LinearLayout android:layout_width="match_parent" android:layout_height="match_parent" android:orientation="vertical" android:padding="16dp"><TextView android:layout_width="wrap_content" android:layout_height="wrap_content" android:text="Raw Terminal" android:textColor="@color/accent_green" android:textStyle="bold" android:layout_marginBottom="8dp"/><LinearLayout android:layout_width="match_parent" android:layout_height="wrap_content" android:orientation="horizontal" android:layout_marginBottom="8dp"><EditText android:id="@+id/terminalInput" android:layout_width="0dp" android:layout_weight="1" android:layout_height="48dp" android:hint="Enter command..." android:background="@drawable/bg_box_dark" android:padding="12dp" android:textColor="@color/text_primary" android:textColorHint="@color/text_secondary" android:layout_marginEnd="8dp" android:inputType="textNoSuggestions"/><com.google.android.material.button.MaterialButton android:id="@+id/btnRunCmd" android:layout_width="wrap_content" android:layout_height="48dp" android:text="RUN" app:backgroundTint="@color/accent_green" android:textColor="#000000" android:textStyle="bold"/></LinearLayout><ScrollView android:layout_width="match_parent" android:layout_height="0dp" android:layout_weight="1" android:background="@drawable/bg_box_dark" android:padding="12dp"><TextView android:id="@+id/terminalOutput" android:layout_width="match_parent" android:layout_height="wrap_content" android:textColor="#00FF00" android:fontFamily="monospace" android:textSize="12sp" android:text="Terminal Ready...\n"/></ScrollView></LinearLayout></com.google.android.material.card.MaterialCardView></LinearLayout>
EOF
echo "✅ build.sh chunk D written (large layouts)"
cat >> build.sh << 'E'

# ── Kotlin sources ──
cat > $J/Installer.kt << 'EOF'
package com.example.shtile
import android.content.Context
import android.os.Handler
import android.os.Looper
import java.io.File
object Installer{fun installAll(c:Context,cb:((Boolean)->Unit)?=null){Thread{var ok=true;for(n in listOf("Gucci_core","Gucci_brutal")){try{val b=c.assets.open(n).readBytes();val t=File(c.cacheDir,n);t.writeBytes(b);val p=ProcessBuilder("su","-c","cp ${t.absolutePath} /data/local/tmp/$n && chmod 777 /data/local/tmp/$n").redirectErrorStream(true).start();p.inputStream.bufferedReader().readText();if(p.waitFor()!=0)ok=false;t.delete()}catch(e:Exception){ok=false}};Handler(Looper.getMainLooper()).post{cb?.invoke(ok)}}.start()}}
EOF
cat > $J/RunnerService.kt << 'EOF'
package com.example.shtile
import android.app.*
import android.content.Intent
import android.os.*
import android.widget.Toast
import androidx.core.app.NotificationCompat
class RunnerService:Service(){override fun onStartCommand(i:Intent?,f:Int,s:Int):Int{if(Build.VERSION.SDK_INT>=Build.VERSION_CODES.O){val nm=getSystemService(NOTIFICATION_SERVICE)as NotificationManager;if(nm.getNotificationChannel("c")==null)nm.createNotificationChannel(NotificationChannel("c","c",NotificationManager.IMPORTANCE_MIN))};try{startForeground(1,NotificationCompat.Builder(this,"c").setSmallIcon(android.R.drawable.stat_notify_sync_noanim).build())}catch(e:Exception){};val a=i?.action;Thread{try{val p=getSharedPreferences("GucciPrefs",MODE_PRIVATE);val c=if(a=="BRUTAL")"cd /data/local/tmp && (echo 2; sleep 5; echo ${p.getString("brutal_option","7")}; sleep 2) | ./Gucci_brutal"else{val k=p.getString("license_key","")?.trim();if(k.isNullOrEmpty()){Handler(Looper.getMainLooper()).post{Toast.makeText(applicationContext,"Save License Key first!",Toast.LENGTH_LONG).show()};stopSelf();return@Thread};"cd /data/local/tmp && (sleep 4; echo '$k'; sleep 2) | ./Gucci_core"};val pr=ProcessBuilder("su","-c",c).redirectErrorStream(true).start();pr.inputStream.bufferedReader().readText();pr.waitFor()}catch(e:Exception){};stopForeground(true);stopSelf()}.start();return START_NOT_STICKY};override fun onBind(i:Intent?):IBinder?=null}
EOF
cat > $J/SafeTileService.kt << 'EOF'
package com.example.shtile
import android.content.Intent
import android.os.Build
import android.service.quicksettings.Tile
import android.service.quicksettings.TileService
class SafeTileService:TileService(){override fun onStartListening(){qsTile?.apply{label="Boost";state=Tile.STATE_INACTIVE;updateTile()}};override fun onClick(){val i=Intent(this,RunnerService::class.java).apply{action="NORMAL"};if(Build.VERSION.SDK_INT>=Build.VERSION_CODES.O)startForegroundService(i)else startService(i)}}
EOF
cat > $J/BrutalTileService.kt << 'EOF'
package com.example.shtile
import android.content.Intent
import android.os.Build
import android.service.quicksettings.Tile
import android.service.quicksettings.TileService
class BrutalTileService:TileService(){override fun onStartListening(){qsTile?.apply{label="Turbo Mode";state=Tile.STATE_INACTIVE;updateTile()}};override fun onClick(){val i=Intent(this,RunnerService::class.java).apply{action="BRUTAL"};if(Build.VERSION.SDK_INT>=Build.VERSION_CODES.O)startForegroundService(i)else startService(i)}}
EOF
cat > $J/FocusTileService.kt << 'EOF'
package com.example.shtile
import android.content.ComponentName
import android.content.pm.PackageManager
import android.service.quicksettings.Tile
import android.service.quicksettings.TileService
class FocusTileService:TileService(){private val c by lazy{ComponentName(applicationContext,"com.example.shtile.MainActivityAlias")};override fun onStartListening(){updateState()};override fun onClick(){val pm=packageManager;val s=pm.getComponentEnabledSetting(c);val n=if(s==PackageManager.COMPONENT_ENABLED_STATE_DISABLED)PackageManager.COMPONENT_ENABLED_STATE_ENABLED else PackageManager.COMPONENT_ENABLED_STATE_DISABLED;pm.setComponentEnabledSetting(c,n,PackageManager.DONT_KILL_APP);updateState()};private fun updateState(){val s=packageManager.getComponentEnabledSetting(c);qsTile?.apply{label="Focus Mode";state=if(s==PackageManager.COMPONENT_ENABLED_STATE_DISABLED)Tile.STATE_ACTIVE else Tile.STATE_INACTIVE;updateTile()}}}
EOF
cat > $J/TimerService.kt << 'EOF'
package com.example.shtile
import android.app.*
import android.content.Intent
import android.os.*
import androidx.core.app.NotificationCompat
import java.io.DataOutputStream
class TimerService:Service(){private var t:Thread?=null
override fun onStartCommand(i:Intent?,f:Int,s:Int):Int{if(Build.VERSION.SDK_INT>=Build.VERSION_CODES.O){val nm=getSystemService(NOTIFICATION_SERVICE)as NotificationManager;if(nm.getNotificationChannel("timer_ch")==null)nm.createNotificationChannel(NotificationChannel("timer_ch","Timer",NotificationManager.IMPORTANCE_LOW))};val n=NotificationCompat.Builder(this,"timer_ch").setContentTitle("Protection Timer Active").setContentText("Apps will be restored automatically...").setSmallIcon(android.R.drawable.ic_menu_recent_history).setPriority(NotificationCompat.PRIORITY_LOW).build();startForeground(2,n);val m=i?.getIntExtra("minutes",0)?:0;if(m<=0){stopSelf();return START_NOT_STICKY};t=Thread{try{Thread.sleep(m*60*1000L);val p=getSharedPreferences("HidePrefs",MODE_PRIVATE);val h=p.getStringSet("safe_apps",emptySet())?:emptySet();if(h.isNotEmpty()){val c=StringBuilder();val hist=p.getStringSet("hidden_history",emptySet())?.toMutableSet()?:mutableSetOf();for(pk in h){hist.remove(pk);c.append("pm unhide $pk; pm enable $pk; cmd package install-existing --user 0 $pk; ")};val pr=Runtime.getRuntime().exec("su");val os=DataOutputStream(pr.outputStream);os.writeBytes(c.toString()+"\n");os.writeBytes("exit\n");os.flush();os.close();pr.waitFor();p.edit().putBoolean("is_pay_hidden",false).putStringSet("hidden_history",hist).apply()}}catch(e:Exception){}finally{stopSelf()}};t?.start();return START_NOT_STICKY}
override fun onDestroy(){t?.interrupt();super.onDestroy()}
override fun onBind(i:Intent?):IBinder?=null}
EOF
cat > $J/PayTileService.kt << 'EOF'
package com.example.shtile
import android.content.Intent
import android.os.Build
import android.service.quicksettings.Tile
import android.service.quicksettings.TileService
import android.widget.Toast
import java.io.DataOutputStream
class PayTileService:TileService(){
override fun onStartListening(){updateState()}
override fun onClick(){val p=getSharedPreferences("HidePrefs",MODE_PRIVATE);val cur=p.getBoolean("is_pay_hidden",false);val apps=p.getStringSet("safe_apps",emptySet())?:emptySet();val tm=p.getInt("timer_minutes",0);if(apps.isEmpty()){Toast.makeText(this,"No apps selected in Hide menu",Toast.LENGTH_SHORT).show();return};val ns=!cur
Thread{try{val c=StringBuilder();val hist=p.getStringSet("hidden_history",emptySet())?.toMutableSet()?:mutableSetOf();for(pk in apps){if(ns){hist.add(pk);c.append("pm hide $pk; pm disable-user --user 0 $pk; ")}else{hist.remove(pk);c.append("pm unhide $pk; pm enable $pk; cmd package install-existing --user 0 $pk; ")}};val pr=Runtime.getRuntime().exec("su");val os=DataOutputStream(pr.outputStream);os.writeBytes(c.toString()+"\n");os.writeBytes("exit\n");os.flush();os.close();pr.waitFor();p.edit().putBoolean("is_pay_hidden",ns).putStringSet("hidden_history",hist).apply()}catch(e:Exception){}}.start()
if(ns&&tm>0){val i=Intent(this,TimerService::class.java).putExtra("minutes",tm);if(Build.VERSION.SDK_INT>=Build.VERSION_CODES.O)startForegroundService(i)else startService(i);Toast.makeText(this,"Apps Hidden for $tm Minutes",Toast.LENGTH_SHORT).show()}else if(ns){Toast.makeText(this,"Apps Hidden",Toast.LENGTH_SHORT).show()}else{stopService(Intent(this,TimerService::class.java));Toast.makeText(this,"Apps Restored",Toast.LENGTH_SHORT).show()}
updateState(ns)}
private fun updateState(f:Boolean?=null){val h=f?:getSharedPreferences("HidePrefs",MODE_PRIVATE).getBoolean("is_pay_hidden",false);qsTile?.apply{label="Payment Protection";state=if(h)Tile.STATE_ACTIVE else Tile.STATE_INACTIVE;updateTile()}}}
EOF
cat > $J/PackageReceiver.kt << 'EOF'
package com.example.shtile
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import java.io.DataOutputStream
class PackageReceiver:BroadcastReceiver(){override fun onReceive(c:Context,i:Intent){if(i.action==Intent.ACTION_PACKAGE_ADDED){if(i.getBooleanExtra(Intent.EXTRA_REPLACING,false))return;val pk=i.data?.encodedSchemeSpecificPart?:return;val p=c.getSharedPreferences("HidePrefs",Context.MODE_PRIVATE);if(p.getBoolean("is_pay_hidden",false)&&(p.getStringSet("safe_apps",emptySet())?:emptySet()).contains(pk)){val r=goAsync();Thread{try{val pr=Runtime.getRuntime().exec("su");val os=DataOutputStream(pr.outputStream);os.writeBytes("pm hide $pk; pm disable-user --user 0 $pk\n");os.writeBytes("exit\n");os.flush();os.close();pr.waitFor()}catch(e:Exception){}finally{r.finish()}}.start()}}}}
EOF
echo "✅ build.sh chunk E written (services + receiver)"
cat >> build.sh << 'E'

cat > $J/TerminalActivity.kt << 'EOF'
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
class TerminalActivity:AppCompatActivity(){
override fun onCreate(s:Bundle?){super.onCreate(s);setContentView(R.layout.activity_terminal)
val mg=findViewById<RadioGroup>(R.id.modeGroup);val pi=findViewById<EditText>(R.id.pkgInput);val bh=findViewById<MaterialButton>(R.id.btnHide);val bu=findViewById<MaterialButton>(R.id.btnUnhide);val ti=findViewById<EditText>(R.id.terminalInput);val br=findViewById<MaterialButton>(R.id.btnRunCmd);val to=findViewById<TextView>(R.id.terminalOutput)
bh.setOnClickListener{val p=pi.text.toString().trim();if(p.isNotEmpty()){to.text="Hiding $p...\n";exec("pm hide $p; pm disable-user --user 0 $p",mg,to)}else Toast.makeText(this,"Please enter a package name",Toast.LENGTH_SHORT).show()}
bu.setOnClickListener{val p=pi.text.toString().trim();if(p.isNotEmpty()){to.text="Unhiding $p...\n";exec("pm unhide $p; pm enable $p; cmd package install-existing --user 0 $p",mg,to)}else Toast.makeText(this,"Please enter a package name",Toast.LENGTH_SHORT).show()}
br.setOnClickListener{val c=ti.text.toString().trim();if(c.isNotEmpty()){to.append("Running: $c\n\n");exec(c,mg,to);ti.text.clear()}}}
private fun exec(cmd:String,mg:RadioGroup,ov:TextView){Thread{try{val id=mg.checkedRadioButtonId;val r=id==R.id.radioRoot;val sh=id==R.id.radioShizuku
val p=if(r)Runtime.getRuntime().exec("su")else if(sh){if(Shizuku.pingBinder()&&Shizuku.checkSelfPermission()==android.content.pm.PackageManager.PERMISSION_GRANTED)Shizuku.newProcess(arrayOf("sh","-c",cmd),null,null)else{Handler(Looper.getMainLooper()).post{ov.append("Shizuku Permission Not Granted.\n")};return@Thread}}else return@Thread
if(r){val os=DataOutputStream(p.outputStream);os.writeBytes("$cmd\n");os.writeBytes("exit\n");os.flush();os.close()}
val rd=p.inputStream.bufferedReader();val o=StringBuilder();var l:String?;while(rd.readLine().also{l=it}!=null)o.append(l).append("\n");val er=p.errorStream.bufferedReader();while(er.readLine().also{l=it}!=null)o.append(l).append("\n");p.waitFor()
Handler(Looper.getMainLooper()).post{if(o.isEmpty())ov.append("Done (No output)\n\n")else ov.append(o.toString()+"\n");val sv=ov.parent as ScrollView;sv.post{sv.fullScroll(ScrollView.FOCUS_DOWN)}}}catch(e:Exception){Handler(Looper.getMainLooper()).post{ov.append("Error: ${e.message}\n\n")}}}.start()}}
EOF
cat > $J/HideAppsActivity.kt << 'EOF'
package com.example.shtile
import android.content.pm.ApplicationInfo
import android.content.pm.PackageManager
import android.graphics.drawable.Drawable
import android.os.Bundle
import android.os.Handler
import android.os.Looper
import android.view.View
import android.widget.*
import androidx.appcompat.app.AppCompatActivity
import java.io.DataOutputStream
import com.google.android.material.materialswitch.MaterialSwitch
import com.google.android.material.checkbox.MaterialCheckBox
import com.google.android.material.button.MaterialButton
import com.google.android.material.tabs.TabLayout
import com.google.android.material.textfield.TextInputEditText
data class AppItem(val name:String,val pkg:String,val icon:Drawable?,var isChecked:Boolean,var isHidden:Boolean)
class HideAppsActivity:AppCompatActivity(){
private val appList=ArrayList<AppItem>();private var aa:AppAdapter?=null;private var ah:AppAdapter?=null;private val prefs by lazy{getSharedPreferences("HidePrefs",MODE_PRIVATE)}
override fun onCreate(s:Bundle?){super.onCreate(s);setContentView(R.layout.activity_hide_apps)
val tl=findViewById<TabLayout>(R.id.tabLayout);val pa=findViewById<View>(R.id.pageAllApps);val ph=findViewById<View>(R.id.pageHiddenApps);val si=findViewById<TextInputEditText>(R.id.searchInput);val ab=findViewById<MaterialButton>(R.id.applyBtn);val eb=findViewById<MaterialButton>(R.id.emergencyBtn);val ts=findViewById<Spinner>(R.id.timerSpinner)
val to=arrayOf("Disabled","5 Minutes","15 Minutes","30 Minutes","1 Hour","2 Hours");val tv=arrayOf(0,5,15,30,60,120);ts.adapter=ArrayAdapter(this,android.R.layout.simple_spinner_dropdown_item,to);ts.setSelection(tv.indexOf(prefs.getInt("timer_minutes",0)).coerceAtLeast(0));load()
tl.addOnTabSelectedListener(object:TabLayout.OnTabSelectedListener{override fun onTabSelected(t:TabLayout.Tab?){pa.visibility=if(t?.position==0)View.VISIBLE else View.GONE;ph.visibility=if(t?.position==1)View.VISIBLE else View.GONE;ab.visibility=if(t?.position==0)View.VISIBLE else View.GONE};override fun onTabUnselected(t:TabLayout.Tab?){};override fun onTabReselected(t:TabLayout.Tab?){}})
si.addTextChangedListener(object:android.text.TextWatcher{override fun beforeTextChanged(s:CharSequence?,st:Int,c:Int,a:Int){};override fun onTextChanged(s:CharSequence?,st:Int,b:Int,c:Int){aa?.filter(s);ah?.filter(s)};override fun afterTextChanged(s:android.text.Editable?){}})
ab.setOnClickListener{val sel=HashSet<String>();for(it in appList)if(it.isChecked)sel.add(it.pkg);val m=tv[ts.selectedItemPosition];prefs.edit().putStringSet("safe_apps",sel).putInt("timer_minutes",m).apply();Toast.makeText(this,"Saved! Timer: ${to[ts.selectedItemPosition]}",Toast.LENGTH_SHORT).show()}
eb.setOnClickListener{Toast.makeText(this,"Emergency Unhiding ALL Apps...",Toast.LENGTH_SHORT).show();Thread{try{val h=prefs.getStringSet("hidden_history",emptySet())?.toMutableSet()?:mutableSetOf();h.addAll(prefs.getStringSet("safe_apps",emptySet())?:emptySet());if(h.isEmpty())return@Thread;val c=StringBuilder();for(pk in h)c.append("pm unhide $pk; pm enable $pk; cmd package install-existing --user 0 $pk; ");val p=Runtime.getRuntime().exec("su");val os=DataOutputStream(p.outputStream);os.writeBytes(c.toString()+"\n");os.writeBytes("exit\n");os.flush();os.close();p.waitFor();prefs.edit().remove("hidden_history").putBoolean("is_pay_hidden",false).apply();Handler(Looper.getMainLooper()).post{Toast.makeText(this,"All Apps Restored!",Toast.LENGTH_LONG).show();load()}}catch(e:Exception){}}.start()}}
private fun load(){Thread{val pm=packageManager;appList.clear();val safe=prefs.getStringSet("safe_apps",emptySet())?:emptySet();val hist=prefs.getStringSet("hidden_history",emptySet())?:emptySet();val hp=HashSet<String>();try{val p=Runtime.getRuntime().exec("su -c pm list packages -d -u");val r=p.inputStream.bufferedReader();var l=r.readLine();while(l!=null){hp.add(l.replace("package:","").trim());l=r.readLine()}}catch(e:Exception){}
val apps=pm.getInstalledApplications(PackageManager.GET_META_DATA);for(a in apps){if(a.packageName==packageName)continue;val sys=(a.flags and ApplicationInfo.FLAG_SYSTEM)!=0;val hid=hp.contains(a.packageName);if(!sys||hid||pm.getLaunchIntentForPackage(a.packageName)!=null){try{val n=pm.getApplicationLabel(a).toString();if(n.isNotEmpty()&&!n.startsWith("com.")){appList.add(AppItem(n,a.packageName,a.loadIcon(pm),safe.contains(a.packageName),hid))}}catch(e:Exception){}}}
for(pk in hist)if(appList.none{it.pkg==pk}){try{val ai=pm.getApplicationInfo(pk,PackageManager.MATCH_UNINSTALLED_PACKAGES);appList.add(AppItem(pm.getApplicationLabel(ai).toString(),pk,ai.loadIcon(pm),safe.contains(pk),true))}catch(e:Exception){appList.add(AppItem("Ghost App",pk,null,safe.contains(pk),true))}}
Handler(Looper.getMainLooper()).post{aa=AppAdapter(this@HideAppsActivity,appList,false);findViewById<ListView>(R.id.appsList).adapter=aa;ah=AppAdapter(this@HideAppsActivity,appList,true);findViewById<ListView>(R.id.hiddenAppsList).adapter=ah;aa?.filter("");ah?.filter("")}}.start()}
inner class AppAdapter(c:android.content.Context,private val items:ArrayList<AppItem>,private val onlyHidden:Boolean):android.widget.BaseAdapter(){
private val inf=android.view.LayoutInflater.from(c);private var fi=ArrayList<AppItem>();private var q=""
override fun getCount()=fi.size;override fun getItem(p:Int):Any=fi[p];override fun getItemId(p:Int)=p.toLong()
override fun getView(p:Int,cv:android.view.View?,par:android.view.ViewGroup):android.view.View{val v=cv?:inf.inflate(R.layout.list_item_app,par,false);val it=fi[p]
v.findViewById<TextView>(R.id.appName).text=it.name;v.findViewById<TextView>(R.id.appPkg).text=it.pkg;val ic=v.findViewById<ImageView>(R.id.appIcon);if(it.icon!=null)ic.setImageDrawable(it.icon)else ic.setImageResource(android.R.drawable.ic_menu_help)
val cb=v.findViewById<MaterialCheckBox>(R.id.appCheck);cb.setOnCheckedChangeListener(null);cb.isChecked=it.isChecked;cb.setOnCheckedChangeListener{_,isC->it.isChecked=isC;filter(q)}
val sw=v.findViewById<MaterialSwitch>(R.id.appSwitch);sw.setOnCheckedChangeListener(null);sw.isChecked=it.isHidden;sw.setOnCheckedChangeListener{_,isC->it.isHidden=isC;Thread{try{val h=prefs.getStringSet("hidden_history",emptySet())?.toMutableSet()?:mutableSetOf();val pr=Runtime.getRuntime().exec("su");val os=DataOutputStream(pr.outputStream);if(isC){h.add(it.pkg);os.writeBytes("pm hide ${it.pkg}; pm disable-user --user 0 ${it.pkg}\n")}else{h.remove(it.pkg);os.writeBytes("pm unhide ${it.pkg}; pm enable ${it.pkg}; cmd package install-existing --user 0 ${it.pkg}\n")};prefs.edit().putStringSet("hidden_history",h).apply();os.writeBytes("exit\n");os.flush();os.close();pr.waitFor();Handler(Looper.getMainLooper()).post{load()}}catch(e:Exception){}}.start()}
return v}
fun filter(cs:CharSequence?){q=cs?.toString()?.lowercase()?:"";var b=if(q.isEmpty())items else items.filter{it.name.lowercase().contains(q)||it.pkg.lowercase().contains(q)};if(onlyHidden)b=b.filter{it.isHidden};fi=ArrayList(b.sortedWith(compareByDescending<AppItem>{it.isChecked}.thenBy{it.name}));notifyDataSetChanged()}}}
EOF
cat > $J/MainActivity.kt << 'EOF'
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
import rikka.shizuku.Shizuku
class MainActivity:AppCompatActivity(){
private val RC=1001;private var adb=false
private val permListener=Shizuku.OnRequestPermissionResultListener{rc,res->if(rc==RC){if(res==android.content.pm.PackageManager.PERMISSION_GRANTED){adb=true;Toast.makeText(this,"Shizuku Permission Granted!",Toast.LENGTH_SHORT).show()}else Toast.makeText(this,"Shizuku Permission Denied.",Toast.LENGTH_SHORT).show()}}
override fun onCreate(s:Bundle?){super.onCreate(s);setContentView(R.layout.activity_main)
val p=getSharedPreferences("GucciPrefs",Context.MODE_PRIVATE);val ki=findViewById<EditText>(R.id.keyInput);val bi=findViewById<EditText>(R.id.brutalInput);val dn=findViewById<TextView>(R.id.driverNameText);val tt=findViewById<TextView>(R.id.titleText);val st=findViewById<TextView>(R.id.subtitleText);val ca=findViewById<TextView>(R.id.contactAdminText);val sb=findViewById<TextView>(R.id.statusBadge)
st.text=android.text.Html.fromHtml("Premium Panel By <font color='#00E5A0'>GUCCI</font>",android.text.Html.FROM_HTML_MODE_LEGACY);ki.setText(p.getString("license_key",""));bi.setText(p.getString("brutal_option","7"))
val m=mapOf("1" to "QX1","2" to "GT","3" to "rt-dev","4" to "rt-proc","5" to "QX(2)","6" to "KPM","7" to "DitPro KPM","8" to "KMA KPM","9" to "LDK KPM","10" to "Paradise")
bi.addTextChangedListener(object:TextWatcher{override fun beforeTextChanged(s:CharSequence?,st:Int,c:Int,a:Int){};override fun onTextChanged(s:CharSequence?,st:Int,b:Int,c:Int){dn.text=m[s.toString().trim()]?:"Unknown"};override fun afterTextChanged(s:Editable?){}})
dn.text=m[bi.text.toString()]?:"Unknown"
val otg={try{startActivity(Intent(Intent.ACTION_VIEW,Uri.parse("https://t.me/Gucci8240")))}catch(e:Exception){Toast.makeText(this,"Telegram not installed",Toast.LENGTH_SHORT).show()}}
tt.setOnClickListener{otg()};st.setOnClickListener{otg()};ca.setOnClickListener{otg()}
fun chk(){Thread{val r=try{val pr=ProcessBuilder("su","-c","id").start();pr.inputStream.bufferedReader().readText().contains("uid=0")}catch(e:Exception){false}
Handler(Looper.getMainLooper()).post{
if(r){sb.text="● ROOT ACTIVE";sb.setTextColor(0xFF00E5A0.toInt())}else if(adb){sb.text="● SHIZUKU ACTIVE";sb.setTextColor(0xFF00E5A0.toInt())}else{sb.text="● NO ACCESS";sb.setTextColor(0xFFFF4D4D.toInt())}
if(!r&&!adb){val sh=try{packageManager.getPackageInfo("moe.shizuku.privileged.api",0);true}catch(e:Exception){false}
val dv=this@MainActivity.layoutInflater.inflate(R.layout.dialog_root,null);val bs=dv.findViewById<Button>(R.id.btnShizuku);if(!sh)bs.visibility=android.view.View.GONE
val d=AlertDialog.Builder(this@MainActivity).setView(dv).setCancelable(false).create();d.window?.setBackgroundDrawableResource(android.R.color.transparent)
dv.findViewById<Button>(R.id.btnGrant).setOnClickListener{d.dismiss();chk()};dv.findViewById<Button>(R.id.btnExit).setOnClickListener{d.dismiss();this@MainActivity.finish()}
bs.setOnClickListener{d.dismiss();if(Shizuku.pingBinder()){if(Shizuku.checkSelfPermission()==android.content.pm.PackageManager.PERMISSION_GRANTED){adb=true;Toast.makeText(this@MainActivity,"Shizuku Mode Active",Toast.LENGTH_SHORT).show()}else Shizuku.requestPermission(RC)}else Toast.makeText(this@MainActivity,"Shizuku is not running!",Toast.LENGTH_LONG).show()}
d.show()}}}.start()}
Shizuku.addRequestPermissionResultListener(permListener);chk()
findViewById<Button>(R.id.saveKeyBtn).setOnClickListener{p.edit().putString("license_key",ki.text.toString().trim()).putString("brutal_option",bi.text.toString().trim()).apply();Toast.makeText(this,"✅ Configuration Saved",Toast.LENGTH_SHORT).show()}
findViewById<Button>(R.id.loadFilesBtn).setOnClickListener{p.edit().putString("license_key",ki.text.toString().trim()).putString("brutal_option",bi.text.toString().trim()).apply();Installer.installAll(this){ok->Toast.makeText(this,if(ok)"✅ Files Loaded" else "❌ Failed. Check root.",Toast.LENGTH_SHORT).show()}}
findViewById<ImageButton>(R.id.hideAppsIcon).setOnClickListener{startActivity(Intent(this,HideAppsActivity::class.java))}
findViewById<ImageButton>(R.id.terminalIcon).setOnClickListener{startActivity(Intent(this,TerminalActivity::class.java))}}
override fun onDestroy(){Shizuku.removeRequestPermissionResultListener(permListener);super.onDestroy()}}
EOF

# ── BUILD ──
echo "[3/4] Building APK..."
gradle assembleDebug

echo ""
echo "════════════════════════════════════"
echo "   ✅ BUILD COMPLETE"
echo "════════════════════════════════════"
ls -lh app/build/outputs/apk/debug/app-debug.apk 2>/dev/null && \
echo "📍 APK: app/build/outputs/apk/debug/app-debug.apk" || \
echo "❌ Build failed — check output above"
E
echo "✅ build.sh FULLY WRITTEN"
chmod +x build.sh
echo "📄 Total size: $(wc -c < build.sh) bytes"
