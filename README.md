# PROJECT EXPERIENCE


Plan:

- Draw diagram of VPC

Required Terraform resources:
- vpc (eu-west-2) ✅
- two subnets (eu-west-2a, eu-west-2b)✅
- Sec Groups✅
- nacls✅
- route table✅
- igw✅
- web instance✅
- load balancer setup✅
- autoscale group setup✅
- Write init.sh script to install & run nginx webserver ✅

### TO-DO:

- Test access via load balancer

######## BLOCKERS

Unable to ssh into web instance. Error="ssh: ...Operation timed out"
POTENTIAL FIXES:
- Triple check firewalls. Inbound access from my ip; port 22
- Created bare instance (no firewalls). [Able to ssh into machine]
- No public dns? Investigate this. [changed; no effect.]
- Investigate LB setup? Try removing lb to test.
- Open ephermal ports? (1024-65535) [SOLUTION✅✅✅]
