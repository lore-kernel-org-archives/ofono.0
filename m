Content-Type: multipart/mixed; boundary="===============2602063858034109400=="
MIME-Version: 1.0
From: Sjur =?unknown-8bit?q?Br=C3=A6ndeland?= <sjurbren@gmail.com>
Subject: [PATCH 3/3] stedriver: Copy if_caif.h from 2.6.36 release candidate.
Date: Mon, 09 Aug 2010 23:29:40 +0200
Message-ID: <1281389380-12219-3-git-send-email-sjurbren@gmail.com>
In-Reply-To: <1281389380-12219-2-git-send-email-sjurbren@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2602063858034109400==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Sjur Br=C3=A6ndeland <sjur.brandeland@stericsson.com>

---
 drivers/stemodem/if_caif.h |   48 +++++-----------------------------------=
---
 1 files changed, 6 insertions(+), 42 deletions(-)

diff --git a/drivers/stemodem/if_caif.h b/drivers/stemodem/if_caif.h
index ad3686b..5e7eed4 100644
--- a/drivers/stemodem/if_caif.h
+++ b/drivers/stemodem/if_caif.h
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) ST-Ericsson AB 2009
+ * Copyright (C) ST-Ericsson AB 2010
  * Author:	Sjur Brendeland/ sjur.brandeland(a)stericsson.com
  * License terms: GNU General Public License (GPL) version 2
  */
@@ -9,57 +9,21 @@
 #include <linux/sockios.h>
 #include <linux/types.h>
 #include <linux/socket.h>
-/**
- * enum sioc_caif -	SOCKIO for creating new CAIF Net Devices.
- * @SIOCCAIFNETNEW:	Used to create a new instance of the CAIF IP Interface.
- *			struct ifreq containing struct ifcaif_param are used
- *			as parameters. ifr_name must be filled in.
- * @SIOCCAIFNETCHANGE:	As above, but changes a disconnected CAIF IP Intefa=
ce.
- * @SIOCCAIFNETREMOVE:	Removes a CAIF IP Interface.
- *
- * CAIF IP Interface can be created, changed and deleted,
- * by this enum. In addition standard Socket IO Controls (SIGIOC*)
- * can be used to manage standard IP Interface parameters.
- * The struct ifreq are used to carry parameters.
- */
-enum sioc_caif {
-	SIOCCAIFNETNEW =3D SIOCPROTOPRIVATE,
-	SIOCCAIFNETCHANGE,
-	SIOCCAIFNETREMOVE
-};
-
 =

 /**
- * struct ifcaif_param - Parameters for creating CAIF Network Interface.
- *
- * When using SIOCCAIFNETNEW to create a CAIF IP interface, this structure
- * is used for configuration data.
- * The attribute ifr_ifru.ifru_data in struct struct ifreq must be set
- * point at an instance of struct ifcaif_param.
- *
- * @ipv4_connid:  Connection ID for IPv4 PDP Context.
- * @ipv6_connid:  Connection ID for IPv6 PDP Context.
- * @loop:	  If different from zero, device is doing loopback
- */
-struct ifcaif_param {
-	__u32			ipv4_connid;
-	__u32			ipv6_connid;
-	__u8			loop;
-};
-
-/**
- * enum ifla_caif
- * When using RT Netlink to create, destroy or configure a CAIF IP interfa=
ce,
- * enum ifla_caif is used to specify the configuration attributes.
- *
+ * enum ifla_caif - CAIF NetlinkRT parameters.
  * @IFLA_CAIF_IPV4_CONNID:  Connection ID for IPv4 PDP Context.
  *			    The type of attribute is NLA_U32.
  * @IFLA_CAIF_IPV6_CONNID:  Connection ID for IPv6 PDP Context.
  *			    The type of attribute is NLA_U32.
  * @IFLA_CAIF_LOOPBACK:	    If different from zero, device is doing loopba=
ck
  *			    The type of attribute is NLA_U8.
+ *
+ * When using RT Netlink to create, destroy or configure a CAIF IP interfa=
ce,
+ * enum ifla_caif is used to specify the configuration attributes.
  */
 enum ifla_caif {
+	__IFLA_CAIF_UNSPEC,
 	IFLA_CAIF_IPV4_CONNID,
 	IFLA_CAIF_IPV6_CONNID,
 	IFLA_CAIF_LOOPBACK,
-- =

1.6.3.3


--===============2602063858034109400==--

