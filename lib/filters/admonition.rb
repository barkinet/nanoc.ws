# encoding: utf-8

class AdmonitionFilter < Nanoc::Filter

  SUDO_GEM_CONTENT = 'If the <span class="command">{cmd}</span> command fails with a permission error, you likely have to prefix the command with <kbd>sudo</kbd>. Do not use <span class="command">sudo</span> until you have tried the command without it; using <span class="command">sudo</span> when not appropriate will damage your RubyGems installation.'

  identifier :admonition

  def run(content, params = {})
    content.gsub(/^(TIP|NOTE|CAUTION|TODO): (.*)$/) do |match|
      case $2
      when '{sudo-gem-install}'
        generate($1.downcase, sudo_gem_install_content)
      when '{sudo-gem-update-system}'
        generate($1.downcase, sudo_gem_update_system_content)
      else
        generate($1.downcase, $2)
      end
    end
  end

  def generate(kind, content)
    s = ''
    s << %[<div class="admonition-wrapper #{kind}">]
    s << %[<div class="admonition">]
    s << content
    s << %[</div>]
    s << %[</div>]
    s
  end

  def sudo_gem_install_content
    SUDO_GEM_CONTENT.gsub('{cmd}', 'gem install')
  end

  def sudo_gem_update_system_content
    SUDO_GEM_CONTENT.gsub('{cmd}', 'gem update --system')
  end

end
