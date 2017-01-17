# Copyright (C) 2009 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
#
LOCAL_PATH := $(call my-dir)
ROOT_PATH := $(LOCAL_PATH)

BUILD_SHARED_EXECUTABLE := $(LOCAL_PATH)/build-shared-executable.mk

########################################################
## libsodium
########################################################

include $(CLEAR_VARS)

SODIUM_SOURCE := \
	crypto_aead/chacha20poly1305/sodium/aead_chacha20poly1305.c \
	crypto_auth/crypto_auth.c \
	crypto_auth/hmacsha256/auth_hmacsha256_api.c \
	crypto_auth/hmacsha256/cp/hmac_hmacsha256.c \
	crypto_auth/hmacsha256/cp/verify_hmacsha256.c \
	crypto_auth/hmacsha512/auth_hmacsha512_api.c \
	crypto_auth/hmacsha512/cp/hmac_hmacsha512.c \
	crypto_auth/hmacsha512/cp/verify_hmacsha512.c \
	crypto_auth/hmacsha512256/auth_hmacsha512256_api.c \
	crypto_auth/hmacsha512256/cp/hmac_hmacsha512256.c \
	crypto_auth/hmacsha512256/cp/verify_hmacsha512256.c \
	crypto_box/crypto_box.c \
	crypto_box/crypto_box_easy.c \
	crypto_box/crypto_box_seal.c \
	crypto_box/curve25519xsalsa20poly1305/box_curve25519xsalsa20poly1305_api.c \
	crypto_box/curve25519xsalsa20poly1305/ref/after_curve25519xsalsa20poly1305.c \
	crypto_box/curve25519xsalsa20poly1305/ref/before_curve25519xsalsa20poly1305.c \
	crypto_box/curve25519xsalsa20poly1305/ref/box_curve25519xsalsa20poly1305.c \
	crypto_box/curve25519xsalsa20poly1305/ref/keypair_curve25519xsalsa20poly1305.c \
	crypto_core/hsalsa20/ref2/core_hsalsa20.c \
	crypto_core/hsalsa20/core_hsalsa20_api.c \
	crypto_core/salsa20/ref/core_salsa20.c \
	crypto_core/salsa20/core_salsa20_api.c \
	crypto_generichash/crypto_generichash.c \
	crypto_generichash/blake2/generichash_blake2_api.c \
	crypto_generichash/blake2/ref/blake2-impl.h \
	crypto_generichash/blake2/ref/blake2.h \
	crypto_generichash/blake2/ref/blake2b-compress-ref.c \
	crypto_generichash/blake2/ref/blake2b-load-sse2.h \
	crypto_generichash/blake2/ref/blake2b-load-sse41.h \
	crypto_generichash/blake2/ref/blake2b-ref.c \
	crypto_generichash/blake2/ref/blake2b-round.h \
	crypto_generichash/blake2/ref/generichash_blake2b.c \
	crypto_hash/crypto_hash.c \
	crypto_hash/sha256/hash_sha256_api.c \
	crypto_hash/sha256/cp/hash_sha256.c \
	crypto_hash/sha512/hash_sha512_api.c \
	crypto_hash/sha512/cp/hash_sha512.c \
	crypto_onetimeauth/crypto_onetimeauth.c \
	crypto_onetimeauth/poly1305/onetimeauth_poly1305.c \
	crypto_onetimeauth/poly1305/onetimeauth_poly1305.h \
	crypto_onetimeauth/poly1305/donna/poly1305_donna.h \
	crypto_onetimeauth/poly1305/donna/poly1305_donna32.h \
	crypto_onetimeauth/poly1305/donna/poly1305_donna64.h \
	crypto_onetimeauth/poly1305/donna/poly1305_donna.c \
	crypto_pwhash/scryptsalsa208sha256/crypto_scrypt-common.c \
	crypto_pwhash/scryptsalsa208sha256/crypto_scrypt.h \
	crypto_pwhash/scryptsalsa208sha256/scrypt_platform.c \
	crypto_pwhash/scryptsalsa208sha256/pbkdf2-sha256.c \
	crypto_pwhash/scryptsalsa208sha256/pbkdf2-sha256.h \
	crypto_pwhash/scryptsalsa208sha256/pwhash_scryptsalsa208sha256.c \
	crypto_pwhash/scryptsalsa208sha256/sysendian.h \
	crypto_pwhash/scryptsalsa208sha256/nosse/pwhash_scryptsalsa208sha256_nosse.c \
	crypto_scalarmult/crypto_scalarmult.c \
	crypto_scalarmult/curve25519/scalarmult_curve25519.c \
	crypto_scalarmult/curve25519/scalarmult_curve25519.h \
	crypto_secretbox/crypto_secretbox.c \
	crypto_secretbox/crypto_secretbox_easy.c \
	crypto_secretbox/xsalsa20poly1305/secretbox_xsalsa20poly1305_api.c \
	crypto_secretbox/xsalsa20poly1305/ref/box_xsalsa20poly1305.c \
	crypto_shorthash/crypto_shorthash.c \
	crypto_shorthash/siphash24/shorthash_siphash24_api.c \
	crypto_shorthash/siphash24/ref/shorthash_siphash24.c \
	crypto_sign/crypto_sign.c \
	crypto_sign/ed25519/ref10/base.h \
	crypto_sign/ed25519/ref10/base2.h \
	crypto_sign/ed25519/sign_ed25519_api.c \
	crypto_sign/ed25519/ref10/d.h \
	crypto_sign/ed25519/ref10/d2.h \
	crypto_sign/ed25519/ref10/fe.h \
	crypto_sign/ed25519/ref10/fe_0.c \
	crypto_sign/ed25519/ref10/fe_1.c \
	crypto_sign/ed25519/ref10/fe_add.c \
	crypto_sign/ed25519/ref10/fe_cmov.c \
	crypto_sign/ed25519/ref10/fe_copy.c \
	crypto_sign/ed25519/ref10/fe_frombytes.c \
	crypto_sign/ed25519/ref10/fe_invert.c \
	crypto_sign/ed25519/ref10/fe_isnegative.c \
	crypto_sign/ed25519/ref10/fe_isnonzero.c \
	crypto_sign/ed25519/ref10/fe_mul.c \
	crypto_sign/ed25519/ref10/fe_neg.c \
	crypto_sign/ed25519/ref10/fe_pow22523.c \
	crypto_sign/ed25519/ref10/fe_sq.c \
	crypto_sign/ed25519/ref10/fe_sq2.c \
	crypto_sign/ed25519/ref10/fe_sub.c \
	crypto_sign/ed25519/ref10/fe_tobytes.c \
	crypto_sign/ed25519/ref10/ge.h \
	crypto_sign/ed25519/ref10/ge_add.c \
	crypto_sign/ed25519/ref10/ge_add.h \
	crypto_sign/ed25519/ref10/ge_double_scalarmult.c \
	crypto_sign/ed25519/ref10/ge_frombytes.c \
	crypto_sign/ed25519/ref10/ge_madd.c \
	crypto_sign/ed25519/ref10/ge_madd.h \
	crypto_sign/ed25519/ref10/ge_msub.c \
	crypto_sign/ed25519/ref10/ge_msub.h \
	crypto_sign/ed25519/ref10/ge_p1p1_to_p2.c \
	crypto_sign/ed25519/ref10/ge_p1p1_to_p3.c \
	crypto_sign/ed25519/ref10/ge_p2_0.c \
	crypto_sign/ed25519/ref10/ge_p2_dbl.c \
	crypto_sign/ed25519/ref10/ge_p2_dbl.h \
	crypto_sign/ed25519/ref10/ge_p3_0.c \
	crypto_sign/ed25519/ref10/ge_p3_dbl.c \
	crypto_sign/ed25519/ref10/ge_p3_to_cached.c \
	crypto_sign/ed25519/ref10/ge_p3_to_p2.c \
	crypto_sign/ed25519/ref10/ge_p3_tobytes.c \
	crypto_sign/ed25519/ref10/ge_precomp_0.c \
	crypto_sign/ed25519/ref10/ge_scalarmult_base.c \
	crypto_sign/ed25519/ref10/ge_sub.c \
	crypto_sign/ed25519/ref10/ge_sub.h \
	crypto_sign/ed25519/ref10/ge_tobytes.c \
	crypto_sign/ed25519/ref10/keypair.c \
	crypto_sign/ed25519/ref10/open.c \
	crypto_sign/ed25519/ref10/pow22523.h \
	crypto_sign/ed25519/ref10/pow225521.h \
	crypto_sign/ed25519/ref10/sc.h \
	crypto_sign/ed25519/ref10/sc_muladd.c \
	crypto_sign/ed25519/ref10/sc_reduce.c \
	crypto_sign/ed25519/ref10/sign.c \
	crypto_sign/ed25519/ref10/sqrtm1.h \
	crypto_stream/crypto_stream.c \
	crypto_stream/chacha20/stream_chacha20.c \
	crypto_stream/chacha20/stream_chacha20.h \
	crypto_stream/chacha20/ref/stream_chacha20_ref.h \
	crypto_stream/chacha20/ref/stream_chacha20_ref.c \
	crypto_stream/salsa20/stream_salsa20_api.c \
	crypto_stream/xsalsa20/stream_xsalsa20_api.c \
	crypto_stream/xsalsa20/ref/stream_xsalsa20.c \
	crypto_stream/xsalsa20/ref/xor_xsalsa20.c \
	crypto_verify/16/verify_16_api.c \
	crypto_verify/16/ref/verify_16.c \
	crypto_verify/32/verify_32_api.c \
	crypto_verify/32/ref/verify_32.c \
	crypto_verify/64/verify_64_api.c \
	crypto_verify/64/ref/verify_64.c \
	randombytes/randombytes.c \
	sodium/core.c \
	sodium/runtime.c \
	sodium/utils.c \
	sodium/version.c

SODIUM_SOURCE += \
	crypto_scalarmult/curve25519/ref10/curve25519_ref10.c \
	crypto_scalarmult/curve25519/ref10/curve25519_ref10.h \
	crypto_scalarmult/curve25519/ref10/fe.h \
	crypto_scalarmult/curve25519/ref10/fe_0_curve25519_ref10.c \
	crypto_scalarmult/curve25519/ref10/fe_1_curve25519_ref10.c \
	crypto_scalarmult/curve25519/ref10/fe_add_curve25519_ref10.c \
	crypto_scalarmult/curve25519/ref10/fe_copy_curve25519_ref10.c \
	crypto_scalarmult/curve25519/ref10/fe_cswap_curve25519_ref10.c \
	crypto_scalarmult/curve25519/ref10/fe_frombytes_curve25519_ref10.c \
	crypto_scalarmult/curve25519/ref10/fe_invert_curve25519_ref10.c \
	crypto_scalarmult/curve25519/ref10/fe_mul_curve25519_ref10.c \
	crypto_scalarmult/curve25519/ref10/fe_mul121666_curve25519_ref10.c \
	crypto_scalarmult/curve25519/ref10/fe_sq_curve25519_ref10.c \
	crypto_scalarmult/curve25519/ref10/fe_sub_curve25519_ref10.c \
	crypto_scalarmult/curve25519/ref10/fe_tobytes_curve25519_ref10.c \
	crypto_scalarmult/curve25519/ref10/montgomery.h \
	crypto_scalarmult/curve25519/ref10/pow225521.h

SODIUM_SOURCE += \
	crypto_stream/salsa20/ref/stream_salsa20_ref.c \
	crypto_stream/salsa20/ref/xor_salsa20_ref.c

SODIUM_SOURCE += \
	randombytes/sysrandom/randombytes_sysrandom.c

LOCAL_MODULE := sodium
LOCAL_CFLAGS += -O2 -I$(LOCAL_PATH)/simple-obfs/libsodium/src/libsodium/include \
				-I$(LOCAL_PATH)/include \
				-I$(LOCAL_PATH)/include/sodium \
				-I$(LOCAL_PATH)/simple-obfs/libsodium/src/libsodium/include/sodium \
				-DPACKAGE_NAME=\"libsodium\" -DPACKAGE_TARNAME=\"libsodium\" \
				-DPACKAGE_VERSION=\"1.0.7\" -DPACKAGE_STRING=\"libsodium\ 1.0.7\" \
				-DPACKAGE_BUGREPORT=\"https://github.com/jedisct1/libsodium/issues\" \
				-DPACKAGE_URL=\"https://github.com/jedisct1/libsodium\" \
				-DPACKAGE=\"libsodium\" -DVERSION=\"1.0.7\" -DSTDC_HEADERS=1 \
				-DHAVE_SYS_TYPES_H=1 -DHAVE_SYS_STAT_H=1 -DHAVE_STDLIB_H=1 \
				-DHAVE_STRING_H=1 -DHAVE_MEMORY_H=1 -DHAVE_STRINGS_H=1 \
				-DHAVE_INTTYPES_H=1 -DHAVE_STDINT_H=1 -DHAVE_UNISTD_H=1 \
				-D__EXTENSIONS__=1 -D_ALL_SOURCE=1 -D_GNU_SOURCE=1 \
				-D_POSIX_PTHREAD_SEMANTICS=1 -D_TANDEM_SOURCE=1 \
				-DHAVE_DLFCN_H=1 -DLT_OBJDIR=\".libs/\" \
				-DHAVE_SYS_MMAN_H=1 -DNATIVE_LITTLE_ENDIAN=1 \
				-DHAVE_WEAK_SYMBOLS=1 -DHAVE_ARC4RANDOM=1 -DHAVE_ARC4RANDOM_BUF=1 \
				-DHAVE_MLOCK=1 -DHAVE_MPROTECT=1 -DHAVE_POSIX_MEMALIGN=1

LOCAL_SRC_FILES := $(addprefix simple-obfs/libsodium/src/libsodium/,$(SODIUM_SOURCE))

include $(BUILD_STATIC_LIBRARY)

########################################################
## libcork
########################################################

include $(CLEAR_VARS)

cli_src := cli/commands.c
core_src := core/allocator.c core/error.c core/gc.c \
			core/hash.c core/ip-address.c core/mempool.c \
			core/timestamp.c core/u128.c
ds_src := ds/array.c ds/bitset.c ds/buffer.c ds/dllist.c \
		  ds/file-stream.c ds/hash-table.c ds/managed-buffer.c \
		  ds/ring-buffer.c ds/slice.c
posix_src := posix/directory-walker.c posix/env.c posix/exec.c \
			 posix/files.c posix/process.c posix/subprocess.c
pthreads_src := pthreads/thread.c

CORK_SOURCE := $(cli_src) $(core_src) $(ds_src) $(posix_src) $(pthreads_src)

LOCAL_MODULE := libcork
LOCAL_CFLAGS += -O2 -I$(LOCAL_PATH)/simple-obfs/libcork/include \
				-DCORK_API=CORK_LOCAL

LOCAL_SRC_FILES := $(addprefix simple-obfs/libcork/,$(CORK_SOURCE))

include $(BUILD_STATIC_LIBRARY)

########################################################
## libudns
########################################################

include $(CLEAR_VARS)

UDNS_SOURCES := udns_dn.c udns_dntosp.c udns_parse.c udns_resolver.c udns_init.c \
	udns_misc.c udns_XtoX.c \
	udns_rr_a.c udns_rr_ptr.c udns_rr_mx.c udns_rr_txt.c udns_bl.c \
	udns_rr_srv.c udns_rr_naptr.c udns_codes.c udns_jran.c

LOCAL_MODULE := libudns
LOCAL_CFLAGS += -O2 -I$(LOCAL_PATH)/simple-obfs/libudns \
				-DHAVE_DECL_INET_NTOP

LOCAL_SRC_FILES := $(addprefix simple-obfs/libudns/,$(UDNS_SOURCES))

include $(BUILD_STATIC_LIBRARY)

########################################################
## libev
########################################################

include $(CLEAR_VARS)

LOCAL_MODULE := libev
LOCAL_CFLAGS += -O2 -DNDEBUG -DHAVE_CONFIG_H \
				-I$(LOCAL_PATH)/include/libev
LOCAL_SRC_FILES := \
	simple-obfs/libev/ev.c \
	simple-obfs/libev/event.c

include $(BUILD_STATIC_LIBRARY)

########################################################
## libancillary
########################################################

include $(CLEAR_VARS)

ANCILLARY_SOURCE := fd_recv.c fd_send.c

LOCAL_MODULE := libancillary
LOCAL_CFLAGS += -O2 -I$(LOCAL_PATH)/libancillary

LOCAL_SRC_FILES := $(addprefix libancillary/, $(ANCILLARY_SOURCE))

include $(BUILD_STATIC_LIBRARY)

########################################################
## simple-obfs local
########################################################

include $(CLEAR_VARS)

OBFS_SOURCES := utils.c jconf.c json.c encrypt.c netutils.c local.c obfs_http.c obfs_tls.c options.c base64.c android.c

LOCAL_MODULE    := obfs-local
LOCAL_SRC_FILES := $(addprefix simple-obfs/src/, $(OBFS_SOURCES))
LOCAL_CFLAGS    := -Wall -O2 -fno-strict-aliasing -DMODULE_LOCAL \
                    -DANDROID -DHAVE_CONFIG_H \
                    -DCONNECT_IN_PROGRESS=EINPROGRESS \
                    -I$(LOCAL_PATH)/include \
					-I$(LOCAL_PATH)/libancillary \
                    -I$(LOCAL_PATH)/simple-obfs/libudns \
					-I$(LOCAL_PATH)/simple-obfs/libcork/include \
					-I$(LOCAL_PATH)/simple-obfs/libsodium/src/libsodium/include \
					-I$(LOCAL_PATH)/simple-obfs/libsodium/src/libsodium/include/sodium \
					-I$(LOCAL_PATH)/simple-obfs/libev \
					-I$(LOCAL_PATH)/include/simple-obfs

LOCAL_STATIC_LIBRARIES := libev libsodium libcork libudns libancillary

LOCAL_LDLIBS := -llog

include $(BUILD_SHARED_EXECUTABLE)


