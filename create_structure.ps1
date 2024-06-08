# Function to create package directories
function Create-Package {
    param (
        [string]$path
    )
    $fullPath = "src\main\java\$path"
    if (-Not (Test-Path -Path $fullPath)) {
        New-Item -ItemType Directory -Path $fullPath
        Write-Output "Created package $fullPath"
    }
}

# Function to create test package directories
function Create-TestPackage {
    param (
        [string]$path
    )
    $fullPath = "src\test\java\$path"
    if (-Not (Test-Path -Path $fullPath)) {
        New-Item -ItemType Directory -Path $fullPath
        Write-Output "Created test package $fullPath"
    }
}

# Function to create interface
function Create-Interface {
    param (
        [string]$packagePath,
        [string]$interfaceName
    )
    $fullPackagePath = "src\main\java\$packagePath"
    $interfacePath = "$fullPackagePath\$interfaceName.java"
    if (-Not (Test-Path -Path $interfacePath)) {
        $packageNamespace = $packagePath -replace '\\', '.'
        $packageNamespace = $packageNamespace -replace 'src.main.java.', ''
        @"
package $packageNamespace;

public interface $interfaceName {
}
"@ | Out-File -FilePath $interfacePath -Encoding utf8
        Write-Output "Created interface $interfaceName in $fullPackagePath"
    }
}

# Function to create implementation class
function Create-Impl {
    param (
        [string]$packagePath,
        [string]$className
    )
    $fullPackagePath = "src\main\java\$packagePath"
    $implName = "${className}Impl"
    $implPath = "$fullPackagePath\impl\$implName.java"
    if (-Not (Test-Path -Path "$fullPackagePath\impl")) {
        New-Item -ItemType Directory -Path "$fullPackagePath\impl"
    }
    if (-Not (Test-Path -Path $implPath)) {
        $packageNamespace = "$packagePath.impl" -replace '\\', '.'
        $packageNamespace = $packageNamespace -replace 'src.main.java.', ''
        @"
package $packageNamespace;

public class $implName implements $className {
}
"@ | Out-File -FilePath $implPath -Encoding utf8
        Write-Output "Created implementation class $implName in $fullPackagePath\impl"
    }
}

# Function to create test classes
function Create-Test {
    param (
        [string]$packagePath,
        [string]$className
    )
    $fullPackagePath = "src\test\java\$packagePath"
    $testClassPath = "$fullPackagePath\$className.java"
    if (-Not (Test-Path -Path $fullPackagePath)) {
        New-Item -ItemType Directory -Path $fullPackagePath
    }
    if (-Not (Test-Path -Path $testClassPath)) {
        $packageNamespace = $packagePath -replace '\\', '.'
        $packageNamespace = $packageNamespace -replace 'src.test.java.', ''
        @"
package $packageNamespace;

import static org.junit.jupiter.api.Assertions.*;
import org.junit.jupiter.api.Test;

public class $className {

    @Test
    public void test() {
        // test code here
    }
}
"@ | Out-File -FilePath $testClassPath -Encoding utf8
        Write-Output "Created test class $className in $fullPackagePath"
    }
}

# Main script
Write-Output "Starting package and source file creation..."

# Model packages
Create-Package -path "model\ch0_AboutJava"
Create-Package -path "model\ch1_ObjectAndTDD"
Create-Package -path "model\ch2_Variable"
Create-Package -path "model\ch3_Operator"
Create-Package -path "model\ch4_ControlStatement"
Create-Package -path "model\ch5_Array"
Create-Package -path "model\ch6_ReferenceType"
Create-Package -path "model\ch7_PackageAndAccessModify"
Create-Package -path "model\ch8_Inheritance"
Create-Package -path "model\ch9_ClassObject"
Create-Package -path "model\ch10_InterfaceAbstractClassEnum"
Create-Package -path "model\ch11_Exception"
Create-Package -path "model\ch12_String"
Create-Package -path "model\ch13_NestedClass"
Create-Package -path "model\ch14_Annotation"
Create-Package -path "model\ch15_JavaLang"
Create-Package -path "model\ch16_Generic"
Create-Package -path "model\ch17_Collection"
Create-Package -path "model\ch18_Thread"
Create-Package -path "model\ch19_FileAndIO"
Create-Package -path "model\ch20_SerializableAndNIO"
Create-Package -path "model\ex_Example\ex1_Calculator"
Create-Package -path "model\ex_Example\ex2_Calendar"
Create-Package -path "model\ex_Example\ex3_java_tdd"

# View packages and interfaces
Create-Package -path "view"
Create-Interface -packagePath "view" -interfaceName "CommonView"
Create-Interface -packagePath "view" -interfaceName "IntroView"
Create-Interface -packagePath "view" -interfaceName "ChapterSelectView"
Create-Interface -packagePath "view" -interfaceName "LectureSelectView"
Create-Interface -packagePath "view" -interfaceName "LectureView"
Create-Interface -packagePath "view" -interfaceName "SourceCodeView"

# View implementation classes
Create-Impl -packagePath "view" -className "CommonView"
Create-Impl -packagePath "view" -className "IntroView"
Create-Impl -packagePath "view" -className "ChapterSelectView"
Create-Impl -packagePath "view" -className "LectureSelectView"
Create-Impl -packagePath "view" -className "LectureView"
Create-Impl -packagePath "view" -className "SourceCodeView"

# Controller packages and interfaces
Create-Package -path "controller"
Create-Interface -packagePath "controller" -interfaceName "BaseController"
Create-Interface -packagePath "controller" -interfaceName "MainController"
Create-Interface -packagePath "controller" -interfaceName "ChapterSelectController"
Create-Interface -packagePath "controller" -interfaceName "LectureSelectController"
Create-Interface -packagePath "controller" -interfaceName "PageOperateController"

# Controller implementation classes
Create-Impl -packagePath "controller" -className "MainController"
Create-Impl -packagePath "controller" -className "ChapterSelectController"
Create-Impl -packagePath "controller" -className "LectureSelectController"
Create-Impl -packagePath "controller" -className "PageOperateController"

# Test packages and classes
Create-TestPackage -path "view"
Create-TestPackage -path "controller"

Create-Test -packagePath "view" -className "CommonViewTest"
Create-Test -packagePath "view" -className "IntroViewTest"
Create-Test -packagePath "view" -className "ChapterSelectViewTest"
Create-Test -packagePath "view" -className "LectureSelectViewTest"
Create-Test -packagePath "view" -className "LectureViewTest"
Create-Test -packagePath "view" -className "SourceCodeViewTest"

Create-Test -packagePath "controller" -className "MainControllerTest"
Create-Test -packagePath "controller" -className "ChapterSelectControllerTest"
Create-Test -packagePath "controller" -className "LectureSelectControllerTest"
Create-Test -packagePath "controller" -className "PageOperateControllerTest"

Write-Output "Finished package and source file creation."
