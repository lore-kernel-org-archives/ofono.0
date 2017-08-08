Content-Type: multipart/mixed; boundary="===============9217186814791490987=="
MIME-Version: 1.0
From: Alexander Couzens <lynxis@fe80.eu>
Subject: [PATCH 1/2] gprs-context: set apn length to 100 bytes
Date: Tue, 08 Aug 2017 15:53:44 +0200
Message-ID: <20170808135345.10755-1-lynxis@fe80.eu>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9217186814791490987==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

According to ETSI TS 123 003 version 9.15.0 Chapter 9.1
---
 include/gprs-context.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/gprs-context.h b/include/gprs-context.h
index ab673265..7e163cc9 100644
--- a/include/gprs-context.h
+++ b/include/gprs-context.h
@@ -30,7 +30,7 @@ extern "C" {
 =

 struct ofono_gprs_context;
 =

-#define OFONO_GPRS_MAX_APN_LENGTH 127
+#define OFONO_GPRS_MAX_APN_LENGTH 100
 #define OFONO_GPRS_MAX_USERNAME_LENGTH 63
 #define OFONO_GPRS_MAX_PASSWORD_LENGTH 255
 =

-- =

2.13.4


--===============9217186814791490987==--

