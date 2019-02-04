Content-Type: multipart/mixed; boundary="===============4776734753737203682=="
MIME-Version: 1.0
From: CRImier <crimier@yandex.ru>
Subject: [PATCH] sim800: fix typo in model check code
Date: Mon, 04 Feb 2019 22:16:54 +0200
Message-ID: <20190204201655.5567-1-crimier@yandex.ru>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4776734753737203682==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Fixing a copy-paste error in SIM800 code
that results in a SIM900 modem being
detected as a SIM800 modem.
---
 plugins/sim900.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/plugins/sim900.c b/plugins/sim900.c
index eeeb248f..256483ea 100644
--- a/plugins/sim900.c
+++ b/plugins/sim900.c
@@ -115,7 +115,7 @@ static void check_model(gboolean ok, GAtResult *result,=
 gpointer user_data)
 		if (strstr(model, "SIM800"))
 			data->modem_type =3D SIM800;
 		else if (strstr(model, "SIM900"))
-			data->modem_type =3D SIM800;
+			data->modem_type =3D SIM900;
 		else
 			data->modem_type =3D SIMCOM_UNKNOWN;
 	}
-- =

2.11.0


--===============4776734753737203682==--

