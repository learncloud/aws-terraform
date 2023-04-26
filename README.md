# 1. modules 폴더는 실제 사용하는 기능을 서술

- route : 해당 테이블에 설정할 경로에 대한 Code 입니다. <br>
- route_association : 생성된 테이블에 서브넷을 명시적으로 연결 해주는 Code 입니다. <br>
- route_table : Route Table을 생성하는 Code 입니다. <br>
- auto_scaling_group : Auto Scaling Group 리소스를 생성하는 Code 입니다. <br>
- lb : nlb,alb 리소스를 생성하는 Code 입니다. <br>
- lb_listener : nlb,alb 리스너를 생성하는 Code 입니다. <br>
- lb_listener_rule : Load Balancer 리스너 규칙을 생성하는 Code 입니다. <br>
- lb_target_group : 로드 밸런서 리소스와 함께 사용할 대상 그룹 리소스지정하는 Code 입니다. <br>
- security_group : 보안 그룹을 생성하기 위한 Code 입니다. <br>
- subnet : 서브넷을 생성하기 위한 Code 입니다. <br>
- vpc : vpc을 생성하기 위한 Code 입니다. <br>
- igw : internet gateway  리소스를 생성하는 Code 입니다. <br>
- ngw : nat gatway 리소스를 생성하는 Code 입니다. <br>
- ec2 : 서버 리소스를 생성하는 Code 입니다. <br>
- eip :  공인ip(eip) 리소스를 생성하는 Code 입니다. <br>
- templates : 오토스케일링에서 스케일 아웃될 때, vm이미지와 인스턴스 타입, SG정의, 서버데이터 스크립트를 선언하는 Code 입니다. <br>
- tgw : transit gateway 리소스를 생성하는 Code, Vpc간에 통신을 담당하는 Code 입니다. <br>

# 2. vpc 폴더는 modules에 있는 변수를 선언하였습니다.
