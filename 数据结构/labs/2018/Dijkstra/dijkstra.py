#!/usr/bin/env python3
# Dijkstra shortest path, a simple navigation software, use matploblib as GUI

import math
import copy


class City:
    def __init__(self, name, longtitude, latitude):
        self.name = name
        self.longtitude = longtitude
        self.latitude = latitude


class Graph:
    def __init__(self):
        self.vexnum = 0
        self.arcnum = 0
        self.vexs = []
        self.arcs = []

    def getnodeidx(self, node):
        idx = -1
        for i in range(self.vexnum):
            if self.vexs[i].name == node:
                idx = i
        if idx == -1:
            print("Node not found!")
        return idx

    def addarc(self, n1, n2, d):
        # if d == -1:
        #     d = math.inf
        # idx1 = n1
        # idx2 = n2
        idx1 = self.getnodeidx(n1)
        idx2 = self.getnodeidx(n2)
        assert idx1 != -1, "No such node %s" % n1
        assert idx2 != -1, "No such node %s" % n2
        assert idx1 != idx2, "Wrong arc!"
        self.arcs[idx1][idx2] = d
        self.arcs[idx2][idx1] = d

    def shortestpath(self, n1, n2, usestr=0):
        if usestr:
            n1 = self.getnodeidx(n1)
            n2 = self.getnodeidx(n2)
        if n1 == -1 or n2 == -1:
            print("No such node!")
            return -1, []
        short = [self.arcs[n1][i] for i in range(self.vexnum)]
        path = [[] for i in range(self.vexnum)]
        final = [False for i in range(self.vexnum)]
        for i in range(self.vexnum):
            short[i] = self.arcs[n1][i]
            if short[i] < math.inf:
                path[i].append(n1)
                path[i].append(i)
        short[n1] = 0
        final[n1] = True
        for i in range(self.vexnum - 1):
            mininum = math.inf
            v = -1
            for w in range(self.vexnum):
                if not final[w] and short[w] < mininum:
                    v = w
                    mininum = short[w]
            final[v] = True
            if v == n2:
                break
            for w in range(self.vexnum):
                if not final[w] and mininum + self.arcs[v][w] < short[w]:
                    short[w] = mininum + self.arcs[v][w]
                    path[w] = copy.deepcopy(path[v])
                    path[w].append(w)
        return short[n2], path[n2]


if __name__ == '__main__':
    import matplotlib.pyplot as plt
    graph = Graph()
    fin = open('./graph.txt', 'r')
    graph.vexnum = int(fin.readline())
    graph.arcnum = int(fin.readline())
    graph.arcs = [[math.inf for i in range(graph.vexnum)] for j in range(graph.vexnum)]
    for i in range(graph.vexnum):
        name, lo, li = fin.readline().split()
        lo = float(lo)
        li = float(li)
        graph.vexs.append(City(name, lo, li))
    for i in range(graph.arcnum):
        city1, city2, dist = fin.readline().split()
        dist = float(dist)
        graph.addarc(city1, city2, dist)
    fin.close()
    # sp = graph.shortestpath("p", "s", usestr=1)
    # print(sp)
    # sp = graph.shortestpath("a", "d", usestr=1)
    # print(sp)
    # sp = graph.shortestpath("a", "g", usestr=1)
    # print(sp)
    plt.figure()
    plt.title("Map")
    plt.xlabel("Longtitude")
    plt.ylabel("Latitude")
    for i in range(graph.vexnum):
        for j in range(i):
            if graph.arcs[i][j] != math.inf:
                v1x = graph.vexs[i].longtitude
                v2x = graph.vexs[j].longtitude
                v1y = graph.vexs[i].latitude
                v2y = graph.vexs[j].latitude
                plt.plot([v1x, v2x], [v1y, v2y], color='cyan')
                plt.text((v1x + v2x) / 2.0, (v1y + v2y) / 2.0,  '%d' % graph.arcs[i][j],
                         ha='center', va='center', fontsize=7, color='blue')
    for i in range(graph.vexnum):
        x = graph.vexs[i].longtitude
        y = graph.vexs[i].latitude
        plt.scatter(x, y, color='cyan')
        plt.text(x, y,  '%s' % graph.vexs[i].name, ha='center', va='center', color='black', fontsize=13)
    plt.show(0)
    lines = []
    while True:
        try:
            start = input('Enter source: ')
            end = input('Enter destination: ')
        except ValueError:
            print('Wrong input')
        except EOFError:
            break
        else:
            for i in lines:
                i.remove()
            lines = []
            short, path = graph.shortestpath(start, end, usestr=1)
            plt.title('Shortest path: %f' % short)
            for i in range(len(path) - 1):
                v1x = graph.vexs[path[i]].longtitude
                v2x = graph.vexs[path[i + 1]].longtitude
                v1y = graph.vexs[path[i]].latitude
                v2y = graph.vexs[path[i + 1]].latitude
                lines.append(plt.plot([v1x, v2x], [v1y, v2y], color='orange')[0])
            plt.show(0)
