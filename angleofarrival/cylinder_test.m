
%[x,y,z]=cylinder(0.2,10000)
%plot3(x,y,z)

a = linspace(0, 2*pi);                              % Assign Angle Vector
r = 2;                                              % Radius
ctr = [2 3];                                        % Centre
x = ctr(1) + r.*cos(a);                             % Circle ‘x’ Vector
y = ctr(2) + r.*sin(a);                             % Circle ‘y’ Vector
dxda = -r.*sin(a);                                  % Derivative
dyda =  r.*cos(a);                                  % Derivative
dydx = dyda./dxda;                                  % Slope Of Tangent
N = 21;                                             % Choose Point On Circle (As Index)
point = [x(N) y(N)];                                % Define Point
intcpt = point(2) - dydx(N).*point(1);              % Calculate Intercept
xvct = point(1)-1:point(1)+1;                       % ‘x’ Vecor For Tangent
tngt = dydx(N).*xvct + intcpt;                      % Calculate Tantent
figure(1)
plot(x, y)                                          % Plot Circle
hold on
plot(point(1), point(2), 'gp')                      % Plot Point
plot(xvct, tngt)                                    % Plot Tangent At Point
hold off
axis equal
grid