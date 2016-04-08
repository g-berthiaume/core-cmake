IF( NOT NOVA_MW_ROOT )
  IF( NOT NOVA_ROOT )
    SET( NOVA_MW_ROOT /opt/nova/middleware )
  ELSE()
    SET( NOVA_MW_ROOT ${NOVA_ROOT}/core-mw )
  ENDIF()

  MESSAGE( STATUS "No NOVA_MW_ROOT specified, using default: ${NOVA_MW_ROOT}" )
ENDIF()

SET( NOVA_MW_SOURCES
  ${NOVA_MW_ROOT}/src/impl/ArrayQueue_.cpp
  ${NOVA_MW_ROOT}/src/impl/SimplePool_.cpp
  ${NOVA_MW_ROOT}/src/impl/StaticList_.cpp
  ${NOVA_MW_ROOT}/src/impl/StaticQueue_.cpp
  ${NOVA_MW_ROOT}/src/BasePublisher.cpp
  ${NOVA_MW_ROOT}/src/BaseSubscriber.cpp
  ${NOVA_MW_ROOT}/src/BaseSubscriberQueue.cpp
  ${NOVA_MW_ROOT}/src/BootMsg.cpp
  ${NOVA_MW_ROOT}/src/Checksummer.cpp
  ${NOVA_MW_ROOT}/src/LocalPublisher.cpp
  ${NOVA_MW_ROOT}/src/LocalSubscriber.cpp
  ${NOVA_MW_ROOT}/src/MessagePtrQueue.cpp
  ${NOVA_MW_ROOT}/src/Message.cpp
  ${NOVA_MW_ROOT}/src/Middleware.cpp
  ${NOVA_MW_ROOT}/src/Node.cpp
  ${NOVA_MW_ROOT}/src/RemotePublisher.cpp
  ${NOVA_MW_ROOT}/src/RemoteSubscriber.cpp
  ${NOVA_MW_ROOT}/src/Time.cpp
  ${NOVA_MW_ROOT}/src/TimestampedMsgPtrQueue.cpp
  ${NOVA_MW_ROOT}/src/Topic.cpp
  ${NOVA_MW_ROOT}/src/Transport.cpp
  ${NOVA_MW_ROOT}/src/Utils.cpp
  
  ${NOVA_MW_ROOT}/src/CoreNode.cpp
  ${NOVA_MW_ROOT}/src/CoreNodeManager.cpp
  ${NOVA_MW_ROOT}/src/CoreConfiguration.cpp
  ${NOVA_MW_ROOT}/src/CoreModule.cpp

  ${NOVA_MW_ROOT}/port/chibios/src/impl/Middleware_.cpp
  ${NOVA_MW_ROOT}/port/chibios/src/impl/Time_.cpp
  
  ${NOVA_MW_ROOT}/port/chibios/src/impl/Stubs.cpp
)

SET( NOVA_MW_INCLUDE_DIRS
  ${NOVA_MW_ROOT}/include
  ${NOVA_MW_ROOT}/port/chibios/include
)

IF( CORE_USE_RTCANTRANSPORT )
  SET( TRANSPORT_SOURCES
    ${NOVA_MW_ROOT}/src/transport/RTCANTransport.cpp
    ${NOVA_MW_ROOT}/src/transport/RTCANPublisher.cpp
    ${NOVA_MW_ROOT}/src/transport/RTCANSubscriber.cpp
  )
  
  LIST( APPEND NOVA_MW_SOURCES ${TRANSPORT_SOURCES} )
ENDIF()

IF( CORE_USE_DEBUGTRANSPORT )
  SET( TRANSPORT_SOURCES
    ${NOVA_MW_ROOT}/src/transport/DebugTransport.cpp
    ${NOVA_MW_ROOT}/src/transport/DebugPublisher.cpp
    ${NOVA_MW_ROOT}/src/transport/DebugSubscriber.cpp
  )
  
  LIST( APPEND NOVA_MW_SOURCES ${TRANSPORT_SOURCES} )
ENDIF()

IF( CORE_USE_BOOTLOADER )
  SET( BOOTLOADER_SOURCES
    ${NOVA_MW_ROOT}/src/Bootloader.cpp

    ${NOVA_MW_ROOT}/port/chibios/src/impl/Bootloader_.cpp
    ${NOVA_MW_ROOT}/port/chibios/src/impl/Flasher_.cpp
  )
  
  LIST( APPEND NOVA_MW_SOURCES ${BOOTLOADER_SOURCES} )
ENDIF()

LIST( REMOVE_DUPLICATES NOVA_MW_SOURCES )
LIST( REMOVE_DUPLICATES NOVA_MW_INCLUDE_DIRS )

INCLUDE( FindPackageHandleStandardArgs )
FIND_PACKAGE_HANDLE_STANDARD_ARGS( Nova_MW DEFAULT_MSG NOVA_MW_SOURCES NOVA_MW_INCLUDE_DIRS )
