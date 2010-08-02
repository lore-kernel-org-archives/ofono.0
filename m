Content-Type: multipart/mixed; boundary="===============7315357870836246964=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Jo=C3=A3o?= Paulo Rechi Vita <jprvita@profusion.mobi>
Subject: [PATCH] huawei: fix double include of GPRS header
Date: Mon, 02 Aug 2010 15:44:41 -0300
Message-ID: <1280774681-13223-1-git-send-email-jprvita@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7315357870836246964==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/huawei.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/plugins/huawei.c b/plugins/huawei.c
index cfc693d..47d59d0 100644
--- a/plugins/huawei.c
+++ b/plugins/huawei.c
@@ -41,7 +41,6 @@
 #include <ofono/sms.h>
 #include <ofono/ussd.h>
 #include <ofono/gprs.h>
-#include <ofono/gprs.h>
 #include <ofono/gprs-context.h>
 #include <ofono/voicecall.h>
 #include <ofono/call-forwarding.h>
-- =

1.7.0.4


--===============7315357870836246964==--

