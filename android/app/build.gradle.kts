import java.util.Properties

plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.sun.pic_grid"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.sun.pic_grid"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    // signingConfigs block removed
    signingConfigs {
        val properties = Properties()
        properties.load(project.rootProject.file("local.properties").inputStream())

        create("config") {
            keyAlias = properties.getProperty("KEYSTORE_ALIAS")
            keyPassword = properties.getProperty("KEYSTORE_ALIAS_PASSWORD")
            storeFile = file(properties.getProperty("KEYSTORE_FILE"))
            storePassword = properties.getProperty("KEYSTORE_PASSWORD")
        }
    }

    buildTypes {
        getByName("debug") {
            isDebuggable = true
        }

        getByName("release") {
            signingConfig = signingConfigs.getByName("config")
            isMinifyEnabled = true
            isShrinkResources = true
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
        }
    }
    // 您的 productFlavors
    flavorDimensions += "flavors"
    productFlavors {
        create("local") {
            dimension = "flavors"
            resValue("string", "app_name", "PicGrids local")
        }
        create("dev") {
            dimension = "flavors"
            resValue("string", "app_name", "PicGrids T")
        }
        create("prod") {
            dimension = "flavors"
            resValue("string", "app_name", "PicGrids")
        }
    }
}

flutter {
    source = "../.."
}
