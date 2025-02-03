rm -rf .repo/local_manifests

# repo init rom
repo init -u https://github.com/LineageOS/android.git -b lineage-21.0 --git-lfs --depth=1
echo ==================
echo Repo init success
echo ==================

# Local manifests
git clone https://github.com/thz22/local_manifest_odessa.git -b main .repo/local_manifests
echo ============================
echo Local manifest clone success
echo ============================

# Sync
/opt/crave/resync.sh
echo =============
echo Sync success
echo =============

# Export
export BUILD_USERNAME=Thiago
export BUILD_HOSTNAME=crave
export BUILD_BROKEN_MISSING_REQUIRED_MODULES=ture 
echo ======= Export Done ======

# KSU
git clone https://github.com/thz22/KernelSU-Next.git -b next kernel/motorola/sm6150/KernelSU-Next

# chmod
chmod a+x device/motorola/odessa/applyPatches.sh

# TestO3
rm -rf build/soong

# Clone O3
git clone https://github.com/thz22/android_build_soong.git -b lineage-21.0 build/soong

# Set up build environment
. build/envsetup.sh

# Clone PrivateKeys
git clone https://github.com/thz22/keysz.git -b main vendor/lineage-priv/keys

echo ====== Envsetup Done =======

# breakfast                                                                  
breakfast odessa

# Clean
make installclean

# Build
m bacon -j$(nproc --all)
