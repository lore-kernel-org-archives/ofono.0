Content-Type: multipart/mixed; boundary="===============1710815605963877634=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH] atmodem: close the list in clvl_range_query
Date: Tue, 08 Feb 2011 12:14:19 +0200
Message-ID: <1297160059-15548-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1710815605963877634==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/atmodem/call-volume.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/atmodem/call-volume.c b/drivers/atmodem/call-volume.c
index 6d87276..1e32a69 100644
--- a/drivers/atmodem/call-volume.c
+++ b/drivers/atmodem/call-volume.c
@@ -114,6 +114,7 @@ static void clvl_range_query(gboolean ok, GAtResult *re=
sult, gpointer user_data)
 	/* Try opening the list, but don't fail */
 	g_at_result_iter_open_list(&iter);
 	g_at_result_iter_next_range(&iter, &cvd->clvl_min, &cvd->clvl_max);
+	g_at_result_iter_close_list(&iter);
 }
 =

 static void cv_generic_set_cb(gboolean ok, GAtResult *result,
-- =

1.7.0.4


--===============1710815605963877634==--

