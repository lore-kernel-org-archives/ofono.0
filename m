Content-Type: multipart/mixed; boundary="===============6194897135770830787=="
MIME-Version: 1.0
From: Kalle Valo <kalle.valo@canonical.com>
Subject: [PATCH 2/2] atmodem: timeout for gprs context deactivation
Date: Tue, 25 May 2010 14:39:08 +0300
Message-ID: <20100525113908.6786.72506.stgit@potku.valot.fi>
In-Reply-To: <20100525113901.6786.73777.stgit@potku.valot.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6194897135770830787==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Huawei modems have an annoying feature to hangup the chat line
after ppp shutdown. Basically what happens is this:

14:15:08 ofonod[11768]: > AT+CGACT=3D0,1\r
14:15:09 ofonod[11768]: EventChannel: < \r\n^BOOT:38645652,0,0,0,87\r\n
14:15:10 ofonod[11768]: EventChannel: < \r\n^RSSI:22\r\n

ofono sends AT+CGACT to the modem but does not get any reply and will
wait forever.

Workaround the issue by adding a five second timeout for the CGACT command.
This makes it possible to properly use huawei modems with connman. Without
this patch you can connect only once from connman and then you have to
restart connman.
---

 drivers/atmodem/gprs-context.c |   35 +++++++++++++++++++++++++++++++++++
 1 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/drivers/atmodem/gprs-context.c b/drivers/atmodem/gprs-context.c
index 4412a07..82e923e 100644
--- a/drivers/atmodem/gprs-context.c
+++ b/drivers/atmodem/gprs-context.c
@@ -63,8 +63,31 @@ struct gprs_context_data {
 		ofono_gprs_context_up_cb_t up_cb;       /* Up callback */
 	};
 	void *cb_data;                                  /* Callback data */
+	gint cgact_timeout;
 };
 =

+static gboolean cgact_timeout(gpointer user_data)
+{
+	struct cb_data *cbd =3D user_data;
+	ofono_gprs_context_cb_t cb =3D cbd->cb;
+	struct ofono_gprs_context *gc =3D cbd->user;
+	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
+	struct ofono_error error;
+
+	DBG("");
+
+	gcd->cgact_timeout =3D 0;
+
+	error.type =3D OFONO_ERROR_TYPE_NO_ERROR;
+	error.error =3D 0;
+
+	cb(&error, cbd->data);
+
+	g_free(cbd);
+
+	return FALSE;
+}
+
 static void at_cgact_down_cb(gboolean ok, GAtResult *result, gpointer user=
_data)
 {
 	struct cb_data *cbd =3D user_data;
@@ -73,6 +96,13 @@ static void at_cgact_down_cb(gboolean ok, GAtResult *res=
ult, gpointer user_data)
 	struct gprs_context_data *gcd =3D ofono_gprs_context_get_data(gc);
 	struct ofono_error error;
 =

+	if (gcd->cgact_timeout =3D=3D 0)
+		/* already timed out */
+		return;
+
+	g_source_remove(gcd->cgact_timeout);
+	gcd->cgact_timeout =3D 0;
+
 	if (ok)
 		gcd->active_context =3D 0;
 =

@@ -136,6 +166,11 @@ static void ppp_disconnect(GAtPPPDisconnectReason reas=
on, gpointer user_data)
 			g_free(cbd);
 			goto out;
 		}
+
+		/* workaround for huawei hangup problem */
+		gcd->cgact_timeout =3D g_timeout_add_seconds(5, cgact_timeout,
+							cbd);
+
 	} else {
 		ofono_gprs_context_deactivated(gc, gcd->active_context);
 	}


--===============6194897135770830787==--

