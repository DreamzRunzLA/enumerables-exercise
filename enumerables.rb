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

#Implement the following methods
#factors(num)
#bubble_sort!(&prc)
#bubble_sort(&prc)
#substrings(string)
#subwords(word, dictionary)
#come up with tests for all of these

# Write a method `factors(num)` that returns an array containing all the
# factors of a given number.
    def factors(num)
        ans = []
        candidates = (1...num).to_a
        candidates.each do |cand|
            if num % cand == 0
                ans << cand
            end
        end
        return ans
    end


### Bubble Sort
#
# http://en.wikipedia.org/wiki/bubble_sort
#
# Implement Bubble sort in a method, `Array#bubble_sort!`. Your method should
# modify the array so that it is in sorted order.
#
# > Bubble sort, sometimes incorrectly referred to as sinking sort, is a
# > simple sorting algorithm that works by repeatedly stepping through
# > the list to be sorted, comparing each pair of adjacent items and
# > swapping them if they are in the wrong order. The pass through the
# > list is repeated until no swaps are needed, which indicates that the
# > list is sorted. The algorithm gets its name from the way smaller
# > elements "bubble" to the top of the list. Because it only uses
# > comparisons to operate on elements, it is a comparison
# > sort. Although the algorithm is simple, most other algorithms are
# > more efficient for sorting large lists.
#
# Hint: Ruby has parallel assignment for easily swapping values:
# http://rubyquicktips.com/post/384502538/easily-swap-two-variables-values
#
# After writing `bubble_sort!`, write a `bubble_sort` that does the same
# but doesn't modify the original. Do this in two lines using `dup`.
#
# Finally, modify your `Array#bubble_sort!` method so that, instead of
# using `>` and `<` to compare elements, it takes a block to perform the
# comparison:
#
# ```ruby
# [1, 3, 5].bubble_sort! { |num1, num2| num1 <=> num2 } #sort ascending
# [1, 3, 5].bubble_sort! { |num1, num2| num2 <=> num1 } #sort descending
# ```
#
# #### `#<=>` (the **spaceship** method) compares objects. `x.<=>(y)` returns
# `-1` if `x` is less than `y`. If `x` and `y` are equal, it returns `0`. If
# greater, `1`. For future reference, you can define `<=>` on your own classes.
#
# http://stackoverflow.com/questions/827649/what-is-the-ruby-spaceship-operator
    def bubble_sort!(&prc)
        prc ||= Proc.new {|a, b| (a <=> b) == 1 ? true : false}
        sorted = false
        while !sorted
            sorted = true
            (0...self.length).each do |index|
                if prc.call(self[index], self[index+1])
                    sorted = false
                    self[index], self[index+1] = self[index + 1], self[index]
                end
            end
        end
        return self
    end

    def bubble_sort(&prc)
        duplicate = self.dup
        prc ||= Proc.new {|a, b| (a <=> b) == 1 ? true : false}
        sorted = false
        while !sorted
            sorted = true
            (0...duplicate.length).each do |index|
                if prc.call(duplicate[index], duplicate[index+1])
                    sorted = false
                    duplicate[index], duplicate[index+1] = duplicate[index + 1], duplicate[index]
                end
            end
        end
        return duplicate
    end

### Substrings and Subwords
#
# Write a method, `substrings`, that will take a `String` and return an
# array containing each of its substrings. Don't repeat substrings.
# Example output: `substrings("cat") => ["c", "ca", "cat", "a", "at",
# "t"]`.
#
# Your `substrings` method returns many strings that are not true English
# words. Let's write a new method, `subwords`, which will call
# `substrings`, filtering it to return only valid words. To do this,
# `subwords` will accept both a string and a dictionary (an array of
# words).
    def substrings(string)
        ans = []
        string.each_char.with_index do |char, i|
            string.each_char.with_index do |char2, k|
                if k >= i
                    ans << string[i..k]
                end
            end
        end
        return ans
    end

    def subwords(string, dictionary)
        allSubs = substrings(string)
        return allSubs.select {|ele| dictionary.include?(ele)}
    end

end