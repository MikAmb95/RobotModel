
function crane = crane_model()

I1 = diag([207.13 247.93 139.99]);
I2 = diag([1023 1026 28]);
I3 = diag([5*0+12 8*0+12 2.50+12]); 

L(1) = Link('revolute', 'd', 1.65, 'a',0, 'alpha', pi/2,'m',546,'I',I1,'r',[0 -1.65/2 0]); %first boom angle
L(2) = Link('revolute', 'd', 0, 'a',6.2, 'alpha',0,'m',312.2,'I',I2,'r',[-6.2/2 0 0]); %second boom angle
L(3) = Link('revolute', 'd', 0, 'a',0, 'alpha', pi/2,'offset',pi/2); %first oscil payload
L(4) = Link('revolute', 'd', 0, 'a',0, 'alpha', pi/2,'offset',-pi/2); %second oscil payload
L(5) = Link('prismatic', 'theta', 0, 'a',0, 'alpha', -pi/2);%length cable
L(6) = Link('revolute', 'd', 0, 'a',0, 'alpha', pi/2,'offset',-pi/2);%1st deg payload
L(7) = Link('revolute', 'd', 0, 'a',0, 'alpha', pi/2,'offset',pi/2);%2nd deg payload
%L(8) = Link('revolute', 'd', 0.3, 'a',0.4, 'alpha', 0,'offset',pi,'m',120,'I',I3,'r',[-0.4 0 -0.3/2]);%3 deg payload
L(8) = Link('revolute', 'd', 0.3, 'a',0, 'alpha',0,'offset',pi,'m',120,'I',I3,'r',[0 0 -0.3/2]);%3 deg payload

L(5).qlim = [0 6];

crane = SerialLink(L,'name','crane');

end