Content-Type: multipart/mixed; boundary="===============0653471028204937015=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH 2/4] PPP:Add new function definitions for using resume callback
Date: Wed, 23 Feb 2011 16:29:24 +0100
Message-ID: <1298474966-1691-3-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0653471028204937015==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gathdlc.c |   40 ++++++++++++++++++++++++++++++++++++++++
 gatchat/gatppp.c  |   14 +++++++++++++-
 2 files changed, 53 insertions(+), 1 deletions(-)

diff --git a/gatchat/gathdlc.c b/gatchat/gathdlc.c
index dd11043..62d08f4 100644
--- a/gatchat/gathdlc.c
+++ b/gatchat/gathdlc.c
@@ -65,6 +65,9 @@ struct _GAtHDLC {
 	int record_fd;
 	gboolean in_read_handler;
 	gboolean destroyed;
+	gboolean ppp_need_disconnect;
+	GAtResumeFunc resume_func;
+	gpointer resume_data;
 };
 =

 static void hdlc_record(int fd, gboolean in, guint8 *data, guint16 length)
@@ -222,6 +225,8 @@ GAtHDLC *g_at_hdlc_new_from_io(GAtIO *io)
 =

 	hdlc->record_fd =3D -1;
 =

+	hdlc->ppp_need_disconnect =3D FALSE;
+
 	hdlc->io =3D g_at_io_ref(io);
 	g_at_io_set_read_handler(hdlc->io, new_bytes, hdlc);
 =

@@ -308,6 +313,16 @@ void g_at_hdlc_set_receive(GAtHDLC *hdlc, GAtReceiveFu=
nc func,
 	hdlc->receive_data =3D user_data;
 }
 =

+void g_at_hdlc_set_resume(GAtHDLC *hdlc, GAtResumeFunc func,
+							gpointer user_data)
+{
+	if (hdlc =3D=3D NULL)
+		return;
+
+	hdlc->resume_func =3D func;
+	hdlc->resume_data =3D user_data;
+}
+
 static gboolean can_write_data(gpointer data)
 {
 	GAtHDLC *hdlc =3D data;
@@ -325,6 +340,12 @@ static gboolean can_write_data(gpointer data)
 	if (ring_buffer_len(hdlc->write_buffer) > 0)
 		return TRUE;
 =

+	if (hdlc->ppp_need_disconnect) {
+		if (hdlc->resume_func)
+			hdlc->resume_func(hdlc->resume_data);
+		g_at_hdlc_unref(hdlc);
+	}
+
 	return FALSE;
 }
 =

@@ -352,6 +373,25 @@ GAtIO *g_at_hdlc_get_io(GAtHDLC *hdlc)
 	return hdlc->io;
 }
 =

+gboolean g_at_hdlc_need_write_data(GAtHDLC *hdlc)
+{
+	if (hdlc =3D=3D NULL)
+		return FALSE;
+
+	if (ring_buffer_len_no_wrap(hdlc->write_buffer) > 0)
+		return TRUE;
+	else
+		return FALSE;
+}
+
+void g_at_hdlc_notify_ppp_disc(GAtHDLC *hdlc)
+{
+	if (hdlc =3D=3D NULL)
+		return;
+
+	hdlc->ppp_need_disconnect =3D TRUE;
+}
+
 #define NEED_ESCAPE(xmit_accm, c) xmit_accm[c >> 5] & (1 << (c & 0x1f))
 =

 gboolean g_at_hdlc_send(GAtHDLC *hdlc, const unsigned char *data, gsize si=
ze)
diff --git a/gatchat/gatppp.c b/gatchat/gatppp.c
index bbd8ab1..169885c 100644
--- a/gatchat/gatppp.c
+++ b/gatchat/gatppp.c
@@ -428,6 +428,15 @@ void g_at_ppp_set_debug(GAtPPP *ppp, GAtDebugFunc func=
, gpointer user_data)
 	ppp->debug_data =3D user_data;
 }
 =

+void g_at_ppp_set_resume_function(GAtPPP *ppp, GAtResumeFunc func, gpointe=
r user_data)
+{
+	if (ppp =3D=3D NULL)
+		return;
+
+	g_at_hdlc_set_resume(ppp->hdlc, func, user_data);
+}
+
+
 void g_at_ppp_shutdown(GAtPPP *ppp)
 {
 	if (ppp->phase =3D=3D PPP_PHASE_DEAD || ppp->phase =3D=3D PPP_PHASE_TERMI=
NATION)
@@ -466,7 +475,10 @@ void g_at_ppp_unref(GAtPPP *ppp)
 	lcp_free(ppp->lcp);
 	ipcp_free(ppp->ipcp);
 =

-	g_at_hdlc_unref(ppp->hdlc);
+	if (g_at_hdlc_need_write_data(ppp->hdlc))
+		g_at_hdlc_notify_ppp_disc(ppp->hdlc);
+	else
+		g_at_hdlc_unref(ppp->hdlc);
 =

 	g_free(ppp);
 }
-- =

1.7.1


--===============0653471028204937015==--

