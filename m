Content-Type: multipart/mixed; boundary="===============3781356725404032624=="
MIME-Version: 1.0
From: Caiwen Zhang <caiwen.zhang@windriver.com>
Subject: [PATCH] fix ppp protocol-reject constructing error
Date: Wed, 11 May 2011 16:15:19 +0800
Message-ID: <1305101719-2913-1-git-send-email-caiwen.zhang@windriver.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3781356725404032624==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In PPP Protocol-Reject package the 'rejected data field' should be a copy
of the rejected package, the copy starts from the data field. besides, =

Protocol-Reject package include a 'rejected protocol field', it is the
same as the protocol field of the rejected package.

Protocol-Reject package structure is:

	| PPP_header | rejected protocol | rejected data

The rejected package structure is:
	| Addr | Control | protocol | data
	=

So the Protocol-Reject package data field is copied from the 3rd byte of
the rejected package.

---
 gatchat/ppp_cp.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/gatchat/ppp_cp.c b/gatchat/ppp_cp.c
index 6e4a9c5..2d47933 100644
--- a/gatchat/ppp_cp.c
+++ b/gatchat/ppp_cp.c
@@ -922,7 +922,8 @@ void pppcp_send_protocol_reject(struct pppcp_data *data,
 	 * info should contain the old packet info, plus the 16bit
 	 * protocol number we are rejecting.
 	 */
-	packet =3D pppcp_packet_new(data, PPPCP_CODE_TYPE_PROTOCOL_REJECT, len);
+	packet =3D pppcp_packet_new(data, PPPCP_CODE_TYPE_PROTOCOL_REJECT,
+		len - 2);
 =

 	/*
 	 * Identifier must be changed for each Protocol-Reject sent
@@ -933,8 +934,7 @@ void pppcp_send_protocol_reject(struct pppcp_data *data,
 	 * rejected packet should be copied in, but it should be
 	 * truncated if it needs to be to comply with mtu requirement
 	 */
-	memcpy(packet->data, rejected_packet,
-			(ntohs(packet->length) - CP_HEADER_SZ));
+	memcpy(packet->data, rejected_packet + 2, len - 2);
 =

 	ppp_transmit(data->ppp, pppcp_to_ppp_packet(packet),
 			ntohs(packet->length));
-- =

1.7.5

--===============3781356725404032624==--

