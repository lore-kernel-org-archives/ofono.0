Content-Type: multipart/mixed; boundary="===============8387685789192997992=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH v3 17/26] gathdlc: add g_at_hdlc_resume() definition
Date: Fri, 01 Apr 2011 10:56:19 +0200
Message-ID: <1301648188-7208-18-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1301648188-7208-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8387685789192997992==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gathdlc.c |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/gatchat/gathdlc.c b/gatchat/gathdlc.c
index 37f2539..816da34 100644
--- a/gatchat/gathdlc.c
+++ b/gatchat/gathdlc.c
@@ -604,3 +604,28 @@ void g_at_hdlc_suspend(GAtHDLC *hdlc)
 	g_at_io_set_write_handler(hdlc->io, NULL, NULL);
 	g_at_io_set_read_handler(hdlc->io, NULL, NULL);
 }
+
+static void hdlc_wakeup_writer(GAtHDLC *hdlc)
+{
+	g_at_io_set_write_handler(hdlc->io, can_write_data, hdlc);
+}
+
+void g_at_hdlc_resume(GAtHDLC *hdlc)
+{
+	if (hdlc =3D=3D NULL)
+		return;
+
+	g_at_io_set_read_handler(hdlc->io, new_bytes, hdlc);
+
+	if (g_queue_get_length(hdlc->write_queue) > 0)
+		hdlc_wakeup_writer(hdlc);
+
+	/*
+	 * As soon as we resume HDLC we can start checking for
+	 * guard timeouts pause.
+	 */
+	if (!hdlc->paused)
+		hdlc->pause_timeout =3D g_timeout_add (GUARD_TIMEOUTS,
+							paused_timeout_cb,
+							hdlc);
+}
-- =

1.7.1


--===============8387685789192997992==--

