Content-Type: multipart/mixed; boundary="===============1996275674395631350=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v4 1/8] gathdlc: delete read/write handler in hdlc_suspend and
 add public suspend function for testing
Date: Wed, 04 May 2011 17:38:59 +0200
Message-ID: <1304523546-643-2-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1304523546-643-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1996275674395631350==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gathdlc.c |   12 ++++++++++++
 gatchat/gathdlc.h |    2 ++
 2 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/gatchat/gathdlc.c b/gatchat/gathdlc.c
index e3ab7ec..7989bd7 100644
--- a/gatchat/gathdlc.c
+++ b/gatchat/gathdlc.c
@@ -166,6 +166,9 @@ static gboolean hdlc_suspend(gpointer user_data)
 =

 	g_at_io_drain_ring_buffer(hdlc->io, 3);
 =

+	g_at_io_set_write_handler(hdlc->io, NULL, NULL);
+	g_at_io_set_read_handler(hdlc->io, NULL, NULL);
+
 	if (hdlc->suspend_func)
 		hdlc->suspend_func(hdlc->suspend_data);
 =

@@ -610,3 +613,12 @@ void g_at_hdlc_set_no_carrier_detect(GAtHDLC *hdlc, gb=
oolean detect)
 =

 	hdlc->no_carrier_detect =3D detect;
 }
+
+void g_at_hdlc_suspend(GAtHDLC *hdlc)
+{
+	if (hdlc =3D=3D NULL)
+		return;
+
+	g_at_io_set_write_handler(hdlc->io, NULL, NULL);
+	g_at_io_set_read_handler(hdlc->io, NULL, NULL);
+}
diff --git a/gatchat/gathdlc.h b/gatchat/gathdlc.h
index 158f27f..556e383 100644
--- a/gatchat/gathdlc.h
+++ b/gatchat/gathdlc.h
@@ -60,6 +60,8 @@ void g_at_hdlc_set_no_carrier_detect(GAtHDLC *hdlc, gbool=
ean detect);
 void g_at_hdlc_set_suspend_function(GAtHDLC *hdlc, GAtSuspendFunc func,
 							gpointer user_data);
 =

+void g_at_hdlc_suspend(GAtHDLC *hdlc);
+
 #ifdef __cplusplus
 }
 #endif
-- =

1.7.1


--===============1996275674395631350==--

