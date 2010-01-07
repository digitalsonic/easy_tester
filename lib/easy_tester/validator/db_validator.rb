require 'rubygems'
require 'yaml'
require 'active_record'

if RUBY_PLATFORM =~ /java/
  gem 'activerecord-jdbc-adapter'
  require 'jdbc_adapter'
end

module EasyTester
  module Validator
    # 基于数据表查询的验证器
    # 期望值格式：
    # ModelClass|验证属性|ActiveRecord查询条件|排序
    class DbValidator
      include Test::Unit::Assertions
      
      @@connected = false
      
      def initialize config_file = 'database.yml'
        connect_db config_file unless @@connected
      end

      def validate expectation, results
        model_class, props, find_criteria, order = expectation.split /\|/
        str = "#{model_class}.find(:all, :conditions => [\"#{find_criteria}\"]"
        str += ", :order => \"#{order}\"" unless order.nil?
        str += ")"
        find_results = eval str
        unless find_results.nil? or results.nil?
          assert_equal find_results.size, results.size
          attrs = props.strip.split(/,/)
          (0...results.size).each { |i|  validate_single_record find_results[i], results[i], attrs } if attrs.size > 0
        end
      end

      # 比较单条记录
      def validate_single_record expectation, result, attrs
        attrs.each { |attr| assert_equal expectation.send(attr.intern), result.send(attr.intern) } unless attrs.nil?
      end

      # 初始化数据库连接
      def connect_db config_file
        file = File.open config_file
        ActiveRecord::Base.establish_connection(YAML::load(file))
        file.close
        @@connected = true
      end
    end
  end
end
