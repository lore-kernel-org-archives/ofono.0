Content-Type: multipart/mixed; boundary="===============6229741418203027055=="
MIME-Version: 1.0
From: Timo Mueller <mail@timomueller.eu>
Subject: [PATCHv3 1/3] hfpmodem: Retry AT+CLCC request after outgoing callsetup
Date: Wed, 13 Feb 2013 09:36:09 +0100
Message-ID: <da43e0125ebcdf570d287d3d84fbf139cc2bfa9e.1360663430.git.timo.mueller@bmw-carit.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6229741418203027055==
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
v3: Splitted clcc_poll_cb to avoid parsing of the clcc result twice
when a dialing call was found in the response.

 drivers/hfpmodem/voicecall.c | 45 +++++++++++++++++++++++++++++++++++++++-=
----
 1 file changed, 40 insertions(+), 5 deletions(-)

diff --git a/drivers/hfpmodem/voicecall.c b/drivers/hfpmodem/voicecall.c
index 33dd05e..9b05dbc 100644
--- a/drivers/hfpmodem/voicecall.c
+++ b/drivers/hfpmodem/voicecall.c
@@ -203,11 +203,10 @@ static void release_with_status(struct ofono_voicecal=
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
@@ -217,8 +216,6 @@ static void clcc_poll_cb(gboolean ok, GAtResult *result=
, gpointer user_data)
 	if (!ok)
 		return;
 =

-	calls =3D at_util_parse_clcc(result);
-
 	n =3D calls;
 	o =3D vd->calls;
 =

@@ -295,6 +292,43 @@ static void clcc_poll_cb(gboolean ok, GAtResult *resul=
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
@@ -977,7 +1011,8 @@ static void ciev_callsetup_notify(struct ofono_voiceca=
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


--===============6229741418203027055==--

