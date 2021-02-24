Content-Type: multipart/mixed; boundary="===============6405579039592569427=="
MIME-Version: 1.0
From: Bing Jupiter <jupiter.hce@gmail.com>
Subject: [PATCH v2 3/4] Add SARA R4 vendor ID
Date: Wed, 24 Feb 2021 19:39:23 +1100
Message-ID: <20210224083924.3480-4-jupiter.hce@gmail.com>
In-Reply-To: <20210224083924.3480-1-jupiter.hce@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6405579039592569427==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/atmodem/vendor.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/atmodem/vendor.h b/drivers/atmodem/vendor.h
index 82284e44..db9fa263 100644
--- a/drivers/atmodem/vendor.h
+++ b/drivers/atmodem/vendor.h
@@ -48,6 +48,7 @@ enum ofono_vendor {
 	OFONO_VENDOR_QUECTEL_EC2X,
 	OFONO_VENDOR_QUECTEL_SERIAL,
 	OFONO_VENDOR_UBLOX,
+	OFONO_VENDOR_UBLOX_SARA_R4,
 	OFONO_VENDOR_XMM,
 	OFONO_VENDOR_GEMALTO,
 };
-- =

2.25.1

--===============6405579039592569427==--

