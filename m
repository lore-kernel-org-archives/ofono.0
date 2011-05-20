Content-Type: multipart/mixed; boundary="===============4247301367467997187=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH 5/7] gobi: remove set but not used var
Date: Fri, 20 May 2011 16:03:43 -0300
Message-ID: <1305918225-8438-5-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1305918225-8438-4-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4247301367467997187==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/gobi.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/plugins/gobi.c b/plugins/gobi.c
index b559f33..dcc41af 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -288,7 +288,6 @@ static void gobi_post_sim(struct ofono_modem *modem)
 static void gobi_post_online(struct ofono_modem *modem)
 {
 	struct gobi_data *data =3D ofono_modem_get_data(modem);
-	struct ofono_gprs *gprs;
 =

 	DBG("%p", modem);
 =

@@ -297,8 +296,7 @@ static void gobi_post_online(struct ofono_modem *modem)
 	ofono_cbs_create(modem, OFONO_VENDOR_GOBI, "atmodem", data->chat);
 	ofono_ussd_create(modem, OFONO_VENDOR_GOBI, "atmodem", data->chat);
 =

-	gprs =3D ofono_gprs_create(modem, OFONO_VENDOR_GOBI,
-						"atmodem", data->chat);
+	ofono_gprs_create(modem, OFONO_VENDOR_GOBI, "atmodem", data->chat);
 }
 =

 static struct ofono_modem_driver gobi_driver =3D {
-- =

1.7.5.1


--===============4247301367467997187==--

