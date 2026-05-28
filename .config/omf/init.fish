# Default editor
set -xg EDITOR code

# Editor for opening gems
set -xg BUNDLER_EDITOR code

set -xg PATH "$PATH:/opt/homebrew/bin"
set -xg JAVA_HOME (/usr/libexec/java_home)

# Bundler
abbr b bundle
abbr be "bundle exec"
abbr bi "bundle install"
abbr bo "bundle open"
abbr bu "bundle update"
abbr buc "bundle update --conservative"

# Ruby/Rails
abbr r "bundle exec rails server -p 3000"
abbr rf "bundle exec foreman start -f Procfile.local"
abbr cf "foreman run bundle exec rails c"
abbr rp "PORT=3000 bundle exec puma -C config/puma.rb"
abbr c "bundle exec rails console"
abbr s "bundle exec rspec"

# Git
abbr g git

# Ruby/Rails aliases
balias dm "bundle exec rails data:migrate"
balias sm "bundle exec rails db:migrate"
balias smm "bundle exec rails g migration"
balias routes "bundle exec rails routes | fzf"
balias tasks "bundle exec rails -T"

# Git aliases
balias grm "git rebase main --autostash"
balias grd "git rebase develop --autostash"
balias grimaster "git rebase -i master --autostash --ignore-date"
balias grimain "git rebase -i main --autostash --ignore-date"
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
balias ms "./bin/ms"

# Postgresql alias
balias createuser "createuser -s -d -R"

# Set vim on fish
fish_vi_key_bindings

function gcf --argument commit_id
    git add . && git commit --fixup=$commit_id
end

function gauto
    git rebase -i --autosquash (git merge-base HEAD main)
end

function gri --argument commit_id
    eval "git rebase -i $commit_id~1 --autostash --ignore-date"
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
