Content-Type: multipart/mixed; boundary="===============0978265276700054050=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 2/2] gathdlc: Unset disconnect function in unref
Date: Tue, 06 Jul 2010 17:57:38 +0800
Message-ID: <1278410258-3077-2-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1278410258-3077-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0978265276700054050==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If we destroy PPP instance from g_at_ppp_unref, we should not invoke
io disconnect function.
---
 gatchat/gathdlc.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/gatchat/gathdlc.c b/gatchat/gathdlc.c
index 08a1939..0186e46 100644
--- a/gatchat/gathdlc.c
+++ b/gatchat/gathdlc.c
@@ -278,6 +278,7 @@ void g_at_hdlc_unref(GAtHDLC *hdlc)
 		hdlc->record_fd =3D -1;
 	}
 =

+	g_at_io_set_disconnect_function(hdlc->io, NULL, NULL);
 	g_at_io_unref(hdlc->io);
 	hdlc->io =3D NULL;
 =

-- =

1.6.3.3


--===============0978265276700054050==--

