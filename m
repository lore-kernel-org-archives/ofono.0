Content-Type: multipart/mixed; boundary="===============7423891758644872282=="
MIME-Version: 1.0
From: Timo Mueller <mail@timomueller.eu>
Subject: [PATCHv4 8/8] hfpmodem: Add N9 quirk for callheld=<2 or 3>
Date: Thu, 28 Mar 2013 14:37:02 +0100
Message-ID: <0f058f192821a59a06cbbc072a8402c5717bd50a.1364477353.git.timo.mueller@bmw-carit.de>
In-Reply-To: <cf8ae4ef10e97e7eb75e3e15c3be88329451ba6b.1364477353.git.timo.mueller@bmw-carit.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7423891758644872282==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Timo Mueller <timo.mueller@bmw-carit.de>

On the Nokia N9 with a call being active, placing a second call on the
AG device will lead to the active call being put on hold. During the
transition the phone does not update the list of current calls. This
leads to an +CLCC response that does not contain the new outgoing
call, even though an outgoing callsetup was reported.

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
 drivers/hfpmodem/voicecall.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/hfpmodem/voicecall.c b/drivers/hfpmodem/voicecall.c
index 6f1434d..79dfce4 100644
--- a/drivers/hfpmodem/voicecall.c
+++ b/drivers/hfpmodem/voicecall.c
@@ -1063,8 +1063,10 @@ static void ciev_callheld_notify(struct ofono_voicec=
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
@@ -1100,6 +1102,16 @@ static void ciev_callheld_notify(struct ofono_voicec=
all *vc,
 				call->status =3D CALL_STATUS_HELD;
 				ofono_voicecall_notify(vc, call);
 			}
+
+			if (needs_callheld_clcc_quirk(vd->vendor)) {
+				if (callsetup =3D=3D 2 || callsetup =3D=3D 3) {
+					dialing =3D find_dialing(vd->calls);
+
+					if (dialing =3D=3D NULL)
+						g_at_chat_send(vd->chat, "AT+CLCC", clcc_prefix,
+								clcc_poll_cb, vc, NULL);
+				}
+			}
 		} else if (callheld =3D=3D 1) {
 			if (vd->clcc_source)
 				g_source_remove(vd->clcc_source);
-- =

1.7.11.7


--===============7423891758644872282==--

