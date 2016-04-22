Content-Type: multipart/mixed; boundary="===============4484453150994138504=="
MIME-Version: 1.0
From: John Ernberg <john.ernberg@actia.se>
Subject: [PATCH 23/24] voicecall: don't rely on undefined behavior when
 casting function pointers
Date: Fri, 22 Apr 2016 13:10:08 +0000
Message-ID: <1461330601-21333-24-git-send-email-john.ernberg@actia.se>
In-Reply-To: <1461330601-21333-23-git-send-email-john.ernberg@actia.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4484453150994138504==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: John Ernberg <john.ernberg@actia.se>

---
 src/voicecall.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/src/voicecall.c b/src/voicecall.c
index c9b1b43..027f03e 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -2534,9 +2534,7 @@ static void free_sim_ecc_numbers(struct ofono_voiceca=
ll *vc, gboolean old_only)
 	 */
 	if (old_only =3D=3D FALSE) {
 		if (vc->new_sim_en_list) {
-			g_slist_foreach(vc->new_sim_en_list, (GFunc) g_free,
-					NULL);
-			g_slist_free(vc->new_sim_en_list);
+			g_slist_free_full(vc->new_sim_en_list, g_free);
 			vc->new_sim_en_list =3D NULL;
 		}
 =

@@ -2544,8 +2542,7 @@ static void free_sim_ecc_numbers(struct ofono_voiceca=
ll *vc, gboolean old_only)
 	}
 =

 	if (vc->sim_en_list) {
-		g_slist_foreach(vc->sim_en_list, (GFunc) g_free, NULL);
-		g_slist_free(vc->sim_en_list);
+		g_slist_free_full(vc->sim_en_list, g_free);
 		vc->sim_en_list =3D NULL;
 	}
 }
-- =

1.9.1

--===============4484453150994138504==--

