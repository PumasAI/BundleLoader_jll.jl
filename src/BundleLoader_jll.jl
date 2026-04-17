# Use baremodule to shave off a few KB from the serialized `.ji` file
baremodule BundleLoader_jll
using Base
using Base: UUID
import JLLWrappers

JLLWrappers.@generate_main_file_header("BundleLoader")
JLLWrappers.@generate_main_file("BundleLoader", Base.UUID("1ad3e620-8996-5565-b8b0-a1489189912b"))
import Preferences
import LicenseSpring_jll

const _PLM_UUID = Base.UUID("ebe2103e-d13d-42b7-8b52-0fb178cf1234")

function load_bundle(bundle_dir::Base.AbstractString,
        module_name::Base.AbstractString,
        mod::Base.Module)
    product = Preferences.load_preference(_PLM_UUID, "product", "pumas")
    app_name = Preferences.load_preference(_PLM_UUID, "appName", "Pumas")
    app_version = Preferences.load_preference(_PLM_UUID, "appVersion", "2.0")
    license_key = Base.get(Base.ENV, "LICENSESPRING_KEY", "")
    license_arg = Base.isempty(license_key) ? Base.C_NULL : license_key

    rc = ccall(
        (:load_package, libbundle_loader),
        Base.Cint,
        (
            Base.Cstring, Base.Cstring, Base.Ptr{Base.Cvoid},
            Base.Cstring, Base.Cstring, Base.Cstring,
            Base.Cstring, Base.Ptr{Base.Cvoid},
        ),
        bundle_dir,
        module_name,
        Base.pointer_from_objref(mod),
        Base.String(product),
        Base.String(app_name),
        Base.String(app_version),
        license_arg,
        LicenseSpring_jll.libLicenseSpring_handle,
    )
    rc == 0 || Base.error("BundleLoader load_package failed for $module_name (rc=$rc)")
end

end  # module BundleLoader_jll
