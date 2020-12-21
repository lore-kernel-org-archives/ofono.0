Content-Type: multipart/mixed; boundary="===============2438146458891176327=="
MIME-Version: 1.0
From: Sergey Matyukevich <geomatsi@gmail.com>
Subject: [PATCH 1/5] plugin: gemalto: fix source of gprs notifications
Date: Mon, 21 Dec 2020 23:01:29 +0300
Message-ID: <20201221200133.522933-2-geomatsi@gmail.com>
In-Reply-To: <20201221200133.522933-1-geomatsi@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2438146458891176327==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Modem USB interface does not receive certain gprs context notifications.
Fix gprs chat: use Application USB interface to receive all the modem
notifications.
---
 plugins/gemalto.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/plugins/gemalto.c b/plugins/gemalto.c
index 238c7cc4..28ee3aff 100644
--- a/plugins/gemalto.c
+++ b/plugins/gemalto.c
@@ -606,7 +606,7 @@ static void gemalto_post_sim(struct ofono_modem *modem)
 		driver =3D "atmodem";
 	}
 =

-	gc =3D ofono_gprs_context_create(modem, 0, driver, data->mdm);
+	gc =3D ofono_gprs_context_create(modem, 0, driver, data->app);
 =

 	if (gprs && gc)
 		ofono_gprs_add_context(gprs, gc);
-- =

2.29.2

--===============2438146458891176327==--

