function h = eig_grid(r,z,ls,clr)
%% Draw a poral grid for eigenvalues

% r = const
ang = 0:0.01:2*pi;
n   = length(r);
for i=1:n
    x(i,:) = r(i)*cos(ang);
    y(i,:) = r(i)*sin(ang);
end
h1 = plot(x',y','linestyle',ls,'color',clr);

% z = const
R = max(r);
ang = acos(-z)';
xp = R*cos(ang);
yp = R*sin(ang);
zr = zeros(size(ang));
for i=1:length(ang)
    h2(i) = plot([0  xp(i)],[0  yp(i)], 'linestyle',ls,'color',clr);
    h3(i) = plot([0  xp(i)],[0 -yp(i)], 'linestyle',ls,'color',clr);
    h4(i) = plot([0 -xp(i)],[0  yp(i)], 'linestyle',ls,'color',clr);
    h5(i) = plot([0 -xp(i)],[0 -yp(i)], 'linestyle',ls,'color',clr);
end
h = [h1; h2'; h3'; h4'; h5'];

set(h,'HandleVisibility','off','HitTest','off','SelectionHighlight','off');
end
