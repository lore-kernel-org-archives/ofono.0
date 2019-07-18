Content-Type: multipart/mixed; boundary="===============2174992594075051783=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: [PATCH 04/10] Makefile
Date: Thu, 18 Jul 2019 12:23:08 +0200
Message-ID: <20190718102314.28094-4-jonas@norrbonn.se>
In-Reply-To: <20190718102314.28094-1-jonas@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2174992594075051783==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile.am b/Makefile.am
index 39777abc..7fb45d35 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -471,6 +471,7 @@ builtin_sources +=3D drivers/atmodem/atutil.h \
 			drivers/ubloxmodem/ubloxmodem.h \
 			drivers/ubloxmodem/ubloxmodem.c \
 			drivers/ubloxmodem/gprs-context.c \
+			drivers/ubloxmodem/network-registration.c \
 			drivers/ubloxmodem/netmon.c \
 			drivers/ubloxmodem/lte.c
 =

-- =

2.20.1


--===============2174992594075051783==--

