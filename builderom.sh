rm -rf .repo/local_manifests

# repo init rom
repo init -u https://github.com/crdroidandroid/android.git -b 15.0 --git-lfs --depth 1
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

# Gapps
git clone https://thjr5965@bitbucket.org/pops11s/vendor_gms_vic.git vendor/gms --depth 1

# chmod
chmod a+x device/motorola/odessa/applyPatches.sh

# Set up build environment
. build/envsetup.sh

# Clone PrivateKeys
git clone https://github.com/thz22/keysz.git -b main vendor/lineage-priv/keys

# resguard
rm -rf hardware/motorola

# Dolby
git clone https://github.com/crdroidandroid/android_hardware_motorola.git -b 15.0 hardware/motorola

echo ====== Envsetup Done =======

# breakfast                                                                  
breakfast odessa

# Clean
make installclean

# Build
m bacon -j$(nproc --all)
