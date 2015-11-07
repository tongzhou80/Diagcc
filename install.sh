sudo cp bin/diagcc /usr/local/bin/

func_str='	
diagcc_gcc_alias() {
    gcc 2>&1 $1 | diagcc
}
alias gcc=diagcc_gcc_alias

diagcc_gpp_alias() {
    g++ 2>&1 $1 | diagcc
}
alias g++=diagcc_gpp_alias' 
sudo echo "$func_str" >> ~/.bashrc
