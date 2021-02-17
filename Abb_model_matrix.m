
function y = Abb_model_matrix(u)


q = u(1:6)';
qd = u(7:12)';
tao = u(13:18); 
he = u(19:24);

Abb = Abb_model();

B = Abb.inertia(q);
C = Abb.coriolis(q,qd);
J = Abb.jacob0(q);
g_v = Abb.gravload(q,[0 0 9.81])';


%invB = inv(B);

F = 0.1*eye(6);

y = B\(-C*qd' -g_v - F*qd'+ tao - J'*he);