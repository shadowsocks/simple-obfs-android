cmake_minimum_required(VERSION 3.22.1)

project(obfs-local)

set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wall -O2 -fno-strict-aliasing")

# Include directories
include_directories(
    ${CMAKE_CURRENT_SOURCE_DIR}/../jni/include
    ${CMAKE_CURRENT_SOURCE_DIR}/../jni/libancillary
    ${CMAKE_CURRENT_SOURCE_DIR}/../jni/simple-obfs/libcork/include
    ${CMAKE_CURRENT_SOURCE_DIR}/../jni/libev
    ${CMAKE_CURRENT_SOURCE_DIR}/../jni/include/simple-obfs
)

# libcork
set(CORK_CLI_SRC
    ${CMAKE_CURRENT_SOURCE_DIR}/../jni/simple-obfs/libcork/src/libcork/cli/commands.c
)

set(CORK_CORE_SRC
    ${CMAKE_CURRENT_SOURCE_DIR}/../jni/simple-obfs/libcork/src/libcork/core/allocator.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../jni/simple-obfs/libcork/src/libcork/core/error.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../jni/simple-obfs/libcork/src/libcork/core/gc.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../jni/simple-obfs/libcork/src/libcork/core/hash.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../jni/simple-obfs/libcork/src/libcork/core/ip-address.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../jni/simple-obfs/libcork/src/libcork/core/mempool.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../jni/simple-obfs/libcork/src/libcork/core/timestamp.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../jni/simple-obfs/libcork/src/libcork/core/u128.c
)

set(CORK_DS_SRC
    ${CMAKE_CURRENT_SOURCE_DIR}/../jni/simple-obfs/libcork/src/libcork/ds/array.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../jni/simple-obfs/libcork/src/libcork/ds/bitset.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../jni/simple-obfs/libcork/src/libcork/ds/buffer.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../jni/simple-obfs/libcork/src/libcork/ds/dllist.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../jni/simple-obfs/libcork/src/libcork/ds/file-stream.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../jni/simple-obfs/libcork/src/libcork/ds/hash-table.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../jni/simple-obfs/libcork/src/libcork/ds/managed-buffer.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../jni/simple-obfs/libcork/src/libcork/ds/ring-buffer.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../jni/simple-obfs/libcork/src/libcork/ds/slice.c
)

set(CORK_POSIX_SRC
    ${CMAKE_CURRENT_SOURCE_DIR}/../jni/simple-obfs/libcork/src/libcork/posix/directory-walker.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../jni/simple-obfs/libcork/src/libcork/posix/env.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../jni/simple-obfs/libcork/src/libcork/posix/exec.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../jni/simple-obfs/libcork/src/libcork/posix/files.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../jni/simple-obfs/libcork/src/libcork/posix/process.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../jni/simple-obfs/libcork/src/libcork/posix/subprocess.c
)

set(CORK_PTHREADS_SRC
    ${CMAKE_CURRENT_SOURCE_DIR}/../jni/simple-obfs/libcork/src/libcork/pthreads/thread.c
)

add_library(cork STATIC
    ${CORK_CLI_SRC}
    ${CORK_CORE_SRC}
    ${CORK_DS_SRC}
    ${CORK_POSIX_SRC}
    ${CORK_PTHREADS_SRC}
)

target_compile_definitions(cork PRIVATE CORK_API=CORK_LOCAL)

# libev
add_library(ev STATIC
    ${CMAKE_CURRENT_SOURCE_DIR}/../jni/libev/ev.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../jni/libev/event.c
)

target_compile_definitions(ev PRIVATE
    NDEBUG
    HAVE_CONFIG_H
    EV_USE_KQUEUE=0
    EV_USE_EPOLL=1
)

# libancillary
add_library(ancillary STATIC
    ${CMAKE_CURRENT_SOURCE_DIR}/../jni/libancillary/fd_recv.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../jni/libancillary/fd_send.c
)

# obfs-local (built as shared library - executable)
set(OBFS_SOURCES
    ${CMAKE_CURRENT_SOURCE_DIR}/../jni/simple-obfs/src/utils.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../jni/simple-obfs/src/jconf.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../jni/simple-obfs/src/json.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../jni/simple-obfs/src/encrypt.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../jni/simple-obfs/src/netutils.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../jni/simple-obfs/src/local.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../jni/simple-obfs/src/obfs_http.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../jni/simple-obfs/src/obfs_tls.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../jni/simple-obfs/src/options.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../jni/simple-obfs/src/base64.c
    ${CMAKE_CURRENT_SOURCE_DIR}/../jni/simple-obfs/src/android.c
)

add_library(obfs-local SHARED ${OBFS_SOURCES})

target_compile_definitions(obfs-local PRIVATE
    MODULE_LOCAL
    ANDROID
    HAVE_CONFIG_H
    CONNECT_IN_PROGRESS=EINPROGRESS
)

target_link_libraries(obfs-local
    ev
    cork
    ancillary
    log
)

# Set the linker flags to make it executable
set_target_properties(obfs-local PROPERTIES
    LINK_FLAGS "-pie -fPIE"
)
