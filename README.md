# lb_target_group이랑  templates를 알아내고 나머지 정리해서 업로드 ㄱ

# modules 폴더는 실제 사용하는 기능을 만들어 두었습니다.

route =  해당 테이블에 설정할 경로에 대한 Code
route_association =  서브넷간, 인터넷 게이트웨이, 가상 프라이빗 게이트웨이 간의  연결을 당담하는 Code
route_table = VPC에서 사용되며, 서브넷의 라우팅 규칙을 정의하는 Code


auto_scaling_group = Auto Scaling Group 리소스를 생성하는 Code
lb = nlb,alb 리소스를 생성하는 Code
lb_listener = nlb,alb 리스터를 생성하는 Code
lb_listener_rule = Load Balancer 리스너 규칙을 생성하는 Code

lb_target_group = 로드 밸런서 리소스와 함께 사용할 대상 그룹 리소스지정하는 code
security_group = 시큐리티 그룹을 생성하기 위한 Code
subnet = 서브넷을 생성하기 위한 Code
vpc = vpc을 생성하기 위한 Code
igw = internet gateway  리소스를 생성하는 Code
ngw = nat gatway 리소스를 생성하는 Code
ec2 = 서버 리소스를 생성하는 Code
eip =  공인ip(eip) 리소스를 생성하는 Code
templates = 오토스케일링에서 스케일 아웃될 때, vm이미지와 인스턴스 타입, SG정의, 서버데이터 스크립트를 선언하는 Code입니다.
tgw = transit gateway 리소스를 생성하는 Code, Vpc간에 통신을 담당

# vpc 폴더는 modules에 있는 변수를 선언하였습니다.

