Content-Type: multipart/mixed; boundary="===============2711404853398810534=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH 3/3] ppp: nak unknown auth protocol
Date: Mon, 12 Apr 2010 07:38:53 -0700
Message-ID: <1271083133-13760-4-git-send-email-kristen@linux.intel.com>
In-Reply-To: <1271083133-13760-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2711404853398810534==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If we are sent a Config-Request with anything other than CHAP/MD5,
send a NAK.
---
 gatchat/ppp.h      |   10 ++++++++++
 gatchat/ppp_auth.c |    2 --
 gatchat/ppp_lcp.c  |   25 +++++++++++++++++++++++--
 3 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/gatchat/ppp.h b/gatchat/ppp.h
index 87541c9..3eaf808 100644
--- a/gatchat/ppp.h
+++ b/gatchat/ppp.h
@@ -25,6 +25,7 @@
 #define CHAP_PROTOCOL	0xc223
 #define IPCP_PROTO	0x8021
 #define PPP_IP_PROTO	0x0021
+#define MD5		5
 =

 enum ppp_event {
 	PPP_UP =3D 1,
@@ -61,12 +62,21 @@ static inline guint16 __get_unaligned_short(const void =
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
index 3f69fa3..e04f708 100644
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
index 429fa49..ab83d9e 100644
--- a/gatchat/ppp_lcp.c
+++ b/gatchat/ppp_lcp.c
@@ -163,9 +163,30 @@ static enum rcr_result lcp_rcr(struct pppcp_data *pppc=
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
+
+			if ((proto !=3D CHAP_PROTOCOL) || (method !=3D MD5)) {
+				guint8 *option =3D g_try_malloc0(5);
+				if (!option)
+					return RCR_REJECT;
+
+				option[0] =3D AUTH_PROTO;
+				option[1] =3D 5;
+				put_network_short(&option[2], CHAP_PROTOCOL);
+				option[4] =3D MD5;
+				*new_options =3D option;
+				*new_len =3D 5;
+				return RCR_NAK;
+			}
+			break;
+		}
+
+		case ACCM:
 		case PFC:
 		case ACFC:
 			break;
-- =

1.6.6.1


--===============2711404853398810534==--

