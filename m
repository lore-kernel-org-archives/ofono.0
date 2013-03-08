Content-Type: multipart/mixed; boundary="===============2621455748610246851=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH] hfp_hf_bluez5: Remove duplicated include
Date: Fri, 08 Mar 2013 20:08:48 -0300
Message-ID: <1362784128-22661-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2621455748610246851==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/hfp_hf_bluez5.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
index 381a541..332dbab 100644
--- a/plugins/hfp_hf_bluez5.c
+++ b/plugins/hfp_hf_bluez5.c
@@ -46,7 +46,6 @@
 #include <ofono/netreg.h>
 #include <ofono/voicecall.h>
 #include <ofono/call-volume.h>
-#include <ofono/handsfree-audio.h>
 #include <ofono/handsfree.h>
 #include <ofono/handsfree-audio.h>
 =

-- =

1.7.11.7


--===============2621455748610246851==--

