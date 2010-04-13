Content-Type: multipart/mixed; boundary="===============6501081426813512628=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH] ppp: nak unknown auth protocol
Date: Tue, 13 Apr 2010 08:17:17 -0700
Message-ID: <1271171837-16303-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6501081426813512628==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If we are sent a Config-Request for an auth proto other than
CHAP with MD5, send a NAK.
---
 gatchat/ppp.h      |   10 ++++++++++
 gatchat/ppp_auth.c |    2 --
 gatchat/ppp_lcp.c  |   30 ++++++++++++++++++++++++++++--
 3 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/gatchat/ppp.h b/gatchat/ppp.h
index 7045162..a8a0486 100644
--- a/gatchat/ppp.h
+++ b/gatchat/ppp.h
@@ -25,6 +25,7 @@
 #define CHAP_PROTOCOL	0xc223
 #define IPCP_PROTO	0x8021
 #define PPP_IP_PROTO	0x0021
+#define MD5		5
 =

 enum ppp_phase {
 	PPP_PHASE_DEAD =3D 0,		/* Link dead */
@@ -62,12 +63,21 @@ static inline guint16 __get_unaligned_short(const void =
*p)
 	return ptr->s;
 }
 =

+static inline void __put_unaligned_short(void *p, guint16 val)
+{
+	struct packed_short *ptr =3D p;
+	ptr->s =3D val;
+}
+
 #define get_host_long(p) \
 	(ntohl(__get_unaligned_long(p)))
 =

 #define get_host_short(p) \
 	(ntohs(__get_unaligned_short(p)))
 =

+#define put_network_short(p, val) \
+	(__put_unaligned_short(p, htons(val)))
+
 #define ppp_info(packet) \
 	(packet + 4)
 =

diff --git a/gatchat/ppp_auth.c b/gatchat/ppp_auth.c
index e794ad6..57203ab 100644
--- a/gatchat/ppp_auth.c
+++ b/gatchat/ppp_auth.c
@@ -35,8 +35,6 @@
 #include "gatppp.h"
 #include "ppp.h"
 =

-#define MD5	5
-
 struct chap_header {
 	guint8 code;
 	guint8 identifier;
diff --git a/gatchat/ppp_lcp.c b/gatchat/ppp_lcp.c
index 720db3e..5cf5656 100644
--- a/gatchat/ppp_lcp.c
+++ b/gatchat/ppp_lcp.c
@@ -166,9 +166,35 @@ static enum rcr_result lcp_rcr(struct pppcp_data *pppc=
p,
 =

 	while (ppp_option_iter_next(&iter) =3D=3D TRUE) {
 		switch (ppp_option_iter_get_type(&iter)) {
-		case ACCM:
-		/* TODO check to make sure it's a proto we recognize */
 		case AUTH_PROTO:
+		{
+			const guint8 *option_data =3D
+				ppp_option_iter_get_data(&iter);
+			guint16 proto =3D get_host_short(option_data);
+			guint8 method =3D option_data[2];
+			guint8 *option;
+
+			if ((proto =3D=3D CHAP_PROTOCOL) && (method =3D=3D MD5))
+				break;
+
+			/*
+			 * try to suggest CHAP & MD5.  If we are out
+			 * of memory, just reject.
+			 */
+
+			option =3D g_try_malloc0(5);
+			if (!option)
+				return RCR_REJECT;
+
+			option[0] =3D AUTH_PROTO;
+			option[1] =3D 5;
+			put_network_short(&option[2], CHAP_PROTOCOL);
+			option[4] =3D MD5;
+			*new_options =3D option;
+			*new_len =3D 5;
+			return RCR_NAK;
+		}
+		case ACCM:
 		case PFC:
 		case ACFC:
 			break;
-- =

1.6.6.1


--===============6501081426813512628==--

