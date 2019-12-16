require 'dfb/version.rb'

# Add requires for other files you add to your project here, so
# you just need to require this one file in your bin file
module Dfb
     # Your code goes here...
     def self.hello
         p "hello world"
         system ('echo ' + outputs)
         system "echo hello world"
     end
     
     def self.clone
         p "git clone ..."
         system 'mkdir ~/YDDictFlutter; cd ~/YDDictFlutter;git clone  git@gitlab.corp.youdao.com:luna-dev/YDNativeFlutterBridge.git;'
         system "cd ~/YDDictFlutter/YDNativeFlutterBridge;git submodule init;git submodule update;"
     end
     
     def self.init_flutter
         p "正在配置flutter环境"
         outputs = File.dirname(__FILE__)
         outputs = outputs.chop.chop.chop.chop #看到这行代码别骂作者，作者也不熟悉ruby，这个意思是说去除/lib
         p outputs
         system "sh " + outputs + "/install_flutter_env.sh"
     end
     
     def self.run_ios
         #ideviceinstaller https://www.jianshu.com/p/92273e86ab2b
        #  system "pod install"
        p "还没有实现"
     end
     
     def self.run_android
         #https://blog.csdn.net/tymatlab/article/details/80989769
         self.flutter_clean
         self.pub_get
         #打包
         system "cd ~/YDDictFlutter/YDNativeFlutterBridge/android_example;./gradlew assembleDebug;"
         #装载，运行
         system "cd ~/YDDictFlutter/YDNativeFlutterBridge/android_example/app/build/outputs/apk/debug/;adb install -r app-debug.apk;adb shell am start -n com.example.android_example/com.youdao.flutter.FlutterBaseActivity;"
         
     end
     
     def self.attach
         p "执行 flutter attach"
         system "cd ~/YDDictFlutter/YDNativeFlutterBridge/Embed/flutter_module;flutter attach;"
     end
     
     def self.create_package(packageName)
         self.checkEnv
         p "创建flutter package"
         command = "cd ~/YDDictFlutter/YDNativeFlutterBridge/Embed/flutter_module/Business;flutter create --template=package " + packageName
         system command
         p "~/YDDictFlutter/YDNativeFlutterBridge/Embed/flutter_module/Business/" + packageName
     end
     
     def self.pub_get
         system "cd ~/YDDictFlutter/YDNativeFlutterBridge/Embed/flutter_module;sh flutter_pub_get.sh"
     end
     
     def self.flutter_clean
          system "cd ~/YDDictFlutter/YDNativeFlutterBridge/Embed/flutter_module;flutter clean;"
     end
     
     def self.checkEnv 
        self.checkFlutter
        self.checkProject
     end

     def self.checkFlutter
        outputs = system 'flutter --version'
        if outputs == nil
            p '安装flutter...'
            self.init_flutter
        else
            p '已安装flutter环境'
        end 
     end

     def self.checkProject
        outputs = system 'cd ~;mkdir YDDictFlutter'
        if outputs == false
            p '工程已存在'
        else
            p '正在下载工程..'
            self.clone
        end
     end
     
   end
