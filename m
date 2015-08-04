Content-Type: multipart/mixed; boundary="===============0688953616222635592=="
MIME-Version: 1.0
From: Kuba Pawlak <kubax.t.pawlak@intel.com>
Subject: [PATCH] Synchronize call status in case of Hangup error
Date: Tue, 04 Aug 2015 18:00:16 +0200
Message-ID: <1438704016-24150-1-git-send-email-kubax.t.pawlak@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0688953616222635592==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

It is possible for the phone to accept Dial request
but not actually dial. This leaves a voicecall object
in state 'dialling' that cannot be removed.
Proposed workaround is to trigger AT+CLCC when an error
is returned for Hangup. As the call is not on the list,
this would remove this hanging object and signal CallRemoved.
---
 drivers/hfpmodem/voicecall.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/hfpmodem/voicecall.c b/drivers/hfpmodem/voicecall.c
index e3e6e0f5eccbbd61972c4b823c8093dd227e4bb9..06ad216b91bcbe99f9632f3c129=
a8f61756fd585 100644
--- a/drivers/hfpmodem/voicecall.c
+++ b/drivers/hfpmodem/voicecall.c
@@ -318,21 +318,31 @@ static void generic_cb(gboolean ok, GAtResult *result=
, gpointer user_data)
 	struct change_state_req *req =3D user_data;
 	struct voicecall_data *vd =3D ofono_voicecall_get_data(req->vc);
 	struct ofono_error error;
+	unsigned int num_calls =3D 0;
 =

 	decode_at_error(&error, g_at_result_final_response(result));
 =

-	if (ok && req->affected_types) {
+	if (req->affected_types) {
 		GSList *l;
 		struct ofono_call *call;
 =

 		for (l =3D vd->calls; l; l =3D l->next) {
 			call =3D l->data;
 =

-			if (req->affected_types & (1 << call->status))
-				vd->local_release |=3D (1 << call->id);
+			if (req->affected_types & (1 << call->status)) {
+				if (ok)
+					vd->local_release |=3D (1 << call->id);
+				else
+					num_calls++;
+			}
 		}
 	}
 =

+	/* AG returned an error, but some calls are present, resync*/
+	if (num_calls)
+		g_at_chat_send(vd->chat, "AT+CLCC", clcc_prefix,
+					clcc_poll_cb, req->vc, NULL);
+
 	req->cb(&error, req->data);
 }
 =

-- =

1.7.11.7

Intel Deutschland GmbH
Registered Address: Am Campeon 10-12, 85579 Neubiberg, Germany
Tel: +49 89 99 8853-0, www.intel.de
Managing Directors: Christin Eisenschmid, Prof. Dr. Hermann Eul
Chairperson of the Supervisory Board: Tiffany Doon Silva
Registered Office: Munich
Commercial Register: Amtsgericht Muenchen HRB 186928


--===============0688953616222635592==--

