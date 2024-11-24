rm -rf .repo/local_manifests

# repo init rom
repo init -u https://github.com/crdroidandroid/android.git -b 14.0 --git-lfs --depth 1
echo ==================
echo Repo init success
echo ==================

# Local manifests
git clone https://github.com/diasthiago11/local_manifest_odessa.git -b los21 .repo/local_manifests
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

# chmod
chmod a+x device/motorola/odessa/applyPatches.sh

# Set up build environment
. build/envsetup.sh

# Clone PrivateKeys
git clone https://github.com/diasthiago11/keysz.git -b main vendor/lineage-priv/keys

echo ====== Envsetup Done =======

# Lunch                                                                     
lunch lineage_odessa-userdebug

# Clean
make installclean

# Build
m bacon -j$(nproc --all)
