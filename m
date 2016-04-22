Content-Type: multipart/mixed; boundary="===============5191474722266346397=="
MIME-Version: 1.0
From: John Ernberg <john.ernberg@actia.se>
Subject: [PATCH 01/24] atmodem: don't rely on undefined behavior when casting
 function pointers
Date: Fri, 22 Apr 2016 13:10:06 +0000
Message-ID: <1461330601-21333-2-git-send-email-john.ernberg@actia.se>
In-Reply-To: <1461330601-21333-1-git-send-email-john.ernberg@actia.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5191474722266346397==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: John Ernberg <john.ernberg@actia.se>

---
 drivers/atmodem/voicecall.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/atmodem/voicecall.c b/drivers/atmodem/voicecall.c
index 7d823a2..e4c59c2 100644
--- a/drivers/atmodem/voicecall.c
+++ b/drivers/atmodem/voicecall.c
@@ -253,8 +253,7 @@ static void clcc_poll_cb(gboolean ok, GAtResult *result=
, gpointer user_data)
 		}
 	}
 =

-	g_slist_foreach(vd->calls, (GFunc) g_free, NULL);
-	g_slist_free(vd->calls);
+	g_slist_free_full(vd->calls, g_free);
 =

 	vd->calls =3D calls;
 =

@@ -1147,8 +1146,7 @@ static void at_voicecall_remove(struct ofono_voicecal=
l *vc)
 	if (vd->vts_source)
 		g_source_remove(vd->vts_source);
 =

-	g_slist_foreach(vd->calls, (GFunc) g_free, NULL);
-	g_slist_free(vd->calls);
+	g_slist_free_full(vd->calls, g_free);
 =

 	ofono_voicecall_set_data(vc, NULL);
 =

-- =

1.9.1

--===============5191474722266346397==--

