function system = computations(system, dt, G)

N = length(system);

%Reset all forces to zero (necessary before adding together all the diff
%contributions to movement)
for i = 1:N
    system(i).force = [0 0 0];
end

%Compute gravitational forces between every pair of bodies
%Use 2x for-loop to compute calculations between every planet i's
%interactions with every other planet (j).
for i = 1:N
    for j = 1:N
        if i == j, continue; end
        
        r = system(j).pos - system(i).pos;
        
        %calc between the two bodies
        d = norm(r);
        if d < 1e-6, continue; end
        
        %Newton's law of u-grav --> |F| = G * mi*mj/d^2
        F = G * system(i).mass * system(j).mass / d^2;
        
        %Full vector force
        system(i).force = system(i).force + F * (r / d);
    end
end

%Euler steps (for every planet "i" in the system)
for i = 1:N
    %Newton's second law
    a = system(i).force / system(i).mass;
    
    %Update velocity one step based on dt size --> v(t+dt) = v(t) + a * dt
    system(i).vel = system(i).vel + a * dt;
    
    %Update position one step based on dt size --> x(t+dt) = x(t) + v(t+dt) * dt
    system(i).pos = system(i).pos + system(i).vel * dt;
end