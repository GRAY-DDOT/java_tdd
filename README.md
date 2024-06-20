# 1. 프로젝트 소개
이 프로젝트는 자바 개발 입문자가 자바 문법과 TDD(Test Driven Development)를 함께 배울 수 있도록 설계 및 구현 중에 있다.
- 개발 환경: Intelij, Java 17 (Corretto), Gradle 8.2, JUnit5
- 중요 철학:
    - MVC 패턴
    - OOP SOLID 원칙
    - TDD

# 2. 버전 별 추가 사항 및 구현 일정
## 버전

| 버전             |    날짜    | 내용                             |
|:---------------|:--------:|:-------------------------------|
| 0.0.1-SNAPSHOT | 24.06.08 | 초기 기획/설계, 구현 계획, 컨트롤러 인터페이스 설계 |
|                |          |                                |

## 구현 계획

# 3. 프로젝트 설계

## 1) 프로젝트 중요 고려사항


### 1. SOLID 원칙 준수

1. **단일 책임 원칙 (SRP)**:
    - 각 클래스는 하나의 책임만을 가지도록 설계하였다. 예를 들어, `LectureView`는 강의 뷰를 표시하는 책임만을 가진다.

2. **개방/폐쇄 원칙 (OCP)**:
    - 시스템은 확장에 열려 있고 수정에는 닫혀 있다. 새로운 뷰나 컨트롤러를 추가할 때 기존 코드를 수정하지 않고 새로운 인터페이스와 구현체를 추가하면 된다.

3. **리스코프 치환 원칙 (LSP)**:
    - 인터페이스의 모든 구현체는 어디서든 인터페이스로 치환 가능하며, 이는 LSP를 따른다.

4. **인터페이스 분리 원칙 (ISP)**:
    - 뷰와 컨트롤러 각각의 인터페이스를 분리하여 구현하였다.

5. **의존성 역전 원칙 (DIP)**:
    - 모든 의존성은 인터페이스를 통해 주입되며, 구체적인 구현체는 런타임에 주입된다.



### 2. MVC 패턴 적용

- **Model**: 각 챕터와 강의에 대한 내용 및 예시 소스코드를 포함한다.
- **View**: 사용자가 상호작용하는 화면을 표시하며,

출력 전용으로 설계되었다.
- **Controller**: 뷰와 모델 사이의 흐름을 제어한다.



### 3. TDD 적용

- 각 뷰와 컨트롤러에 대한 테스트 클래스를 추가하였다. 이는 TDD의 사이클인 "테스트 작성 -> 코드 작성 -> 리팩토링"을 가능하게 한다.
- JUnit5를 사용하여 테스트를 작성한다.


### 4. 스크립트 파일

- create_structure.ps1
    - src/main/java, src/test/java 폴더 내에 지정된 패키지와 소스 파일 생성
    - 전부 직접 생성하는 과정이 너무 많아 프로젝트 구조를 chatgpt에 전달해 파워쉘 스크립트 파일을 작성함
    - 실행 방법 : .\create_structure.ps1

## 2) 패키지 구조

```plaintext
java_tdd/src
├── main
│   └── java
│       ├── model
│       ├── view
│       │   └── impl
│       └── controller
│           └── impl
└── test
    └── java
        ├── view
        └── controller
```

## 3)model 패키지

- model 패키지는 각 챕터와 강의에 대한 내용 및 예시 소스코드를 포함한다.
- 각 챕터는 자바의 주요 개념을 설명하며, 예시 코드를 통해 실습할 수 있도록 구성되었다.
- 각 챕터 패키지 내부에는 해당 챕터의 강의 내용과 예시 코드가 포함되어 있다.
- 예시 코드들은 강의 내용을 실습하기 위한 코드들로 구성되어 있다.
- `LectureView`와 `SourceCodeView`를 통해 출력된다.

```plaintext
model
├── ch0_AboutJava
├── ch1_ObjectAndTDD
├── ch2_Variable
├── ch3_Operator
├── ch4_ControlStatement
├── ch5_Array
├── ch6_ReferenceType
├── ch7_PackageAndAccessModify
├── ch8_Inheritance
├── ch9_ClassObject
├── ch10_InterfaceAbstractClassEnum
├── ch11_Exception
├── ch12_String
├── ch13_NestedClass
├── ch14_Annotation
├── ch15_JavaLang
├── ch16_Generic
├── ch17_Collection
├── ch18_Thread
├── ch19_FileAndIO
├── ch20_SerializableAndNIO
└── ex_Example
    ├── ex1_Calculator
    ├── ex2_Calendar
    └── ex3_java_tdd
```

## 4)view 패키지

view 패키지는 사용자가 상호작용하는 화면을 표시하며, 출력 전용으로 설계되었다. 각 뷰는 인터페이스와 구현체로 나뉘어 있으며, 필요 시 여러 구현체를 패키지로 묶었다. 출력은 뷰를 통해 이루어지며, 흐름 제어는 컨트롤러를 통해 이루어진다.

```plaintext
view
├── CommonView.java
├── IntroView.java
├── ChapterSelectView.java
├── LectureSelectView.java
├── LectureView.java
└── SourceCodeView.java
└── impl//구현체 패키지
└──impl 패키지
    ├── CommonViewImpl.java
    ├── IntroViewImpl.java
    ├── ChapterSelectViewImpl.java
    ├── LectureSelectViewImpl.java
    ├── LectureViewImpl.java
    └── SourceCodeViewImpl.java
```

### CommonView.java
챕터 선택, 강의 선택, 강의, 코드 각 뷰 모드의 공통 양식을 제공한다. 선택 가능한 챕터나 강의를 표시하거나 강의 본문을 출력한다. 하단에 현재 위치를 표시하고 이동을 위한 코드를 안내한다. 이동:
- 상위 이동(back): 각 뷰 모드의 상위 뷰로 이동.
- 하위 이동(go): 출력된 하위 목록에서 특정 객체를 선택해 해당 뷰로 이동.
- 코드 보기(code): 현재 뷰가 강의에 해당하면 [code "코드번호"]를 입력해 SourceCodeView로 이동.
- 테스트 코드 보기(tcode): 현재 뷰가 강의에 해당하면 [tcode "코드번호"]를 입력해 SourceCodeView로 이동.

### IntroView.java
초기 페이지와 간단한 설명을 제공한다. 제작의도와 깃허브 주소, 기본 사용 설명, 참고 자료 목록을 노출한다. 엔터를 누르면 ChapterSelectView로 이동(해당 동작은 MainControl을 통해 이루어지며, HomeView에는 해당 커멘드를 설명만 한다).

### ChapterSelectView.java
모든 챕터의 리스트를 노출하고 챕터 선택을 위한 뷰를 출력한다. CommonView를 통해 이동, 종료 등을 위한 커맨드를 동적으로 출력한다. HomeView로 이동할 수 있는 커맨드도 설명한다.

### LectureSelectView.java
챕터 내부 강의 선택 뷰를 제공한다. 선택한 챕터 내부 모든 강의 리스트를 노출하고 강의 선택을 위한 뷰를 출력한다. CommonView를 통해 이동, 종료 등을 위한 커맨드를 동적으로 출력한다.

### LectureView.java
선택한 강의의 뷰를 출력한다. CommonView를 통해 이동, 종료 등을 위한 커맨드를 동적으로 출력한다.

### SourceCodeView.java
해당 강의 소스코드 출력을 위한 뷰이다. 선택한 코드를 출력하며, CommonView를 통해 이동, 종료 등을 위한 커맨드를 동적으로 출력한다.

## 5)controller 패키지

controller 패키지는 뷰와 모델 사이의 흐름을 제어한다. 주요 이동 및 동작 제어를 담당하며, 모든 동작은 예외 처리를 통해 안정적으로 처리된다.

```plaintext
controller
├── BaseController.java
├── MainController.java
├── ChapterSelectController.java
├── LectureSelectController.java
└── PageOperateController.java
└── impl 패키지
    ├── MainControllerImpl.java
    ├── ChapterSelectControllerImpl.java
    ├── LectureSelectControllerImpl.java
    └── PageOperateControllerImpl.java
```

### BaseController.java
공통 기능을 정의하는 인터페이스
- 공통 기능
  - 재시작: restart
  - 종료: exit

### MainController.java
모든 컨트롤의 최상위 컨트롤러 역할을 한다. 최초 실행 시 IntroView를 출력하고 엔터 입력 시 ChapterSelect를 진행한다. 중요한 이동 및 동작 제어를 담당한다.
- IntroView 출력: intro(ChapterSelect 시에만 실행 가능)
- 재시작: restart
- 종료: exit

### ChapterSelectController.java
챕터 선택을 위한 컨트롤러이다. ChapterSelectView를 통해 각 챕터의 목록을 출력한다. CommonView를 이용해 챕터 선택에서 사용 가능한 커맨드를 출력한다.
- 가능한 동작:
  - 챕터 선택: go "챕터 이름"
  - 인트로 출력: intro
  - 재시작: restart
  - 종료: exit
- 잘못된 커맨드 입력 시: "잘못된 입력입니다." 출력 후 재입력
    
### LectureSelectController.java
강의 선택을 위한 컨트롤러이다. 챕터 선택과 비슷하지만 상위에 챕터 선택, 하위에 강의가 있다.
- 가능한 동작:
    - 강의 선택: go "강의 이름"
    - 재시작: restart
    - 종료: exit
- 잘못된 커맨드 입력 시: "잘못된 입력입니다." 출력 후 재입력

### PageOperateController.java
LectureView와 SourceCodeView에 해당하는 동작을 제어한다.

## 6)test 패키지(단위 테스트)

TDD의 사이클 : 테스트 작성 -> 코드 작성 -> 리팩토링

```plaintext
view
├── CommonViewTest.java
├── IntroViewTest.java
├── ChapterSelectViewTest.java
├── LectureSelectViewTest.java
├── LectureViewTest.java
└── SourceCodeViewTest.java
```

```text
controller
├── MainControllerTest.java
├── ChapterSelectControllerTest.java
├── LectureSelectControllerTest.java
└── PageOperateControllerTest.java
```




