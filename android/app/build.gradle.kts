plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
    id("com.google.gms.google-services") // لتفعيل Firebase
}

android {
    namespace = "com.sanad_2025.qa"
    compileSdk = 36 // يمكنك تغييره حسب Flutter SDK

    defaultConfig {
        applicationId = "com.sanad_2025.qa"
        minSdk = flutter.minSdkVersion
        targetSdk = 36
        versionCode = 3
        versionName = "1.0.2"
    }

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = "11"
    }

    signingConfigs {
        create("release") {
            storeFile = file("upload-keystore.jks")
            storePassword = "123456"
            keyAlias = "upload"
            keyPassword = "123456"
        }
    }

    buildTypes {
        getByName("release") {
            signingConfig = signingConfigs.getByName("release")
            isMinifyEnabled = false
            isShrinkResources = false
        }
    }
}

dependencies {
    implementation("org.jetbrains.kotlin:kotlin-stdlib:1.9.0")
}

flutter {
    source = "../.."
}
