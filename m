Content-Type: multipart/mixed; boundary="===============8693933216131789780=="
MIME-Version: 1.0
From: Jesper Larsen <jesper.larsen@ixonos.com>
Subject: [PATCH v2 1/3] atmodem: Add vendor entry for SIM900 module
Date: Thu, 18 Jul 2013 09:49:56 +0200
Message-ID: <1374133798-20488-1-git-send-email-jesper.larsen@ixonos.com>
In-Reply-To: <1374045255-26600-1-git-send-email-jesper.larsen@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8693933216131789780==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/atmodem/vendor.h |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/atmodem/vendor.h b/drivers/atmodem/vendor.h
index 0532d10..bf2b38a 100644
--- a/drivers/atmodem/vendor.h
+++ b/drivers/atmodem/vendor.h
@@ -39,6 +39,7 @@ enum ofono_vendor {
 	OFONO_VENDOR_SPEEDUP,
 	OFONO_VENDOR_SAMSUNG,
 	OFONO_VENDOR_SIMCOM,
+	OFONO_VENDOR_SIMCOM_SIM900,
 	OFONO_VENDOR_ICERA,
 	OFONO_VENDOR_WAVECOM_Q2XXX,
 	OFONO_VENDOR_ALCATEL
-- =

1.7.10.4


--===============8693933216131789780==--

