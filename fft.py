# -*- coding: utf-8 -*-
"""
Created on Tue Jul 30 22:10:39 2019

@author: user
"""
import glob
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import os

path = r'C:/Users/user/Documents/MATLAB/Training/Healthy'
allFiles = glob.glob(os.path.join(path,"*.txt"))
columns = ['Acceleration']
all = pd.DataFrame(columns=['Acceleration'])
data_list = []
for index, file_ in enumerate(allFiles):
    new_df = pd.DataFrame()
    temp = pd.read_csv(file_, names=columns)
    temp = temp.drop(temp.index[[0, 1, 2, 3, 4, 5]], axis=0)
    temp = temp.reset_index(drop=True)
    temp = temp.astype(float)
    print(file_)
    #temp.plot()
    #plt.show()
    temp_np =temp.values

    list1 = []
    list2 = []
    for i in temp_np:
        list1.append(i[0])
    list2.append(list1)
    list2.append(1)
    print(list2)
    globals()['data_{}'.format(index)] = list2
#    all = all.append(temp)
#    print ( all)
#    print("------------------")
#    temp_np =temp.values
for i in range(20):
    data_list.append(globals()['data_{}'.format(i)])

data_array = np.array(data_list)
healthy_1 = data_array[0][0]
healthy_label = data_array[0][1]
fft = np.fft.fft(healthy_1)
plt.plot(healthy_1)
plt.show()
plt.plot(fft)
plt.show()
print(healthy_label)
#for i in range(1, 21):
#    df = pd.read_csv("Normal Data Mar-26-14 Time 152"*"-{}.txt".format(i))
#    df = df.drop(df.index[0:4])
#    df = df.astype(float)
#    df['label'] = 1

#data = df.values
#list = []
#list2 = []
#for i in data:
#    list.append(i[0])
#list2.append(list)
#list2.append(1)
#plt.plot(data_array)
#plt.show()
#fft = np.fft.fft(data_array)
#
#plt.plot(fft)
#plt.show()