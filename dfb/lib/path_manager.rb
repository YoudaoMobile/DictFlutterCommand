#!/usr/bin/ruby


module PathManager

     def self.inputPath(path)
        if self.containsPath
            puts "确定您的新路径？为" + path
            puts "y/n"
            val = gets
            if val =~ /Y|y/ 
                self.deletePathFile
                self.storagePathFile(path)
                return
            else
                p "结束"
                return
            end
        end
        self.storagePathFile(path)

     end

     def self.outputPath
        return IO.readlines(self.pathFileName)[0]
     end

     def self.storagePathFile(path) 
        file = File.new(self.pathFileName,"w");
        file << path
        file.close;
        puts "更改路径成功！路径为：" + path
     end

     def self.deletePathFile
        File.delete(self.pathFileName)
     end

     def self.containsPath
        if File.exists?(self.pathFileName)
            puts '当前根目录: '
            IO.foreach(self.pathFileName) { |c| 
                puts c
            }
            return true
        else
            puts "根目录不存在,请添加！"
            return false
        end
     end

     def self.pathFileName 
        return "dfb_path_file"
     end
end