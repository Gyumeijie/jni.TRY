# JNI HelloWorld

#1 Define your native methods using the **native** modifier.

```java

public class HelloJNI {
   // Declare a native method sayHello() that receives nothing and returns void
   private native void sayHello();
}
```

#2 Generate your .h header files from the Java.

```bash
javac HelloJNI.java
javah -jni -classpath . HelloJNI
```
Or 

```bash
javac -h .  HelloJNI.java
```

#3 Implement your methods in a .c file.

```c
#include "HelloJNI.h"

#include <jni.h>
#include <stdio.h>
 
// Implementation of native method sayHello() of HelloJNI class
JNIEXPORT void JNICALL Java_HelloJNI_sayHello(JNIEnv *env, jobject thisObj)
{
   printf("Hello JNI\n");
   return;
}
```

#4 Build your native library, this will vary between platforms.

```
gcc -I$JAVA_HOME/include -I$JAVA_HOME/include/darwin HelloJNI.c -shared -o libhello.dylib
```
> MacOS 10.6 - uses .dylib extension; MacOS - older extension name "jnilib"
  Linux - use .so extension; Windows -- use .dll extension.

#5 Loading your library.
> This is traditionally done in a static block. The value you pass to loadLibrary() 
is the “base” library name – no lib prefix or .so, .dylib, .jnilib or .dll extensions.

```java
public class HelloJNI {
   static {
      // Load native library at runtime
      // hello.dll (Windows) or libhello.so (Unixes) or libhello.dylib(mac)
      System.loadLibrary("hello");
   }

   // Declare a native method sayHello() that receives nothing and returns void
   private native void sayHello();
 
   public static void main(String[] args) {
      new HelloJNI().sayHello();  // invoke the native method
   }
}
```

#6 Running.

Alter the VM arg java.library.path
```bash
java -Djava.library.path=. HelloJNI
```

Alter the OS library loader
```bash
export LD_LIBRARY_PATH="."
java -cp . HelloJNI
```