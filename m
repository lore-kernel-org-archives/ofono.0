Content-Type: multipart/mixed; boundary="===============1029856939880186563=="
MIME-Version: 1.0
From: Philip Paeps <philip@paeps.cx>
Subject: [PATCH 1/4] atmodem: add vendor Quectel
Date: Thu, 26 Jun 2014 19:08:11 +0200
Message-ID: <1403802494-4542-2-git-send-email-philip@paeps.cx>
In-Reply-To: <1403802494-4542-1-git-send-email-philip@paeps.cx>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1029856939880186563==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/atmodem/vendor.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/atmodem/vendor.h b/drivers/atmodem/vendor.h
index bf2b38a..05ec872 100644
--- a/drivers/atmodem/vendor.h
+++ b/drivers/atmodem/vendor.h
@@ -42,5 +42,6 @@ enum ofono_vendor {
 	OFONO_VENDOR_SIMCOM_SIM900,
 	OFONO_VENDOR_ICERA,
 	OFONO_VENDOR_WAVECOM_Q2XXX,
-	OFONO_VENDOR_ALCATEL
+	OFONO_VENDOR_ALCATEL,
+	OFONO_VENDOR_QUECTEL
 };
-- =

1.7.10.4


--===============1029856939880186563==--

