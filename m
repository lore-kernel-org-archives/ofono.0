Content-Type: multipart/mixed; boundary="===============3352017847779192973=="
MIME-Version: 1.0
From: Sjur =?unknown-8bit?q?Br=C3=A6ndeland?= <sjurbren@gmail.com>
Subject: [PATCH 2/3] stedriver: Copy caif_socket.h from 2.6.36 release
 candidate.
Date: Mon, 09 Aug 2010 23:29:39 +0200
Message-ID: <1281389380-12219-2-git-send-email-sjurbren@gmail.com>
In-Reply-To: <1281389380-12219-1-git-send-email-sjurbren@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3352017847779192973==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Sjur Br=C3=A6ndeland <sjur.brandeland@stericsson.com>

Copied include/linux/caif/caif_socket.h and
added AF_CAIF, PF_CAIF and SOL_CAIF definitions
found in linux/include/socket.h.
---
 drivers/stemodem/caif_socket.h |  207 ++++++++++++++++++++++++------------=
----
 1 files changed, 123 insertions(+), 84 deletions(-)

diff --git a/drivers/stemodem/caif_socket.h b/drivers/stemodem/caif_socket.h
index 424c301..745d43d 100644
--- a/drivers/stemodem/caif_socket.h
+++ b/drivers/stemodem/caif_socket.h
@@ -1,6 +1,6 @@
 /* linux/caif_socket.h
  * CAIF Definitions for CAIF socket and network layer
- * Copyright (C) ST-Ericsson AB 2009
+ * Copyright (C) ST-Ericsson AB 2010
  * Author:	 Sjur Brendeland/ sjur.brandeland(a)stericsson.com
  * License terms: GNU General Public License (GPL) version 2
  */
@@ -8,33 +8,35 @@
 #ifndef _LINUX_CAIF_SOCKET_H
 #define _LINUX_CAIF_SOCKET_H
 =

-#ifdef __KERNEL__
 #include <linux/types.h>
+
+#ifdef __KERNEL__
 #include <linux/socket.h>
 #else
-#include <sys/types.h>
 #include <sys/socket.h>
 #endif
 =

-#ifdef __cplusplus
-extern "C" {
-#endif
+/* Copy definitions from include/linux/socket.h */
 #ifndef AF_CAIF
-#define AF_CAIF    37          /* CAIF Socket Address Family */
+#define AF_CAIF	37		/* CAIF Socket Address Family */
 #endif
 #ifndef PF_CAIF
-#define PF_CAIF    AF_CAIF      /* CAIF Socket Protocol Family */
+#define PF_CAIF	AF_CAIF	/* CAIF Socket Protocol Family */
 #endif
 #ifndef SOL_CAIF
-#define SOL_CAIF   278		/* CAIF Socket Option Level */
+#define SOL_CAIF	278		/* CAIF Socket Option Level */
 #endif
 =

 /**
- * enum caif_link_selector -   Physical Link Selection.
- * @CAIF_LINK_HIGH_BANDW:	Default physical interface for high-bandwidth
+ * enum caif_link_selector -    Physical Link Selection.
+ * @CAIF_LINK_HIGH_BANDW:	Physical interface for high-bandwidth
  *				traffic.
- * @CAIF_LINK_LOW_LATENCY:	Default physical interface for low-latency
+ * @CAIF_LINK_LOW_LATENCY:	Physical interface for low-latency
  *				traffic.
+ *
+ * CAIF Link Layers can register their link properties.
+ * This enum is used for choosing between CAIF Link Layers when
+ * setting up CAIF Channels when multiple CAIF Link Layers exists.
  */
 enum caif_link_selector {
 	CAIF_LINK_HIGH_BANDW,
@@ -42,12 +44,39 @@ enum caif_link_selector {
 };
 =

 /**
- * enum caif_protocol_type  -	Types of CAIF protocols in the CAIF Stack.
+ * enum caif_channel_priority - CAIF channel priorities.
+ *
+ * @CAIF_PRIO_MIN:	Min priority for a channel.
+ * @CAIF_PRIO_LOW:	Low-priority channel.
+ * @CAIF_PRIO_NORMAL:	Normal/default priority level.
+ * @CAIF_PRIO_HIGH:	High priority level
+ * @CAIF_PRIO_MAX:	Max priority for channel
+ *
+ * Priority can be set on CAIF Channels in order to
+ * prioritize between traffic on different CAIF Channels.
+ * These priority levels are recommended, but the priority value
+ * is not restricted to the values defined in this enum, any value
+ * between CAIF_PRIO_MIN and CAIF_PRIO_MAX could be used.
+ */
+enum caif_channel_priority {
+	CAIF_PRIO_MIN	 =3D 0x01,
+	CAIF_PRIO_LOW	 =3D 0x04,
+	CAIF_PRIO_NORMAL =3D 0x0f,
+	CAIF_PRIO_HIGH	 =3D 0x14,
+	CAIF_PRIO_MAX	 =3D 0x1F
+};
+
+/**
+ * enum caif_protocol_type  -	CAIF Channel type.
  * @CAIFPROTO_AT:		Classic AT channel.
- * @CAIFPROTO_DATAGRAM:		Datagram channel.
+ * @CAIFPROTO_DATAGRAM:	Datagram channel.
  * @CAIFPROTO_DATAGRAM_LOOP:	Datagram loopback channel, used for testing.
  * @CAIFPROTO_UTIL:		Utility (Psock) channel.
  * @CAIFPROTO_RFM:		Remote File Manager
+ * @CAIFPROTO_DEBUG:		Debug link
+ *
+ * This enum defines the CAIF Channel type to be used. This defines
+ * the service to connect to on the modem.
  */
 enum caif_protocol_type {
 	CAIFPROTO_AT,
@@ -55,6 +84,7 @@ enum caif_protocol_type {
 	CAIFPROTO_DATAGRAM_LOOP,
 	CAIFPROTO_UTIL,
 	CAIFPROTO_RFM,
+	CAIFPROTO_DEBUG,
 	_CAIFPROTO_MAX
 };
 #define	CAIFPROTO_MAX _CAIFPROTO_MAX
@@ -64,108 +94,117 @@ enum caif_protocol_type {
  * @CAIF_ATTYPE_PLAIN:	     Connects to a plain vanilla AT channel.
  */
 enum caif_at_type {
-	CAIF_ATTYPE_PLAIN
+	CAIF_ATTYPE_PLAIN =3D 2
+};
+ /**
+ * enum caif_debug_type - Content selection for debug connection
+ * @CAIF_DEBUG_TRACE_INTERACTIVE: Connection will contain
+ *				both trace and interactive debug.
+ * @CAIF_DEBUG_TRACE:		Connection contains trace only.
+ * @CAIF_DEBUG_INTERACTIVE:	Connection to interactive debug.
+ */
+enum caif_debug_type {
+	CAIF_DEBUG_TRACE_INTERACTIVE =3D 0,
+	CAIF_DEBUG_TRACE,
+	CAIF_DEBUG_INTERACTIVE,
+};
+
+/**
+ * enum caif_debug_service - Debug Service Endpoint
+ * @CAIF_RADIO_DEBUG_SERVICE:	Debug service on the Radio sub-system
+ * @CAIF_APP_DEBUG_SERVICE:	Debug for the applications sub-system
+ */
+enum caif_debug_service {
+	CAIF_RADIO_DEBUG_SERVICE =3D 1,
+	CAIF_APP_DEBUG_SERVICE
 };
 =

 /**
  * struct sockaddr_caif - the sockaddr structure for CAIF sockets.
  * @family:		     Address family number, must be AF_CAIF.
- * @u:			     Union of address data 'switched' by familty.
- * @at:			     Applies when family =3D CAIFPROTO_AT.
- * @at.type:		     Type of AT link to set up (enum caif_at_type).
- * @util:		     Applies when family =3D CAIFPROTO_UTIL
- * @util.service:	     Service name.
- * @dgm:		     Applies when family =3D CAIFPROTO_DATAGRAM
- * @dgm.connection_id:	     Datagram connection id.
- * @dgm.nsapi:		     NSAPI of the PDP-Context.
- * @rfm:		     Applies when family =3D CAIFPROTO_RFM
- * @rfm.connection_id:       Connection ID for RFM.
- * @rfm.volume:	     	     Volume to mount.
+ * @u:			     Union of address data 'switched' by family.
+ * :
+ * @u.at:                    Applies when family =3D CAIFPROTO_AT.
+ *
+ * @u.at.type:               Type of AT link to set up (enum caif_at_type).
+ *
+ * @u.util:                  Applies when family =3D CAIFPROTO_UTIL
+ *
+ * @u.util.service:          Utility service name.
+ *
+ * @u.dgm:                   Applies when family =3D CAIFPROTO_DATAGRAM
+ *
+ * @u.dgm.connection_id:     Datagram connection id.
+ *
+ * @u.dgm.nsapi:             NSAPI of the PDP-Context.
+ *
+ * @u.rfm:                   Applies when family =3D CAIFPROTO_RFM
+ *
+ * @u.rfm.connection_id:     Connection ID for RFM.
+ *
+ * @u.rfm.volume:            Volume to mount.
+ *
+ * @u.dbg:		      Applies when family =3D CAIFPROTO_DEBUG.
+ *
+ * @u.dbg.type:			     Type of debug connection to set up
+ *			      (caif_debug_type).
+ *
+ * @u.dbg.service:	      Service sub-system to connect (caif_debug_service
+ * Description:
+ * This structure holds the connect parameters used for setting up a
+ * CAIF Channel. It defines the service to connect to on the modem.
  */
 struct sockaddr_caif {
 	sa_family_t  family;
 	union {
 		struct {
-			u_int8_t  type;		/* type: enum caif_at_type */
+			__u8  type;		/* type: enum caif_at_type */
 		} at;				/* CAIFPROTO_AT */
 		struct {
 			char	  service[16];
 		} util;				/* CAIFPROTO_UTIL */
 		union {
-			u_int32_t connection_id;
-			u_int8_t  nsapi;
+			__u32 connection_id;
+			__u8  nsapi;
 		} dgm;				/* CAIFPROTO_DATAGRAM(_LOOP)*/
 		struct {
-			u_int32_t connection_id;
+			__u32 connection_id;
 			char	  volume[16];
 		} rfm;				/* CAIFPROTO_RFM */
+		struct {
+			__u8  type;		/* type:enum caif_debug_type */
+			__u8  service;		/* service:caif_debug_service */
+		} dbg;				/* CAIFPROTO_DEBUG */
 	} u;
 };
 =

 /**
- * struct caif_channel_opt - CAIF channel connect options.
- * @priority:		Priority of the channel (between 0 and 0x1f)
- * @link_selector:	Selector for the physical link.
- *			(see enum caif_phy_preference in caif_config.h)
- * @link_name:		Physical link to use. This is the instance name of the
- *			CAIF Physical Driver.
- */
-struct caif_channel_opt {
-	u_int16_t  priority;
-	u_int16_t  link_selector;
-	char	   link_name[16];
-};
-
-/**
- * struct caif_param - CAIF parameters.
- * @size:	Length of data
- * @data:	Binary Data Blob
- */
-struct caif_param {
-	u_int16_t  size;
-	u_int8_t   data[256];
-};
-
-
-/** enum caif_socket_opts - CAIF option values for getsockopt and setsocko=
pt
- * @CAIFSO_CHANNEL:		Used to set the connect options on a CAIF
- *				socket. (struct caif_config_opt). This can only
- *				be set before connecting.
- * @CAIFSO_REQ_PARAM:		Used to set the request parameters for a
- *				utility channel. (struct caif_param). This
- *				can only be set before connecting.
+ * enum caif_socket_opts - CAIF option values for getsockopt and setsockop=
t.
  *
- * @CAIFSO_RSP_PARAM:		Gets the request parameters for a utility
- *				channel. (struct caif_param). This can only be
- *				fetched after connecting the socket.
+ * @CAIFSO_LINK_SELECT:		Selector used if multiple CAIF Link layers are
+ *				available. Either a high bandwidth
+ *				link can be selected (CAIF_LINK_HIGH_BANDW) or
+ *				or a low latency link (CAIF_LINK_LOW_LATENCY).
+ *                              This option is of type __u32.
+ *				Alternatively SO_BINDTODEVICE can be used.
  *
- * @CAIFSO_UTIL_FLOW:		Sets the utility channels flow options.
- *				This can only be set before connecting.
- *				(struct caif_util_modem_flow_opt)
+ * @CAIFSO_REQ_PARAM:		Used to set the request parameters for a
+ *				utility channel. (maximum 256 bytes). This
+ *				option must be set before connecting.
  *
- * @CAIFSO_CONN_ID:		Gets the channel id on a CAIF Channel.
- *				This can only be done after connect.
- *				( u_int32_t)
+ * @CAIFSO_RSP_PARAM:		Gets the response parameters for a utility
+ *				channel. (maximum 256 bytes). This option
+ *				is valid after a successful connect.
  *
- * @CAIFSO_NEXT_PAKCET_LEN:	Gets the size of next received packet.
- *				Value is 0 if no packet is available.
- *				This can only be done after connect.
- *				( u_int32_t)
  *
- * @CAIFSO_MAX_PAKCET_LEN:	Gets the maximum packet size for this
- *				connection. ( u_int32_t)
+ * This enum defines the CAIF Socket options to be used on a socket
+ * of type PF_CAIF.
+ *
  */
 enum caif_socket_opts {
-	CAIFSO_CHANNEL_CONFIG	=3D 127,
+	CAIFSO_LINK_SELECT	=3D 127,
 	CAIFSO_REQ_PARAM	=3D 128,
 	CAIFSO_RSP_PARAM	=3D 129,
-	CAIFSO_UTIL_FLOW	=3D 130,
-	CAIFSO_CONN_ID		=3D 131,
-	CAIFSO_NEXT_PACKET_LEN	=3D 132,
-	CAIFSO_MAX_PACKET_LEN	=3D 133,
 };
 =

-#ifdef __cplusplus
-}				/* extern "C" */
-#endif
 #endif /* _LINUX_CAIF_SOCKET_H */
-- =

1.6.3.3


--===============3352017847779192973==--

