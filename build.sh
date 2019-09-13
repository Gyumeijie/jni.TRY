#! /bin/sh

# Set JAVA_HOME properly
JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk-12.jdk/Contents/Home

# Clean everything!
rm -f *.dylib *.class
rm -f *.so
rm -f *.dll

# Generate your .h header files from the Java
javac -h .  HelloJNI.java

# Compile C wrapper with jni.h, export shared library(.so in *nix, .dylib in mac, .dll in windows)
gcc -I$JAVA_HOME/include -I$JAVA_HOME/include/darwin HelloJNI.c -shared -o libhello.dylib

# run .class (with C binding)
java -Djava.library.path=. HelloJNI


