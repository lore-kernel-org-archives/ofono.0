Content-Type: multipart/mixed; boundary="===============3682659566474472744=="
MIME-Version: 1.0
From: John Ernberg <john.ernberg@actia.se>
Subject: [PATCH 04/24] ril: don't rely on undefined behavior when casting
 function pointers
Date: Fri, 22 Apr 2016 13:10:06 +0000
Message-ID: <1461330601-21333-5-git-send-email-john.ernberg@actia.se>
In-Reply-To: <1461330601-21333-4-git-send-email-john.ernberg@actia.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3682659566474472744==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: John Ernberg <john.ernberg@actia.se>

---
 drivers/rilmodem/voicecall.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/rilmodem/voicecall.c b/drivers/rilmodem/voicecall.c
index 8515ebb..b7180b9 100644
--- a/drivers/rilmodem/voicecall.c
+++ b/drivers/rilmodem/voicecall.c
@@ -302,8 +302,7 @@ no_calls:
 		}
 	}
 =

-	g_slist_foreach(vd->calls, (GFunc) g_free, NULL);
-	g_slist_free(vd->calls);
+	g_slist_free_full(vd->calls, g_free);
 =

 	vd->calls =3D calls;
 	vd->local_release =3D 0;
@@ -848,8 +847,7 @@ void ril_voicecall_remove(struct ofono_voicecall *vc)
 	if (vd->clcc_source)
 		g_source_remove(vd->clcc_source);
 =

-	g_slist_foreach(vd->calls, (GFunc) g_free, NULL);
-	g_slist_free(vd->calls);
+	g_slist_free_full(vd->calls, g_free);
 =

 	ofono_voicecall_set_data(vc, NULL);
 =

-- =

1.9.1

--===============3682659566474472744==--

