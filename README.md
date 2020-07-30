# TextSim_cn_finetune
微调预训练语言模型(BERT、Roberta、XLBert等),用于计算两个文本之间的相似度（通过句子对分类任务转换）,适用于中文文本

## 项目变动
2020-07-23：在使用AlBert时，请将该项目下的modeling.py文件更新为官方ALBert项目中下的modeling.py，而后在运行。<br>
2020-3-2：新增tf-serving模块部署方式。

## 项目描述
* 项目驱动
* 数据集
* 模型训练
* 模型导出
* 预测
## 项目驱动
在公司做意图分类以及CAIL比赛时，由于句子对应的标签往往为一个短句描述，而且类别数量或者标签数量在50以上，通过将<sent1, label>转换成<sent, label, 1/0>这种句子对分类形式，并取模型的softmax层输出的概率值来衡量sent和label之间的相似度。<br>
通过这种模式，可解决以下类型的问题：<br>
（1）多分类问题<br>
（2）多标签问题<br>
（3）相似句子匹配问题<br>
## 数据集
该项目所采用的的数据集来源于CAIL2019的要素识别数据集，不过本项目中通过特殊处理将其处理成了下述形式：<br>
![数据集描述](https://github.com/Vincent131499/TextSim_cn_finetune/raw/master/imgs/dataset_show.jpg)
第一列为句子对的分类标签（0代表不相关，1代表相关），第二列表示句子sent对应的类别label，第三列代表句子sent。
## 模型训练
运行命令：<br>
```Bash
bash train.sh
```
运行参数说明：
BERT_BASE_DIR：下载的预训练语言模型所在路径（本文使用的是Roberta-base模型，下载地址：https://pan.baidu.com/s/1qVzinv0KzFzKHIABJKquuw&shfl=sharepset  提取码：usav）<br>
DATA_DIR：数据集所在路径，该路径下包括三个文件train.tsv,dev.tsv,test.tsv<br>
TRAINED_CLASSIFIER：模型保存的路径<br>
MODEL_NAME：模型名称。模型保存时会保存在$TRAINED_CLASSIFIER/$MODEL_NAME目录下<br>
## 模型导出
模型训练完成会在指定的$TRAINED_CLASSIFIER/$MODEL_NAME目录下生成ckpt格式的文件，如下所示：<br>
* checkpoint
* model.ckpt-926.data-00000-of-00001
* model.ckpt-926.index
* model.ckpt-926.meta<br><br>
<br>但这种ckpt格式的模型占用空间很大，一般都需要好几个G的空间，为了压缩模型，也为了进一步加速模型加载的速度，使用export.sh来导出模型<br>
模型导出命令：
```Bash
bash export.sh
```
注意，除了需要将do_eval、do_train设置为False，还要把do_export设置为True，再指定模型导出的目录export_dir.
本项目运行导出命令，会生成exported目录，如下图所示：<br>
![模型导出文件展示](https://github.com/Vincent131499/TextSim_cn_finetune/raw/master/imgs/exported_show.jpg)
## 预测
支持两种模式：
### 线下实时预测
运行命令：
```Bash
python test_serving.py
```
运行效果：<br>
![线下推理](https://github.com/Vincent131499/TextSim_cn_finetune/raw/master/imgs/offline_show.jpg)
### 线上实时预测
方式1：flask简单部署
运行命令：
```Bash
python test_serving_api.py
```
运行效果：<br>
![线下推理](https://github.com/Vincent131499/TextSim_cn_finetune/raw/master/imgs/api_show.jpg)
方式2：tf-serving部署
详细部署步骤可参考[this post](https://vincent131499.github.io/2020/02/28/以BERT分类为例阐述模型部署关键技术)
