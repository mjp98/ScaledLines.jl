using ScaledLines
using ApproxFun
using RiemannHilbert
using SingularIntegralEquations
using WienerHopf
using Test

@testset "ScaledLines.jl" begin
    @testset "ScaledSegmentLine" begin
        @testset "line" begin
            d = Line(0.0, π / 2)

            F2 = Fun(z -> exp(z^2), ScaledLine(d, 2))
            F1 = Fun(z -> exp(z^2), ScaledLine(d, 1))
            F = Fun(z -> exp(z^2), d)

            z = 0.4im

            @test F2(z) ≈ exp(z^2)
            @test F1(z) ≈ exp(z^2)
            @test coefficients(F1) ≈ coefficients(F)
        end

        @testset "stieltjes" begin
            d = Line(0.0, π / 2)
            F = Fun(z -> exp(z^2), d)
            F0 = Fun(z -> exp(z^2), ScaledLine(d, 0.5))
            F1 = Fun(z -> exp(z^2), ScaledLine(d, 1))
            F2 = Fun(z -> exp(z^2), ScaledLine(d, 2))

            @testset "cauchy" begin
                z = 1 + 0.4im

                ref = cauchy(F, z)

                @test cauchy(F0, z) ≈ ref
                @test cauchy(F1, z) ≈ ref
                @test cauchy(F2, z) ≈ ref

            end

        end
    end

    @testset "SqrtLine" begin
        @testset "line" begin
            d = SqrtLine{0.5}(0.0)

            F2 = Fun(z -> exp(z^2), ScaledLine(d, 2))
            F1 = Fun(z -> exp(z^2), ScaledLine(d, 1))
            F = Fun(z -> exp(z^2), d)

            z = 0.4im

            @test F2(z) ≈ exp(z^2)
            @test F1(z) ≈ exp(z^2)
            @test coefficients(F1) ≈ coefficients(F)
        end

        @testset "stieltjes" begin
            d = SqrtLine{0.5}(0.0)
            F = Fun(z -> exp(z^2), Line(0.0, π / 2))
            F0 = Fun(z -> exp(z^2), ScaledLine(d, 0.5))
            F1 = Fun(z -> exp(z^2), ScaledLine(d, 1))
            F2 = Fun(z -> exp(z^2), ScaledLine(d, 2))

            @testset "cauchy" begin
                z = 1 + 0.4im

                ref = cauchy(F, z)

                @test cauchy(F0, z) ≈ ref
                @test cauchy(F1, z) ≈ ref
                @test cauchy(F2, z) ≈ ref

            end

        end
    end



end
