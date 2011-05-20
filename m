Content-Type: multipart/mixed; boundary="===============0508255024735956819=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v6 1/5] gathdlc: add g_at_hdlc_resume() API
Date: Fri, 20 May 2011 11:38:12 +0200
Message-ID: <1305884296-2601-2-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1305884296-2601-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0508255024735956819==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gathdlc.c |   16 ++++++++++++++++
 gatchat/gathdlc.h |    1 +
 2 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/gatchat/gathdlc.c b/gatchat/gathdlc.c
index 7989bd7..d04ba38 100644
--- a/gatchat/gathdlc.c
+++ b/gatchat/gathdlc.c
@@ -622,3 +622,19 @@ void g_at_hdlc_suspend(GAtHDLC *hdlc)
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
+}
diff --git a/gatchat/gathdlc.h b/gatchat/gathdlc.h
index 556e383..e82b33e 100644
--- a/gatchat/gathdlc.h
+++ b/gatchat/gathdlc.h
@@ -61,6 +61,7 @@ void g_at_hdlc_set_suspend_function(GAtHDLC *hdlc, GAtSus=
pendFunc func,
 							gpointer user_data);
 =

 void g_at_hdlc_suspend(GAtHDLC *hdlc);
+void g_at_hdlc_resume(GAtHDLC *hdlc);
 =

 #ifdef __cplusplus
 }
-- =

1.7.1


--===============0508255024735956819==--

