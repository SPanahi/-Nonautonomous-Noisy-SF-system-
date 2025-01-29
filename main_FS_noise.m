clear;
close all;
clc;


%% Parameters
f_size = 36;
l_size = 18;

k=0.01;
eta=0.8;
r=0.0002;
e=1e-6;
phi_min=eta*(1-eta)/(1+eta)+e;
phi_max=1-eta-e;

Ts=(phi_max-phi_min)/r %

t_start = 0;
dt=0.005;
t_end = 1000;

phi0=phi_min+1e-4;
x0=[8;4;phi0];


%% Nominal
sigma_n=zeros(3,1); % no noise
[tn,xn] = ode_Noise(@(t,x) SF_3d(t,x,phi_min,phi_max,eta,k,r),@(x)eq_PP_MDN(x),t_start:dt:t_end,x0,sigma_n);
un=xn(:,1);
vn=xn(:,2);
phin=xn(:,3);

% Plot
figure('Renderer', 'painters', 'Position', [196,65,1102,890])
subplot(311)
plot(tn,un, 'LineWidth', 3.5);
set(gca,'LineWidth',1,'FontSize',l_size,'FontWeight','normal');
xlabel('time','Interpreter','latex','FontSize',f_size)
ylabel('$u_n$','Interpreter','latex','FontSize',f_size)
title('Nominal system','Interpreter','latex','FontSize',f_size-10);
subplot(312)
plot(tn,vn, 'LineWidth', 3.5);
set(gca,'LineWidth',1,'FontSize',l_size,'FontWeight','normal');
xlabel('time','Interpreter','latex','FontSize',f_size)
ylabel('$v_n$','Interpreter','latex','FontSize',f_size)
subplot(313)
plot(tn,phin, 'LineWidth', 3.5);
set(gca,'LineWidth',1,'FontSize',l_size,'FontWeight','normal');
xlabel('time','Interpreter','latex','FontSize',f_size)
ylabel('$\phi_n$','Interpreter','latex','FontSize',f_size)

%% Noisy

co=1;% noise strength
sigma=[co*1e-1;co*1e-1;0]; 
[t,x] = ode_Noise(@(t,x) SF_3d(t,x,phi_min,phi_max,eta,k,r),@(x)eq_PP_MDN(x),t_start:dt:t_end,x0,sigma);

u=x(:,1);
v=x(:,2);
phi=x(:,3);

% Plot
figure('Renderer', 'painters', 'Position', [1305,64,1102,890])
subplot(311)
plot(t,u, 'LineWidth', 3.5);
set(gca,'LineWidth',1,'FontSize',l_size,'FontWeight','normal');
xlabel('time','Interpreter','latex','FontSize',f_size)
ylabel('$u$','Interpreter','latex','FontSize',f_size)
title('Noisy system','Interpreter','latex','FontSize',f_size-10);
subplot(312)
plot(t,v, 'LineWidth', 3.5);
set(gca,'LineWidth',1,'FontSize',l_size,'FontWeight','normal');
xlabel('time','Interpreter','latex','FontSize',f_size)
ylabel('$v$','Interpreter','latex','FontSize',f_size)
subplot(313)
plot(t,phi, 'LineWidth', 3.5);
set(gca,'LineWidth',1,'FontSize',l_size,'FontWeight','normal');
xlabel('time','Interpreter','latex','FontSize',f_size)
ylabel('$\phi$','Interpreter','latex','FontSize',f_size)
