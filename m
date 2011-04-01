Content-Type: multipart/mixed; boundary="===============4707439199565968670=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH v3 04/26] gathdlc: add g_at_hdlc_set_suspend_function()
 prototype
Date: Fri, 01 Apr 2011 10:56:06 +0200
Message-ID: <1301648188-7208-5-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1301648188-7208-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4707439199565968670==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gathdlc.h |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/gatchat/gathdlc.h b/gatchat/gathdlc.h
index 95c389e..158f27f 100644
--- a/gatchat/gathdlc.h
+++ b/gatchat/gathdlc.h
@@ -57,6 +57,9 @@ GAtIO *g_at_hdlc_get_io(GAtHDLC *hdlc);
 =

 void g_at_hdlc_set_no_carrier_detect(GAtHDLC *hdlc, gboolean detect);
 =

+void g_at_hdlc_set_suspend_function(GAtHDLC *hdlc, GAtSuspendFunc func,
+							gpointer user_data);
+
 #ifdef __cplusplus
 }
 #endif
-- =

1.7.1


--===============4707439199565968670==--

