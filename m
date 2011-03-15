Content-Type: multipart/mixed; boundary="===============1705096035295085603=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH 3/6] gathdlc: add mechanism to detect ppp suspension from DUN
 client.
Date: Tue, 15 Mar 2011 10:19:00 +0100
Message-ID: <1300180743-27624-4-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1705096035295085603==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gathdlc.c |   58 +++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 58 insertions(+), 0 deletions(-)

diff --git a/gatchat/gathdlc.c b/gatchat/gathdlc.c
index 6c39e6c..38606b8 100644
--- a/gatchat/gathdlc.c
+++ b/gatchat/gathdlc.c
@@ -66,6 +66,10 @@ struct _GAtHDLC {
 	gboolean in_read_handler;
 	gboolean destroyed;
 	gboolean no_carrier_detect;
+	GAtSuspendFunc suspend_func;
+	gpointer suspend_data;
+	guint cmpt;
+	guint suspend_timeout;
 };
 =

 static void hdlc_record(int fd, gboolean in, guint8 *data, guint16 length)
@@ -128,6 +132,34 @@ guint32 g_at_hdlc_get_recv_accm(GAtHDLC *hdlc)
 	return hdlc->recv_accm;
 }
 =

+void g_at_hdlc_set_suspend_function(GAtHDLC *hdlc, GAtSuspendFunc func,
+							gpointer user_data)
+{
+	if (hdlc =3D=3D NULL)
+		return;
+
+	hdlc->suspend_func =3D func;
+	hdlc->suspend_data =3D user_data;
+}
+
+static gboolean susp_timeout_cb(gpointer user_data)
+{
+	GAtHDLC *hdlc =3D user_data;
+
+	hdlc->cmpt =3D 0;
+
+	return FALSE;
+}
+
+static void hdlc_suspend(GAtHDLC *hdlc)
+{
+	g_at_io_set_write_handler(hdlc->io, NULL, NULL);
+	g_at_io_set_read_handler(hdlc->io, NULL, NULL);
+
+	if (hdlc->suspend_func)
+		hdlc->suspend_func(hdlc->suspend_data);
+}
+
 static void new_bytes(struct ring_buffer *rbuf, gpointer user_data)
 {
 	GAtHDLC *hdlc =3D user_data;
@@ -151,6 +183,21 @@ static void new_bytes(struct ring_buffer *rbuf, gpoint=
er user_data)
 				hdlc->decode_offset =3D=3D 0 && *buf =3D=3D '\r')
 			break;
 =

+		/* We detect the '+' character to suspend data call if
+		 * 3 '+' are detected in less than 500 milliseconds
+		 */
+		if (*buf =3D=3D '+') {
+			if (hdlc->cmpt =3D=3D 0)
+				hdlc->suspend_timeout =3D g_timeout_add (500,
+							susp_timeout_cb, hdlc);
+			hdlc->cmpt++;
+			if (hdlc->cmpt =3D=3D 3)
+				goto suspend;
+		}
+		else {
+			hdlc->cmpt =3D 0;
+		}
+
 		if (hdlc->decode_escape =3D=3D TRUE) {
 			unsigned char val =3D *buf ^ HDLC_TRANS;
 =

@@ -195,6 +242,15 @@ out:
 =

 	if (hdlc->destroyed)
 		g_free(hdlc);
+
+	return;
+
+suspend:
+	g_source_remove(hdlc->suspend_timeout);
+
+	ring_buffer_reset(rbuf);
+
+	hdlc_suspend(hdlc);
 }
 =

 GAtHDLC *g_at_hdlc_new_from_io(GAtIO *io)
@@ -236,6 +292,8 @@ GAtHDLC *g_at_hdlc_new_from_io(GAtIO *io)
 	hdlc->io =3D g_at_io_ref(io);
 	g_at_io_set_read_handler(hdlc->io, new_bytes, hdlc);
 =

+	hdlc->cmpt =3D 0;
+
 	return hdlc;
 =

 error:
-- =

1.7.1


--===============1705096035295085603==--

