SET(EASTL ${NOVA_ROOT}/libs/EASTL)
MESSAGE( STATUS "EASTL: ${EASTL}" )

IF( NOT EXISTS ${EASTL})
  MESSAGE( FATAL_ERROR "${EASTL} does not exists." )
ENDIF()

SET(EASTL_SRC
    ${EASTL}/source/allocator_eastl.cpp  
    ${EASTL}/source/assert.cpp  
    ${EASTL}/source/fixed_pool.cpp  
    ${EASTL}/source/hashtable.cpp  
    ${EASTL}/source/intrusive_list.cpp  
    ${EASTL}/source/numeric_limits.cpp  
    ${EASTL}/source/red_black_tree.cpp  
    ${EASTL}/source/string.cpp  
    ${EASTL}/source/thread_support.cpp
)

SET(EASTL_SOURCES ${EASTL_SRC} )

SET( EASTL_INCLUDE_DIRS
        ${EASTL}/include
        ${EASTL}/test/packages/EABase/include/Common/
)


LIST( REMOVE_DUPLICATES EASTL_SOURCES )
LIST( REMOVE_DUPLICATES EASTL_INCLUDE_DIRS )

INCLUDE( FindPackageHandleStandardArgs )
FIND_PACKAGE_HANDLE_STANDARD_ARGS( EASTL DEFAULT_MSG EASTL_SOURCES EASTL_INCLUDE_DIRS )
