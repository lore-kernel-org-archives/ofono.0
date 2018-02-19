Content-Type: multipart/mixed; boundary="===============2737308096729742068=="
MIME-Version: 1.0
From: Christophe Ronco <c.ronco@kerlink.fr>
Subject: [PATCH 1/3] udevng: Add modem string SystemPath
Date: Mon, 19 Feb 2018 15:57:12 +0100
Message-ID: <1519052234-13973-2-git-send-email-c.ronco@kerlink.fr>
In-Reply-To: <1519052234-13973-1-git-send-email-c.ronco@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2737308096729742068==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/udevng.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/plugins/udevng.c b/plugins/udevng.c
index 9b78ab4..3c7d99e 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -1732,6 +1732,8 @@ static gboolean create_modem(gpointer key, gpointer v=
alue, gpointer user_data)
 			continue;
 =

 		if (driver_list[i].setup(modem) =3D=3D TRUE) {
+			ofono_modem_set_string(modem->modem, "SystemPath",
+								syspath);
 			ofono_modem_register(modem->modem);
 			return FALSE;
 		}
-- =

2.7.4


--===============2737308096729742068==--

