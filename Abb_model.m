
function Abb = Abb_model()

d1 = 184/1000;
a2 = 448/1000;
a3 = 451/1000;
a4 = 95/1000;

m1 = 6.2; %kg
I1 = diag([77483.507953495573 49580.778279004364 56056.523120868093])/(1000*1000);

m2 = 7; %kg
I2 = diag([0.1686 0.1462 0.0414]);

m3 = 6.5; %kg
I3 = diag([20555.381182020741 79019.6911293859 72864.613303519742])/(1000*1000);

m4 = 1.7; %kg
I4 = diag([3566.3858633130858 6371.8735058738948 6900.3823336347241])/(1000*1000);

m5 = 0.5;
I5 = diag([382.36300791966312 876.289426584027 738.20852541923364])/(1000*1000);

m6 = 0.4;
I6 = diag([56.675820752026205 53.373353267096142 3.3735984291553973])/(1000*1000);

L_abb(1) = Link('revolute', 'd', d1, 'a',0, 'alpha', pi/2,'m',m1,'I',I1,'r',[0 -d1/2 0]); %first angle
L_abb(2) = Link('revolute', 'd', 0, 'a',a2, 'alpha', 0,'offset',0,'m',m2,'I',I2,'r',[-a2/2 0 0]); %second angle
L_abb(3) = Link('revolute', 'd', 0, 'a',0, 'alpha', pi/2,'offset',pi/2,'m',m3,'I',I3,'r',[0 0 +290/2000]); %third angle
L_abb(4) = Link('revolute', 'd', a3, 'a',0, 'alpha', -pi/2,'offset',0,'m',m4,'I',I4,'r',[0 164/2000 0]); %third angle
L_abb(5) = Link('revolute', 'd', 0, 'a',0, 'alpha', pi/2,'offset',0,'m',m5,'I',I5,'r',[0 0 82/2000]); %third angle
L_abb(6) = Link('revolute', 'd', a4, 'a',0, 'alpha', 0,'offset',0,'m',m6,'I',I6,'r',[0 0 -15/2000]); %third angle


Abb = SerialLink(L_abb,'name','abb');

end