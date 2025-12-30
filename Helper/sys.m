function system = sys()

N = 7;% 1 Sun + 5 Planets + 1 Moon
system(N) = struct();
G = 6.67e-11;
Msun = 2e30;

% Anon helper rotation function
rot = @(v,th) [v(1), v(2)*cosd(th) - v(3)*sind(th), v(2)*sind(th) + v(3)*cosd(th)];

% Sun
system(1).mass  = Msun;
system(1).pos   = [0 0 0];
system(1).vel   = [0 0 0];
system(1).force = [0 0 0];
system(1).color = [1 0.9 0.1];

% Planets
    % ** Circular velocity: v = sqrt(G*M/r)
    % Positions are initialized then the position is set based on the anonymous rotation
    % helper function

% Planet 1
r1 = 6e10;
v1 = sqrt(G*Msun/r1);
system(2).mass  = 3e23;
system(2).pos   = rot([r1 0 0], 4);
system(2).vel   = rot([0 v1 0], 4);
system(2).force = [0 0 0];
system(2).color = [0.7 0.7 0.7];

% Planet 2
r2 = 1.1e11;
v2 = sqrt(G*Msun/r2);
system(3).mass  = 5e24;
system(3).pos   = rot([r2 0 0], -7);
system(3).vel   = rot([0 v2 0], -7);
system(3).force = [0 0 0];
system(3).color = [0.4 0.7 1.0];

% Planet 3 ** Has a moon
r3 = 1.7e11;
v3 = sqrt(G*Msun/r3);
system(4).mass  = 6e23;
system(4).pos   = rot([r3 0 0], 12);
system(4).vel   = rot([0 v3 0], 12);
system(4).force = [0 0 0];
system(4).color = [1.0 0.4 0.2];

% Planet 4
r4 = 3e11;
v4 = sqrt(G*Msun/r4);
system(5).mass  = 1.5e27;
system(5).pos   = rot([r4 0 0], -3);
system(5).vel   = rot([0 v4 0], -3);
system(5).force = [0 0 0];
system(5).color = [0.2 1.0 0.4];

% Planet 5 ** Has a moon
r5 = 4.5e11;
v5 = sqrt(G*Msun/r5);
system(6).mass  = 8e26;
system(6).pos   = rot([r5 0 0], 18);
system(6).vel   = rot([0 v5 0], 18);
system(6).force = [0 0 0];
system(6).color = [0.6 0.3 0.2];

% MOON
    % The moon orbits its planet using slight offset of position/velocity

% Moon 2 around Planet 5
rm2 = 5e9;
vm2 = sqrt(G*system(6).mass/rm2);
system(7).mass  = 1e22;
system(7).pos   = system(6).pos + rot([rm2 0 0], -18);
system(7).vel   = system(6).vel + rot([0 vm2 0], -10);
system(7).force = [0 0 0];
system(7).color = [0.95 0.95 0.95];

end
