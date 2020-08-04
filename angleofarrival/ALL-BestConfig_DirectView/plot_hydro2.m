function plot_hydro2(H)

figure(1);
plot3( H(1,1), H(1,2), H(1,3), '.', 'MarkerSize',19 );
hold on;
plot3( H(2,1), H(2,2), H(2,3), 's' );
plot3( H(3,1), H(3,2), H(3,3), 'o' );
plot3( H(4,1), H(4,2), H(4,3), 'd' );

for i=1:3
    for j=i+1:4
        plot3( [H(i,1), H(j,1) ], [H(i,2), H(j,2)], [H(i,3), H(j,3)],'linewidth',5 );
    end
end
% 
% plot3( [H1(1), H2(1) ], [H1(2), H2(2)], [H1(3), H2(3)] );
% plot3( [H1(1), H3(1) ], [H1(2), H3(2)], [H1(3), H3(3)] );
% plot3( [H1(1), H4(1) ], [H1(2), H4(2)], [H1(3), H4(3)] );
% plot3( [H2(1), H3(1) ], [H2(2), H3(2)], [H2(3), H3(3)] );
% plot3( [H2(1), H4(1) ], [H2(2), H4(2)], [H2(3), H4(3)] );
% plot3( [H3(1), H4(1) ], [H3(2), H4(2)], [H3(3), H4(3)] );

grid on;

axis( [ -1 1 -1 1 -1 1] );
xlabel('X - North');
ylabel('Y - East');
zlabel('Z - Down');
% hold off;