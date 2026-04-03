# Use baremodule to shave off a few KB from the serialized `.ji` file
baremodule BundleLoader_jll
using Base
using Base: UUID
import JLLWrappers

JLLWrappers.@generate_main_file_header("BundleLoader")
JLLWrappers.@generate_main_file("BundleLoader", Base.UUID("1ad3e620-8996-5565-b8b0-a1489189912b"))
end  # module BundleLoader_jll
