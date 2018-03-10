SET( UROS ${NOVA_ROOT}/libs/uROSnode )

SET( UROSNODESRC 
    ${UROS}/src/urosBase.c
    ${UROS}/src/urosConn.c
    ${UROS}/src/urosNode.c
    ${UROS}/src/urosRpcCall.c
    ${UROS}/src/urosRpcParser.c
    ${UROS}/src/urosRpcSlave.c
    ${UROS}/src/urosRpcStreamer.c
    ${UROS}/src/urosTcpRos.c
    ${UROS}/src/urosThreading.c
)

SET( UROSNODELWIPSRC
    ${UROS}/src/lld/lwip/uros_lld_conn.c
)

SET( UROSNODECHIBIOSSRC 
    ${UROS}/src/lld/chibios/uros_lld_base.c
    ${UROS}/src/lld/chibios/uros_lld_threading.c
)


SET( UROSNODE_SOURCES ${UROSNODESRC} ${UROSNODELWIPSRC} ${UROSNODECHIBIOSSRC} )

SET( UROSNODE_INCLUDE_DIRS
    ${UROS}/include
)

LIST( REMOVE_DUPLICATES UROSNODE_SOURCES )
LIST( REMOVE_DUPLICATES UROSNODE_INCLUDE_DIRS )

INCLUDE( FindPackageHandleStandardArgs )
FIND_PACKAGE_HANDLE_STANDARD_ARGS( UROS DEFAULT_MSG UROSNODE_SOURCES UROSNODE_INCLUDE_DIRS )
