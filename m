Content-Type: multipart/mixed; boundary="===============7779980812323530643=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH v3 09/26] gathdlc: add g_at_hdlc_suspend() definition
Date: Fri, 01 Apr 2011 10:56:11 +0200
Message-ID: <1301648188-7208-10-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1301648188-7208-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7779980812323530643==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gathdlc.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/gatchat/gathdlc.c b/gatchat/gathdlc.c
index db4ad5a..37f2539 100644
--- a/gatchat/gathdlc.c
+++ b/gatchat/gathdlc.c
@@ -595,3 +595,12 @@ void g_at_hdlc_set_no_carrier_detect(GAtHDLC *hdlc, gb=
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
-- =

1.7.1


--===============7779980812323530643==--

