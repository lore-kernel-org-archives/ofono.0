Content-Type: multipart/mixed; boundary="===============2258140070016099337=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH 13/18] gathdlc: add prototype to suspend gathdlc externally
Date: Fri, 25 Mar 2011 16:25:44 +0100
Message-ID: <1301066749-12052-14-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2258140070016099337==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gathdlc.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/gatchat/gathdlc.h b/gatchat/gathdlc.h
index 9719816..e5a5c29 100644
--- a/gatchat/gathdlc.h
+++ b/gatchat/gathdlc.h
@@ -62,6 +62,8 @@ void g_at_hdlc_set_suspend_function(GAtHDLC *hdlc, GAtSus=
pendFunc func,
 =

 void g_at_hdlc_resume(GAtHDLC *hdlc);
 =

+void g_at_hdlc_suspend(GAtHDLC *hdlc);
+
 #ifdef __cplusplus
 }
 #endif
-- =

1.7.1


--===============2258140070016099337==--

