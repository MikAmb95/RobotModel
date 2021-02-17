
function y = crane_model_matrix(u)


q = u(1:8)';
qd = u(9:16)';

q_d = u(17:19);

err_a = q_d(1)-q(1);
err_b = q_d(2)-q(2);
err_l = q_d(3)-q(5);

crane = crane_model();
B = crane.inertia(q);
C = crane.coriolis(q,qd);
J = crane.jacob0(q);
g_v = crane.gravload(q,[0 0 +9.81])';

F = diag([0 0 1 1*0 0 1 1 1]);

for i=1:8
    if abs(g_v(i)) > 10e-10
        g_vv(i) = g_v(i);
    else
        g_vv(i) = 0;
    end
end

for i=1:8
    for j = 1:8
    if abs(B(i,j)) > 10e-10
        Bb(i,j) = B(i,j);
    else
        Bb(i,j) = 0;
    end
    end
end

for i=1:8
    for j = 1:8
    if abs(C(i,j)) > 10e-10
        Cc(i,j) = C(i,j);
    else
        Cc(i,j) = 0;
    end
    end
end

kp1 = 300*0+350*0+10000; kp2 = 80*0+300; kp3 = 10; 
kd1 = 200*0+250*0+5000; kd2 = 80*0+200; kd3 = 100; 


u1 = kp1*err_a - kd1*qd(1);
u2 = kp2*err_b - kd2*qd(2);
u3 = kp3*err_l - kd3*qd(5);



tao = [u1+g_v(1) u2+g_v(2) 0 0 u3+g_v(5) 0 0 0]';


y = inv(Bb)*(-Cc*qd'- g_vv' - F*qd' + tao);

