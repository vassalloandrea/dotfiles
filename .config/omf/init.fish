# Make atom the default editor
set -xg EDITOR "vim"

# Editor for opening gems
set -xg BUNDLER_EDITOR "code"

# Update the ANDROID_SDK_ROOT, this is needed for react native
set -xg ANDROID_SDK_ROOT "$HOME/Library/Android/sdk"
set -xg PATH "$PATH:$ANDROID_SDK_ROOT/emulator"
set -xg PATH "$PATH:$ANDROID_SDK_ROOT/tools"
set -xg PATH "$PATH:$ANDROID_SDK_ROOT/tools/bin"
set -xg PATH "$PATH:$ANDROID_SDK_ROOT/cmdline-tools"
set -xg PATH "$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest"
set -xg PATH "$PATH:$ANDROID_SDK_ROOT/cmdline-tools/latest/bin"
set -xg PATH "$PATH:$ANDROID_SDK_ROOT/platform-tools"
set -xg PATH "$PATH:/opt/homebrew/bin"
set -xg JAVA_HOME (/usr/libexec/java_home)
set -xg NODE_BINARY (which node)

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
abbr rf "bundle exec foreman start -f Procfile.local"
abbr cf "foreman run bundle exec rails c"
abbr rp "PORT=5000 bundle exec puma -C config/puma.rb"
abbr c "bundle exec rails console"
abbr s "bundle exec rspec"

# Heroku
abbr hc "heroku run bundle exec rails console"
abbr hdm "heroku run bundle exec rails data:migrate"
abbr hsm "heroku run bundle exec rails db:migrate"

# NodeJS
abbr wb "./bin/webpack-dev-server"
abbr nd "npm run dev"

# PHP
abbr psl "php -S localhost:8080 -t public"

# Git
abbr g "git"

# Heroku
abbr hr "heroku run"

# Ruby/Rails aliases
balias dm "bundle exec rails data:migrate"
balias sm "bundle exec rails db:migrate"
balias smm "bundle exec rails g migration"
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
balias gsnap "git add . && git commit -m '[SNAPSHOT]' -n"
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
balias sts "start_tcw_server"
balias stc "start_tcw_client"

# Postgresql alias
balias createuser "createuser -s -d -R"

# Heroku alias
balias hal "heroku accounts"
balias han "heroku accounts:set nebulab"
balias hap "heroku accounts:set personal"

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
  cp $HOME/projects/personal/dotfiles/.config/omf/init.fish ~/.config/omf/init.fish
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
  # You need to install and configure Android studio before
  update_aliases
  sdkmanager "platforms;android-30" "system-images;android-30;default;x86_64" "system-images;android-30;google_apis;x86"
  sdkmanager "cmdline-tools;latest" "build-tools;30.0.2"
end

function setup_rn_env
  asdf plugin-remove nodejs
end

function setup_nebulab_env
  asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git
  asdf install nodejs lts
  asdf global nodejs lts
  asdf install nodejs 16.13.1
end

function start_tcw_server
  cd ~/projects/personal/tcw-store
  gco api-only
  make run
end

function start_tcw_client
  cd ~/projects/personal/tcw-frontend
  gco api-only
  pnpm run dev
end
