Content-Type: multipart/mixed; boundary="===============6128205844901397574=="
MIME-Version: 1.0
From: r.r.zaripov@gmail.com
Subject: [PATCH v5 4/4] SIM900 vendor quirk 
Date: Thu, 12 Jan 2012 16:32:22 +0400
Message-ID: <1326371542-29964-4-git-send-email-r.r.zaripov@gmail.com>
In-Reply-To: <1326371542-29964-1-git-send-email-r.r.zaripov@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6128205844901397574==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Renat Zaripov <r.r.zaripov@gmail.com>

Adding vendor quirk for SIMCOM SIM900 modem module.
---
 drivers/atmodem/network-registration.c |    1 +
 drivers/atmodem/vendor.h               |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/atmodem/network-registration.c b/drivers/atmodem/netwo=
rk-registration.c
index b943241..78e73e2 100644
--- a/drivers/atmodem/network-registration.c
+++ b/drivers/atmodem/network-registration.c
@@ -1496,6 +1496,7 @@ static void at_creg_set_cb(gboolean ok, GAtResult *re=
sult, gpointer user_data)
 		break;
 	case OFONO_VENDOR_NOKIA:
 	case OFONO_VENDOR_SAMSUNG:
+	case OFONO_VENDOR_SIM900:
 		/* Signal strength reporting via CIND is not supported */
 		break;
 	default:
diff --git a/drivers/atmodem/vendor.h b/drivers/atmodem/vendor.h
index c4ef742..4aab7bf 100644
--- a/drivers/atmodem/vendor.h
+++ b/drivers/atmodem/vendor.h
@@ -38,4 +38,5 @@ enum ofono_vendor {
 	OFONO_VENDOR_TELIT,
 	OFONO_VENDOR_SPEEDUP,
 	OFONO_VENDOR_SAMSUNG,
+	OFONO_VENDOR_SIM900,
 };
-- =

1.7.7.3


--===============6128205844901397574==--

