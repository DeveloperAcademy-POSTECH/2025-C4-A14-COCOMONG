# 🚀 Beat100

<img width="200" height="200" alt="Beat100_Logo" src="https://github.com/user-attachments/assets/7f700f0e-8ba7-4930-bf7e-e73b61820d62" />

[![Swift](https://img.shields.io/badge/Swift-5.9-orange.svg)]()
[![Xcode](https://img.shields.io/badge/Xcode-15.0-blue.svg)]()
[![License](https://img.shields.io/badge/license-MIT-green.svg)]()

---

## 🗂 목차
- [소개](#소개)
- [프로젝트 기간](#프로젝트-기간)
- [기술 스택](#기술-스택)
- [기능](#기능)
- [시연](#시연)
- [폴더 구조](#폴더-구조)
- [팀 소개](#팀-소개)
- [Git 컨벤션](#git-컨벤션)
- [테스트 방법](#테스트-방법)
- [프로젝트 문서](#프로젝트-문서)
- [라이선스](#lock_with_ink_pen-license)

---

## 📱 소개

<img width="3291" height="1040" alt="image" src="https://github.com/user-attachments/assets/c19fe824-7ee6-493b-b43b-c8998634310f" />

> ### **Problem and Solution**

**Problem:** **단체 CPR 교육**을 받고 있는 사람이 강사의 1대1 코칭을 받지 못해 정확한 자세를 취하고 있는지 확신하지 못하는 상황에서

**Solution:** 우리의 앱에 진입해서 **CPR을 실시(연습)하면서, Core Motion이 제공하는 가슴 압박 깊이와 횟수에 대한 피드백과 CPR 실시 후에 리포트를 제공해** 교육 현장에서 CPR이 정확히 이루어지고 있는지 확인할 수 있게 한다.


## 📆 프로젝트 기간
- 전체 기간: `2025.06.23 - 2025.08.01`
- 개발 기간: `2025.07.17 - 2025.07.31`


## 🛠 기술 스택

- Swift / SwiftUI / Combine
- Core Motion / Core Data / Watch Connectivity / HealthKit
- 아키텍처: MVVM
- 기타 도구: Figma, Confluence, JIRA, Xcode Cloud, GitHub


## 🌟 주요 기능

- ✅ 기능 1: CPR 측정중 실시간 iOS 시각 리듬
  <img width="1044" height="602" alt="Screenshot 2025-08-01 at 9 41 07 AM" src="https://github.com/user-attachments/assets/d23f0b9b-63fc-4b84-b928-39622735c183" />
- ✅ 기능 2: CPR 측정 결과 리포트 제공
  <img width="960" height="865" alt="Screenshot 2025-08-01 at 9 41 26 AM" src="https://github.com/user-attachments/assets/40f6a4b8-acaf-4c13-8c8b-10a6cd38b357" />

## 🖼 화면 구성 및 시연

| 기능 | 설명 | 이미지 |
|------|------|--------|
| 예시1 | 기능 요약 | ![gif](링크) |
| 예시2 | 기능 요약 | ![gif](링크) |


## 🧱 폴더 구조

Beat100 iOS App
```
📦Beat100
┣ 📂App
┣ 📂Resources
┃ ┣ 📂Common
┃ ┃ ┣ 📂Components
┃ ┃ ┃ ┣ 📂Buttons
┃ ┃ ┃ ┣ 📂Card
┃ ┃ ┃ ┣ 📂Measuring
┃ ┃ ┃ ┣ 📂ProgressBar
┃ ┃ ┃ ┗ 📂Toolbars
┃ ┃ ┣ 📂DesignSystem
┃ ┃ ┣ 📂Enum
┃ ┃ ┣ 📂Protocol
┃ ┗ 📂Extension
┣ 📂Models
┃ ┣ 📂CoreDataModel
┃ ┗ 📂Dto
┣ 📂Presentation
┃ ┣ 📂Countdown
┃ ┣ 📂Guide
┃ ┃ ┣ 📂CPRGuide
┃ ┃ ┗ 📂MeasurementGuide
┃ ┣ 📂iOSMeasuringFlow
┃ ┣ 📂MainTab
┃ ┣ 📂Measuring
┃ ┗ 📂Report
┣ 📂Service
┃ ┗ 📂Manager
┃   ┣ 📂CPRAnalysis
┃   ┗ 📂WatchConnect
┣ 📂Util
┣ 📂Sources
┃ ┣ 📂Fonts
┃ ┗ 📂Rive
┣ 📂Assets
┣ 📂Beat100
┗ 📂Info
```
Beat100 WatchOS App
```
📦WatchBeat100 Watch App
┣ 📂App
┣ 📂Resources
┃ ┣ 📂Common
┃ ┃ ┣ 📂Components
┃ ┃ ┣ 📂DesignSystem
┃ ┃ ┣ 📂Enum
┃ ┃ ┗ 📂Protocol
┃ ┗ 📂Extension
┣ 📂Presentation
┃ ┣ 📂BeforeWatch
┃ ┣ 📂ChooseCycle
┃ ┣ 📂Finish
┃ ┗ 📂MeasuringFlow
┣ 📂Service
┃ ┗ 📂Manager
┣ 📂Utils
┣ 📂Sources
┃ ┗ 📂Fonts
┣ 📂Assets
┗ 📂WatchBeat100 Watch App
```


## 🧑‍💻 팀 소개

| 이름 | 역할 | GitHub |
|------|------|--------|
| **Zani (이창희)** | Product Manager |  |
| **Green (고승아)** | Product Designer |  |
| **Singsing (이시은)** | Product Designer |  |
| **Ivy (이현주)** | iOS Developer | [@dlguszoo](https://github.com/dlguszoo) |
| **Joid (나현흠)** | iOS Developer | [@nakisara01](https://github.com/nakisara01) |
| **Oliver (홍석호)** | iOS Developer | [@cherry-go-round](https://github.com/cherry-go-round) |

## 🔖 브랜치 전략
- `main`: 배포 가능한 안정 버전
- `dev`: 통합 개발 브랜치
- `feat/*`: 기능 개발 브랜치
- `design/*`: 디자인 구현 브랜치
- `chore/*`: 패키지, 파일 수정 브랜치
- `bug/*`: 버그 수정 브랜치
- `hotfix/*`: 긴급 수정 브랜치

## 🌀 커밋 메시지 컨벤션
`(예시)`  
[#(issue Number)] + [Conventional Commits](https://www.conventionalcommits.org)

### 예시
- [#72] feat: 로그인 화면 추가
- [#21] fix: 홈 진입 시 크래시 수정
- [#11] refactor: 데이터 모델 구조 정리


## ✅ 테스트 방법

1. 이 저장소를 클론합니다.
```bash
git clone https://github.com/DeveloperAcademy-POSTECH/2025-C4-A14-COCOMONG/project.git
```
2. `Xcode`로 `.xcodeproj` 또는 `.xcworkspace` 열기
3. 시뮬레이터 환경 설정: iPhone 15 / iOS 17
4. `Cmd + R`로 실행 / `Cmd + U`로 테스트 실행


## 📎 프로젝트 문서

- [기획 히스토리](링크)
- [디자인 히스토리](링크)
- [기술 문서 (아키텍처 등)](링크)


## 📝 License

This project is licensed under the ~~[CHOOSE A LICENSE](https://choosealicense.com). and update this line~~
