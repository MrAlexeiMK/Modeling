function ForceLines
global XY Q X Y;

X = [-5 5];
Y = [0 0];
Q = [3 -3];
N = size(Q,2);
R = 0.05;
R1 = [-20 20 -20 20];

figure('Color', [1 1 1]);
plot(0,0);
axis(R1);
grid;
hold on;

XY = 1;
i = 1;
pColor = 'm';
X0 = X(i);
XN = X(2);
dX = (XN-X0)/100;
for a=[-180, -162, -144, -126, -108, -90, -72, -54, -36, -18, 0, 18, 36, 54, 72, 90, 108, 126, 144, 162]
    fi=a*pi/180;
    X0 = X(i)+R*cos(fi);
    Y0 = Y(i)+R*sin(fi);
    [x, y] = ode45(@dipole, [X0:dX:XN], Y0);
    h1=plot(x,y,pColor);
end

XY = 1;
i=2;
pColor='g';
X0=X(i);
XN = 20;
dX=(XN-X0)/100;

for a=[-40 -30 0 30 40]
    fi=a*pi/180;
    X0 = X(i)+R*cos(fi);
    Y0 = Y(i)+R*sin(fi);
    [x, y] = ode45(@dipole, [X0:dX:XN], Y0);
    h2=plot(x,y,pColor);
end

XY = 1;
i=1;
pColor='g--';
X0=X(i);
XN=-20;
dX=(XN-X0)/100;

for a=[-40 -30 0 30 40]
    fi=a*pi/180;
    X0 = X(i)+R*cos(fi);
    Y0 = Y(i)+R*sin(fi);
    [x, y] = ode45(@dipole, [X0:dX:XN], Y0);
    h3=plot(x,y,pColor);
end

for i=1:N
    h=plot(X(i),Y(i));
    pColor='b';
    if Q(i) > 0
        pColor='r';
    end
    set(h, 'LineStyle', 'none', 'marker', 'o', 'MarkerSize', 8, 'Color', pColor, 'MarkerFaceColor', pColor);
end
ylabel('\ity','fontsize',14);
xlabel('\itx','fontsize',14);
end

function z=dipole(x,y)
global XY Q X Y;
q1 = Q(1);
q2 = Q(2);
a=(X(2)-X(1))/2;

if XY==1
   r13=((x+a).^2+y.^2).^(3/2);
   r23=((x-a).^2+y.^2).^(3/2);
   z1=q1*y./r13+q2*y./r23;
   z2=q1*(x+a)./r13+q2*(x-a)./r23;
end

if XY==2
   r13=((y-a).^2+x.^2).^(3/2);
   r23=((y+a).^2+x.^2).^(3/2);
   z1=q1*x./r13+q2*x./r23;
   z2=q1*(y-a)./r13+q2*(y+a)./r23;
end
z=z1./z2;
end