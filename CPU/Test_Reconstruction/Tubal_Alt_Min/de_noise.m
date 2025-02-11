function [Y,rank]=de_noise(X, Uf)
    %[U, S, V]=t_svd(X);
    [U, S, V] = g_SVD(X, Uf);
    [m,n,k]=size(X);
    sum=zeros(1,min(m,n));
    for i=1:1:min(m,n)
        if i==1
            sum(i)=norm(reshape(S(i,i,:),1,k));
        else
            sum(i)=sum(i-1)+norm(reshape(S(i,i,:),1,k));
        end
    end
    for i=1:1:min(m,n)
        if sum(i)>=0.9*sum(min(m,n))
            break;
        end
    end
    rank=i;
    for l=i:1:min(m,n)
        S(l,l,:)=0;
    end
    %Y=t_product(t_product(U,S),transpos(V));
    Y=g_product(g_product(U, S, Uf), g_transpose(V, Uf), Uf);
end