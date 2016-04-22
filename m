Content-Type: multipart/mixed; boundary="===============7572860678771165450=="
MIME-Version: 1.0
From: John Ernberg <john.ernberg@actia.se>
Subject: [PATCH 17/24] simutil: don't rely on undefined behavior when casting
 function pointers
Date: Fri, 22 Apr 2016 13:10:07 +0000
Message-ID: <1461330601-21333-18-git-send-email-john.ernberg@actia.se>
In-Reply-To: <1461330601-21333-17-git-send-email-john.ernberg@actia.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7572860678771165450==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: John Ernberg <john.ernberg@actia.se>

---
 src/simutil.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/src/simutil.c b/src/simutil.c
index 5f8c8b8..4731d3b 100644
--- a/src/simutil.c
+++ b/src/simutil.c
@@ -980,8 +980,7 @@ void sim_spdi_free(struct sim_spdi *spdi)
 	if (spdi =3D=3D NULL)
 		return;
 =

-	g_slist_foreach(spdi->operators, (GFunc)g_free, NULL);
-	g_slist_free(spdi->operators);
+	g_slist_free_full(spdi->operators, g_free);
 	g_free(spdi);
 }
 =

@@ -1088,8 +1087,7 @@ void sim_eons_free(struct sim_eons *eons)
 =

 	g_free(eons->pnn_list);
 =

-	g_slist_foreach(eons->opl_list, (GFunc)g_free, NULL);
-	g_slist_free(eons->opl_list);
+	g_slist_free_full(eons->opl_list, g_free);
 =

 	g_free(eons);
 }
-- =

1.9.1

--===============7572860678771165450==--

