# -*- coding: utf-8 -*-
import jieba
from nltk import word_tokenize
from nltk.corpus import stopwords
import numpy as np
import re


def get_word_vector(s1, s2):
    """
    :param s1: 句子1
    :param s2: 句子2
    :return: 返回句子的余弦相似度
    """
    # 分词
    Filed1_V1 = word_tokenize(s1)
    Filed2_V1 = word_tokenize(s2)

    interpunctuations = [',', '.', ':', ';', '?', '(', ')', '[', ']', '&', '!', '*', '@', '#', '$', '%']
    Filed1_V2 = [word for word in Filed1_V1 if word not in interpunctuations]
    Filed2_V2 = [word for word in Filed2_V1 if word not in interpunctuations]

    stops = set(stopwords.words("english"))
    Filed1_V3 = [word for word in Filed1_V2 if word not in stops]
    Filed2_V3 = [word for word in Filed2_V2 if word not in stops]

    list_word1 = (','.join(Filed1_V3)).split(',')
    list_word2 = (','.join(Filed2_V3)).split(',')

    # 列出所有的词,取并集
    key_word = list(set(list_word1 + list_word2))
    # 给定形状和类型的用0填充的矩阵存储向量
    word_vector1 = np.zeros(len(key_word))
    word_vector2 = np.zeros(len(key_word))

    # 计算词频
    # 依次确定向量的每个位置的值
    for i in range(len(key_word)):
        # 遍历key_word中每个词在句子中的出现次数
        for j in range(len(list_word1)):
            if key_word[i] == list_word1[j]:
                word_vector1[i] += 1
        for k in range(len(list_word2)):
            if key_word[i] == list_word2[k]:
                word_vector2[i] += 1

    # 输出向量
    print(word_vector1)
    print(word_vector2)
    return word_vector1, word_vector2


def cos_dist(vec1, vec2):
    """
    :param vec1: 向量1
    :param vec2: 向量2
    :return: 返回两个向量的余弦相似度
    """
    dist1 = float(np.dot(vec1, vec2) / (np.linalg.norm(vec1) * np.linalg.norm(vec2)))
    return dist1


def filter_html(html):
    """
    :param html: html
    :return: 返回去掉html的纯净文本
    """
    dr = re.compile(r'<[^>]+>', re.S)
    dd = dr.sub('', html).strip()
    return dd


if __name__ == '__main__':
    s1 = "Total energy cost"
    s2 = "Total cost (include VAT)"

    vec1, vec2 = get_word_vector(s1, s2)
    dist1 = cos_dist(vec1, vec2)
    print(dist1)
