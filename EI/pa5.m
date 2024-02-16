clear all, close all

nx = 50;
ny = 50;
V = zeros(nx,ny);
G = sparse(nx*ny, nx*ny);

Inclusion = 0;

% Setting diagonal elements to 1 and all others to 0 for the sparse matrix
for i = 1:nx
    for j = 1:ny
        n = (i - 1) * ny + j;

      
        if i == 1
            G(n, n) = 1;

        elseif i == (nx)
            G(n, n) = 1;

        elseif j == 1
            G(n, n) = 1;

        elseif j == (ny)
            G(n, n) = 1;

        elseif (i>10 && i< 20) && (j >10 && j< 20)
            nxm = (i-2)*ny + j ;
            nxp = (i)*ny + j;
            nym = (i-1) *ny + (j-1);
            nyp = (i-1) *ny + (j+1);
            
            G(n,nxm) = 1;
            G(n,nxp) = 1;
            G(n, n) = -2;
            G(n,nym) = 1;
            G(n,nyp) = 1;

        else
            nxm = (i-2)*ny + j ;
            nxp = (i)*ny + j;
            nym = (i-1) *ny + (j-1);
            nyp = (i-1) *ny + (j+1);
            
            G(n,nxm) = 1;
            G(n,nxp) = 1;
            G(n, n) = -4;
            G(n,nym) = 1;
            G(n,nyp) = 1;
        end
    end
end
        

figure ('name','Matrix');
spy(G)




nmodes = 20;
[E,D] = eigs(G,nmodes,'SM');

figure('name','Eigenvalues')
plot(diag(D), '*');

np = ceil(sqrt(nmodes))
figure('name', 'Modes')

for k = 1:nmodes
    M = E(:,k);
    for i = 1:nx
        for j = 1:ny
            n= i + (j-1)*nx;
            V(i,j) = M(n);
        end
        subplot(np,np,k), surf(V, 'linestyle','none');
        %subplot(np,np,k), surf(V, 'EdgeColor', 'none');
        title(['EV = ' num2str(D(k,k))])
    end
end 

