Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy ByPass

# Basic checking, many other cases present
if (![Environment]::UserInteractive) {
	Write-Output "In non-interactive mode"
	return
}

function prompt {
	$u=[Environment]::UserName
	$h=[Environment]::MachineName.ToLower()
	$u + "@" + $h + "> " 
}

Set-PSReadlineOption -BellStyle None
Set-PSReadlineKeyHandler -Key Tab -Function Complete
Set-PSReadlineKeyHandler -Key Alt+p -Function ReverseSearchHistory
Set-PSReadlineKeyHandler -Key Alt+n -Function ForwardSearchHistory

function mkgls {
	Get-ChildItem -Name
}

function mkgAlias {
	Param(
		[Parameter(Mandatory, HelpMessage="key is missing")]
		[String]$key,
		[Parameter(Mandatory, HelpMessage="val is missing")]
		[string]$val
	)
	Set-Alias -Name $key -Value $val
}

del alias:ls -Force
del alias:sc -Force

Set-Alias -Name ls -Value mkgls
Set-Alias -Name ll -Value Get-ChildItem

function vid {
	vim.exe -d $args
}
function vip {
	vim.exe -p $args
}
function vio {
	vim.exe -O $args
}
function gvid {
	gvim.exe -d $args
}
function gvip {
	gvim.exe -p $args
}
function gvio {
	gvim.exe -O $args
}

Set-Alias -Name vi -Value vim.exe
Set-Alias -Name gvi -Value gvim.exe

function diu {
	diff.exe -U 0 $args
}
function di {
	diff.exe -U 0  --brief -r -x ".git*" -x "*.pyc" -x "node_modules*" -x "*.o" -x "Build*" -x "installs*" $args
}
function dv {
	dirs.exe -v $args
}
function fn {
	find.exe . -name $args
}
function ssh {
	ssh.exe -X $args
}
function grp {
	grep.exe -Irn --exclude "swagger-ui-bundle.js" --exclude "*_wrap*" --exclude "*.min.js" --exclude-dir "*node_modules*" --exclude-dir "*angular*" --exclude "*.map" --exclude "*tags" $args
}

Set-Alias -Name cf -Value c++filt.exe

function p4in {
	p4.exe interchanges -u [Environment]::UserName //depot/$args[0]/dev/main/src/... //depot/$args[0]/dev/$args[1]/src/...
}
function p4de {
	p4.exe describe $args
}
function p4d {
	p4.exe diff ...
}
function p4src {
	p4.exe diff -se /path/...
}
function p4se {
	p4.exe diff -se ...
}
function p4e {
	p4.exe diff -se ... | xargs.exe -l p4.exe edit
}
function p4o {
	p4.exe opened ...
}
function p4h {
	p4.exe changes -m 5 -u [Environment]::UserName ...
}
function p4c {
	p4.exe change $args
}
function p4s {
	p4.exe shelve -f -c $args
}
function p4sd {
	p4.exe shelve -d -c $args
}

function gitl {
	git.exe log --oneline --all --graph $args
}
function gitb {
	git.exe branch $args
}
function gitrev {
	git.exe checkout origin/master -- $args
}
function gitc {
	git.exe checkout $args
}
function gitcb {
	git.exe checkout -b $args
}
function gits {
	git.exe status $args
}
function gitd {
	git.exe diff -U0 $args
}
function gitdt {
	git.exe difftool $args
}
function gita {
	git.exe add $args
}
function gitaa {
	git.exe add --all
}
function gitm {
	git.exe commit -m $args
}
function gitr {
	git.exe restore $args
}
function gitrs {
	git.exe restore --staged $args
}
function gitsp {
	git.exe stash push -m $args
}
function gitspp {
	git.exe stash pop $args
}
function gitpo {
	git.exe push origin $args
}
function gitppo {
	git.exe pull origin $args
}
function gitch {
	gitc master
	gitppo
	gitc $args[0]
	gitppo $args[0]
	git cherry-pick -m 1 $args[1]
	gits
}
function gitdb {
	gitc $args[0]
	gitppo
	gitc master
	gitppo
	git branch -d $args[0]
}
function gitff {
	gitc master
	gitppo
	gitc $args[0]
	gitppo master
}

function tarc {
	tar.exe -zcvf $args
}
function tarx {
	tar.exe -zxvf $args
}
function tart {
	tar.exe -ztvf $args
}
function pnet {
	netstat.exe -tlunp | grep.exe -v "-" | sort.exe -u
}
function psg {
	ps.exe | grep.exe $args
}
function psgu {
	ps.exe | grep.exe [Environment]::UserName | grep.exe $args
}
function sc {
	screen.exe -rd $args
}
function scc {
	screen.exe -S $args
}
function bcd {
	for (($i = 0); $i -lt $args[0]; $i++) {
		Set-Location ..
	}
	Get-Location
}
function mkcd {
	mkdir.exe $args[0]
	Set-Location $args[0]
}
function cdh {
	Set-Location C:\backup\repo\mercury-monorepo
}
function tree {
	tree.com /A $args
}
