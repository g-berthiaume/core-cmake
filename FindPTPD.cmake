SET(PTPD ${NOVA_ROOT}/libs/ptpd-2.0.0)
MESSAGE( STATUS "PTPD: ${PTPD}" )

IF( NOT EXISTS ${PTPD})
  MESSAGE( FATAL_ERROR "${PTPD} does not exists." )
ENDIF()

SET(PTPD_SRC
    ${PTPD}/src/arith.c
    ${PTPD}/src/bmc.c
    ${PTPD}/src/protocol.c
    ${PTPD}/src/ptpd.c
    ${PTPD}/src/dep/msg.c
    ${PTPD}/src/dep/net.c
    ${PTPD}/src/dep/servo.c
    ${PTPD}/src/dep/startup.c
    ${PTPD}/src/dep/sys_time.c
    ${PTPD}/src/dep/timer.c
)

SET(PTPD_SOURCES ${PTPD_SRC})

SET( PTPD_INCLUDE_DIRS
        ${PTPD}/src
)


LIST( REMOVE_DUPLICATES PTPD_SOURCES )
LIST( REMOVE_DUPLICATES PTPD_INCLUDE_DIRS )

INCLUDE( FindPackageHandleStandardArgs )
FIND_PACKAGE_HANDLE_STANDARD_ARGS( PTPD DEFAULT_MSG PTPD_SOURCES PTPD_INCLUDE_DIRS )
