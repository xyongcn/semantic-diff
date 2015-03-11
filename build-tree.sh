

gcc -fdump-tree-cfg-raw $1
mv $1.013t.cfg $1.cfg

gcc -fdump-tree-cfg-raw-lineno $1
mv $1.013t.cfg $1.lcfg

gcc -fdump-tree-cfg-raw $2
mv $2.013t.cfg $2.cfg

gcc -fdump-tree-cfg-raw-lineno $2
mv $2.013t.cfg $2.lcfg

sed -i 's/D\.[0-9]*/real_tmp/g' $1.cfg
sed -i 's/D\.[0-9]*/real_tmp/g' $2.cfg

diff -C 2 $1.cfg $2.cfg  > $1_$2.astdiff

ruby get-linenum.rb $1 $2

diff -u  $1.out $2.out  > $1_$2.diff

