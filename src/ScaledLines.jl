module ScaledLines

import Base: +, -, *, /, union, intersect, ==, convert, isempty, setdiff, in
import DomainSets: similardomain
import ApproxFun: space, domain, setdomain, tocanonical, fromcanonical, fromcanonicalD, reverseorientation, isambiguous, arclength, leftendpoint, rightendpoint, complexlength, angle, Segment, Ray, SegmentDomain, PeriodicDomain, Line, PeriodicLine, Interval, Space,  Fun
import SingularIntegralEquations: hilbert, stieltjes, stieltjesmoment!

export ScaledLine
export ScaledSegmentLine

struct ScaledSegmentLine{R,S<:Real,T<:Number} <: SegmentDomain{T}
    line::R
    scale::S
end

function ScaledLine(line::R, scale::S) where {R<:SegmentDomain, S<:Real}
    return ScaledSegmentLine{R,S,eltype(line)}(line, scale)
end
function ScaledLine(line::R, scale) where {R<:PeriodicLine}
    return T(line.center,convert(Float64,scale))
end


scale(S::Space{<:ScaledSegmentLine}) = scale(domain(S))
scale(S::ScaledSegmentLine) = S.scale
descale(S::Space{<:ScaledSegmentLine}) = setdomain(S, descale(domain(S)))
descale(S::ScaledSegmentLine) = S.line

angle(d::ScaledSegmentLine) = angle(descale(d))

reverseorientation(d) = ScaledLine(reverseorientation(descale(d)), scale(d))
isambiguous(d::ScaledSegmentLine) = isambiguous(descale(d)) || isnan(scale(d))

tocanonical(d::ScaledSegmentLine, x) = tocanonical(descale(d), x / scale(d))
tocanonicalD(d::ScaledSegmentLine, x) = tocanonicalD(descale(d), x / scale(d)) / scale(d)
fromcanonical(d::ScaledSegmentLine, x) = scale(d) * fromcanonical(descale(d), x)
fromcanonicalD(d::ScaledSegmentLine, x) = scale(d) * fromcanonicalD(descale(d), x)

invfromcanonicalD(d::ScaledSegmentLine, x) = invfromcanonicalD(descale(d), x) / scale(d)

isempty(d::ScaledSegmentLine) = false

# algebra
arclength(d::ScaledSegmentLine) = Inf
leftendpoint(d::ScaledSegmentLine) = -Inf
rightendpoint(d::ScaledSegmentLine) = Inf
complexlength(d::ScaledSegmentLine) = Inf

# algebra
for OP in (:+, :-, :*)
    @eval begin
        $OP(c::Number, d::ScaledSegmentLine) = ScaledLine($OP(c, descale(d)), scale(d))
        $OP(d::ScaledSegmentLine, c::Number) = ScaledLine($OP(descale(d), c), scale(d))
    end
end

in(x, a::ScaledSegmentLine) = in(x, descale(a))

issubset(a, b::ScaledSegmentLine) = issubset(a, descale(b))
intersect(a, b::ScaledSegmentLine) = intersect(a, descale(b))
union(a, b::ScaledSegmentLine) = union(a, descale(b))

intersect(b::ScaledSegmentLine, a::Union{Interval,Segment,Ray}) = intersect(a, b)
union(b::ScaledSegmentLine, a::Union{Interval,Segment,Ray}) = union(a, b)

setdiff(b::ScaledSegmentLine, a::Segment) = setdiff(descale(b), a)

function stieltjes(S::Space{<:ScaledSegmentLine}, f::AbstractVector, z::Number)
    stieltjes(descale(S), f, z / scale(S))
end

function cauchy(S::Space{<:ScaledSegmentLine}, f::AbstractVector, z::Number)
    cauchy(descale(S), f, z / scale(S))
end

hilbert(S::Space{<:ScaledSegmentLine}, f::AbstractVector, z::Number) = hilbert(descale(S), f, z / scale(S))

function stieltjesmoment!(ret::AbstractVector, S::Space{<:ScaledSegmentLine}, z::Number)
    return stieltjesmoment!(ret, descale(S), z / scale(S))
end

end
