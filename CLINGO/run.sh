ulimit -v unlimited
clingo --parallel-mode=22 go.cl 
clingo --parallel-mode=22 go.cl --outf=2 > output.json
python3 sort_JSON.py