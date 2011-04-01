Content-Type: multipart/mixed; boundary="===============0096235678970376721=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH v3 05/26] gathdlc: add mechansim to detect '+++' escape
 sequence
Date: Fri, 01 Apr 2011 10:56:07 +0200
Message-ID: <1301648188-7208-6-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1301648188-7208-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0096235678970376721==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gathdlc.c |   92 +++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 92 insertions(+), 0 deletions(-)

diff --git a/gatchat/gathdlc.c b/gatchat/gathdlc.c
index 7c45454..db4ad5a 100644
--- a/gatchat/gathdlc.c
+++ b/gatchat/gathdlc.c
@@ -50,6 +50,8 @@
 =

 #define HDLC_FCS(fcs, c) crc_ccitt_byte(fcs, c)
 =

+#define GUARD_TIMEOUTS	1000	/* Pause time before and after '+++' sequence =
*/
+
 struct _GAtHDLC {
 	gint ref_count;
 	GAtIO *io;
@@ -68,6 +70,11 @@ struct _GAtHDLC {
 	gboolean in_read_handler;
 	gboolean destroyed;
 	gboolean no_carrier_detect;
+	GAtSuspendFunc suspend_func;
+	gpointer suspend_data;
+	guint cmpt;
+	guint pause_timeout;
+	gboolean paused;
 };
 =

 static void hdlc_record(int fd, gboolean in, guint8 *data, guint16 length)
@@ -130,6 +137,37 @@ guint32 g_at_hdlc_get_recv_accm(GAtHDLC *hdlc)
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
+static gboolean paused_timeout_cb(gpointer user_data)
+{
+	GAtHDLC *hdlc =3D user_data;
+
+	hdlc->paused =3D TRUE;
+
+	return FALSE;
+}
+
+static gboolean hdlc_suspend(gpointer user_data)
+{
+	GAtHDLC *hdlc =3D user_data;
+
+	g_at_io_drain_ring_buffer(hdlc->io, 3);
+
+	if (hdlc->suspend_func)
+		hdlc->suspend_func(hdlc->suspend_data);
+
+	return FALSE;
+}
+
 static void new_bytes(struct ring_buffer *rbuf, gpointer user_data)
 {
 	GAtHDLC *hdlc =3D user_data;
@@ -142,6 +180,13 @@ static void new_bytes(struct ring_buffer *rbuf, gpoint=
er user_data)
 =

 	hdlc->in_read_handler =3D TRUE;
 =

+	/*
+	 * We delete the the paused_timeout_cb or hdlc_suspend as soons as
+	 * we read a data.
+	 */
+	if (hdlc->pause_timeout > 0)
+		g_source_remove(hdlc->pause_timeout);
+
 	while (pos < len) {
 		/*
 		 * We try to detect NO CARRIER conditions here.  We
@@ -153,6 +198,18 @@ static void new_bytes(struct ring_buffer *rbuf, gpoint=
er user_data)
 				hdlc->decode_offset =3D=3D 0 && *buf =3D=3D '\r')
 			break;
 =

+		/*
+		 * If there was no character for 1 second we try to detect
+		 * the '+' character to suspend data call if 3 '+' are
+		 * detected.
+		 */
+		if (*buf =3D=3D '+' && hdlc->paused) {
+			hdlc->cmpt++;
+		} else {
+			hdlc->cmpt =3D 0;
+			hdlc->paused =3D FALSE;
+		}
+
 		if (hdlc->decode_escape =3D=3D TRUE) {
 			unsigned char val =3D *buf ^ HDLC_TRANS;
 =

@@ -190,6 +247,9 @@ static void new_bytes(struct ring_buffer *rbuf, gpointe=
r user_data)
 		}
 	}
 =

+	if (hdlc->cmpt =3D=3D 3)
+		goto suspend;
+
 out:
 	ring_buffer_drain(rbuf, pos);
 =

@@ -197,6 +257,29 @@ out:
 =

 	if (hdlc->destroyed)
 		g_free(hdlc);
+
+	/*
+	 * If there were no data pause for GUARD_TIMEOUTS ms,
+	 * we try again to check it.
+	 */
+	if (!hdlc->paused)
+		hdlc->pause_timeout =3D g_timeout_add (GUARD_TIMEOUTS,
+							paused_timeout_cb,
+							hdlc);
+
+	return;
+
+suspend:
+	/*
+	 * Restart the counter and reset the ring buffer.
+	 */
+	hdlc->cmpt =3D 0;
+
+	/*
+	 * Wait for another pause of GUARD_TIMEOUTS ms before returning to comman=
d mode.
+	 */
+	hdlc->paused =3D FALSE;
+	hdlc->pause_timeout =3D g_timeout_add (GUARD_TIMEOUTS, hdlc_suspend, hdlc=
);
 }
 =

 GAtHDLC *g_at_hdlc_new_from_io(GAtIO *io)
@@ -245,6 +328,11 @@ GAtHDLC *g_at_hdlc_new_from_io(GAtIO *io)
 	hdlc->io =3D g_at_io_ref(io);
 	g_at_io_set_read_handler(hdlc->io, new_bytes, hdlc);
 =

+	/* We can try to check the pause as soon as read handler is set */
+	hdlc->pause_timeout =3D g_timeout_add (GUARD_TIMEOUTS,
+							paused_timeout_cb,
+							hdlc);
+
 	return hdlc;
 =

 error:
@@ -305,6 +393,10 @@ void g_at_hdlc_unref(GAtHDLC *hdlc)
 	g_at_io_set_write_handler(hdlc->io, NULL, NULL);
 	g_at_io_set_read_handler(hdlc->io, NULL, NULL);
 =

+	if (hdlc->pause_timeout > 0)
+		g_source_remove(hdlc->pause_timeout);
+
+
 	g_at_io_unref(hdlc->io);
 	hdlc->io =3D NULL;
 =

-- =

1.7.1


--===============0096235678970376721==--

