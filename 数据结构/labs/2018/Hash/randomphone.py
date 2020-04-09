#!/usr/bin/env python3
import random
import sys
for i in range(int(sys.argv[1])):
    print(random.choice(['139','188','185','136','158','151'])+"".join(random.choice("0123456789") for i in range(8)))
