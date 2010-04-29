Content-Type: multipart/mixed; boundary="===============4708513896247843500=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH] ppp: silently drop invalid packets
Date: Thu, 29 Apr 2010 12:18:29 -0700
Message-ID: <1272568709-6812-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4708513896247843500==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gatppp.c |   36 ++++++++++++++++++++++++++++--------
 1 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/gatchat/gatppp.c b/gatchat/gatppp.c
index dfdaf40..6a2c30e 100644
--- a/gatchat/gatppp.c
+++ b/gatchat/gatppp.c
@@ -71,24 +71,44 @@ void ppp_debug(GAtPPP *ppp, const char *str)
 	ppp->debugf(str, ppp->debug_data);
 }
 =

+/*
+ * Silently discard packets which are received when they shouldn't be
+ */
+static inline gboolean ppp_drop_packet(GAtPPP *ppp, guint16 protocol)
+{
+	switch (ppp->phase) {
+	case PPP_PHASE_ESTABLISHMENT:
+	case PPP_PHASE_TERMINATION:
+		if (protocol !=3D LCP_PROTOCOL)
+			return TRUE;
+		break;
+	case PPP_PHASE_AUTHENTICATION:
+		if (protocol !=3D LCP_PROTOCOL && protocol !=3D CHAP_PROTOCOL)
+			return TRUE;
+		break;
+	case PPP_PHASE_DEAD:
+		return TRUE;
+	case PPP_PHASE_NETWORK:
+		if (ppp->net =3D=3D NULL)
+			return TRUE;
+		break;
+	}
+
+	return FALSE;
+}
+
 static void ppp_receive(const unsigned char *buf, gsize len, void *data)
 {
 	GAtPPP *ppp =3D data;
 	guint16 protocol =3D ppp_proto(buf);
 	const guint8 *packet =3D ppp_info(buf);
 =

-	/*
-	 * Any non-LCP packets received during Link Establishment
-	 * phase must be silently discarded.
-	 */
-	if (ppp->phase =3D=3D PPP_PHASE_ESTABLISHMENT && protocol !=3D LCP_PROTOC=
OL)
+	if (ppp_drop_packet(ppp, protocol))
 		return;
 =

 	switch (protocol) {
 	case PPP_IP_PROTO:
-		/* If network is up & open, process the packet, if not, drop */
-		if (ppp->net)
-			ppp_net_process_packet(ppp->net, packet);
+		ppp_net_process_packet(ppp->net, packet);
 		break;
 	case LCP_PROTOCOL:
 		pppcp_process_packet(ppp->lcp, packet);
-- =

1.6.6.1


--===============4708513896247843500==--

