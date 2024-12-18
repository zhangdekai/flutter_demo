## Git command

git config --global user.name "zhangdekai"

git config --global user.email "zhangdekai@me.com"

1. 保留改动到工作区, 提交了，但未push,要取消commit.
   git reset --soft HEAD~1

2. 保留改动到暂存区（常用）
   git reset --soft HEAD~1

3. 完全丢弃改动
   git reset --hard HEAD~1

4. git cherry-pick commit_id
5. git log -2
6. git clone <仓库地址>
7. git status
8. git add <文件名>  # 添加单个文件
   git add .
9. git commit -m "提交信息"
10. git branch
11. git switch <分支名>
12. git checkout -b <分支名>
13. git merge <分支名>
14. git push origin <分支名>
15. git pull origin <分支名>
16. git fetch origin <分支名>
17. git remote -v
18. git tag <标签名>
19. git push origin <标签名>
20. git push origin --delete <标签名>






