function love.math.lerp(a, b, t)
    return a * (1-t) + b * t
end

function math.clamp(low, n, high) return math.min(math.max(n, low), high) end

function areCirclesIntersecting(aX, aY, aRadius, bX, bY, bRadius)
    return (aX - bX)^2 + (aY - bY)^2 <= (aRadius + bRadius)^2
end