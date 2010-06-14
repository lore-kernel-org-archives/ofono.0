Content-Type: multipart/mixed; boundary="===============3814141753313279828=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: [RFC v0 2/3] Pass down vendor flag into DCM
Date: Mon, 14 Jun 2010 13:14:19 +0200
Message-ID: <1276514060-16226-3-git-send-email-wagi@monom.org>
In-Reply-To: <1276514060-16226-1-git-send-email-wagi@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3814141753313279828==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

---
 plugins/hso.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/plugins/hso.c b/plugins/hso.c
index 9e3b35a..e645221 100644
--- a/plugins/hso.c
+++ b/plugins/hso.c
@@ -246,7 +246,8 @@ static void hso_post_sim(struct ofono_modem *modem)
 				"atmodem", data->app);
 	ofono_ussd_create(modem, 0, "atmodem", data->app);
 =

-	gprs =3D ofono_gprs_create(modem, 0, "atmodem", data->app);
+	gprs =3D ofono_gprs_create(modem, OFONO_VENDOR_OPTION_HSO,
+				"atmodem", data->app);
 	gc =3D ofono_gprs_context_create(modem, 0, "hsomodem", data->control);
 =

 	if (gprs && gc)
-- =

1.6.6.1


--===============3814141753313279828==--

