# bist-parser

- description
  - test code for bist-parser

- how to test
```
$ git clone https://github.com/dsindex/bist-parser.git
$ cd bist-parser
(after installing cnn, eigen)
(for test)
$ cp cnn/pycnn/libcnn_shared.so .
$ cp cnn/pyexamples/xor.py .
$ python xor.py
$ git clone https://github.com/elikip/bist-parser.git
$ ls 
README.md  bist-parser  cnn  eigen  libcnn_shared.so  xor.py
(download univeral treebank corpus, http://universaldependencies.org/#en, for example UD_English)
$ mkdir results
$ python bist-parser/barchybrid/src/parser.py --cnn-seed 123456789 --outdir results --train UD_English/en-ud-train.conllu --dev UD_English/en-ud-dev.conllu --test UD_English/en-ud-test.conllu --epochs 30 --lstmdims 125 --lstmlayers 2 --bibi-lstm --k 3 --usehead --userl
....
```
