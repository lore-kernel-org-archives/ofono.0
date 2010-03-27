Content-Type: multipart/mixed; boundary="===============8521029183889347804=="
MIME-Version: 1.0
From: Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH 1/5] ppp: fix segfault in pppcp_send_code_reject()
Date: Fri, 26 Mar 2010 18:34:26 -0700
Message-ID: <1269653670-31352-2-git-send-email-kristen@linux.intel.com>
In-Reply-To: <1269653670-31352-1-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8521029183889347804==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

fix memory corruption caused by misplaced paren when memcpying
rejected packet data into Code-Reject packet.
---
 gatchat/ppp_cp.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/gatchat/ppp_cp.c b/gatchat/ppp_cp.c
index 137f6b9..39e872b 100644
--- a/gatchat/ppp_cp.c
+++ b/gatchat/ppp_cp.c
@@ -454,9 +454,12 @@ static void pppcp_send_code_reject(struct pppcp_data *=
data,
 					guint8 *rejected_packet)
 {
 	struct pppcp_packet *packet;
+	struct pppcp_packet *old_packet =3D
+				(struct pppcp_packet *) rejected_packet;
 =

-	packet =3D pppcp_packet_new(data, CODE_REJECT,
-			ntohs(((struct pppcp_packet *) rejected_packet)->length));
+	pppcp_trace(data);
+
+	packet =3D pppcp_packet_new(data, CODE_REJECT, ntohs(old_packet->length));
 =

 	/*
 	 * Identifier must be changed for each Code-Reject sent
@@ -468,7 +471,7 @@ static void pppcp_send_code_reject(struct pppcp_data *d=
ata,
 	 * truncated if it needs to be to comply with mtu requirement
 	 */
 	memcpy(packet->data, rejected_packet,
-			ntohs(packet->length - CP_HEADER_SZ));
+			ntohs(packet->length) - CP_HEADER_SZ);
 =

 	ppp_transmit(data->ppp, pppcp_to_ppp_packet(packet),
 			ntohs(packet->length));
-- =

1.6.6.1


--===============8521029183889347804==--

