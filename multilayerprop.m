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
%thickness of each region
d = zeros(1,N);
%propagation constant for each region
propconst = zeros(1,N);
%incident electric field in each region 
E = zeros(1,N);
%magnitude of the reflected electric field in each region
Er = zeros(1,N);
%characteristic impedance for each region
n = zeros(1,N);
n0 = 120*pi;
%instantiate arrays to store values for impedance and reflection coefficient
z = zeros(1,N);
%impedance at opposite from orgin of each region
zp = zeros(1,N);
%reflective coefficients at -d from origin of each region 
rp = zeros(1,N);
rp(N) = 0;
%reflective coefficient at origin of each region
r = zeros(1,N);
dielectric = inputdlg('Enter space-separated values for dielectric constant in each region in order',...
             'Sample', [1 50]);
e = str2num(dielectric{1}); 
permiability = inputdlg('Enter space-separated values for magnetic permeability in each region in order',...
             'Sample', [1 50]);
u = str2num(permiability{1});
conductivity = inputdlg('Enter space-separated values for conductivity in each region in order',...
             'Sample', [1 50]);
c = str2num(conductivity{1});
%get the magnitude of the incident efield 
f = input("Enter the frequency of the incident electric field: ");
E(1,1) = input("Enter the magnitude of the incident electric field: ");

w = 2*pi*f;
%get parameters of each region 
%for loop to get the input data
%power density 
p = zeros(1,N); 
for v = 1:N 
    itr=string(v);
    if v > 1 && v < N 
        d(1,v) = input("Enter the thickness of region: "+ itr+": ");    
    end
    
    %calculate characteristic impedance for each region
    n(1,v) = sqrt(u(1,v)/e(1,v));
    if c(1,v) == 0
        beta = w*sqrt(u(1,v)*e(1,v));
        propconst(1,v)= beta*1i;
    else 
        alpha = (w*sqrt(u(1,v)*e(1,v))/sqrt(2))*sqrt(sqrt(1+((c(1,v)/w*e(1,v))^2))-1);
        beta = (w*sqrt(u(1,v)*e(1,v))/sqrt(2))*sqrt(sqrt(1+((c(1,v)/w*e(1,v))^2))+1);
        propconst(1,v)= alpha + beta*1i;
    end
end
z(1,N)= n(1,N);
z(1,N-1) = z(1,N);
%calculate impedences 
for v = N-1:-1:1
    r(1,v) = (z(1,v)-n(1,v))/(z(1,v)+n(1,v));
    if v >1
        rp(1,v) = r(1,v)*exp(-2*propconst(1,v)*d(1,v));
        zp(1,v) = n(1,v)*((1+rp(1,v))/(1-rp(1,v)));
        z(1,v-1) = zp(1,v);
    end
end

%calculate the outputs 
Er(1,1) = r(1,1)*E(1,1);
p(1,1) = (0.5*(abs(E(1,1))^2)*(1 - abs(r(1,1))^2))/n(1,1);
for v = 2:+1:N
   if v<N
       E(1,v)=(E(1,v-1)*(1+r(1,v-1)))/(exp(propconst(1,v)*d(1,v))*(1+rp(1,v)));
       Er(1,v)= r(1,v)*E(1,v);
   end
   if v == N
       E(1,v)=(E(1,v-1)*(1+r(1,v-1)));
   end
   p(1,v) = (0.5*(abs(E(1,v))^2)*(1 - abs(r(1,v))^2))/n(1,v);
end 
