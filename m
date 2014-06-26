Content-Type: multipart/mixed; boundary="===============3729235213395293999=="
MIME-Version: 1.0
From: Philip Paeps <philip@paeps.cx>
Subject: [PATCH 1/6] atmodem: add vendor u-blox
Date: Thu, 26 Jun 2014 20:28:13 +0200
Message-ID: <1403807298-14588-2-git-send-email-philip@paeps.cx>
In-Reply-To: <1403807298-14588-1-git-send-email-philip@paeps.cx>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3729235213395293999==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/atmodem/vendor.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/atmodem/vendor.h b/drivers/atmodem/vendor.h
index bf2b38a..de3c455 100644
--- a/drivers/atmodem/vendor.h
+++ b/drivers/atmodem/vendor.h
@@ -42,5 +42,6 @@ enum ofono_vendor {
 	OFONO_VENDOR_SIMCOM_SIM900,
 	OFONO_VENDOR_ICERA,
 	OFONO_VENDOR_WAVECOM_Q2XXX,
-	OFONO_VENDOR_ALCATEL
+	OFONO_VENDOR_ALCATEL,
+	OFONO_VENDOR_UBLOX
 };
-- =

1.7.10.4


--===============3729235213395293999==--

