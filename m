Content-Type: multipart/mixed; boundary="===============3319105188384883583=="
MIME-Version: 1.0
From: Mike Brudevold <puffy.taco@gmail.com>
Subject: [PATCH] hfpmodem: use full CLCC handling in dialing case
Date: Wed, 11 Apr 2012 14:36:38 -0500
Message-ID: <1334172998-3969-1-git-send-email-puffy.taco@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3319105188384883583==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Michael Brudevold <michael.brudevold@logicpd.com>

A call that moves from the dialing to active state before the +CLCC response
will not properly be added as a voicecall. This is because the dialing call=
back
was using simplified handling and only looked for calls in the dialing or
alerting state.

AT sequence that exhibited the failure (AG device was an iPhone accessing
visual voicemail):

> +CIND: ("service",(0-1)),("call",(0-1)),("callsetup",(0-3)),
("battchg",(0-5)),("signal",(0-5)),("roam",(0-1)),("callheld",(0-2))
...
> +CIEV: 3,2
< AT+CLCC
> +CIEV: 2,1
> +CIEV: 3,0
> +CLCC: 1,0,0,0,0,"**21153**",129,"Voicemail"
---
 drivers/hfpmodem/voicecall.c |   68 +-------------------------------------=
----
 1 files changed, 1 insertions(+), 67 deletions(-)

diff --git a/drivers/hfpmodem/voicecall.c b/drivers/hfpmodem/voicecall.c
index bcf4292..505601c 100644
--- a/drivers/hfpmodem/voicecall.c
+++ b/drivers/hfpmodem/voicecall.c
@@ -123,19 +123,6 @@ static struct ofono_call *create_call(struct ofono_voi=
cecall *vc, int type,
 	return call;
 }
 =

-static struct ofono_call *new_call_notify(struct ofono_voicecall *vc, int =
type,
-					int direction, int status,
-					const char *num, int num_type, int clip)
-{
-	struct ofono_call *c;
-
-	c =3D create_call(vc, type, direction, status, num, num_type, clip);
-
-	ofono_voicecall_notify(vc, c);
-
-	return c;
-}
-
 static void release_call(struct ofono_voicecall *vc, struct ofono_call *ca=
ll)
 {
 	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
@@ -849,59 +836,6 @@ static void ciev_call_notify(struct ofono_voicecall *v=
c,
 	vd->cind_val[HFP_INDICATOR_CALL] =3D value;
 }
 =

-static void sync_dialing_cb(gboolean ok, GAtResult *result, gpointer user_=
data)
-{
-	struct ofono_voicecall *vc =3D user_data;
-	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
-	struct ofono_error error;
-	GSList *calls;
-	GSList *o;
-	GSList *n;
-	struct ofono_call *oc;
-	struct ofono_call *nc;
-
-	decode_at_error(&error, g_at_result_final_response(result));
-
-	if (!ok)
-		return;
-
-	calls =3D at_util_parse_clcc(result);
-
-	if (calls =3D=3D NULL)
-		return;
-
-	/* Look for dialing or alerting calls on the new list */
-	n =3D find_dialing(calls);
-
-	/* Let us find if we have done the dial from HF by looking for
-	 * existing dialing or alerting calls
-	 */
-	o =3D find_dialing(vd->calls);
-
-	if (n =3D=3D NULL && o) {
-		oc =3D o->data;
-		release_call(vc, oc);
-		vd->calls =3D g_slist_remove(vd->calls, oc);
-	} else if (n && o =3D=3D NULL) {
-		nc =3D n->data;
-		new_call_notify(vc, nc->type, nc->direction, nc->status,
-				nc->phone_number.number, nc->phone_number.type,
-				nc->clip_validity);
-	} else if (n && o) {
-		oc =3D o->data;
-		nc =3D n->data;
-
-		memcpy(&oc->phone_number, &nc->phone_number,
-				sizeof(struct ofono_phone_number));
-		oc->status =3D nc->status;
-		oc->clip_validity =3D nc->clip_validity;
-		ofono_voicecall_notify(vc, oc);
-	}
-
-	g_slist_foreach(calls, (GFunc) g_free, NULL);
-	g_slist_free(calls);
-}
-
 static void ciev_callsetup_notify(struct ofono_voicecall *vc,
 					unsigned int value)
 {
@@ -979,7 +913,7 @@ static void ciev_callsetup_notify(struct ofono_voicecal=
l *vc,
 		 * from AG: query and create call.
 		 */
 		g_at_chat_send(vd->chat, "AT+CLCC", clcc_prefix,
-				sync_dialing_cb, vc, NULL);
+				clcc_poll_cb, vc, NULL);
 		break;
 =

 	case 3:
-- =

1.7.5.4


--===============3319105188384883583==--

