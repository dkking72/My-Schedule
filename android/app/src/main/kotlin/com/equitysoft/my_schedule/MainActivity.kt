package com.equitysoft.my_schedule

//import android.os.Bundle
//import android.support.v7.app.AppCompatActivity
//import android.widget.Button
//import android.widget.EditText
//import android.widget.Toast
//import believe.cht.fadeintextview.TextViewListener
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.android.SplashScreen


//class MainActivity : FlutterActivity() {
//    override fun onCreate(savedInstanceState: Bundle?) {
//        // Aligns the Flutter view vertically with the window.
//        WindowCompat.setDecorFitsSystemWindows(getWindow(), false)
//
//        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
//            // Disable the Android splash screen fade out animation to avoid
//            // a flicker before the similar frame is drawn in Flutter.
//            splashScreen.setOnExitAnimationListener { splashScreenView -> splashScreenView.remove() }
//        }
//
//        super.onCreate(savedInstanceState)
//    }
//}

class MainActivity: FlutterActivity() {
    override fun provideSplashScreen(): SplashScreen = SplashView()
}


//
//class MainActivity : AppCompatActivity() {
//    var textView: TextView? = null
//    var editText: EditText? = null
//    var button: Button? = null
//    protected fun onCreate(savedInstanceState: Bundle?) {
//        super.onCreate(savedInstanceState)
//        setContentView(R.layout.activity_main)
//        textView = findViewById(R.id.textView)
//        editText = findViewById(R.id.editText)
//        button = findViewById(R.id.button)
//        textView = findViewById(R.id.textView)
//        textView.setListener(object : TextViewListener() {
//            fun onTextStart() {
//                Toast.makeText(getBaseContext(), "onTextStart() fired!", Toast.LENGTH_SHORT).show()
//            }
//
//            fun onTextFinish() {
//                Toast.makeText(getBaseContext(), "onTextFinish() fired!", Toast.LENGTH_SHORT).show()
//            }
//        })
//        editText = findViewById(R.id.editText)
//        button = findViewById(R.id.button)
//        editText.setText(getResources().getString(R.string.welcome_message))
//        button!!.setOnClickListener { textView.setText(editText!!.text.toString()) }
//    }
//}