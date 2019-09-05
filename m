Content-Type: multipart/mixed; boundary="===============4058730580294279374=="
MIME-Version: 1.0
From: Martin =?unknown-8bit?q?Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: [PATCH] atmodem: sms: don't request URC buffering for Quectel UC15
 modems
Date: Thu, 05 Sep 2019 11:16:55 +0200
Message-ID: <20190905091655.109912-1-martin@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4058730580294279374==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add a vendor quirk to avoid an error being returned when setting up sms
notification for Quectel UC15 modems.
---
 drivers/atmodem/sms.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/atmodem/sms.c b/drivers/atmodem/sms.c
index 442cfc58..d502da72 100644
--- a/drivers/atmodem/sms.c
+++ b/drivers/atmodem/sms.c
@@ -844,6 +844,7 @@ static gboolean build_cnmi_string(char *buf, int *cnmi_=
opts,
 	case OFONO_VENDOR_HUAWEI:
 	case OFONO_VENDOR_ZTE:
 	case OFONO_VENDOR_SIMCOM:
+	case OFONO_VENDOR_QUECTEL:
 		/* MSM devices advertise support for mode 2, but return an
 		 * error if we attempt to actually use it. */
 		mode =3D "1";
-- =

2.23.0


--===============4058730580294279374==--

