Content-Type: multipart/mixed; boundary="===============6662867163548837303=="
MIME-Version: 1.0
From: jussi.pakkanen@canonical.com
Subject: [PATCH] Allow configuration file override with environment variable.
Date: Thu, 27 Mar 2014 15:08:56 +0200
Message-ID: <1395925736-16223-1-git-send-email-jussi.pakkanen@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6662867163548837303==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Jussi Pakkanen <jussi.pakkanen@canonical.com>

---
 plugins/phonesim.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/plugins/phonesim.c b/plugins/phonesim.c
index 918d2eb..e84bbf6 100644
--- a/plugins/phonesim.c
+++ b/plugins/phonesim.c
@@ -1071,7 +1071,7 @@ done:
 static int phonesim_init(void)
 {
 	int err;
-
+	char *conf_override =3D getenv("OFONO_PHONESIM_CONFIG");
 	err =3D ofono_modem_driver_register(&phonesim_driver);
 	if (err < 0)
 		return err;
@@ -1081,7 +1081,10 @@ static int phonesim_init(void)
 	ofono_gprs_context_driver_register(&context_driver);
 	ofono_ctm_driver_register(&ctm_driver);
 =

-	parse_config(CONFIGDIR "/phonesim.conf");
+	if (conf_override)
+		parse_config(conf_override);
+	else
+		parse_config(CONFIGDIR "/phonesim.conf");
 =

 	return 0;
 }
-- =

1.9.1


--===============6662867163548837303==--

