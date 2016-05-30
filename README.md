# bist-parser

- description
  - test code for [bist-parser](https://github.com/elikip/bist-parser)

- how to test
```
$ git clone https://github.com/dsindex/bist-parser.git
$ cd bist-parser
(after installing cnn, eigen)
$ cd cnn/pycnn; make install
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
  # epoch 5 
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
# epoch 5
accuracy(UAS) = 0.892086
...
$ cat results/test_pred.coll.txt
  # epoch 5
  Labeled   attachment score: 81723 / 88608 * 100 = 92.23 %
  Unlabeled attachment score: 83967 / 88608 * 100 = 94.76 %
  Label accuracy score:       85909 / 88608 * 100 = 96.95 %
  ...
$ more results/test_pred.conll-eoj-ret
; 프랑스의 세계적인 의상 디자이너 엠마누엘 웅가로가 실내 장식용 직물 디자이너로 나섰다.
1	프랑스의	프랑스/NNP + 의/JKG	NP_MOD	4	NP_MOD	6	FAILURE
2	세계적인	세계/NNG + 적/XSN + 이/VCP + ᆫ/ETM	VNP_MOD	4	VNP_MOD	4	SUCCESS
3	의상	의상/NNG	NP	4	NP	4	SUCCESS
4	디자이너	디자이너/NNG	NP	6	NP	6	SUCCESS
5	엠마누엘	엠마누엘/NNP	NP	6	NP	6	SUCCESS
6	웅가로가	웅가로/NNP + 가/JKS	NP_SBJ	11	NP_SBJ	11	SUCCESS
7	실내	실내/NNG	NP	8	NP	9	FAILURE
8	장식용	장식/NNG + 용/XSN	NP	9	NP	9	SUCCESS
9	직물	직물/NNG	NP	10	NP	10	SUCCESS
10	디자이너로	디자이너/NNG + 로/JKB	NP_AJT	11	NP_AJT	11	SUCCESS
11	나섰다.	나서/VV + 었/EP + 다/EF + ./SF	VP	0	VP	0	SUCCESS
....
```
