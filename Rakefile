require 'rake'
require 'fileutils'
require File.join(File.dirname(__FILE__), 'bin', 'neobundle')

desc "Hook our dotfiles into system-standard positions."
task :install => [:submodule_init, :submodules] do
  puts
  puts "======================================================"
  puts "Welcome to dotfiles Installation."
  puts "======================================================"
  puts

  install_homebrew if RUBY_PLATFORM.downcase.include?("darwin")

  # this has all the runcoms from this directory.
  file_operation(Dir.glob('git/*')) if want_to_install?('git configs (color, aliases)')
  file_operation(Dir.glob('irb/*')) if want_to_install?('irb/pry configs (more colorful)')
  file_operation(Dir.glob('ctags/*')) if want_to_install?('ctags config (better js/ruby support)')
  file_operation(Dir.glob('tmux/*')) if want_to_install?('tmux config')
  file_operation(Dir.glob('vimify/*')) if want_to_install?('vimification of command line tools')
  if want_to_install?('vim configuration (highly recommended)')
    file_operation(Dir.glob('{vim,vimrc}')) 
    Rake::Task["install_neobundle"].execute
  end

  Rake::Task["install_prezto"].execute

  install_fonts if RUBY_PLATFORM.downcase.include?("darwin")

  install_term_theme if RUBY_PLATFORM.downcase.include?("darwin")

  success_msg("installed")
end

task :install_prezto do
  if want_to_install?('zsh enhancements & prezto')
    install_prezto
    file_operation(Dir.glob('{zsh/*}'))
  end
end

task :submodule_init do
  unless ENV["SKIP_SUBMODULES"]
    run %{ git submodule update --init --recursive }
  end
end

desc "Init and update submodules."
task :submodules do
  unless ENV["SKIP_SUBMODULES"]
    puts "======================================================"
    puts "Downloading dotfiles submodules...please wait"
    puts "======================================================"

    run %{
      cd $HOME/lib/dotfiles
      git submodule update --recursive
      git stash
      git clean -df
    }
    puts
  end
end

desc "Runs NeoBundle installer in a clean vim environment"
task :install_neobundle do
  puts "======================================================"
  puts "Installing NeoBundle."
  puts "The installer will now proceed to run NeoBundleInstall."
  puts "Due to a bug, the installer may report some errors"
  puts "when installing the plugin 'syntastic'. Fortunately"
  puts "Syntastic will install and work properly despite the"
  puts "errors so please just ignore them and let's hope for"
  puts "an update that fixes the problem!"
  puts "======================================================"

  puts ""

  run %{
    cd $HOME/lib/dotfiles
    git clone https://github.com/Shougo/neobundle.vim #{File.join('vim','bundle', 'neobundle.vim')}
  }

  NeoBundle::update_neobundle
end

task :default => 'install'


private
def run(cmd)
  puts "[Running] #{cmd}"
  `#{cmd}` unless ENV['DEBUG']
end

def install_homebrew
  run %{which brew}
  unless $?.success?
    puts "======================================================"
    puts "Installing Homebrew, the OSX package manager...If it's"
    puts "already installed, this will do nothing."
    puts "======================================================"
    run %{ruby -e "$(curl -fsSkL raw.github.com/mxcl/homebrew/go)"}
  end

  puts
  puts
  puts "======================================================"
  puts "Updating Homebrew."
  puts "======================================================"
  run %{brew update}
  puts
  puts
  puts "======================================================"
  puts "Installing Homebrew packages...There may be some warnings."
  puts "======================================================"
  run %{brew install zsh ctags git hub tmux reattach-to-user-namespace the_silver_searcher}
  run %{brew install macvim --with-macarchs=i386 --with-lua --enable-pythoninterp --override-system-vim}
  puts
  puts
end

def install_fonts
  puts "======================================================"
  puts "Installing patched fonts for Powerline."
  puts "======================================================"
  run %{ cp -f $HOME/lib/dotfiles/fonts/* $HOME/Library/Fonts }
  puts
end

def install_term_theme
  puts "======================================================"
  puts "Installing iTerm2 solarized theme."
  puts "======================================================"
  run %{ /usr/libexec/PlistBuddy -c "Add :'Custom Color Presets':'Solarized Light' dict" ~/Library/Preferences/com.googlecode.iterm2.plist }
  run %{ /usr/libexec/PlistBuddy -c "Merge 'iTerm2/Solarized Light.itermcolors' :'Custom Color Presets':'Solarized Light'" ~/Library/Preferences/com.googlecode.iterm2.plist }
  run %{ /usr/libexec/PlistBuddy -c "Add :'Custom Color Presets':'Solarized Dark' dict" ~/Library/Preferences/com.googlecode.iterm2.plist }
  run %{ /usr/libexec/PlistBuddy -c "Merge 'iTerm2/Solarized Dark.itermcolors' :'Custom Color Presets':'Solarized Dark'" ~/Library/Preferences/com.googlecode.iterm2.plist }

  # If iTerm2 is not installed or has never run, we can't autoinstall the profile since the plist is not there
  if !File.exists?(File.join(ENV['HOME'], '/Library/Preferences/com.googlecode.iterm2.plist'))
    puts "======================================================"
    puts "To make sure your profile is using the solarized theme"
    puts "Please check your settings under:"
    puts "Preferences> Profiles> [your profile]> Colors> Load Preset.."
    puts "======================================================"
    return
  end

  # Ask the user which theme he wants to install
  message = "Which theme would you like to apply to your iTerm2 profile?"
  color_scheme = ask message, iTerm_available_themes
  color_scheme_file = File.join('iTerm2', "#{color_scheme}.itermcolors")

  # Ask the user on which profile he wants to install the theme
  profiles = iTerm_profile_list
  message = "I've found #{profiles.size} #{profiles.size>1 ? 'profiles': 'profile'} on your iTerm2 configuration, which one would you like to apply the Solarized theme to?"
  profiles << 'All'
  selected = ask message, profiles
  
  if selected == 'All'
    (profiles.size-1).times { |idx| apply_theme_to_iterm_profile_idx idx, color_scheme_file }
  else
    apply_theme_to_iterm_profile_idx profiles.index(selected), color_scheme_file
  end
end

def iTerm_available_themes
   Dir['iTerm2/*.itermcolors'].map { |value| File.basename(value, '.itermcolors')}
end

def iTerm_profile_list
  profiles=Array.new
  begin
    profiles <<  %x{ /usr/libexec/PlistBuddy -c "Print :'New Bookmarks':#{profiles.size}:Name" ~/Library/Preferences/com.googlecode.iterm2.plist 2>/dev/null}
  end while $?.exitstatus==0
  profiles.pop
  profiles
end

def ask(message, values)
  puts message
  while true
    values.each_with_index { |val, idx| puts " #{idx+1}. #{val}" }
    selection = STDIN.gets.chomp
    if (Float(selection)==nil rescue true) || selection.to_i < 0 || selection.to_i > values.size+1
      puts "ERROR: Invalid selection.\n\n"
    else
      break
    end
  end 
  selection = selection.to_i-1
  values[selection]
end

def install_prezto
  puts
  puts "Installing Prezto (ZSH Enhancements)..."

  unless File.exists?(File.join(ENV['ZDOTDIR'] || ENV['HOME'], ".zprezto"))
    run %{ ln -nfs "$HOME/lib/dotfiles/zsh/prezto" "${ZDOTDIR:-$HOME}/.zprezto" }
  end
  file_operation(Dir.glob('zsh/prezto/runcoms/z*'), :copy)

  puts
  run %{ ln -nfs "$HOME/.zprezto/runcoms/zpreztorc" "${ZDOTDIR:-$HOME}/.zpreztorc" }

  puts

  if ENV["SHELL"].include? 'zsh' then
    puts "Zsh is already configured as your shell of choice. Restart your session to load the new settings"
  else
    puts "Setting zsh as your default shell"
    run %{ chsh -s /bin/zsh }
  end
end

def want_to_install? (section)
  if ENV["ASK"]=="true"
    puts "Would you like to install configuration files for: #{section}? [y]es, [n]o"
    STDIN.gets.chomp == 'y'
  else
    true
  end
end

def file_operation(files, method = :symlink)
  files.each do |f|
    file = f.split('/').last
    source = "#{ENV["PWD"]}/#{f}"
    target = "#{ENV["HOME"]}/.#{file}"

    puts "======================#{file}=============================="
    puts "Source: #{source}"
    puts "Target: #{target}"

    if File.exists?(target) && (!File.symlink?(target) || (File.symlink?(target) && File.readlink(target) != source))
      puts "[Overwriting] #{target}...leaving original at #{target}.backup..."
      run %{ mv "$HOME/.#{file}" "$HOME/.#{file}.backup" }
    end

    run %{ ln -nfs "#{source}" "#{target}" }

    if file == 'vimrc'
      run %{ ln -nfs "#{ENV["PWD"]}/vim"  "#{ENV["HOME"]}/.vim" }
      run %{ ln -nfs "#{ENV["PWD"]}/vim/vimrc" "#{ENV["HOME"]}/.vimrc" }
    end

    puts "=========================================================="
    puts
  end
end

def apply_theme_to_iterm_profile_idx(index, color_scheme_path)
  values = Array.new
  16.times { |i| values << "Ansi #{i} Color" }
  values << ['Background Color', 'Bold Color', 'Cursor Color', 'Cursor Text Color', 'Foreground Color', 'Selected Text Color', 'Selection Color']
  values.flatten.each { |entry| run %{ /usr/libexec/PlistBuddy -c "Delete :'New Bookmarks':#{index}:'#{entry}'" ~/Library/Preferences/com.googlecode.iterm2.plist } }

  run %{ /usr/libexec/PlistBuddy -c "Merge '#{color_scheme_path}' :'New Bookmarks':#{index}" ~/Library/Preferences/com.googlecode.iterm2.plist }
end

def success_msg(action)
  puts "dotfiles has been #{action}. Please restart your terminal and vim."
end
