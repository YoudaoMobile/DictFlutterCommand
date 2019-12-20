#!/usr/bin/ruby

require 'dfb/version.rb'
require 'path_manager.rb'

# Add requires for other files you add to your project here, so
# you just need to require this one file in your bin file
# https://www.cnblogs.com/rubylouvre/archive/2011/04/04/2005122.html
module Dfb 
     # Your code goes here...
     def self.hello
         p "hello world"
         system ('echo ' + outputs)
         system "echo hello world"
     end
     
     def self.clone
        puts "请输入您要放此工程的位置："
        val = STDIN.gets
        val = val.chop
        path = val + "/YDNativeFlutterBridge"
        puts "您的工程的路径为" + val + path
        PathManager.inputPath(path)
        puts "git clone ..."

        system 'cd ' + val +'; git clone  git@gitlab.corp.youdao.com:luna-dev/YDNativeFlutterBridge.git;'
        system 'cd ' + path + ';git submodule init;git submodule update;'
     end
     
     def self.init_flutter
        puts "正在配置flutter环境"
        outputs = File.dirname(__FILE__)
        outputs = outputs.chop.chop.chop.chop #看到这行代码别骂作者，作者也不熟悉ruby，这个意思是说去除/lib
        puts outputs
        system "sh " + outputs + "/install_flutter_env.sh"
     end
     
     def self.run_ios
        #ideviceinstaller https://www.jianshu.com/p/92273e86ab2b
        #  system "pod install"
        if self.isHasProject == false
            return
        end
        p "还没有实现"
     end
     
     def self.run_android
        #https://blog.csdn.net/tymatlab/article/details/80989769
        if self.isHasProject == false
            return
        end
        self.flutter_clean
        self.pub_get
        #打包
        system self.cdPathWithAndroidExample + ";./gradlew assembleDebug;"
        #装载，运行
        system self.cdPathWithAndroidExample + "/app/build/outputs/apk/debug/;adb install -r app-debug.apk;adb shell am start -n com.example.android_example/.MainActivity;"
         
     end
     
     def self.attach
        if self.isHasProject == false
            return
        end
        puts "执行 flutter attach"
        system self.cdPathWithFlutterModule + ";flutter attach;"
     end
     
     def self.create_package(packageName)
        if self.isHasProject == false
            return
        end
         self.checkEnv
         puts "创建flutter package"
         command = self.cdPathWithFlutterModule + "/Business;flutter create --template=package " + packageName
         p command
         system command
     end
     
     def self.pub_get
        if self.isHasProject == false
            return
        end
         system self.cdPathWithFlutterModule + ";sh flutter_pub_get.sh"
     end
     
     def self.flutter_clean
        if self.isHasProject == false
            return
        end
          system self.cdPathWithFlutterModule + ";flutter clean;"
     end
     
     def self.checkEnv 
        self.checkFlutter
        self.checkProject
     end

     def self.checkFlutter
        outputs = system 'flutter --version'
        if outputs == nil
            puts '安装flutter...'
            self.init_flutter
        else
            puts '已安装flutter环境'
        end 
     end

     def self.checkProject
        outputs = system self.cdPathWithFlutterModule + ";"
        if outputs == false
            puts '工程已存在'
        else
            puts '正在下载工程..'
            self.clone
        end
     end

     def self.isHasProject
        outputs = system self.cdPathWithFlutterModule + ";"
        if outputs == false
            puts '工程不存在'
            return false
        else
            return true
        end
     end

     def self.changePath
        puts "如果您的工程是YDNativeFlutterBridge 路径是 /Users/chedch/YDDictFlutter/YDNativeFlutterBridge，则输入此路径"
        puts "请输入您的新的YDNativeFlutterBridge工程路径:"
        
        val = STDIN.gets
        if val =~ /(.*)\/YDNativeFlutterBridge/ 
            PathManager.inputPath(val.chop)
            return
        else
            puts "'change path' fails"
            return
        end
        
     end

     def self.projectPath 
        return PathManager.outputPath
     end

     def self.cdPath(path)
        if PathManager.containsPath 
            puts '当前目录：'
            puts self.projectPath + path
            return "cd " + self.projectPath + path
        else
            puts "路径有错误"
            return ""
        end
     end

     def self.cdPathWithFlutterModule
        self.cdPath("/Embed/flutter_module")
     end

     def self.cdPathWithAndroidExample
        self.cdPath("/android_example")
     end
   end

#    Dfb.changePath("/user/asdfadfasdf/sdfasdf/user/asdfadfasdf/sdfasdf/user/asdfadfasdf/sdfasdf/user/asdfadfasdf/sdfasdf/user/asdfadfasdf/sdfasdf/user/asdfadfasdf/sdfasdf/user/asdfadfasdf/sdfasdf/user/asdfadfasdf/sdfasdf/user/asdfadfasdf/sdfasdf")
#    Dfb.systemCDInProject
# Dfb.attach
# Dfb.systemCDInProject
#  Dfb.changePath
# Dfb.run_android
# Dfb.cdPathWithFlutterModule
# Dfb.cdPathWithAndroidExample


