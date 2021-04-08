# Anthos clusters on AHV

## What to expect

This repo provides two automation methods for deploying Anthos clusters on AHV. You can choose between a Calm blueprint or a Terraform file.

## Overview

The characteristics for the Kubernetes cluster are:

* Anthos model: bare metal

* Anthos versions:

  * Supported [1.6.x](https://cloud.google.com/anthos/clusters/docs/bare-metal/1.6/concepts/about-bare-metal)

  * Unsupported [1.7.0](https://cloud.google.com/anthos/clusters/docs/bare-metal/1.7/concepts/about-bare-metal)

* Type: hybrid - <https://cloud.google.com/anthos/clusters/docs/bare-metal/1.6/installing/install-prep#hybrid_cluster_deployment>

* Number of virtual machines: 6 (Total resources: 24 vCPU / 192 GB memory / 768 GB storage )

  * 1 x Admin

  * 3 x Control plane

  * 2 x Worker nodes

* Virtual machine OS: CentOS 8 GenericCloud - <https://cloud.centos.org/centos/8/x86_64/images/CentOS-8-GenericCloud-8.2.2004-20200611.2.x86_64.qcow2>

* High availability: yes

* Load balancing: yes (bundled)

* Ingress: yes

* Persistent storage: yes (Nutanix CSI)

* Proxy: no

* KubeVirt: no

* OpenID Connect: no

* Application logs/metrics: no

* Scale Out/In: yes

* Upgrade Anthos version: yes

* Decommission Anthos cluster: yes

## Prerequisites

* Nutanix:

  * Cluster:

    * AHV: 20201105.1045 or later

    * AOS: 5.19.1 or later

    * iSCSI data service IP configured

    * VLAN network with AHV IPAM configured

    * Prism Central: 2020.11.0.1 or later

* Google Cloud:

  * A project with Owner role

  * The project must have enabled Monitoring - <https://console.cloud.google.com/monitoring>

  * A service account - <https://console.cloud.google.com/iam-admin/serviceaccounts/create>

    * Role: Project Owner

    * A private key: JSON

* Networking:

  * Internet connectivity

  * AHV IPAM: Minimum 6 IP addresses available for the virtual machines

  * Kubernetes:

    * Control plane VIP: One IP address in the same network than virtual machines but not part of the AHV IPAM

    * Ingress VIP: One IP address in the same network than virtual machines but not part of the AHV IPAM. This IP must be part of the load balancing pool

    * Load balancing pool: Range of IP addresses in the same network than virtual machines but not part of the AHV IPAM. The Ingress VIP is included in this pool

    * Pods network: CIDR network with enough IP addresses, usually /16 and not sharing the same network than virtual machines or Kubernetes Services. If your containerized application must communicate with a system out of the Kubernetes cluster, make sure then this network doesn't overlap either with the external system network

    * Services network: CIDR network with enough IP addresses, usually /16 and not sharing the same network than virtual machines or Kubernetes Pods. If your containerized application must communicate with a system out of the Kubernetes cluster, make sure then this network doesn't overlap either with the external system network

* Credentials:

  * Operating system: you need a SSH key. It must start with `---BEGIN RSA PRIVATE KEY---`. To generate one in a terminal:

    ```console
    ssh-keygen -m PEM -t rsa -f <keyname>
    ```

  * Prism Element: an account, local or Active Directory, with *User Admin* role. This is for the CSI plugin configuration