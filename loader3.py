import os
import re
import cv2
import numpy as np
import csv
import random


def image_load(path):
    file_list = os.listdir(path)
    result = []
    file_res = []
    
    for i in file_list:
        a = int( re.sub('[^0-9]','',i))
        result.append(a)
    result.sort()
    
    for i in result:
        a = ('%s\\%d.jpg'%(path,i))
        file_res.append(a)
    image = []
    
    for k in file_res:
        img = cv2.imread(k)        
        image.append(img)
    
    return np.array(image)


def label_load(path):

    file = open(path)
    labeldata = csv.reader(file)
    labellist = list(labeldata)
    label = np.array(labellist)
    label = label.astype(int)
    label = np.eye(12)[label]
    label = label.reshape(-1,12)
    return label


def next_batch( data1, data2, init, fina ):
    return data1[ init : fina ], data2[ init : fina ]

def shuffle_batch( data_list, label ) :
    x = np.arange( len( data_list) )
    random.shuffle(x)
    data_list2 = data_list[x]
    label2 = label[x]
    return data_list2,label2