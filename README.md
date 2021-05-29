# lecture
A new Flutter project.

### 파일 구조

```bash
├── data
├── └── model - json 응답 모델
├── └── remote - api 서버의 데이터에 접근하는 클래스
├── └── repository - 적절한 data source를 선택하는 클래스
├
├── domain : useCase
├
├── presentation
├── └── home - 홈 화면의 위젯과 Bloc
├── └── lectures_total - 과목 전체보기 화면의 위젯, Bloc은 홈 화면의 Bloc을 사용
├── └── qr - qr 코드 스캐너 화면
├── └── web_view - 웹뷰 화면
├
└── symbols : 재사용 가능한 문자열의 집합입니다.
```

### 1. 빌드 방법

```bash
   flutter pub get
   flutter pub run build_runner build --delete-conflicting-outputs
   flutter run --release
```

### 2. 테스트 환경

```bash
❯ flutter doctor -v
[✓] Flutter (Channel stable, 2.2.0, on macOS 11.2.3 20D91 darwin-x64, locale en-KR)
    • Flutter version 2.2.0 at /Users/jang-wonpyo/development/flutter
    • Framework revision b22742018b (2 weeks ago), 2021-05-14 19:12:57 -0700
    • Engine revision a9d88a4d18
    • Dart version 2.13.0

[✓] Android toolchain - develop for Android devices (Android SDK version 29.0.3)
    • Android SDK at /Users/jang-wonpyo/Library/Android/sdk
    • Platform android-30, build-tools 29.0.3
    • ANDROID_HOME = /Users/jang-wonpyo/Library/Android/sdk/
    • Java binary at: /Applications/Android Studio.app/Contents/jre/jdk/Contents/Home/bin/java
    • Java version OpenJDK Runtime Environment (build 1.8.0_242-release-1644-b3-6915495)
    • All Android licenses accepted.

[✓] Xcode - develop for iOS and macOS
    • Xcode at /Applications/Xcode.app/Contents/Developer
    • Xcode 12.5, Build version 12E262
    • CocoaPods version 1.10.1

[✓] Chrome - develop for the web
    • Chrome at /Applications/Google Chrome.app/Contents/MacOS/Google Chrome

[✓] Android Studio (version 4.1)
    • Android Studio at /Applications/Android Studio.app/Contents
    • Flutter plugin can be installed from:
      🔨 https://plugins.jetbrains.com/plugin/9212-flutter
    • Dart plugin can be installed from:
      🔨 https://plugins.jetbrains.com/plugin/6351-dart
    • Java version OpenJDK Runtime Environment (build 1.8.0_242-release-1644-b3-6915495)

[✓] IntelliJ IDEA Community Edition (version 2020.3.3)
    • IntelliJ at /Applications/IntelliJ IDEA CE.app
    • Flutter plugin can be installed from:
      🔨 https://plugins.jetbrains.com/plugin/9212-flutter
    • Dart plugin can be installed from:
      🔨 https://plugins.jetbrains.com/plugin/6351-dart

[✓] VS Code (version 1.55.0)
    • VS Code at /Applications/Visual Studio Code.app/Contents
    • Flutter extension version 3.22.0

[✓] Connected device (3 available)
    • 장원표의 iPhone (mobile) • 00008030-0009181601F3802E • ios            • iOS 14.4.2
    • macOS (desktop)      • macos                     • darwin-x64     • macOS 11.2.3 20D91 darwin-x64
    • Chrome (web)         • chrome                    • web-javascript • Google Chrome 90.0.4430.212

• No issues found!
```
