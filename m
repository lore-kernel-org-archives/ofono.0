Content-Type: multipart/mixed; boundary="===============7860355428344880683=="
MIME-Version: 1.0
From: John Ernberg <john.ernberg@actia.se>
Subject: [PATCH 12/24] modem: don't rely on undefined behavior when casting
 function pointers
Date: Fri, 22 Apr 2016 13:10:07 +0000
Message-ID: <1461330601-21333-13-git-send-email-john.ernberg@actia.se>
In-Reply-To: <1461330601-21333-12-git-send-email-john.ernberg@actia.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7860355428344880683==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: John Ernberg <john.ernberg@actia.se>

---
 src/modem.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/src/modem.c b/src/modem.c
index a89fa48..b1e8d3e 100644
--- a/src/modem.c
+++ b/src/modem.c
@@ -2083,12 +2083,10 @@ static void modem_unregister(struct ofono_modem *mo=
dem)
 	modem->sim_watch =3D 0;
 	modem->sim_ready_watch =3D 0;
 =

-	g_slist_foreach(modem->interface_list, (GFunc) g_free, NULL);
-	g_slist_free(modem->interface_list);
+	g_slist_free_full(modem->interface_list, g_free);
 	modem->interface_list =3D NULL;
 =

-	g_slist_foreach(modem->feature_list, (GFunc) g_free, NULL);
-	g_slist_free(modem->feature_list);
+	g_slist_free_full(modem->feature_list, g_free);
 	modem->feature_list =3D NULL;
 =

 	if (modem->timeout) {
-- =

1.9.1

--===============7860355428344880683==--

