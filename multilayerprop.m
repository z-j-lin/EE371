%get user inputs 
N = input("Enter the number of layers");
f = input("Enter the number of layers");
w = 2*pi/f;
%get parameters of each region 
%permitivity of free space
e0= 8.85418782e-12;
%magnetic permeability of free space 
u0 = (4*pi)*10^(-7);
%conductivity 
c = zeros(N);
%permitivity 
e = zeros(N);
%permeability
u = zeros(N);
%distances 
d = zeros(N);
%get the characteristic impedance for each region
propconst = zeros(N);
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
    alpha = w*sqrt(u(v)*e(v)/2)*sqrt(sqrt(1+((c(v)/w*e(v))^2)-1));
    beta = w*sqrt(u(v)*e(v)/2)*sqrt(sqrt(1+((c(v)/w*e(v))^2)+1));
    propconst(v)= alpha + ibeta;
end
%instantiate arrays to store values for impedance and reflection coefficient
z = zeros(N);
zp = zeros(N);
rp = zeros(N-1);
r = zeros(N);
z(N)= n(N);
z(n-1) = z(n);
%calculate impedences 
for v = N-1:-1:1
    r(v) = (z(v)- n(v))/(z(v)+n(v));
    rp(v) = r(v)*exp(2*propconst(v)*-d(v));
    zp(v) = n(v)*((1+rp(v))/(1-rp(v)));
    z(v-1) = zp(v);
end
%calculate the outputs 
for v = 0 :1:N
    
end 
