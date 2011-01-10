Content-Type: multipart/mixed; boundary="===============1404731567195480952=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [RFC 4/5] ifxmodem: Add support for tty call notifications
Date: Mon, 10 Jan 2011 16:01:31 +0200
Message-ID: <1294668092-27896-5-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1294668092-27896-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1404731567195480952==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/ifxmodem/voicecall.c |   36 +++++++++++++++++++++++++++++++-----
 1 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/drivers/ifxmodem/voicecall.c b/drivers/ifxmodem/voicecall.c
index d43e6f9..7401337 100644
--- a/drivers/ifxmodem/voicecall.c
+++ b/drivers/ifxmodem/voicecall.c
@@ -81,7 +81,8 @@ static int class_to_call_type(int cls)
 =

 static struct ofono_call *create_call(struct ofono_voicecall *vc, int type,
 					int direction, int status,
-					const char *num, int num_type, int clip)
+					const char *num, int num_type, int clip,
+					gboolean tty)
 {
 	struct voicecall_data *d =3D ofono_voicecall_get_data(vc);
 	struct ofono_call *call;
@@ -95,6 +96,7 @@ static struct ofono_call *create_call(struct ofono_voicec=
all *vc, int type,
 	call->type =3D type;
 	call->direction =3D direction;
 	call->status =3D status;
+	call->tty =3D tty;
 =

 	if (clip !=3D 2) {
 		strncpy(call->phone_number.number, num,
@@ -280,7 +282,7 @@ static void atd_cb(gboolean ok, GAtResult *result, gpoi=
nter user_data)
 	}
 =

 	/* Generate a voice call that was just dialed, we guess the ID */
-	call =3D create_call(vc, 0, 0, 2, num, type, validity);
+	call =3D create_call(vc, 0, 0, 2, num, type, validity, FALSE);
 	if (call =3D=3D NULL) {
 		ofono_error("Unable to malloc, call tracking will fail!");
 		return;
@@ -546,6 +548,7 @@ static void cring_notify(GAtResult *result, gpointer us=
er_data)
 	GAtResultIter iter;
 	const char *line;
 	int type;
+	gboolean tty =3D FALSE;
 =

 	/* Handle the following situation:
 	 * Active Call + Waiting Call.  Active Call is Released.  The Waiting
@@ -575,11 +578,14 @@ static void cring_notify(GAtResult *result, gpointer =
user_data)
 	/* Ignore everything that is not voice for now */
 	if (!strcasecmp(line, "VOICE"))
 		type =3D 0;
-	else
+	else if (!strcasecmp(line, "CTM")) {
+		type =3D 0;
+		tty =3D TRUE;
+	} else
 		type =3D 9;
 =

 	/* Generate an incoming call */
-	create_call(vc, type, 1, 4, NULL, 128, 2);
+	create_call(vc, type, 1, 4, NULL, 128, 2, tty);
 =

 	/* Assume the CLIP always arrives, and we signal the call there */
 	DBG("cring_notify");
@@ -682,7 +688,7 @@ static void ccwa_notify(GAtResult *result, gpointer use=
r_data)
 	DBG("ccwa_notify: %s %d %d %d", num, num_type, cls, validity);
 =

 	call =3D create_call(vc, class_to_call_type(cls), 1, 5,
-				num, num_type, validity);
+				num, num_type, validity, FALSE);
 	if (call =3D=3D NULL) {
 		ofono_error("Unable to malloc. Call management is fubar");
 		return;
@@ -692,6 +698,25 @@ static void ccwa_notify(GAtResult *result, gpointer us=
er_data)
 		ofono_voicecall_notify(vc, call);
 }
 =

+static void ctm_notify(GAtResult *result, gpointer user_data)
+{
+	struct ofono_voicecall *vc =3D user_data;
+	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
+	GSList *l;
+	struct ofono_call *call;
+
+	l =3D g_slist_find_custom(vd->calls, GINT_TO_POINTER(0),
+				at_util_call_compare_by_status);
+	if (l =3D=3D NULL) {
+		ofono_error("CTM for unknown call");
+		return;
+	}
+
+	call =3D l->data;
+
+	ofono_voicecall_tty_notify(vc, call);
+}
+
 static void ifx_voicecall_initialized(gboolean ok, GAtResult *result,
 					gpointer user_data)
 {
@@ -706,6 +731,7 @@ static void ifx_voicecall_initialized(gboolean ok, GAtR=
esult *result,
 	g_at_chat_register(vd->chat, "+XEM:", xem_notify, FALSE, vc, NULL);
 	g_at_chat_register(vd->chat, "+XCALLSTAT:", xcallstat_notify,
 							FALSE, vc, NULL);
+	g_at_chat_register(vd->chat, "CTM CALL", ctm_notify, FALSE, vc, NULL);
 =

 	ofono_voicecall_register(vc);
 }
-- =

1.7.0.4


--===============1404731567195480952==--

