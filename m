Content-Type: multipart/mixed; boundary="===============0358329188388870810=="
MIME-Version: 1.0
From: Timo Mueller <mail@timomueller.eu>
Subject: [PATCHv2 1/2] hfpmodem: Retry AT+CLCC request after outgoing callsetup
Date: Mon, 28 Jan 2013 11:13:16 +0100
Message-ID: <07c8015b845d8b1a310dc9f33397cda7dd42e4a2.1359360111.git.timo.mueller@bmw-carit.de>
In-Reply-To: <cover.1359360111.git.timo.mueller@bmw-carit.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0358329188388870810==
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
v2: Request CLCC immediately and schedule a second request if the
call was not found in the response. Recheck CLCC when callheld=3D2 was
received after a callsetup=3D<2 or 3>.

 drivers/hfpmodem/voicecall.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/hfpmodem/voicecall.c b/drivers/hfpmodem/voicecall.c
index 33dd05e..18ed54a 100644
--- a/drivers/hfpmodem/voicecall.c
+++ b/drivers/hfpmodem/voicecall.c
@@ -295,6 +295,31 @@ static void clcc_poll_cb(gboolean ok, GAtResult *resul=
t, gpointer user_data)
 							vc);
 }
 =

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
+	clcc_poll_cb(ok, result, user_data);
+}
+
 static gboolean poll_clcc(gpointer user_data)
 {
 	struct ofono_voicecall *vc =3D user_data;
@@ -977,7 +1002,8 @@ static void ciev_callsetup_notify(struct ofono_voiceca=
ll *vc,
 		 * from AG: query and create call.
 		 */
 		g_at_chat_send(vd->chat, "AT+CLCC", clcc_prefix,
-				clcc_poll_cb, vc, NULL);
+				clcc_poll_dialing_cb, vc, NULL);
+
 		break;
 =

 	case 3:
-- =

1.7.11.7


--===============0358329188388870810==--

