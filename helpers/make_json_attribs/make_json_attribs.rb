#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

# make_json_attribs.rb

require 'json'
require 'yaml'

def main()
    json = {
        "run_list" => []
    }

    ARGV.each do |filepath|
        fp = open(filepath)
        if(File.extname(filepath) == ".yaml") then
            data = YAML.load(fp.read())
        else
            data = JSON.load(fp.read())
        end
        fp.close()

        data.keys.each do |recipe|
            if !json.has_key?(recipe) then
                json[recipe] = data[recipe]
            else
                json[recipe] = deep_merge(json[recipe], data[recipe])
            end
            rs = "recipe[%s]" % recipe
            if !json["run_list"].index(rs) then
                json["run_list"].push(rs)
            end
        end
    end

    puts JSON.pretty_generate(json)
end

def deep_merge(lhs, rhs)
    left = duplicate(lhs)
    right = duplicate(rhs)

    if left.class == Hash && right.class == Hash then
        right.each do |key, value|
            if left.has_key?(key) then
                left[key] = deep_merge(left[key], value)
            else
                left[key] = duplicate(value)
            end
        end
    elsif left.class == Array && right.class == Array then
        right.each do |item|
            left.push(duplicate(item)) if !left.index(item)
        end
    else
        left = right
    end
    return left
end

def duplicate(v)
    return (v.class == Array || v.class == Hash) ? v.dup : v
end


if __FILE__ == $0 then
    main()
end
