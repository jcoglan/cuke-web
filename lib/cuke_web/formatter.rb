require 'cucumber/formatter/pretty'

class CukeWeb
  class Formatter < Cucumber::Formatter::Pretty
    
    OPTIONS = {:dry_run => true, :source => true}.freeze
    
    def initialize(step_mother, options)
      existing_options = step_mother.options
      
      @options = OPTIONS.dup
      @options[:tag_expression] = Cucumber::TagExpression.parse([options[:tag]]) if options[:tag]
      step_mother.options = @options
      
      if file = options[:file]
        feature_file = Cucumber::FeatureFile.new(file)
        feature = feature_file.parse(step_mother, @options)
        @features = Cucumber::Ast::Features.new
        @features.add_feature(feature)
        
      elsif tag = options[:tag]
        @features = step_mother.load_plain_text_features(options[:files])
      end
      
      step_mother.options = existing_options
      super(step_mother, StringIO.new, @options)
    end
    
    def render_html
      walker = Cucumber::Ast::TreeWalker.new(@step_mother, [self], @options, @io)
      walker.visit_features(@features)
      @io.rewind
      @io.read
    rescue => e
      puts e
      p e.backtrace
    end
    
    def feature_name(name)
      super('<span class="cuke-keyword">' + name + '</span>')
    end
    
    def format_keyword(keyword)
      '<span class="kwd">' + keyword + '</span>'
    end
    
    def format_step_match(step_match)
      step_match.format_args { |arg| '<span class="str">' + arg.to_s + '</span>' }
    end
    
    def format_step(keyword, step_match, status, source_indent)
      line = format_keyword(keyword) + " " + format_step_match(step_match)
      file, linenum = *step_match.file_colon_line.split(':')
      '<a href="/steps/' + file + '#L' + linenum + '">' + line + '</a>'
    end
    
    def format_string(string, status)
      return "" if status == :comment
      return '<a href="/tags/' + string + '" class="lit">' + string + '</a>' if status == :tag
      string
    end
    
    def py_string(string)
      super('<span class="str">' + string + '</span>')
    end
    
    private
    
    def print_feature_element_name(keyword, name, file_colon_line, source_indent)
      file, line = *file_colon_line.split(':')
      keyword = '<span class="cuke-keyword">' + keyword + '</span>'
      name = '<a href="/run' + file + '/' + line + '" class="cuke-name">' + name + '</a>'
      super(keyword, name, file_colon_line, source_indent)
    end
    
    def print_summary(features)
    end
    
  end
end

