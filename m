Content-Type: multipart/mixed; boundary="===============6423276747035624703=="
MIME-Version: 1.0
From: sjur.brandeland@stericsson.com
Subject: [RFC v2 6/7] STE-plugin: Add CAIF header files in gcaif.
Date: Tue, 19 Jan 2010 17:11:52 +0100
Message-ID: <1263917513-6756-7-git-send-email-sjur.brandeland@stericsson.com>
In-Reply-To: <1263917513-6756-6-git-send-email-sjur.brandeland@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6423276747035624703==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Adding CAIF header files. These should be removed when
CAIF is included Linux kernel.
---
 gcaif/caif_socket.h |  171 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 gcaif/if_caif.h     |   70 +++++++++++++++++++++
 2 files changed, 241 insertions(+), 0 deletions(-)
 create mode 100644 gcaif/caif_socket.h
 create mode 100644 gcaif/if_caif.h

diff --git a/gcaif/caif_socket.h b/gcaif/caif_socket.h
new file mode 100644
index 0000000..7122b41
--- /dev/null
+++ b/gcaif/caif_socket.h
@@ -0,0 +1,171 @@
+/* linux/caif_socket.h
+ * CAIF Definitions for CAIF socket and network layer
+ * Copyright (C) ST-Ericsson AB 2009
+ * Author:	 Sjur Brendeland/ sjur.brandeland(a)stericsson.com
+ * License terms: GNU General Public License (GPL) version 2
+ */
+
+#ifndef _LINUX_CAIF_SOCKET_H
+#define _LINUX_CAIF_SOCKET_H
+
+#ifdef __KERNEL__
+#include <linux/types.h>
+#include <linux/socket.h>
+#else
+#include <sys/types.h>
+#include <sys/socket.h>
+#endif
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+#ifndef AF_CAIF
+#define AF_CAIF    28          /* CAIF Socket Address Family */
+#endif
+#ifndef PF_CAIF
+#define PF_CAIF    AF_CAIF      /* CAIF Socket Protocol Family */
+#endif
+#ifndef SOL_CAIF
+#define SOL_CAIF   278		/* CAIF Socket Option Level */
+#endif
+
+/**
+ * enum caif_link_selector -   Physical Link Selection.
+ * @CAIF_LINK_HIGH_BANDW:	Default physical interface for high-bandwidth
+ *				traffic.
+ * @CAIF_LINK_LOW_LATENCY:	Default physical interface for low-latency
+ *				traffic.
+ */
+enum caif_link_selector {
+	CAIF_LINK_HIGH_BANDW,
+	CAIF_LINK_LOW_LATENCY
+};
+
+/**
+ * enum caif_protocol_type  -	Types of CAIF protocols in the CAIF Stack.
+ * @CAIFPROTO_AT:		Classic AT channel.
+ * @CAIFPROTO_DATAGRAM:		Datagram channel.
+ * @CAIFPROTO_DATAGRAM_LOOP:	Datagram loopback channel, used for testing.
+ * @CAIFPROTO_UTIL:		Utility (Psock) channel.
+ * @CAIFPROTO_RFM:		Remote File Manager
+ */
+enum caif_protocol_type {
+	CAIFPROTO_AT,
+	CAIFPROTO_DATAGRAM,
+	CAIFPROTO_DATAGRAM_LOOP,
+	CAIFPROTO_UTIL,
+	CAIFPROTO_RFM,
+	_CAIFPROTO_MAX
+};
+#define	CAIFPROTO_MAX _CAIFPROTO_MAX
+
+/**
+ * enum caif_at_type - AT Service Endpoint
+ * @CAIF_ATTYPE_PLAIN:	     Connects to a plain vanilla AT channel.
+ */
+enum caif_at_type {
+	CAIF_ATTYPE_PLAIN
+};
+
+/**
+ * struct sockaddr_caif - the sockaddr structure for CAIF sockets.
+ * @family:		     Address family number, must be AF_CAIF.
+ * @u:			     Union of address data 'switched' by familty.
+ * @at:			     Applies when family =3D CAIFPROTO_AT.
+ * @at.type:		     Type of AT link to set up (enum caif_at_type).
+ * @util:		     Applies when family =3D CAIFPROTO_UTIL
+ * @util.service:	     Service name.
+ * @dgm:		     Applies when family =3D CAIFPROTO_DATAGRAM
+ * @dgm.connection_id:	     Datagram connection id.
+ * @dgm.nsapi:		     NSAPI of the PDP-Context.
+ * @rfm:		     Applies when family =3D CAIFPROTO_RFM
+ * @rfm.connection_id:       Connection ID for RFM.
+ * @rfm.volume:	     	     Volume to mount.
+ */
+struct sockaddr_caif {
+	sa_family_t  family;
+	union {
+		struct {
+			u_int8_t  type;		/* type: enum caif_at_type */
+		} at;				/* CAIFPROTO_AT */
+		struct {
+			char	  service[16];
+		} util;				/* CAIFPROTO_UTIL */
+		union {
+			u_int32_t connection_id;
+			u_int8_t  nsapi;
+		} dgm;				/* CAIFPROTO_DATAGRAM(_LOOP)*/
+		struct {
+			u_int32_t connection_id;
+			char	  volume[16];
+		} rfm;				/* CAIFPROTO_RFM */
+	} u;
+};
+
+/**
+ * struct caif_channel_opt - CAIF channel connect options.
+ * @priority:		Priority of the channel (between 0 and 0x1f)
+ * @link_selector:	Selector for the physical link.
+ *			(see enum caif_phy_preference in caif_config.h)
+ * @link_name:		Physical link to use. This is the instance name of the
+ *			CAIF Physical Driver.
+ */
+struct caif_channel_opt {
+	u_int16_t  priority;
+	u_int16_t  link_selector;
+	char	   link_name[16];
+};
+
+/**
+ * struct caif_param - CAIF parameters.
+ * @size:	Length of data
+ * @data:	Binary Data Blob
+ */
+struct caif_param {
+	u_int16_t  size;
+	u_int8_t   data[256];
+};
+
+
+/** enum caif_socket_opts - CAIF option values for getsockopt and setsocko=
pt
+ * @CAIFSO_CHANNEL:		Used to set the connect options on a CAIF
+ *				socket. (struct caif_config_opt). This can only
+ *				be set before connecting.
+ * @CAIFSO_REQ_PARAM:		Used to set the request parameters for a
+ *				utility channel. (struct caif_param). This
+ *				can only be set before connecting.
+ *
+ * @CAIFSO_RSP_PARAM:		Gets the request parameters for a utility
+ *				channel. (struct caif_param). This can only be
+ *				fetched after connecting the socket.
+ *
+ * @CAIFSO_UTIL_FLOW:		Sets the utility channels flow options.
+ *				This can only be set before connecting.
+ *				(struct caif_util_modem_flow_opt)
+ *
+ * @CAIFSO_CONN_ID:		Gets the channel id on a CAIF Channel.
+ *				This can only be done after connect.
+ *				( u_int32_t)
+ *
+ * @CAIFSO_NEXT_PAKCET_LEN:	Gets the size of next received packet.
+ *				Value is 0 if no packet is available.
+ *				This can only be done after connect.
+ *				( u_int32_t)
+ *
+ * @CAIFSO_MAX_PAKCET_LEN:	Gets the maximum packet size for this
+ *				connection. ( u_int32_t)
+ */
+enum caif_socket_opts {
+	CAIFSO_CHANNEL_CONFIG	=3D 127,
+	CAIFSO_REQ_PARAM	=3D 128,
+	CAIFSO_RSP_PARAM	=3D 129,
+	CAIFSO_UTIL_FLOW	=3D 130,
+	CAIFSO_CONN_ID		=3D 131,
+	CAIFSO_NEXT_PACKET_LEN	=3D 132,
+	CAIFSO_MAX_PACKET_LEN	=3D 133,
+};
+
+#ifdef __cplusplus
+}				/* extern "C" */
+#endif
+#endif /* _LINUX_CAIF_SOCKET_H */
diff --git a/gcaif/if_caif.h b/gcaif/if_caif.h
new file mode 100644
index 0000000..ad3686b
--- /dev/null
+++ b/gcaif/if_caif.h
@@ -0,0 +1,70 @@
+/*
+ * Copyright (C) ST-Ericsson AB 2009
+ * Author:	Sjur Brendeland/ sjur.brandeland(a)stericsson.com
+ * License terms: GNU General Public License (GPL) version 2
+ */
+
+#ifndef IF_CAIF_H_
+#define IF_CAIF_H_
+#include <linux/sockios.h>
+#include <linux/types.h>
+#include <linux/socket.h>
+/**
+ * enum sioc_caif -	SOCKIO for creating new CAIF Net Devices.
+ * @SIOCCAIFNETNEW:	Used to create a new instance of the CAIF IP Interface.
+ *			struct ifreq containing struct ifcaif_param are used
+ *			as parameters. ifr_name must be filled in.
+ * @SIOCCAIFNETCHANGE:	As above, but changes a disconnected CAIF IP Intefa=
ce.
+ * @SIOCCAIFNETREMOVE:	Removes a CAIF IP Interface.
+ *
+ * CAIF IP Interface can be created, changed and deleted,
+ * by this enum. In addition standard Socket IO Controls (SIGIOC*)
+ * can be used to manage standard IP Interface parameters.
+ * The struct ifreq are used to carry parameters.
+ */
+enum sioc_caif {
+	SIOCCAIFNETNEW =3D SIOCPROTOPRIVATE,
+	SIOCCAIFNETCHANGE,
+	SIOCCAIFNETREMOVE
+};
+
+
+/**
+ * struct ifcaif_param - Parameters for creating CAIF Network Interface.
+ *
+ * When using SIOCCAIFNETNEW to create a CAIF IP interface, this structure
+ * is used for configuration data.
+ * The attribute ifr_ifru.ifru_data in struct struct ifreq must be set
+ * point at an instance of struct ifcaif_param.
+ *
+ * @ipv4_connid:  Connection ID for IPv4 PDP Context.
+ * @ipv6_connid:  Connection ID for IPv6 PDP Context.
+ * @loop:	  If different from zero, device is doing loopback
+ */
+struct ifcaif_param {
+	__u32			ipv4_connid;
+	__u32			ipv6_connid;
+	__u8			loop;
+};
+
+/**
+ * enum ifla_caif
+ * When using RT Netlink to create, destroy or configure a CAIF IP interfa=
ce,
+ * enum ifla_caif is used to specify the configuration attributes.
+ *
+ * @IFLA_CAIF_IPV4_CONNID:  Connection ID for IPv4 PDP Context.
+ *			    The type of attribute is NLA_U32.
+ * @IFLA_CAIF_IPV6_CONNID:  Connection ID for IPv6 PDP Context.
+ *			    The type of attribute is NLA_U32.
+ * @IFLA_CAIF_LOOPBACK:	    If different from zero, device is doing loopba=
ck
+ *			    The type of attribute is NLA_U8.
+ */
+enum ifla_caif {
+	IFLA_CAIF_IPV4_CONNID,
+	IFLA_CAIF_IPV6_CONNID,
+	IFLA_CAIF_LOOPBACK,
+	__IFLA_CAIF_MAX
+};
+#define	IFLA_CAIF_MAX (__IFLA_CAIF_MAX-1)
+
+#endif /*IF_CAIF_H_*/
-- =

1.6.0.4


--===============6423276747035624703==--

