package com.equitysoft.my_schedule

import android.content.Context
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import io.flutter.embedding.android.SplashScreen

//class SplashActivity : AppCompatActivity() {



//    override fun onCreate(savedInstanceState: Bundle?) {
//        super.onCreate(savedInstanceState)
//        setContentView(R.layout.activity_splash)
//        supportActionBar?.hide();
//        val splash = findViewById<View>(R.id.spalsh) as View
//
//        splash.postDelayed(Runnable {
//            splash.setVisibility(View.GONE);
//        }, 3000);
//
////        val content: View = findViewById(R.layout.activity_splash)
////        content.viewTreeObserver.addOnPreDrawListener(
////                object : ViewTreeObserver.OnPreDrawListener {
////                    override fun onPreDraw(): Boolean {
////                        content.remove
////                    }
////                }
////        )
//    }
//}

class SplashView : SplashScreen {
    override fun createSplashView(context: Context, savedInstanceState: Bundle?): View? =
        LayoutInflater.from(context).inflate(R.layout.activity_splash, null, false)

    override fun transitionToFlutter(onTransitionComplete: Runnable) {
        onTransitionComplete.run()
    }
}