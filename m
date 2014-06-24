Content-Type: multipart/mixed; boundary="===============0853917715252118550=="
MIME-Version: 1.0
From: Philip Paeps <philip@paeps.cx>
Subject: [PATCH 1/4] atmodem: add vendor Quectel
Date: Tue, 24 Jun 2014 12:08:39 +0200
Message-ID: <1403604522-22645-2-git-send-email-philip@paeps.cx>
In-Reply-To: <1403604522-22645-1-git-send-email-philip@paeps.cx>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0853917715252118550==
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


--===============0853917715252118550==--

