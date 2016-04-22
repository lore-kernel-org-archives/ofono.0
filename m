Content-Type: multipart/mixed; boundary="===============2314616735337751747=="
MIME-Version: 1.0
From: John Ernberg <john.ernberg@actia.se>
Subject: [PATCH 02/24] hfpmodem: don't rely on undefined behavior when casting
 function pointers
Date: Fri, 22 Apr 2016 13:10:06 +0000
Message-ID: <1461330601-21333-3-git-send-email-john.ernberg@actia.se>
In-Reply-To: <1461330601-21333-2-git-send-email-john.ernberg@actia.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2314616735337751747==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: John Ernberg <john.ernberg@actia.se>

---
 drivers/hfpmodem/voicecall.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/hfpmodem/voicecall.c b/drivers/hfpmodem/voicecall.c
index f8db584..ffdf4b7 100644
--- a/drivers/hfpmodem/voicecall.c
+++ b/drivers/hfpmodem/voicecall.c
@@ -286,8 +286,7 @@ static void clcc_poll_cb(gboolean ok, GAtResult *result=
, gpointer user_data)
 =

 	ofono_voicecall_mpty_hint(vc, mpty_ids);
 =

-	g_slist_foreach(vd->calls, (GFunc) g_free, NULL);
-	g_slist_free(vd->calls);
+	g_slist_free_full(vd->calls, g_free);
 =

 	vd->calls =3D calls;
 =

@@ -1256,8 +1255,7 @@ static void hfp_voicecall_remove(struct ofono_voiceca=
ll *vc)
 	if (vd->expect_release_source)
 		g_source_remove(vd->expect_release_source);
 =

-	g_slist_foreach(vd->calls, (GFunc) g_free, NULL);
-	g_slist_free(vd->calls);
+	g_slist_free_full(vd->calls, g_free);
 =

 	ofono_voicecall_set_data(vc, NULL);
 =

-- =

1.9.1

--===============2314616735337751747==--

