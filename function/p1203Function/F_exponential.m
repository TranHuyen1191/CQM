function [o] = F_exponential(a, b, c, d, x)
    o = b + (a - b) * exp(-(x - c) * log(0.5) / (-(d - c)));
end