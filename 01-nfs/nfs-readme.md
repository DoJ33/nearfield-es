# Setup NFS for Microk8s/ULT 22.04

## Option-1  (https://microk8s.io/docs/nfs)

1. Setup an NFS server 
2. Install the CSI driver for NFS
3. Create a StorageClass for NFS
4. Create a new PVC

## Option-2: 

1. Set up a NFS Server on a Kubernetes cluster (https://github.com/CrunchyData/postgres-operator-examples)
2. Install CSI driver with Helm 3 (same as option-1/setp:2)(https://github.com/kubernetes-csi/csi-driver-nfs/blob/master/charts/README.md)
3. refer the file `storageclass-nfs.yaml` create **storageclass-nfs.yaml** https://github.com/kubernetes-csi/csi-driver-nfs/blob/master/deploy/example/storageclass-nfs.yaml
4. refer the file `pvc-nfs-csi-dynamic.yaml` create **pvc-nfs-csi-dynamic.yaml** kubectl create -f https://raw.githubusercontent.com/kubernetes-csi/csi-driver-nfs/master/deploy/example/pvc-nfs-csi-dynamic.yaml
>  overall study click on https://github.com/kubernetes-csi/csi-driver-nfs/tree/master/deploy/example



