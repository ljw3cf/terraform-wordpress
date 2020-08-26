LIMP Stack with terraform
--------------------------

### Components
- network.tf
  + VPC                             = 1 [192.168.0.0/16]
    - AZ                            = 3
      - ap-northeast-2a
      - ap-northeast-2b
      - ap-northeast-2c
    - Public Subnet                 = 3
      - 192.168.10.0/24
      - 192.168.20.0/24
      - 192.168.30.0/24
    - Private Subnet                = 3
      - 192.168.40.0/24
      - 192.168.50.0/24
      - 192.168.60.0/24
    - Route table                   = 2 [Public 1 / Private 1]
    - Public Route table association = 3 [Public Subnet 3]
    - Private Route talbe association = 3 [Private Subnet 3]
    - Internet gateway              = 1 [VPC 1]
    - NAT gateway                   = 1 [Public Subnet 3]
    - Elastic IP                    = 1 [NAT gateway]
- provider.tf

 