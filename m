Content-Type: multipart/mixed; boundary="===============4520515525522813807=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH v3 16/26] gathdlc: add g_at_hdlc_resume() prototype
Date: Fri, 01 Apr 2011 10:56:18 +0200
Message-ID: <1301648188-7208-17-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1301648188-7208-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4520515525522813807==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gathdlc.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

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


--===============4520515525522813807==--

