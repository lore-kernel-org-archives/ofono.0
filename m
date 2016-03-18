Content-Type: multipart/mixed; boundary="===============3765916096597142494=="
MIME-Version: 1.0
From: Dragos Tatulea <dragos@endocode.com>
Subject: [PATCH 3/9] gprs.h: automatic context configuration notifier
Date: Fri, 18 Mar 2016 12:53:10 +0100
Message-ID: <1458301994-5567-5-git-send-email-dragos@endocode.com>
In-Reply-To: <1458301994-5567-1-git-send-email-dragos@endocode.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3765916096597142494==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Useful for LTE automatic bearer activation.

This is called from the gprs driver to let the gprs atom know that
a new context has been activated.
---
 include/gprs.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/gprs.h b/include/gprs.h
index 8d2a260..988d610 100644
--- a/include/gprs.h
+++ b/include/gprs.h
@@ -80,6 +80,9 @@ void ofono_gprs_set_cid_range(struct ofono_gprs *gprs,
 void ofono_gprs_add_context(struct ofono_gprs *gprs,
 				struct ofono_gprs_context *gc);
 =

+void ofono_gprs_cid_activated(struct ofono_gprs  *gprs, unsigned int cid,
+				const char *apn);
+
 #ifdef __cplusplus
 }
 #endif
-- =

2.5.0


--===============3765916096597142494==--

