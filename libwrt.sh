#!/bin/bash
rm -rf package/emortal/luci-app-athena-led
# 去除值守管理
rm -rf package/emortal/luci-app-athena-led

# Git稀疏克隆，只克隆指定目录到本地
function git_sparse_clone() {
  branch="$1" repourl="$2" && shift 2
  git clone --depth=1 -b $branch --single-branch --filter=blob:none --sparse $repourl
  repodir=$(echo $repourl | awk -F '/' '{print $(NF)}')
  cd $repodir && git sparse-checkout set $@
  mv -f $@ ../package
  cd .. && rm -rf $repodir
}

git clone --depth=1 https://github.com/NONGFAH/luci-app-athena-led package/luci-app-athena-led
chmod +x package/luci-app-athena-led/root/etc/init.d/athena_led package/luci-app-athena-led/root/usr/sbin/athena-led
# 添加momo
git_sparse_clone main https://github.com/kenzok8/small-package momo luci-app-momo
#添加chinadns
git clone -b master https://github.com/izilzty/luci-app-chinadns-ng package/luci-app-chinadns-ng