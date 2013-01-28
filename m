Content-Type: multipart/mixed; boundary="===============6675069882913694045=="
MIME-Version: 1.0
From: Timo Mueller <mail@timomueller.eu>
Subject: [PATCHv2 2/2] hfpmodem: Request AT+CLCC again after callheld=<2 or 3>
Date: Mon, 28 Jan 2013 11:13:17 +0100
Message-ID: <70cf00e077ef3e1dff65de3f6fcb5df7c754734f.1359360111.git.timo.mueller@bmw-carit.de>
In-Reply-To: <07c8015b845d8b1a310dc9f33397cda7dd42e4a2.1359360111.git.timo.mueller@bmw-carit.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6675069882913694045==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Timo Mueller <timo.mueller@bmw-carit.de>

With a call being active, placing a second call on the AG device will
lead to the active call being put on hold. During the transition some
phones do not update the list of current calls. This leads to an +CLCC
response that does not contain the new outgoing call, even though an
outgoing callsetup was reported.

The list will be updated once the active call was put on hold and
callheld=3D2 is reported. In this case the list has to be requested
again (AT+CLCC).

AT sequence that exhibited the failure (AG device was a Nokia N9
having an active outgoing call and placing a second outgoing call)

< \r\n+CIEV: 5,2\r\n
> AT+CLCC\r
< \r\n+CLCC: 1,0,0,0,0,"+49xxx1",145\r\n
< \r\nOK\r\n
< \r\n+CIEV: 6,2\r\n
< \r\n+CIEV: 5,3\r\n
< \r\n+CIEV: 6,1\r\n
> AT+CLCC\r
< \r\n+CIEV: 5,0\r\n
< \r\n+CLCC: 1,0,1,0,0,"+49xxx1",145\r\n
< \r\n+CLCC: 2,0,0,0,0,"+49xxx2",145\r\n
< \r\nOK\r\n
---
 drivers/hfpmodem/voicecall.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/hfpmodem/voicecall.c b/drivers/hfpmodem/voicecall.c
index 18ed54a..482b325 100644
--- a/drivers/hfpmodem/voicecall.c
+++ b/drivers/hfpmodem/voicecall.c
@@ -1035,8 +1035,10 @@ static void ciev_callheld_notify(struct ofono_voicec=
all *vc,
 {
 	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
 	GSList *l;
+	GSList *dialing;
 	struct ofono_call *call;
 	unsigned int callheld =3D vd->cind_val[HFP_INDICATOR_CALLHELD];
+	unsigned int callsetup =3D vd->cind_val[HFP_INDICATOR_CALLSETUP];
 =

 	switch (value) {
 	case 0:
@@ -1072,6 +1074,14 @@ static void ciev_callheld_notify(struct ofono_voicec=
all *vc,
 				call->status =3D CALL_STATUS_HELD;
 				ofono_voicecall_notify(vc, call);
 			}
+
+			if (callsetup =3D=3D 2 || callsetup =3D=3D 3) {
+				dialing =3D find_dialing(vd->calls);
+
+				if (dialing =3D=3D NULL)
+					g_at_chat_send(vd->chat, "AT+CLCC", clcc_prefix,
+						clcc_poll_cb, vc, NULL);
+			}
 		} else if (callheld =3D=3D 1) {
 			if (vd->clcc_source)
 				g_source_remove(vd->clcc_source);
-- =

1.7.11.7


--===============6675069882913694045==--

