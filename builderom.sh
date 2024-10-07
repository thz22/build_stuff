rm -rf .repo/local_manifests


# repo init rom
repo init -u https://github.com/alphadroid-project/manifest -b alpha-14 --git-lfs
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

# Set up build environment
source build/envsetup.sh

# Clone PrivateKeys
git clone https://github.com/diasthiago11/keysz.git -b main vendor/lineage-priv/keys

echo ====== Envsetup Done =======

# Lunch                                                                     
lunch lineage_odessa-userdebug

# Build
make bacon
