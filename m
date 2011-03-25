Content-Type: multipart/mixed; boundary="===============4747665966158063954=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH 08/18] gathdlc: add g_at_resume_hdlc() prototype.
Date: Fri, 25 Mar 2011 16:25:39 +0100
Message-ID: <1301066749-12052-9-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4747665966158063954==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gathdlc.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/gatchat/gathdlc.h b/gatchat/gathdlc.h
index 158f27f..9719816 100644
--- a/gatchat/gathdlc.h
+++ b/gatchat/gathdlc.h
@@ -60,6 +60,8 @@ void g_at_hdlc_set_no_carrier_detect(GAtHDLC *hdlc, gbool=
ean detect);
 void g_at_hdlc_set_suspend_function(GAtHDLC *hdlc, GAtSuspendFunc func,
 							gpointer user_data);
 =

+void g_at_hdlc_resume(GAtHDLC *hdlc);
+
 #ifdef __cplusplus
 }
 #endif
-- =

1.7.1


--===============4747665966158063954==--

