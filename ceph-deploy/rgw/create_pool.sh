#!/bin/bash

PG_NUM=250
PGP_NUM=250
SIZE=3

for i in `cat /root/pool`
        do
        ceph osd pool create $i $PG_NUM
        ceph osd pool set $i size $SIZE
        done

for i in `cat /root/pool`
        do
        ceph osd pool set $i pgp_num $PGP_NUM
        done
