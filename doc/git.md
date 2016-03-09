git log --stat
git log -p


git fetch --all
git merge
git rebase
git pull
git pull --rebase

git add tools.py
git rm utils.py
git mv model.py models.py

git status
git diff
git diff --staged
git diff --cached



git checkout -- main.py

git reset HEAD main.py

git add tests.py
git commit --amend

git fetch --all
git rebase bugfix/remove_error
这个时候就提示你代码冲突了，处理完冲突的代码后
git diff  # code review 下代码
git rebase --continue  # 有时候会 git rebase --skip
直到不用再 rebase 为止

git checkout master
git merge --no-ff release-1.2
git tag -a v1.2
git tag  # 确认下打上了标签了
git push origin v1.2  # 推送标签到远程版本库

git blame
git log


git stash
合并或衍合完毕代码后
git stash pop  # 恢复刚才修改了一半的代码

原来的一个项目想拆分多个项目，又想保留版本仓库记录，可以用下 git subtree split，例如：
git subtree split --prefix=plugins/sqli



# 显示已经全部合并到当前分支的分支
$ git branch --merged
# 显示没有合并到当前分支的分支
$ git branch --no-merged



 git commit --amend
 git checkout feature132
 git reset --hard HEAD~2

 git checkout FOO
 git reset --hard SHA

 git update-ref refs/heads/FOO SHA

 



