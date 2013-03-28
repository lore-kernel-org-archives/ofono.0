Content-Type: multipart/mixed; boundary="===============5439764741557206674=="
MIME-Version: 1.0
From: Timo Mueller <mail@timomueller.eu>
Subject: [PATCHv4 7/8] hfpmodem: Add N9 quirk for outgoing callsetup
Date: Thu, 28 Mar 2013 14:37:01 +0100
Message-ID: <cf8ae4ef10e97e7eb75e3e15c3be88329451ba6b.1364477353.git.timo.mueller@bmw-carit.de>
In-Reply-To: <8187c3fa8bc9ae2be0bfb06b3d8a5641afa27862.1364477353.git.timo.mueller@bmw-carit.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5439764741557206674==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Timo Mueller <timo.mueller@bmw-carit.de>

Currently the list of current calls is requested right after an
outgoing callsetup has been reported by the AG device. If the AG
device updates the list after reporting the callsetup the +CLCC
response may not contain the new call and it is not registered
with oFono.

In this case AT+CLCC should be requested again once after a small
delay.

AT sequence that exhibited the failure (AG device was a Nokia N9
placing an outgoing call)

< \r\n+CIEV: 5,2\r\n
> AT+CLCC\r
< \r\nOK\r\n
< \r\n+VGS=3D7\r\n
< \r\n+VGM=3D7\r\n
< \r\n+CIEV: 5,3\r\n
< \r\n+CIEV: 4,1\r\n
< \r\n+CIEV: 5,0\r\n
---
 drivers/hfpmodem/voicecall.c | 50 +++++++++++++++++++++++++++++++++++++++-=
----
 1 file changed, 45 insertions(+), 5 deletions(-)

diff --git a/drivers/hfpmodem/voicecall.c b/drivers/hfpmodem/voicecall.c
index b7a9ec5..6f1434d 100644
--- a/drivers/hfpmodem/voicecall.c
+++ b/drivers/hfpmodem/voicecall.c
@@ -217,11 +217,10 @@ static void release_with_status(struct ofono_voicecal=
l *vc, int status)
 	}
 }
 =

-static void clcc_poll_cb(gboolean ok, GAtResult *result, gpointer user_dat=
a)
+static void handle_clcc_response(gboolean ok, GSList *calls, gpointer user=
_data)
 {
 	struct ofono_voicecall *vc =3D user_data;
 	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
-	GSList *calls;
 	GSList *n, *o;
 	struct ofono_call *nc, *oc;
 	unsigned int num_active =3D 0;
@@ -231,8 +230,6 @@ static void clcc_poll_cb(gboolean ok, GAtResult *result=
, gpointer user_data)
 	if (!ok)
 		return;
 =

-	calls =3D at_util_parse_clcc(result);
-
 	n =3D calls;
 	o =3D vd->calls;
 =

@@ -309,6 +306,43 @@ static void clcc_poll_cb(gboolean ok, GAtResult *resul=
t, gpointer user_data)
 							vc);
 }
 =

+static void clcc_poll_cb(gboolean ok, GAtResult *result, gpointer user_dat=
a)
+{
+	GSList *calls;
+
+	if (!ok)
+		return;
+
+	calls =3D at_util_parse_clcc(result);
+
+	handle_clcc_response(ok, calls, user_data);
+}
+
+static void clcc_poll_dialing_cb(gboolean ok, GAtResult *result,
+			gpointer user_data)
+{
+	struct ofono_voicecall *vc =3D user_data;
+	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
+	GSList *calls, *dialing;
+
+	if (!ok)
+		return;
+
+	calls =3D at_util_parse_clcc(result);
+	dialing =3D find_dialing(calls);
+
+	if (dialing =3D=3D NULL) {
+		if (vd->clcc_source)
+			g_source_remove(vd->clcc_source);
+
+		vd->clcc_source =3D g_timeout_add(POLL_CLCC_DELAY,
+												poll_clcc, vc);
+		return;
+	}
+
+	handle_clcc_response(ok, calls, user_data);
+}
+
 static gboolean poll_clcc(gpointer user_data)
 {
 	struct ofono_voicecall *vc =3D user_data;
@@ -990,8 +1024,14 @@ static void ciev_callsetup_notify(struct ofono_voicec=
all *vc,
 		 * from HF: query and sync the phone number.
 		 * from AG: query and create call.
 		 */
-		g_at_chat_send(vd->chat, "AT+CLCC", clcc_prefix,
+		if (needs_callheld_clcc_quirk(vd->vendor)) {
+			g_at_chat_send(vd->chat, "AT+CLCC", clcc_prefix,
+				clcc_poll_dialing_cb, vc, NULL);
+		} else {
+			g_at_chat_send(vd->chat, "AT+CLCC", clcc_prefix,
 				clcc_poll_cb, vc, NULL);
+		}
+
 		break;
 =

 	case 3:
-- =

1.7.11.7


--===============5439764741557206674==--

