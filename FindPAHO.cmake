SET(PAHO ${NOVA_ROOT}/libs/paho.mqtt.embedded-c)
MESSAGE( STATUS "PAHO: ${PAHO}" )

IF( NOT EXISTS ${PAHO})
  MESSAGE( FATAL_ERROR "${PAHO} does not exists." )
ENDIF()

SET(MQTTPacketSRC
	${PAHO}/MQTTPacket/src/MQTTConnectClient.c
	${PAHO}/MQTTPacket/src/MQTTConnectServer.c
	${PAHO}/MQTTPacket/src/MQTTDeserializePublish.c
	${PAHO}/MQTTPacket/src/MQTTFormat.c
	${PAHO}/MQTTPacket/src/MQTTPacket.c
	${PAHO}/MQTTPacket/src/MQTTSerializePublish.c
	${PAHO}/MQTTPacket/src/MQTTSubscribeClient.c
	${PAHO}/MQTTPacket/src/MQTTSubscribeServer.c
	${PAHO}/MQTTPacket/src/MQTTUnsubscribeClient.c
	${PAHO}/MQTTPacket/src/MQTTUnsubscribeServer.c
)

SET(PAHO_SOURCES ${MQTTPacketSRC} )

SET( PAHO_INCLUDE_DIRS
        ${PAHO}/MQTTPacket/src
        ${PAHO}/MQTTClient/src
)


LIST( REMOVE_DUPLICATES PAHO_SOURCES )
LIST( REMOVE_DUPLICATES PAHO_INCLUDE_DIRS )

INCLUDE( FindPackageHandleStandardArgs )
FIND_PACKAGE_HANDLE_STANDARD_ARGS( PAHO DEFAULT_MSG PAHO_SOURCES PAHO_INCLUDE_DIRS )
