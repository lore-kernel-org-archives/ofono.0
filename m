Content-Type: multipart/mixed; boundary="===============1834387029154303971=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: [PATCH 4/5] plugins/cinterion: use Gemalto vendor in netreg
Date: Fri, 26 Oct 2018 07:11:05 +0200
Message-ID: <20181026051106.16828-4-gciofono@gmail.com>
In-Reply-To: <20181026051106.16828-1-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1834387029154303971==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/cinterion.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/plugins/cinterion.c b/plugins/cinterion.c
index a18b9fe8..cd5e9e81 100644
--- a/plugins/cinterion.c
+++ b/plugins/cinterion.c
@@ -209,7 +209,7 @@ static void cinterion_post_online(struct ofono_modem *m=
odem)
 	ofono_ussd_create(modem, 0, "atmodem", chat);
 	ofono_call_forwarding_create(modem, 0, "atmodem", chat);
 	ofono_call_settings_create(modem, 0, "atmodem", chat);
-	ofono_netreg_create(modem, OFONO_VENDOR_CINTERION, "atmodem", chat);
+	ofono_netreg_create(modem, OFONO_VENDOR_GEMALTO, "atmodem", chat);
 	ofono_call_meter_create(modem, 0, "atmodem", chat);
 	ofono_call_barring_create(modem, 0, "atmodem", chat);
 =

-- =

2.17.1


--===============1834387029154303971==--

