#!/usr/bin/env pypy3

import dijkstra as dij
import math


if __name__ == '__main__':
    graph = dij.Graph()
    # fin = open('test.txt', 'r')
    # graph.vexnum = int(fin.readline())
    # start, end = [int(i) for i in fin.readline().split()]
    # fin = open('t()est.txt', 'r')
    # fin.close
    graph.vexnum = int(input())
    start, end = [int(i) for i in input().split()]
    for i in range(graph.vexnum):
        graph.arcs.append([int(j) if int(j) != -1 else math.inf for j in input().split()])
        # graph.arcs.append([int(j) if int(j) != -1 else math.inf for j in fin.readline().split()])
        for j in range(i):
            graph.arcs[i][j] = graph.arcs[j][i]
    # print(graph.arcs)
    short, path = graph.shortestpath(start, end)
    print("Min=%f" % short)
    print("Path ", end='')
    for i in path:
        print(i, end=' ')
    print()
    pass
