%% storage overhead
x=[200:1:500]
y1=x.^2
y2=2.*x.^1.5

b=2
c=4
y3=(x./b).^2.*b+x.*b
y4=(x./c).^2.*c+x.*c
%y3=(3.*x+4).*(log(0.75.*x+1)./log(4))
plot(x,y1)
hold on
plot(x,y2)
plot(x,y3)
plot(x,y4)

grid on
xlabel('Total number of nodes')
ylabel('Storage overhead (MB)')
legend('PBFT','ULS-PBFT','Pyramid Scheme1','Pyramid Scheme2')

x=100
s=[0:50]
y1=(x.^2).*s
y2=(2.*x.^1.5).*s
b=2
c=4
y3=((x./b).^2.*b+x.*b).*s
y4=((x./c).^2.*c+x.*c).*s
%y3=(3.*x+4).*(log(0.75.*x+1)./log(4))
plot(s,y1)
hold on
plot(s,y2)
plot(s,y3)
plot(s,y4)
plot(s,y5)
grid on
xlabel('Total number of blocks')
ylabel('Storage overhead (MB)')
legend('PBFT','ULS-PBFT','Pyramid Scheme1','Pyramid Scheme2')

%% communication overhead
N=[5:2:100]
y1=N.^2
y2=N.^1.5
y3=0.25.*N.^2
y4=1.9.*N.^1.333

plot(N,y1)
hold on
plot(N,y2)
plot(N,y3)
plot(N,y4)

grid on
xlabel('Total number of nodes')
ylabel('Commnication overhead')
legend('PBFT','ULS-PBFT','SG-PBFT','Two-layer PBFT')
%% security
y=[4:20]
x=(y.^2+2.*y)./(y+1)
N=x+x.*y

N=200
Pf=0:0.02:1%单个节点失败的概率
Ps1=(1-Pf).^N%单层共识成功的概率 
for i=1:N./3
  Ps1=Ps1+(nchoosek(N,i)).*((1-Pf).^(N-i) ).*(Pf.^i)
end
plot(Pf,Ps1)
hold on

x=20
Pf=0:0.01:1%单个节点失败的概率
P1=(1-Pf).^x%二层单个子组共识成功的概率 
for i=1:x./3
    P1=P1+(nchoosek(x,i)).*((1-Pf).^(x-i) ).*(Pf.^i)

y=20
P2=P1.^y%二层有2/3及以上的子组共识成功的概率

for j=1:y./3
    P2=P2+(nchoosek(y,j)).*((1-P1).^j ).*(P1.^(y-j))
    P3=(1-Pf).^(y-j)%二层有2/3及以上的子组共识成功的情况下首层共识成功的概率
    for k=1:y./3
        P3=P3+(nchoosek((y-j),k)).*((1-Pf).^(y-j-k) ).*(Pf.^k)
    end
end
end
P4=P2.*P3%首层共识成功的概率

plot(Pf,P4)

xlabel('Probability of a node failure')
ylabel('Probability of consensus success')
legend('PBFT','ULS-PBFT')
title('N=50')
grid on
%% comprehensive

x=4
y=89
%[x,y]=meshgrid(x,y);
N=x+x.*y

%存储
S1=N.^2
S2=N.*x+x.*(y.^2)

I1=log(S1./S2)
%通信
C1=N.^2
C2=x.^2+x.*(y.^2)

I2=log(C1./C2)
%安全
P1=N./3
P2=x./3+(y./3).*(x./3)

I3=log(P2./P1)

I=0.05.*I1+0.05.*I2+0.9.*I3

mesh(x,y,I)
%contourf(x,y,I,'ShowText','on')
xlabel('the value of x');
ylabel('the value of y');
zlabel('the value of I_G');


y1=[2.1734 2.301 3.0431 -0.9933;1.9573  2.0336 3.4389 -0.8979;1.9565 2.1013 2.3508 -1.0445]
y2=[2.4738 2.6274 3.2177 -1.0341;2.3614  2.4673 3.7901 -0.9734; 2.0403 2.1971 2.3286 -1.0712]
y3=[3.0738 2.2414 3.3439 -0.9555; 2.8042 2.301 3.0431 -0.9933;2.0695 2.0233 2.2451 -1.046;]
y4=[3.5767 2.3929 3.8942 -0.9555;2.9756 2.6274 3.2177 -1.0341; 2.7622 2.5659 2.9847 -1.046]
y5=[-0.4545 1.5741 3.0536 -0.7621;-0.5309 2.0474 3.4965 -0.8979; -0.5807 2.2414 3.3439 -0.9555]
y6=[-0.4496 1.5917 3.1333 -0.7621;-0.5095 2.1204 3.8526 -0.8979; -0.5456 2.3929 3.8942 -0.9555]
y7=[1.5295 2.1951 3.3537 -0.9445; 1.4358 2.3010 3.0431 -0.9933; 1.5036 2.0336 3.4389 -0.8979]
y8=[1.7402 2.5007 3.7534 -0.9808; 1.6631 2.6272 3.4312 -1.0186; 1.6046 2.0136 3.7242 -0.8755]
bar(y8)
set(gca,'XTickLabel',{'x=45,y=15','x=30,y=23','x=90,y=7'});
xlabel('the number of nodes')
ylabel('the value of gains')

title('N=720')
legend('Total gain','Storage gain','Communication gain','Security gain')
grid on
%%
A=0.9.*I1+0.05.*I2-0.05.*I3
B=0.05.*I1+0.9.*I2-0.05.*I3
C=0.05.*2.3929+0.05.*3.8942-0.9.*0.9555

D=0.33.*I1+0.033.*I2-0.033.*I3
plot(x,A)
hold on 
plot(x,B)
plot(x,C)
plot(x,D)
xlabel('the value of x')
ylabel('the value of I')
legend('S','C','P','Z')

grid on

I=0.333.*I1+0.333.*I2-0.333.*I3
mesh(x,y,I)
xlabel('the value of x');
ylabel('the value of y');
zlabel('the value of I_G');
