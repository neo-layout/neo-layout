#!/usr/bin/env python
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import matplotlib.image as mpimg
import seaborn as sns 

f = open("faust.txt", "r")
str = f.read()

LAYOUT = ["xvlcwkhgfqß","uiaeosnrtdy","üöäpzbm,.j"]
#LAYOUT = ["qwertzuiopü","asdfghjklöö","yxcvbnm;:-"]

# we create two vertically offset data points for each key
# to visually vertically stretch the result
d = {}
for i in range(len(LAYOUT[0])):
    x = LAYOUT[0][i]
    X = x.upper()
    d[x] = [(73+i*36), (62-10),0]
    d[X] = [(73+i*36), (62+0),0]
for i in range(len(LAYOUT[1])):
    x = LAYOUT[1][i]
    X = x.upper()
    d[x] = [(84+i*36), (98-10),0]
    d[X] = [(84+i*36), (98+0),0]
for i in range(len(LAYOUT[2])):
    x = LAYOUT[2][i]
    X = x.upper()
    d[x] = [(101+i*36), (134-10),0]
    d[X] = [(101+i*36), (134+0),0]

for x in str:
    x = x.lower()
    X = x.upper()
    if x in d.keys():
        d[x][2] += 1
        d[X][2] += 1

df = pd.DataFrame.from_dict(d, orient="index", columns=["x","y","z"])
fig = plt.figure(figsize=(5.35, 1.83), dpi=100)
ax= fig.add_axes([0,0,1,1])
img = mpimg.imread("neo.png")
sns.kdeplot(data=df, x="x",y="y",weights="z",
            cmap='rainbow', fill=True, alpha=1,
            bw_adjust=0.5, thresh=0,
            cut=800, clip=((0,535),(0,183)),
            levels=1000)

ax.imshow(img, alpha=0.4, zorder=5)
ax.axes.get_xaxis().set_visible(False)
ax.axes.get_yaxis().set_visible(False)
ax.set_frame_on(False)
ax.axis('off')
plt.savefig('heatmap.png')
