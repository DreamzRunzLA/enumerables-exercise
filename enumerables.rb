require 'pry'

class Array
    def my_each(&block)
        for i in 0..self.length-1
            block.call(self[i])
        end
        return self
    end

    def my_select(&block)
        ans = []
        for i in 0..self.length-1
            if block.call(self[i]) == true
                ans << self[i]
            end
        end
        return ans
    end

    def my_reject(&block)
        ans = []
        for i in 0..self.length-1
            if block.call(self[i]) == false
                ans << self[i]
            end
        end
        return ans
    end

    def my_any?(&block)
        for i in 0..self.length-1
            if block.call(self[i]) == true
                return true
            end
        end
        return false
    end

    def my_all?(&block)
        for i in 0..self.length-1
            if block.call(self[i]) == false
                return false
            end
        end
        return true
    end

    def my_flatten
        ans = []
        for i in 0...self.length
            if self[i].kind_of?(Array)
                ans += self[i].my_flatten
            else
                ans << self[i]
            end
        end
        return ans
    end

    def my_zip(*args)
        finalAns = Array.new(self.length) {[]}
        self.each_with_index do |ele, i|
            finalAns[i] << self[i]
            args.each_with_index do |arg, k|
                finalAns[i] << arg[i]
            end
        end
        return finalAns
    end

    def my_rotate(dir = 1)
        finalAns = Array.new(self.length, nil)
        self.each_with_index do |ele, i|
            temp = ele
            newIndex = i - (dir % self.length) + self.length
            if newIndex >= self.length
                newIndex -= self.length
            end
            finalAns[newIndex] = temp
        end
        return finalAns
    end

    def my_join(sep = '')
        ans = ''
        self.each do |ele|
            ans += ele.to_s + sep
        end
        return ans
    end

    def my_reverse
        ans = []
        i = self.length - 1
        while i >= 0
            ans << self[i]
            i -= 1
        end
        return ans
    end



end