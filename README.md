# bist-parser

- description
  - test code for [bist-parser](https://github.com/elikip/bist-parser)

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
$ cp cnn/pycnn/libcnn_shared.so bist-parser/barchybrid/src
$ ./train.sh -v -v
(training korean sejong corpus)
(get korean sejong corpus from somewhere;;)
$ cp sejong_treebank.txt.v1 sejong/
$ ./train_sejong.sh -v -v
....
```
