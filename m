Content-Type: multipart/mixed; boundary="===============6869878050661055848=="
MIME-Version: 1.0
From: Alex J Lennon <ajlennon@dynamicdevices.co.uk>
Subject: [PATCH 1/3] ehs6: Add support for Cinterion EHS6 plugin
Date: Wed, 29 Apr 2015 19:39:03 +0100
Message-ID: <1430332745-15275-1-git-send-email-ajlennon@dynamicdevices.co.uk>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6869878050661055848==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/atmodem/network-registration.c | 1 +
 drivers/atmodem/vendor.h               | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/atmodem/network-registration.c b/drivers/atmodem/netwo=
rk-registration.c
index a438726..6844860 100644
--- a/drivers/atmodem/network-registration.c
+++ b/drivers/atmodem/network-registration.c
@@ -1917,6 +1917,7 @@ static void at_creg_set_cb(gboolean ok, GAtResult *re=
sult, gpointer user_data)
 		break;
 	case OFONO_VENDOR_NOKIA:
 	case OFONO_VENDOR_SAMSUNG:
+	case OFONO_VENDOR_CINTERION:
 		/* Signal strength reporting via CIND is not supported */
 		break;
 	default:
diff --git a/drivers/atmodem/vendor.h b/drivers/atmodem/vendor.h
index c132e45..52071c8 100644
--- a/drivers/atmodem/vendor.h
+++ b/drivers/atmodem/vendor.h
@@ -45,4 +45,5 @@ enum ofono_vendor {
 	OFONO_VENDOR_ALCATEL,
 	OFONO_VENDOR_QUECTEL,
 	OFONO_VENDOR_UBLOX,
+	OFONO_VENDOR_CINTERION,
 };
-- =

1.9.1


--===============6869878050661055848==--

