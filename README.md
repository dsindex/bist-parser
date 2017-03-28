# bist-parser

### description
  - test code for [bist-parser](https://github.com/elikip/bist-parser)

### how to test
```shell
$ git clone https://github.com/dsindex/bist-parser.git
$ cd bist-parser
# install dynet, http://dynet.readthedocs.io/en/latest/python.html
$ git clone https://github.com/elikip/bist-parser.git
$ ls
README.md        UD_English/      bist-parser/     convert.py       dynet-base/      eval.sh*         eval_sejong.sh*  results/         sejong/          train.sh*        train_sejong.sh*
# training with UD_English corpus.
$ ./train.sh -v -v
$ ./eval.sh -v -v
$ cat results/test_pred.coll.txt
  # epoch 5 
  Labeled   attachment score: 18611 / 21943 * 100 = 84.82 %
  Unlabeled attachment score: 19280 / 21943 * 100 = 87.86 %
  Label accuracy score:       19993 / 21943 * 100 = 91.11 %
  ...
# training with Sejong corpus.
# the corpus is accessible through the path on this image : https://raw.githubusercontent.com/dsindex/blog/master/images/url_sejong.png
# copy sejong_treebank.txt.v1 to `sejong` directory.
$ ./train_sejong.sh -v -v
$ ./eval_sejong.sh -v -v
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
