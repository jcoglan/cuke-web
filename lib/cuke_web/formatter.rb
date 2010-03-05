require 'cucumber/formatter/pretty'

class CukeWeb
  class Formatter < Cucumber::Formatter::Pretty
    
    OPTIONS = {:dry_run => true, :source => true}.freeze
    
    def initialize(step_mother, feature_path)
      @step_mother = step_mother
      @feature_file = Cucumber::FeatureFile.new(feature_path)
      @feature = @feature_file.parse(step_mother, {})
      super(@step_mother, StringIO.new, OPTIONS)
    end
    
    def render_html
      walker = Cucumber::Ast::TreeWalker.new(@step_mother, [self], OPTIONS, @io)
      walker.visit_feature(@feature)
      @io.rewind
      @io.read
    rescue => e
      p e.backtrace
    end
    
    def feature_name(name)
      super('<span class="cuke-keyword">' + name + '</span>')
    end
    
    def format_keyword(keyword)
      '<span class="kwd">' + keyword + '</span>'
    end
    
    def format_step_match(step_match)
      step_match.format_args { |arg| '<span class="str">' + arg + '</span>' }
    end
    
    def format_step(keyword, step_match, status, source_indent)
      line = format_keyword(keyword) + " " + format_step_match(step_match)
      file, linenum = *step_match.file_colon_line.split(':')
      '<a href="/steps/' + file + '#L' + linenum + '">' + line + '</a>'
    end
    
    def format_string(string, status)
      status == :comment ? "" : string
    end
    
    def py_string(string)
      super('<span class="str">' + string + '</span>')
    end
    
    private
    
    def print_feature_element_name(keyword, name, file_colon_line, source_indent)
      keyword = '<span class="cuke-keyword">' + keyword + '</span>'
      name = '<span class="cuke-name">' + name + '</span>'
      super(keyword, name, file_colon_line, source_indent)
    end
    
  end
end

