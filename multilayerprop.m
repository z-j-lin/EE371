%get user inputs 
N = input("Enter the number of layers");
%get parameters of each region 
%conductivity 
c = zeros(N);
%permitivity 
e = zeros(N);
%permeability
u = zeros(N);
%distances 
d = zeros(N);
%get the characteristic impedance for each region
n = zeros(N);
n0 = 120*pi;
%for loop to get the input data
for v = 1:N 
    itr=string(v);
    c(v) = input("Enter the conductivity of region"+ v);
    e(v) = input("Enter the permitivity of region"+ v);
    u(v) = input("Enter the permiability of region"+ v);
    d(v) = input("Enter the thickness of region" + v);
    %calculate characteristic impedance for each region
    n(v) = n0/sqrt(e(v));
%instantiate arrays to store values for impedance and reflection coefficient
z = zeros(N);
zp = zeros(N);
rp = zeros(N-1);
r = zeros(N);
z(N)= n(N)
z(n-1) = z(n);
for v = N-1:-1:1
    r(v) = (z(v)- n(v))/(z(v)+n(v));
    rp(v) = r(v)*e^2(g*-d(v));
    zp(v) = n(v)*((1+rp(v)/1-rp(v))
    z(v-1) = zp(v);

