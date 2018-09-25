Content-Type: multipart/mixed; boundary="===============9166828768052330987=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: [PATCH] gemalto plugin: sms vendor to GEMALTO
Date: Tue, 25 Sep 2018 09:13:13 +0200
Message-ID: <20180925071313.25119-2-gciofono@gmail.com>
In-Reply-To: <20180925071313.25119-1-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9166828768052330987==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

changed from CINTERION.
Note that the cinterion plugin itself does not use the specific vendor
for the sms atom.
---
 plugins/gemalto.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/plugins/gemalto.c b/plugins/gemalto.c
index 6e0d765b..0fcf30d8 100644
--- a/plugins/gemalto.c
+++ b/plugins/gemalto.c
@@ -589,7 +589,7 @@ static void gemalto_post_sim(struct ofono_modem *modem)
 =

 	ofono_phonebook_create(modem, 0, "atmodem", data->app);
 =

-	ofono_sms_create(modem, OFONO_VENDOR_CINTERION, "atmodem", data->app);
+	ofono_sms_create(modem, OFONO_VENDOR_GEMALTO, "atmodem", data->app);
 =

 	gprs =3D ofono_gprs_create(modem, 0, "atmodem", data->app);
 	gc =3D ofono_gprs_context_create(modem, 0, "atmodem", data->mdm);
-- =

2.17.1


--===============9166828768052330987==--

