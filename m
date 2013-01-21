Content-Type: multipart/mixed; boundary="===============4945743806892529674=="
MIME-Version: 1.0
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
Subject: [PATCH v1 3/3] hfpmodem: Fix release-and-swap without +CIEV
Date: Mon, 21 Jan 2013 16:30:24 +0100
Message-ID: <1358782224-28632-4-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1358782224-28632-1-git-send-email-mikel.astiz.oss@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4945743806892529674==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Some phones do not send the corresponding call state update (+CIEV)
after a successful release-and-swap operation (AT+CHLD=3D1).

This has been observed with a Nokia 500, while testing ReleaseAndSwap()
while an active and a held call exist:

ofonod[20414]: > AT+CLCC\r
ofonod[20414]: < \r\n+CLCC: 1,0,1,0,0,"<number1>",145\r\n
ofonod[20414]: < \r\n+CLCC: 2,0,0,0,0,"<number2>",145\r\n
ofonod[20414]: < \r\nOK\r\n
ofonod[20414]: > AT+CHLD=3D1\r
ofonod[20414]: < \r\nOK\r\n

After this, no +CIEV is received, but the call has been hung up.

The proposed approach to solve this consists of using AT+CLCC, unless
a call release has been received within a specific time period.

The result fixes the problem as can be seen below:

ofonod[20847]: < \r\n+CLCC: 1,0,1,0,0,"<number1>",145\r\n
ofonod[20847]: < \r\n+CLCC: 2,0,0,0,0,"<number2>",145\r\n
ofonod[20847]: < \r\nOK\r\n
ofonod[20847]: > AT+CHLD=3D1\r
ofonod[20847]: < \r\nOK\r\n
ofonod[20847]: > AT+CLCC\r
ofonod[20847]: < \r\n+CLCC: 1,0,0,0,0,"<number1>",145\r\n
ofonod[20847]: < \r\nOK\r\n
ofonod[20847]: < \r\n+CIEV: 5,2\r\n
ofonod[20847]: < \r\n+CIEV: 5,0\r\n
---
 drivers/hfpmodem/voicecall.c | 46 ++++++++++++++++++++++++++++++++++++++++=
+++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/drivers/hfpmodem/voicecall.c b/drivers/hfpmodem/voicecall.c
index e0da3fc..39d81f1 100644
--- a/drivers/hfpmodem/voicecall.c
+++ b/drivers/hfpmodem/voicecall.c
@@ -43,6 +43,7 @@
 =

 #define POLL_CLCC_INTERVAL 2000
 #define POLL_CLCC_DELAY 50
+#define EXPECT_RELEASE_DELAY 50
 #define CLIP_TIMEOUT 500
 =

 static const char *none_prefix[] =3D { NULL };
@@ -57,6 +58,7 @@ struct voicecall_data {
 	int cind_val[HFP_INDICATOR_LAST];
 	unsigned int local_release;
 	unsigned int clcc_source;
+	unsigned int expect_release_source;
 	unsigned int clip_source;
 };
 =

@@ -194,6 +196,11 @@ static void release_with_status(struct ofono_voicecall=
 *vc, int status)
 		c =3D c->next;
 		g_slist_free_1(t);
 	}
+
+	if (vd->expect_release_source) {
+		g_source_remove(vd->expect_release_source);
+		vd->expect_release_source =3D 0;
+	}
 }
 =

 static void clcc_poll_cb(gboolean ok, GAtResult *result, gpointer user_dat=
a)
@@ -471,13 +478,47 @@ static void hfp_set_udub(struct ofono_voicecall *vc,
 	CALLBACK_WITH_FAILURE(cb, data);
 }
 =

+static gboolean expect_release(gpointer user_data)
+{
+	struct ofono_voicecall *vc =3D user_data;
+	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
+
+	g_at_chat_send(vd->chat, "AT+CLCC", clcc_prefix,
+				clcc_poll_cb, vc, NULL);
+
+	vd->expect_release_source =3D 0;
+
+	return FALSE;
+}
+
+static void release_all_active_cb(gboolean ok, GAtResult *result,
+							gpointer user_data)
+{
+	struct change_state_req *req =3D user_data;
+	struct voicecall_data *vd =3D ofono_voicecall_get_data(req->vc);
+
+	if (!ok)
+		goto out;
+
+	if (vd->expect_release_source)
+		g_source_remove(vd->expect_release_source);
+
+	vd->expect_release_source =3D g_timeout_add(EXPECT_RELEASE_DELAY,
+							expect_release,
+							req->vc);
+
+out:
+	generic_cb(ok, result, user_data);
+}
+
 static void hfp_release_all_active(struct ofono_voicecall *vc,
 					ofono_voicecall_cb_t cb, void *data)
 {
 	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
 =

 	if (vd->ag_mpty_features & AG_CHLD_1) {
-		hfp_template("AT+CHLD=3D1", vc, generic_cb, 0x1, cb, data);
+		hfp_template("AT+CHLD=3D1", vc, release_all_active_cb, 0x1, cb,
+									data);
 		return;
 	}
 =

@@ -1111,6 +1152,9 @@ static void hfp_voicecall_remove(struct ofono_voiceca=
ll *vc)
 	if (vd->clip_source)
 		g_source_remove(vd->clip_source);
 =

+	if (vd->expect_release_source)
+		g_source_remove(vd->expect_release_source);
+
 	g_slist_foreach(vd->calls, (GFunc) g_free, NULL);
 	g_slist_free(vd->calls);
 =

-- =

1.7.11.7


--===============4945743806892529674==--

