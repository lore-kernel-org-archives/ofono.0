Content-Type: multipart/mixed; boundary="===============4293609641285708081=="
MIME-Version: 1.0
From: Gustavo F. Padovan <gustavo@padovan.org>
Subject: [PATCH 1/1] fix handsfree profile to compile with
 --enable-maintainer-mode
Date: Fri, 16 Oct 2009 14:47:15 -0300
Message-ID: <1255715235-10199-2-git-send-email-gustavo@padovan.org>
In-Reply-To: <1255715235-10199-1-git-send-email-gustavo@padovan.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4293609641285708081==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

this is all about compile-warnings.
---
 drivers/hfpmodem/hfp.c |    2 +-
 drivers/hfpmodem/hfp.h |    2 +-
 plugins/hfp.c          |    4 ----
 3 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/hfpmodem/hfp.c b/drivers/hfpmodem/hfp.c
index 941e7b1..69e2f64 100644
--- a/drivers/hfpmodem/hfp.c
+++ b/drivers/hfpmodem/hfp.c
@@ -40,7 +40,6 @@
 =

 #include "hfp.h"
 =

-static const char *none_prefix[] =3D { NULL };
 static const char *brsf_prefix[] =3D { "+BRSF:", NULL };
 static const char *cind_prefix[] =3D { "+CIND:", NULL };
 static const char *cmer_prefix[] =3D { "+CMER:", NULL };
@@ -337,6 +336,7 @@ GAtChat *hfp_get_chat(gpointer user_data)
 =

 static int hfpmodem_init(void)
 {
+    return 0;
 }
 =

 static void hfpmodem_exit(void)
diff --git a/drivers/hfpmodem/hfp.h b/drivers/hfpmodem/hfp.h
index fa5641f..5a98c3d 100644
--- a/drivers/hfpmodem/hfp.h
+++ b/drivers/hfpmodem/hfp.h
@@ -71,7 +71,7 @@ struct gateway {
 	HfpConnectFunc conn_cb;
 	gpointer cb_data;
 =

-	unsigned int ag_features;
+	int ag_features;
 	unsigned int mpty_features;
 	GSList *indies;
 };
diff --git a/plugins/hfp.c b/plugins/hfp.c
index c73a032..1a7f064 100644
--- a/plugins/hfp.c
+++ b/plugins/hfp.c
@@ -187,15 +187,11 @@ static int hfp_disable(struct ofono_modem *modem)
 =

 static void hfp_pre_sim(struct ofono_modem *modem)
 {
-	struct hfp_data *hfp_data =3D ofono_modem_get_data(modem);
-
 	DBG("%p", modem);
 }
 =

 static void hfp_post_sim(struct ofono_modem *modem)
 {
-	struct hfp_data *hfp_data =3D ofono_modem_get_data(modem);
-
 	DBG("%p", modem);
 }
 =

-- =

1.6.4.4


--===============4293609641285708081==--

