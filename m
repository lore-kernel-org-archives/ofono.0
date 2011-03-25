Content-Type: multipart/mixed; boundary="===============3960713804278842702=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH 14/18] gathdlc: add g_at_hdlc_suspend() definition
Date: Fri, 25 Mar 2011 16:25:45 +0100
Message-ID: <1301066749-12052-15-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3960713804278842702==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gathdlc.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/gatchat/gathdlc.c b/gatchat/gathdlc.c
index 16d803d..90de4e9 100644
--- a/gatchat/gathdlc.c
+++ b/gatchat/gathdlc.c
@@ -642,3 +642,16 @@ void g_at_hdlc_resume(GAtHDLC *hdlc)
 							paused_timeout_cb,
 							hdlc);
 }
+
+void g_at_hdlc_suspend(GAtHDLC *hdlc)
+{
+	if (hdlc =3D=3D NULL)
+		return;
+
+	g_at_io_set_write_handler(hdlc->io, NULL, NULL);
+	g_at_io_set_read_handler(hdlc->io, NULL, NULL);
+
+	if (hdlc->suspend_func)
+		hdlc->suspend_func(hdlc->suspend_data);
+}
+
-- =

1.7.1


--===============3960713804278842702==--

