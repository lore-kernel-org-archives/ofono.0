Content-Type: multipart/mixed; boundary="===============5161177487680143612=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH v3 08/26] gathdlc: add g_at_hdlc_suspend() prototype
Date: Fri, 01 Apr 2011 10:56:10 +0200
Message-ID: <1301648188-7208-9-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1301648188-7208-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5161177487680143612==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gathdlc.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

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


--===============5161177487680143612==--

