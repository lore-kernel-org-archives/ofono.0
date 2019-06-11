Content-Type: multipart/mixed; boundary="===============3966846362361295628=="
MIME-Version: 1.0
From: Antara Borwankar <antara.borwankar@intel.com>
Subject: [PATCH 2/2] xmm7modem: changed gprs driver vendor for xmm7modem
Date: Tue, 11 Jun 2019 15:01:58 +0530
Message-ID: <1560245518-18914-1-git-send-email-antara.borwankar@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3966846362361295628==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Changed gprs driver vendor from "OFONO_VENDOR_IFX" to
"OFONO_VENDOR_XMM" for xmm7modem specific behavior.
---
 plugins/xmm7xxx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/plugins/xmm7xxx.c b/plugins/xmm7xxx.c
index a544798..aade18f 100644
--- a/plugins/xmm7xxx.c
+++ b/plugins/xmm7xxx.c
@@ -1243,7 +1243,7 @@ static void xmm7xxx_post_online(struct ofono_modem *m=
odem)
 =

 	ofono_netreg_create(modem, OFONO_VENDOR_IFX, "atmodem", data->chat);
 =

-	gprs =3D ofono_gprs_create(modem, OFONO_VENDOR_IFX, "atmodem",
+	gprs =3D ofono_gprs_create(modem, OFONO_VENDOR_XMM, "atmodem",
 					data->chat);
 =

 	interface =3D ofono_modem_get_string(modem, "NetworkInterface");
-- =

1.9.1


--===============3966846362361295628==--

