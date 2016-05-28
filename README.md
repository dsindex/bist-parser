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
$ cp cnn/pycnn/libcnn_shared.so bist-parser/barchybrid/
$ ./train.sh -v -v
$ ./test.sh -v -v
$ cat results/test_pred.coll.txt
  Labeled   attachment score: 18611 / 21943 * 100 = 84.82 %
  Unlabeled attachment score: 19280 / 21943 * 100 = 87.86 %
  Label accuracy score:       19993 / 21943 * 100 = 91.11 %
  ...
(training korean sejong corpus)
(get korean sejong corpus from somewhere;;)
$ cp sejong_treebank.txt.v1 sejong/
$ ./train_sejong.sh -v -v
$ ./test_sejong.sh -v -v
...
accuracy(UAS) = 0.892086
...
$ cat results/test_pred.coll.txt
  Labeled   attachment score: 81723 / 88608 * 100 = 92.23 %
  Unlabeled attachment score: 83967 / 88608 * 100 = 94.76 %
  Label accuracy score:       85909 / 88608 * 100 = 96.95 %
  ...
....
```
