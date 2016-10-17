close all
clear all
clc
global h1 N h2 M

%p = -1;
%q = -0.0005;
%r = 1;
%h2  = 1/1200;
U_exact = Exact();
h2 = 1/2400;
xi = 0;
xf = 1;
ti = 0;
tf = h2*2400;
%M = 50;

h1 = 1/(10);


for m=1:5
    

    N = fix((xf-xi)/h1);

    x = linspace(xi,xf,N+1);
    %U0 = (0.1*sin(2*pi*x) + 0.01*cos(0.01*4*pi*x) + 0.06*sin(4*pi*x) + 0.02*cos(10*pi*x))';

    for i =1:N+1
        U0(i,1) = x(i)^2*(x(i)-1)^2*(x(i)-0.5)*100;
    end

    tol = 1e-4;
    err = 1000;


    for j=1:M*4^(m-1)

        U1 = zeros(N+1,1);
        U_compare = zeros(N+1,1);
        J = Jacob(U0,U1);
        err = 1000;
        c = 0;
        while(err>tol)
            delt = -J \ F1(U0,U1);
            U1_2 = U1 + delt;
            err = max(abs(U1-U1_2));
            U1 = U1_2;
            c = c+1;
            
        end
        %if (mod(j,3) == 0 || j==1)
        %    U0 = U1;
        %   plot(x,U1);
        %    hold on
        %   pause(0.01)
        %end

    end

        U_compare(1) = U_exact(1);

        for i=1:N
            U_compare(i+1) = U_exact(i*256/2^(m-1)+1);
        end

    erro(m) = max(abs(U_compare-U1));

    h1 = h1/2;
    h2 = h2/4;

end

erro
[U_compare U1]
%U1
%plot(x,U1)