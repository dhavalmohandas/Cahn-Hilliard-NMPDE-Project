function U_exact = Exact()

global p q r h1 N h2 M

p = -1;
q = -0.0005;
r = 1;
%h2  = 1/1200;
h2 = 1/2400;
xi = 0;
xf = 1;
ti = 0;
tf = h2*20000;
M = 5;
%M = 2000;

%for i=1:5
    
h1 = 1/(10*2^8);
N = fix((xf-xi)/h1);

x = linspace(xi,xf,N+1);
%U0 = (0.1*sin(2*pi*x) + 0.01*cos(0.01*4*pi*x) + 0.06*sin(4*pi*x) + 0.02*cos(10*pi*x))';

for i =1:N+1
    U0(i,1) = x(i)^2*(x(i)-1)^2*(x(i)-0.5)*100;
end

tol = 1e-4;
err = 1000;
%F = zeros(N+1,1);

for j=1:M
    
    U_exact = zeros(N+1,1);
    
    J = Jacob(U0,U_exact);
    err = 1000;
    c = 0;
    while(err>tol)
        delt = -J \ F1(U0,U_exact);
        U1_2 = U_exact + delt;
        err = max(abs(U_exact-U1_2));
        U_exact = U1_2;
        c = c+1;
        [j c]
    end
           
end

end



%plot(x,U_exact)