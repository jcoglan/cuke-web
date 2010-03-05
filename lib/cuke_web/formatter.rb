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
    
    def format_step(keyword, step_match, status, source_indent)
      line = keyword + " " + step_match.format_args
      file, linenum = *step_match.file_colon_line.split(':')
      '<a href="/steps/' + file + '#L' + linenum + '">' + line + '</a>'
    end
    
    def format_string(string, status)
      string
    end
    
  end
end

