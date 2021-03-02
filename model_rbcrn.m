
function y = model_rbcrn2_v5(u)

q = u(1:14)';
qd = u(15:28)';

dJa(1,:) = u(29:34);
dJa(2,:) = u(35:40);
dJa(3,:) = u(41:46);
dJa(4,:) = u(47:52);
dJa(5,:) = u(53:58);
dJa(6,:) = u(59:64);

dJc(1,:) = u(65:72);
dJc(2,:) = u(73:80);
dJc(3,:) = u(81:88);
dJc(4,:) = u(89:96);
dJc(5,:) = u(97:104);
dJc(6,:) = u(105:112);


inp2 = u(113:120);


Abb = Abb_model();
Br = Abb.inertia(q(1:6));
Cr = Abb.coriolis(q(1:6),qd(1:6));
g_vr = Abb.gravload(q(1:6),[0 0 9.81])';


crane = crane_model();

Bc = crane.inertia(q(7:14));
Cc = crane.coriolis(q(7:14),qd(7:14));
g_vc = crane.gravload(q(7:14),[0 0 9.81])';


Ff = 1*eye(14);
Ff = diag([0 0 0 0 0 0 0 0 10 10 0 10 10 10]);

M = blkdiag(Br,Bc);
g_vec = [g_vr;g_vc];

C = blkdiag(Cr,Cc);

% y = inv(M)*(-C*qd -g_vec - F*qd);

c = C*qd' + Ff*qd';

%%%%%% Ja %%%%%%%%%%%

Ja = Abb.jacob0(q(1:6),'rpy');


%%%%%%%%%%%%%%% Jc %%%

Jval = new_Jacobian(q(7:14));
Jcc = crane.jacob0(q(7:14),'rpy');
Jc = [Jval;Jcc(4:6,:)];

%%%%%%%%%%%%%%%%%


A = [Ja -Jc];

Am = inv(M)*A'*inv(A*inv(M)*A');

Ad = [dJa -dJc];


m = (-c-g_vec+M*(E*Ad+F*zeros(8,14))*F*D*qd');


qdd2 = inv(M)*(eye(14)-A'*Am')*(inp2 - m) -inv(M)*M*Am*Ad*qd';  


y = [qdd2;inp2];