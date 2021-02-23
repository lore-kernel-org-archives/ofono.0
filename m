Content-Type: multipart/mixed; boundary="===============8634917481296708687=="
MIME-Version: 1.0
From: Bing Jupiter <jupiter.hce@gmail.com>
Subject: [PATCH v1 2/5] Change 2: Add SARA R4 vendor ID
Date: Tue, 23 Feb 2021 15:46:50 +1100
Message-ID: <20210223044653.4933-3-jupiter.hce@gmail.com>
In-Reply-To: <20210223044653.4933-1-jupiter.hce@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8634917481296708687==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: jupiter <jupiter.hce@gmail.com>

---
 drivers/atmodem/vendor.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/atmodem/vendor.h b/drivers/atmodem/vendor.h
index 82284e44..38613679 100644
--- a/drivers/atmodem/vendor.h
+++ b/drivers/atmodem/vendor.h
@@ -48,6 +48,7 @@ enum ofono_vendor {
 	OFONO_VENDOR_QUECTEL_EC2X,
 	OFONO_VENDOR_QUECTEL_SERIAL,
 	OFONO_VENDOR_UBLOX,
+    OFONO_VENDOR_UBLOX_SARA_R4,
 	OFONO_VENDOR_XMM,
 	OFONO_VENDOR_GEMALTO,
 };
-- =

2.25.1

--===============8634917481296708687==--

