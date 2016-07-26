MESSAGE( STATUS "CHIBIOS_ROOT: ${CHIBIOS_ROOT}" )
SET(LWIP ${CHIBIOS_ROOT}/ext/lwip)

IF( NOT EXISTS ${LWIP})
  MESSAGE( FATAL_ERROR "${LWIP} does not exists. Have you extracted the archive there?" )
ENDIF()

SET(LWBINDSRC 
	${CHIBIOS_ROOT}/os/various/lwip_bindings/lwipthread.c
	${CHIBIOS_ROOT}/os/various/lwip_bindings/arch/sys_arch.c
)

SET(LWNETIFSRC
	${LWIP}/src/netif/etharp.c
)

SET(LWCORESRC 
        ${LWIP}/src/core/dhcp.c
        ${LWIP}/src/core/dns.c
        ${LWIP}/src/core/init.c
        ${LWIP}/src/core/mem.c
        ${LWIP}/src/core/memp.c
        ${LWIP}/src/core/netif.c
        ${LWIP}/src/core/pbuf.c
        ${LWIP}/src/core/raw.c
        ${LWIP}/src/core/stats.c
        ${LWIP}/src/core/sys.c
        ${LWIP}/src/core/tcp.c
        ${LWIP}/src/core/tcp_in.c
        ${LWIP}/src/core/tcp_out.c
        ${LWIP}/src/core/udp.c
)

SET(LWIPV4SRC
        ${LWIP}/src/core/ipv4/autoip.c
        ${LWIP}/src/core/ipv4/icmp.c
        ${LWIP}/src/core/ipv4/igmp.c
        ${LWIP}/src/core/ipv4/inet.c
        ${LWIP}/src/core/ipv4/inet_chksum.c
        ${LWIP}/src/core/ipv4/ip.c
        ${LWIP}/src/core/ipv4/ip_addr.c
        ${LWIP}/src/core/ipv4/ip_frag.c
        ${LWIP}/src/core/def.c
        ${LWIP}/src/core/timers.c
)

SET(LWAPISRC
        ${LWIP}/src/api/api_lib.c
        ${LWIP}/src/api/api_msg.c
        ${LWIP}/src/api/err.c
        ${LWIP}/src/api/netbuf.c
        ${LWIP}/src/api/netdb.c
        ${LWIP}/src/api/netifapi.c
        ${LWIP}/src/api/sockets.c
        ${LWIP}/src/api/tcpip.c
)       

SET(LWIP_SOURCES ${LWBINDSRC} ${LWNETIFSRC} ${LWCORESRC} ${LWIPV4SRC} ${LWAPISRC})

SET( LWIP_INCLUDE_DIRS
        ${CHIBIOS_ROOT}/os/various/lwip_bindings
        ${LWIP}/src/include
        ${LWIP}/src/include/ipv4
)

LIST( REMOVE_DUPLICATES LWIP_SOURCES )
LIST( REMOVE_DUPLICATES LWIP_INCLUDE_DIRS )

INCLUDE( FindPackageHandleStandardArgs )
FIND_PACKAGE_HANDLE_STANDARD_ARGS( LWIP DEFAULT_MSG LWIP_SOURCES LWIP_INCLUDE_DIRS )
