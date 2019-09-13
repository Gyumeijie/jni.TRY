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