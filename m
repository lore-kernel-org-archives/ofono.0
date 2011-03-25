Content-Type: multipart/mixed; boundary="===============5543741305233149175=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH 09/18] gathdlc: add g_at_hdlc_resume() definition.
Date: Fri, 25 Mar 2011 16:25:40 +0100
Message-ID: <1301066749-12052-10-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5543741305233149175==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gathdlc.c |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/gatchat/gathdlc.c b/gatchat/gathdlc.c
index 21e4533..16d803d 100644
--- a/gatchat/gathdlc.c
+++ b/gatchat/gathdlc.c
@@ -617,3 +617,28 @@ void g_at_hdlc_set_no_carrier_detect(GAtHDLC *hdlc, gb=
oolean detect)
 =

 	hdlc->no_carrier_detect =3D detect;
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


--===============5543741305233149175==--

