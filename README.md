# OptimusCam 📸
### Native Computational Photography & Level_3 RAW Camera for Redmi 15 5G

OptimusCam is a custom native Android camera engine built with **Jetpack Compose** and **Android Camera2 API**, specifically designed to bypass aggressive OEM noise-smearing algorithms and extract the maximum optical potential from your phone's **LEVEL_3** camera sensor.

---

## 🌟 Why OptimusCam?

Stock camera software on budget and mid-range devices often ruins good sensor optics by applying heavy-handed temporal smoothing and bilateral blurring. This creates an artificial "oil-painting" effect that wipes out skin pores, hair strands, fabric textures, and foliage.

OptimusCam unlocks your phone's hardware by directly accessing the uncompressed sensor buffer streams:

1. **Optimus Enhanced (Multi-Frame Burst Stacking):**
   - Fires an 8-frame rapid burst sequence with Zero Shutter Lag (ZSL).
   - Averages luminance and chrominance planes across all frames ($E[noise] = 0$).
   - Cuts sensor shot/thermal noise by up to **65%** ($1/\sqrt{8} \approx 0.35$).
   - Preserves 100% of real optical micro-textures without artificial halos or plastic smoothing.
   - Applies an adaptive S-curve tone mapper with dynamic shadow lifting and highlight protection.

2. **Pro RAW (Adobe DNG Capture):**
   - Bypasses all processing and captures uncompressed 16-bit Bayer sensor data.
   - Encapsulates lens shading correction maps, white balance neutrals, and color calibration matrices into an Adobe DNG container using `DngCreator`.
   - Ready for professional color grading in Adobe Lightroom Mobile or Snapseed.

3. **Standard Instant Capture:**
   - Single-frame high-quality capture for fast-moving action.

---

## 🎛 Pro Camera Controls & Features

- **Live Sensor Telemetry HUD:** Real-time display of active ISO, shutter speed (e.g. `1/120s`), focus distance, and hardware tier badge (`LEVEL_3`).
- **Exposure Compensation (EV):** Quick slider from -3.0 EV to +3.0 EV.
- **Manual ISO Control:** Auto, 50, 100, 200, 400, 800, 1600, 3200, 6400.
- **Manual Shutter Speed:** Auto, 1/4000s up to 1s.
- **Focus Control:** Continuous AF, Tap-to-Focus with animated metering box, and Manual Focus distance slider.
- **White Balance:** Auto, Daylight, Cloudy, Incandescent, Fluorescent, Shade.
- **Flash / Torch Modes:** Auto, Forced On, Off, Continuous Torch.
- **Composition Grid:** Rule-of-Thirds overlay.
- **Gyro Horizon Leveler:** Accelerometer-based tilt indicator that turns vibrant green when the phone is perfectly level.
- **Gallery Integration:** Tap the thumbnail to preview captured photos or open directly in the system gallery / Lightroom.

---

## 🏗 Architecture & Code Structure

```
app/src/main/java/com/optimus/cam/
├── MainActivity.kt               # Single-activity Compose container
├── camera/
│   ├── CameraEngine.kt           # Camera2 session, raw sensor streams, ZSL burst
│   └── CameraModels.kt           # Telemetry, CaptureMode, ProControlTab, UiState
├── processing/
│   └── ComputationalEngine.kt    # Multi-frame YUV temporal averaging & tone mapping
├── sensors/
│   └── OrientationSensor.kt      # Gravity & accelerometer for horizon leveler
├── storage/
│   └── StorageManager.kt         # Scoped MediaStore storage (JPG & DNG)
├── theme/
│   ├── Color.kt                  # Pro dark camera theme palette
│   ├── Theme.kt                  # OptimusCamTheme Material3 wrapper
│   └── Type.kt                   # Bundled CameraSans typography
└── ui/
    ├── CameraScreen.kt           # Master viewfinder and partitioned layout
    ├── CameraViewModel.kt        # Reactive state machine (StateFlow)
    ├── PermissionScreen.kt       # Camera & storage runtime permissions
    └── components/
        ├── ControlsOverlay.kt    # TopBar, BottomDeck, TelemetryBadge, Shutter button
        ├── ProSliders.kt         # Manual EV, ISO, Shutter, Focus, WB controls
        ├── ViewfinderView.kt     # SurfaceView, Framing brackets, Grid, Leveler
        └── PhotoPreviewDialog.kt # In-app fullscreen photo inspector
```

---

## 🛠 Tech Stack & Specifications

- **UI Framework:** Jetpack Compose + Material 3 (100% declarative UI)
- **Camera Pipeline:** Android `Camera2` API (`LEVEL_3` hardware capabilities)
- **Language:** Kotlin 2.3.20 + Coroutines & StateFlow
- **Minimum SDK:** Android 7.0 (API 24)
- **Target SDK:** Android 16 (API 36)
- **Build System:** Gradle 9.0 + Android Gradle Plugin 9.0.1 + Java 17

---

## 🚀 How to Build & Install

### Option 1: One-Click Script (Recommended)
1. Plug your Redmi phone into your laptop via USB.
2. Ensure **USB Debugging** and **Install via USB** are toggled **ON** in Developer Options.
3. Double-click `install.bat` in this folder (or run `.\install.bat` in terminal).

### Option 2: ADB Command
```powershell
$adb = "$env:USERPROFILE\AppData\Local\Android\Sdk\platform-tools\adb.exe"
& $adb install -r -d app/build/outputs/apk/debug/app-debug.apk
& $adb shell am start -n com.optimus.cam/.MainActivity
```

### Option 3: Direct APK Transfer
Transfer `app/build/outputs/apk/debug/app-debug.apk` to your phone via USB or WhatsApp/Telegram and tap to install!
