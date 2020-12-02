%initiate some varaibles to store values
%permitivity of free space
e0= 8.85418782e-12;
%magnetic permeability of free space 
u0 = (4*pi)*10^(-7);
N=0;
%get user input for number of region 
while N <= 2
    N = input("Enter the number of layers (minimum is 3): ");
end
%conductivity of each region
c = zeros(N);
%permitivity of each region
e = zeros(N);
%permeability of each region
u = zeros(N);
%thickness of each region
d = zeros(N);
%propagation constant for each region
propconst = zeros(N);
%incident electric field in each region 
E = zeros(N);
%magnitude of the reflected electric field in each region
Er = zeros(N);
%characteristic impedance for each region
n = zeros(N);
n0 = 120*pi;
%instantiate arrays to store values for impedance and reflection coefficient
z = zeros(N);
%impedance at opposite from orgin of each region
zp = zeros(N);
%reflective coefficients at -d from origin of each region 
rp = zeros(N);
rp(N) = 0;
%reflective coefficient at origin of each region
r = zeros(N);
%get the frequency
f = input("Enter the frequency in Hz");
%get the magnitude of the incident efield 
E(1) = input("Enter the magnitude of the incident electric field");
w = 2*pi*f;
%get parameters of each region 
%for loop to get the input data
for v = 1:N 
    itr=string(v);
    c(v) = input("Enter the conductivity of region "+ int2str(v)+": ");
    e(v) = input("Enter the permitivity of region "+ int2str(v)+": ");
    u(v) = input("Enter the permiability of region "+ int2str(v)+ ": ");
    if v > 1 && v < N 
        d(v) = input("Enter the thickness of region: " + int2str(v));    
    end
    
    %calculate characteristic impedance for each region
    n(v) = n0/sqrt(e(v));
    alpha = w*sqrt(u(v)*e(v)/2)*sqrt(sqrt(1+((c(v)/w*e(v))^2)-1));
    beta = w*sqrt(u(v)*e(v)/2)*sqrt(sqrt(1+((c(v)/w*e(v))^2)+1));
    propconst(v)= alpha + beta*1i;
end
z(N)= n(N);
z(N-1) = z(N);
%calculate impedences 
for v = N-1:-1:1
    r(v) = (z(v)- n(v))/(z(v)+n(v));
    rp(v) = r(v)*exp(2*propconst(v)*-d(v));
    zp(v) = n(v)*((1+rp(v))/(1-rp(v)));
    z(v-1) = zp(v);
end
%calculate the outputs 
for v = 2:1:N
   E(v)=(E(v-1)*(1+r(v-1)))/(exp(propconst(v)*d(v)*(1+rp(v))));
   Er(v)= r(v)*E(v);
end 
