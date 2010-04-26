Content-Type: multipart/mixed; boundary="===============5553340489244334056=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH] ppp: discard non-LCP packets when in Establishment phase
Date: Mon, 26 Apr 2010 10:28:41 -0700
Message-ID: <1272302921-21344-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5553340489244334056==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gatppp.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/gatchat/gatppp.c b/gatchat/gatppp.c
index fc6769c..1547a75 100644
--- a/gatchat/gatppp.c
+++ b/gatchat/gatppp.c
@@ -169,6 +169,13 @@ static void ppp_recv(GAtPPP *ppp, struct frame_buffer =
*frame)
 	guint16 protocol =3D ppp_proto(frame->bytes);
 	guint8 *packet =3D ppp_info(frame->bytes);
 =

+	/*
+	 * Any non-LCP packets received during Link Establishment
+	 * phase must be silently discarded.
+	 */
+	if (ppp->phase =3D=3D PPP_PHASE_ESTABLISHMENT && protocol !=3D LCP_PROTOC=
OL)
+		return;
+
 	switch (protocol) {
 	case PPP_IP_PROTO:
 		/* If network is up & open, process the packet, if not, drop */
-- =

1.6.6.1


--===============5553340489244334056==--

