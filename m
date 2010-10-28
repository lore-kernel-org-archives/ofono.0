Content-Type: multipart/mixed; boundary="===============4734218365103517055=="
MIME-Version: 1.0
From: Sjur =?unknown-8bit?q?Br=C3=A6ndeland?= <sjurbren@gmail.com>
Subject: [PATCH 4/4] stemodem: Add rtnl to Makefile.
Date: Thu, 28 Oct 2010 16:04:01 +0200
Message-ID: <1288274641-4216-4-git-send-email-sjurbren@gmail.com>
In-Reply-To: <1288274641-4216-1-git-send-email-sjurbren@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4734218365103517055==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Sjur Br=C3=A6ndeland <sjur.brandeland@stericsson.com>

---
 Makefile.am |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/Makefile.am b/Makefile.am
index 2562160..1b09a3c 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -226,6 +226,8 @@ builtin_sources +=3D drivers/atmodem/atutil.h \
 			drivers/stemodem/stemodem.c \
 			drivers/stemodem/voicecall.c \
 			drivers/stemodem/radio-settings.c \
+			drivers/stemodem/rtnl.c \
+			drivers/stemodem/rtnl.h \
 			drivers/stemodem/gprs-context.c \
 			drivers/stemodem/caif_socket.h \
 			drivers/stemodem/if_caif.h
-- =

1.6.3.3


--===============4734218365103517055==--

