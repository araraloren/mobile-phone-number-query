#!/usr/bin/env python  
# -*- coding: utf-8 -*-
import re,sys,os
#ÔËÐÐÊ± python abc.py  num.unl
DATABASE = 'msi.unl'
D_START = {}
D_STOP  = {}
REGION  = {}
def loadcfg():
  row = 1
  with open(DATABASE,'r') as f:
    for line in f:
      if not re.search('^\s*$',line):
        line = line.split()
        D_START[row] = int(line[0].strip())
        D_STOP[row]  = int(line[1].strip())
        REGION[row] = line[2].strip()
        row += 1
def search(tel):
  low = 1
  max = len(D_START)
  while low <=max:
    mid = (low+max) / 2
    if tel >= D_START[mid]:
      if tel >= D_START[mid] and tel <= D_STOP[mid]:
        return REGION[mid]
      else:
        low = mid +1
    else:
      max = mid-1
  return 'unknow'
def main():
  argvs = len(sys.argv)
  if argvs != 2:
    print 'Usage : %s telfile' % sys.argv[0]
    return False
  
  if not os.path.isfile(sys.argv[1]):
    print 'Error : %s is not file . ' % sys.argv[1]
    return False
  loadcfg()
  if len(D_START) == 0:return False
  with open(sys.argv[1],'r') as f:
    for line in f:
      if not re.search('^\s*$',line):
        line = line.strip()
        print line,search(int(line))
if __name__ == '__main__':
  main()
