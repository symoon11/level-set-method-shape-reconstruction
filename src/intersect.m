function y = intersect(a, b, c, d)
    u = zeros(2,1);
    A = zeros(2,2);
    A(1,1) = a(2) - b(2);   A(1,2) = b(1) - a(1);
    A(2,1) = c(2) - d(2);   A(2,2) = d(1) - c(1);
    u(1) = b(1)*a(2) - b(2)*a(1);
    u(2) = d(1)*c(2) - d(2)*c(1);
    y = A\u;
