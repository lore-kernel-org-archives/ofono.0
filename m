Content-Type: multipart/mixed; boundary="===============6106170429404214448=="
MIME-Version: 1.0
From: Dragos Tatulea <dragos@endocode.com>
Subject: [PATCH 04/19] include: vendor.h: add vendor for ublox toby
Date: Wed, 09 Mar 2016 16:44:45 +0100
Message-ID: <1457538300-7183-5-git-send-email-dragos@endocode.com>
In-Reply-To: <1457538300-7183-1-git-send-email-dragos@endocode.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6106170429404214448==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Required to differentiate between the old LISA family
of supported devices and future TOBY L2 devices.
---
 drivers/atmodem/vendor.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/atmodem/vendor.h b/drivers/atmodem/vendor.h
index 52071c8..71a9af7 100644
--- a/drivers/atmodem/vendor.h
+++ b/drivers/atmodem/vendor.h
@@ -45,5 +45,6 @@ enum ofono_vendor {
 	OFONO_VENDOR_ALCATEL,
 	OFONO_VENDOR_QUECTEL,
 	OFONO_VENDOR_UBLOX,
+	OFONO_VENDOR_UBLOX_TOBY_L2,
 	OFONO_VENDOR_CINTERION,
 };
-- =

2.5.0


--===============6106170429404214448==--

