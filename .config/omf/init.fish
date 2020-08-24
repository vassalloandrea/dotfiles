# Make atom the default editor
set -xg EDITOR "vim"

# Editor for opening gems
set -xg BUNDLER_EDITOR "code"

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
abbr c "bundle exec rails console"
abbr s "bundle exec rspec"
abbr migrate "bundle exec rails db:migrate"

# NodeJS
abbr wb "./bin/webpack-dev-server"
abbr nd "npm run dev"

# Git
abbr g "git"

# Ruby/Rails aliases
balias migrate "bundle exec rails db:migrate"
balias routes "bundle exec rails routes | fzf"
balias tasks "bundle exec rails -T"

# Git aliases
balias grm "git rebase master --autostash"
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
balias gco "git checkout"
balias gcon "git checkout -b"
balias gl "git log"
balias gs "git status"

# Utility aliases
balias eh "sudo vim /etc/hosts"
balias reload "exec $SHELL"
balias ll "ls -al"
balias ln "ln -v"
balias mkdir "mkdir -p"
balias cdn "cd ~/projects/nebulab"
balias cdp "cd ~/projects/personal"
balias cda "cd ~/projects/app2u"

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
