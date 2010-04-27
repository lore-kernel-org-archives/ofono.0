Content-Type: multipart/mixed; boundary="===============7036427928218831685=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH] ppp: silently discard packets if needed
Date: Tue, 27 Apr 2010 14:53:38 -0700
Message-ID: <1272405218-30006-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7036427928218831685==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When receiving a packet, check the protocol and the phase to see
if the packet should be dropped.
---
 gatchat/gatppp.c |   30 +++++++++++++++++++++++++-----
 1 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/gatchat/gatppp.c b/gatchat/gatppp.c
index c7bf089..e51c281 100644
--- a/gatchat/gatppp.c
+++ b/gatchat/gatppp.c
@@ -173,17 +173,37 @@ static struct frame_buffer *ppp_encode(GAtPPP *ppp, g=
uint8 *data, int len)
 	return fb;
 }
 =

+/*
+ * Silently discard packets which are received when they shouldn't be
+ */
+static inline gboolean drop_packet(GAtPPP *ppp, guint16 protocol)
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
+		break;
+	}
+
+	return FALSE;
+}
+
 /* called when we have received a complete ppp frame */
 static void ppp_recv(GAtPPP *ppp, struct frame_buffer *frame)
 {
 	guint16 protocol =3D ppp_proto(frame->bytes);
 	guint8 *packet =3D ppp_info(frame->bytes);
 =

-	/*
-	 * Any non-LCP packets received during Link Establishment
-	 * phase must be silently discarded.
-	 */
-	if (ppp->phase =3D=3D PPP_PHASE_ESTABLISHMENT && protocol !=3D LCP_PROTOC=
OL)
+	if (drop_packet(ppp, protocol))
 		return;
 =

 	switch (protocol) {
-- =

1.6.6.1


--===============7036427928218831685==--

