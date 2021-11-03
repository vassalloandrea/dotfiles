# Make atom the default editor
set -xg EDITOR "vim"

# Editor for opening gems
set -xg BUNDLER_EDITOR "code"

# Update the ANDROID_HOME, this is needed for react native
set -xg ANDROID_HOME "$HOME/Library/Android/sdk"
set -xg PATH "$PATH:$ANDROID_HOME/emulator"
set -xg PATH "$PATH:$ANDROID_HOME/tools"
set -xg PATH "$PATH:$ANDROID_HOME/tools/bin"
set -xg PATH "$PATH:$ANDROID_HOME/platform-tools"

# Git/Hub
eval (hub alias -s)

# Bundler
abbr b "bundle"
abbr be "bundle exec"
abbr bi "bundle install"
abbr bo "bundle open"
abbr bu "bundle update"
abbr buc "bundle update --conservative"

# Ruby/Rails
abbr r "bundle exec rails server -p 5000"
abbr rp "PORT=5000 bundle exec puma -C config/puma.rb"
abbr c "bundle exec rails console"
abbr s "bundle exec rspec"
abbr migrate "bundle exec rails db:migrate"

# NodeJS
abbr wb "./bin/webpack-dev-server"
abbr nd "npm run dev"

# PHP
abbr psl "php -S localhost:8080 -t public"

# Git
abbr g "git"

# Unix
abbr up "lsof -i -P -n | grep"

# Ruby/Rails aliases
balias migrate "bundle exec rails db:migrate"
balias routes "bundle exec rails routes | fzf"
balias tasks "bundle exec rails -T"

# Git aliases
balias grm "git rebase main --autostash"
balias grd "git rebase develop --autostash"
balias grim "git rebase -i master --autostash"
balias grc "git add . && git rebase --continue"
balias gra "git rebase --abort"
balias grs "git rebase --skip"
balias ga "git add"
balias gaa "git add ."
balias gac "git add . && git commit"
balias gc "git commit"
balias gsnap "git add . && git commit -m '[SNAPSHOT]'"
balias gca "git add . && git commit --amend --no-edit"
balias gcae "git add . && git commit --amend"
balias gps "git push"
balias gpsf "git push --force"
balias gpl "git pull"
balias gplr "git pull --rebase"
balias gco "git checkout"
balias gcon "git checkout -b"
balias gl "git log"
balias gs "git status"
balias gres "git reset --soft HEAD~1"
balias greh "git reset --hard HEAD~1"
balias grehom "git reset --hard origin/master"

# Utility aliases
balias eh "sudo vim /etc/hosts"
balias reload "exec $SHELL"
balias ll "ls -al"
balias ln "ln -v"
balias mkdir "mkdir -p"
balias cdn "cd ~/projects/nebulab"
balias cdp "cd ~/projects/personal"
balias cda "cd ~/projects/app2u"
balias cdi "cd ~/projects/ied"

# Postgresql alias
balias createuser "createuser -s -d -R"

# Set vim on fish
fish_vi_key_bindings

# Functions
function itermbackup
  cp "$HOME/.iterm2/com.googlecode.iterm2.plist" "$HOME/projects/personal/dotfiles/.iterm2/com.googlecode.iterm2.plist"
  cd "$HOME/projects/personal/dotfiles"
  git add "$HOME/projects/personal/dotfiles/.iterm2/com.googlecode.iterm2.plist"
  git commit -m "Update ITerm2 configuration"
  git push
end

function gri --argument commit_id
  eval "git rebase -i $commit_id~1 --autostash"
end

# Automatically run ls after cd
function cd --argument dirs
  eval "builtin cd $dirs && ls -a"
end

function rollback --argument migration_id
  eval "bundle exec rails db:rollback VERSION=$migration_id"
end

function update_aliases
  cp /Users/vassalloandrea/dotfiles/.config/omf/init.fish ~/.config/omf/init.fish
  omf update
  reload
end

function kill_port --argument port
  kill (lsof -t -i:$port)
end

function reload_postgres
  rm /usr/local/var/postgres/postmaster.pid
  brew services restart postgresql
end

function install_android_sdk
  # Install SDKs for react native
  sdkmanager "platforms;android-29" "system-images;android-29;default;x86_64" "system-images;android-29;google_apis;x86"
  sdkmanager "cmdline-tools;latest" "build-tools;29.0.2"
end
