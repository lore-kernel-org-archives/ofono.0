Content-Type: multipart/mixed; boundary="===============3436394490472728466=="
MIME-Version: 1.0
From: Jupiter <jupiter.hce@gmail.com>
Subject: [PATCH 2/4] Add SARA R4 vendor ID
Date: Mon, 22 Feb 2021 21:14:47 +1100
Message-ID: <20210222101449.2809-3-jupiter.hce@gmail.com>
In-Reply-To: <20210222101449.2809-1-jupiter.hce@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3436394490472728466==
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

2.17.1

--===============3436394490472728466==--

