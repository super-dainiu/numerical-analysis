f=@(u,t) [-u(2);u(1)]; n=1000; t=0; u0=[1;1];
uEu=Euler(f,u0,t,n);
uBE=BackEuler(f,u0,t,n);
uRK=RK4(f,u0,t,n);
uT=Trapezoidal(f,u0,t,n);
subplot(2,2,1);
plot(uEu);
xlabel("x'(t)");
ylabel("x(t)");
title("Euler");
subplot(2,2,2);
plot(uBE);
xlabel("x'(t)");
ylabel("x(t)");
title("Backward-Euler");
subplot(2,2,3);
plot(uRK);
xlabel("x'(t)");
ylabel("x(t)");
title("Runge-Kutta 4");
subplot(2,2,4);
plot(uT);
xlabel("x'(t)");
ylabel("x(t)");
title("Trapezoidal");
function u=Euler(f,u0,t,n)
    u=zeros(2,n+1); h=0.1; u(:,1)=u0;
    for i=1:n
        u(:,i+1)=u(:,i)+h*f(u(:,i),t);
        t=t+h;
    end
end
function u=BackEuler(f,u0,t,n)
    u=zeros(2,n+1); h=0.1; u(:,1)=u0;
    for i=1:n
        temp=inf;
        while norm(temp-u(:,i+1))>1e-6
            temp=u(:,i+1);
            u(:,i+1)=u(:,i)+h*f(u(:,i+1),t+h);
        end
        t=t+h;
    end
end
function u=Trapezoidal(f,u0,t,n)
    u=zeros(2,n+1); h=0.1; u(:,1)=u0;
    for i=1:n
        temp=inf;
        while norm(temp-u(:,i+1))>1e-6
            temp=u(:,i+1);
            u(:,i+1)=u(:,i)+h*(1/2*f(u(:,i+1),t+h)+1/2*f(u(:,i),t));
        end
        t=t+h;
    end
end
function u=RK4(f,u0,t,n)
    u=zeros(2,n+1); h=0.1; u(:,1)=u0;
    for i=1:n
        k1=f(u(:,i),t); k2=f(u(:,i)+h/2*k1,t+h/2);
        k3=f(u(:,i)+h/2*k2,t+h/2); k4=f(u(:,i)+h*k3,t+h);
        u(:,i+1)=u(:,i)+h/6*(k1+2*k2+2*k3+k4);
        t=t+h;
    end
end