using Test
import BundleLoader_jll

@testset "Library Loaded" begin
    @test !isempty(BundleLoader_jll.libbundle_loader)
end
