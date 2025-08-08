# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

MacCalendarはSwiftUIを使用したmacOSカレンダーアプリケーションです。Xcodeプロジェクトとして構成されており、メインアプリ、ユニットテスト、UIテストが含まれています。

## Commands

### Build and Run
```bash
# Xcodeでビルド
xcodebuild -project MacCalendar.xcodeproj -scheme MacCalendar -configuration Debug build

# アプリケーションを実行
xcodebuild -project MacCalendar.xcodeproj -scheme MacCalendar -configuration Debug -sdk macosx build
open build/Debug/MacCalendar.app
```

### Testing
```bash
# ユニットテストを実行
xcodebuild test -project MacCalendar.xcodeproj -scheme MacCalendar -destination 'platform=macOS'

# UIテストのみ実行
xcodebuild test -project MacCalendar.xcodeproj -scheme MacCalendar -destination 'platform=macOS' -only-testing:MacCalendarUITests
```

## Code Architecture

### Main Application Structure
- `MacCalendarApp.swift`: アプリケーションのエントリーポイント。WindowGroupを使用してContentViewを表示
- `ContentView.swift`: メインのビューコンポーネント。現在はシンプルなHello Worldインターフェース
- `MacCalendar.entitlements`: アプリのサンドボックス設定（読み取り専用ファイルアクセス権限付き）

### Test Structure
- `MacCalendarTests/`: Swift Testingフレームワークを使用したユニットテスト
- `MacCalendarUITests/`: XCTestを使用したUIテスト（パフォーマンステストを含む）

### Key Technical Details
- SwiftUIベースのmacOSアプリケーション
- App Sandboxが有効
- ユニットテストにはSwift Testingフレームワークを使用
- UIテストにはXCTestを使用