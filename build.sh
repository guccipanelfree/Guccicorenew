cat > app/src/main/res/drawable/ic_home.xml << 'EOF'
<vector xmlns:android="http://schemas.android.com/apk/res/android" android:width="24dp" android:height="24dp" android:viewportWidth="24" android:viewportHeight="24"><path android:fillColor="#FFFFFFFF" android:pathData="M10,20v-6h4v6h5v-8h3L12,3 2,12h3v8z"/></vector>
EOF
cat > app/src/main/res/drawable/ic_hide.xml << 'EOF'
<vector xmlns:android="http://schemas.android.com/apk/res/android" android:width="24dp" android:height="24dp" android:viewportWidth="24" android:viewportHeight="24"><path android:fillColor="#FFFFFFFF" android:pathData="M12,7c2.76,0 5,2.24 5,5 0,0.65 -0.13,1.26 -0.36,1.83l2.92,2.92c1.51,-1.26 2.7,-2.89 3.43,-4.75 -1.73,-4.39 -6,-7.5 -11,-7.5 -1.4,0 -2.74,0.25 -3.98,0.7l2.16,2.16C10.74,7.13 11.35,7 12,7zM2,4.27l2.28,2.28 0.46,0.46C3.08,8.3 1.78,10.02 1,12c1.73,4.39 6,7.5 11,7.5 1.55,0 3.03,-0.3 4.38,-0.84l0.42,0.42L19.73,22 21,20.73 3.27,3 2,4.27zM7.53,9.8l1.55,1.55c-0.05,0.21 -0.08,0.43 -0.08,0.65 0,1.66 1.34,3 3,3 0.22,0 0.44,-0.03 0.65,-0.08l1.55,1.55c-0.67,0.33 -1.41,0.53 -2.2,0.53 -2.76,0 -5,-2.24 -5,-5 0,-0.79 0.2,-1.53 0.53,-2.2zM11.84,9.02l3.15,3.15 0.02,-0.16c0,-1.66 -1.34,-3 -3,-3l-0.17,0.01z"/></vector>
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
<LinearLayout android:orientation="horizontal" android:layout_width="match_parent" android:layout_height="wrap_content" android:paddingBottom="24dp" android:gravity="space_between">
<ImageButton android:id="@+id/hideAppsIcon" android:layout_width="60dp" android:layout_height="60dp" android:padding="16dp" android:background="?attr/selectableItemBackgroundBorderless" android:src="@drawable/ic_hide" android:tint="@color/accent_green"/>
<ImageButton android:id="@+id/homeIcon" android:layout_width="60dp" android:layout_height="60dp" android:padding="16dp" android:background="?attr/selectableItemBackgroundBorderless" android:src="@drawable/ic_home" android:tint="@color/accent_green"/>
</LinearLayout>
</LinearLayout>
</ScrollView>
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
import java.io.DataOutputStream
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
                        val dialogView = layoutInflater.inflate(R.layout.dialog_root, null)
                        val dialog = AlertDialog.Builder(this).setView(dialogView).setCancelable(false).create()
                        dialog.window?.setBackgroundDrawableResource(android.R.color.transparent)
                        dialogView.findViewById<Button>(R.id.btnGrant).setOnClickListener { dialog.dismiss(); chkRoot() }
                        dialogView.findViewById<Button>(R.id.btnExit).setOnClickListener { dialog.dismiss(); finish() }
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
        findViewById<ImageButton>(R.id.homeIcon).setOnClickListener {
            val startMain = Intent(Intent.ACTION_MAIN)
            startMain.addCategory(Intent.CATEGORY_HOME)
            startMain.flags = Intent.FLAG_ACTIVITY_NEW_TASK
            startActivity(startMain)
        }
        findViewById<ImageButton>(R.id.hideAppsIcon).setOnClickListener {
            Thread {
                val pm = packageManager
                val apps = pm.getInstalledApplications(0)
                val appNames = ArrayList<String>()
                val appPkgs = ArrayList<String>()
                for (app in apps) {
                    if (app.packageName != packageName) {
                        appNames.add(pm.getApplicationLabel(app).toString())
                        appPkgs.add(app.packageName)
                    }
                }
                Handler(Looper.getMainLooper()).post {
                    val builder = AlertDialog.Builder(this)
                    builder.setTitle("Select App to Hide")
                    builder.setItems(appNames.toTypedArray()) { _, which ->
                        val selectedPkg = appPkgs[which]
                        val hideTypeBuilder = AlertDialog.Builder(this)
                        hideTypeBuilder.setTitle("Hide ${appNames[which]}")
                        hideTypeBuilder.setMessage("Choose hide mode:")
                        hideTypeBuilder.setPositiveButton("Normal Hide") { _, _ -> runRootCmd("pm disable-user --user 0 $selectedPkg") }
                        hideTypeBuilder.setNeutralButton("Complete Hide") { _, _ -> runRootCmd("pm hide $selectedPkg") }
                        hideTypeBuilder.setNegativeButton("Cancel", null)
                        hideTypeBuilder.show()
                    }
                    builder.show()
                }
            }.start()
        }
    }
    fun runRootCmd(cmd: String) {
        Thread {
            try {
                val p = Runtime.getRuntime().exec("su")
                val os = DataOutputStream(p.outputStream)
                os.writeBytes(cmd + "\n")
                os.writeBytes("exit\n")
                os.flush()
                os.close()
                p.waitFor()
                Handler(Looper.getMainLooper()).post {
                    Toast.makeText(applicationContext, "Executed!", Toast.LENGTH_SHORT).show()
                }
            } catch (e: Exception) {}
        }.start()
    }
}
EOF
gradle assembleDebug
