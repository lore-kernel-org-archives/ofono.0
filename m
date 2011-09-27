Content-Type: multipart/mixed; boundary="===============4014984540859552617=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH -v4 21/21] sap: fix sap modem remove
Date: Tue, 27 Sep 2011 18:04:20 -0300
Message-ID: <1317157460-17012-21-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1317157460-17012-20-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4014984540859552617==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: "Gustavo F. Padovan" <gustavo@padovan.org>

prefix NULL means that the modem needs to be removed
---
 plugins/sap.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/plugins/sap.c b/plugins/sap.c
index b128517..6a140b3 100644
--- a/plugins/sap.c
+++ b/plugins/sap.c
@@ -419,13 +419,13 @@ static void bluetooth_sap_remove(const char *prefix)
 =

 	DBG("%s", prefix);
 =

-	if (modem_hash =3D=3D NULL || prefix =3D=3D NULL)
+	if (modem_hash =3D=3D NULL)
 		return;
 =

 	g_hash_table_iter_init(&iter, modem_hash);
 =

 	while (g_hash_table_iter_next(&iter, &key, &value)) {
-		if (g_str_has_prefix((char *)key, prefix) =3D=3D FALSE)
+		if (prefix && g_str_has_prefix((char *)key, prefix) =3D=3D FALSE)
 			continue;
 =

 		g_hash_table_iter_remove(&iter);
-- =

1.7.6.2


--===============4014984540859552617==--

