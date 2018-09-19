Content-Type: multipart/mixed; boundary="===============5142904387419582865=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: [PATCH 5/7] extended support for LTE and NR. Some minor fixes. part 5
 of 7
Date: Wed, 19 Sep 2018 07:37:31 +0200
Message-ID: <1537335453-21498-5-git-send-email-gciofono@gmail.com>
In-Reply-To: <1537335453-21498-1-git-send-email-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5142904387419582865==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gatmux.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/gatchat/gatmux.c b/gatchat/gatmux.c
index 9660006..21552d9 100644
--- a/gatchat/gatmux.c
+++ b/gatchat/gatmux.c
@@ -30,8 +30,8 @@
 #include <string.h>
 #include <alloca.h>
 =

-#pragma GCC diagnostic ignored "-Wpragmas"
-#pragma GCC diagnostic ignored "-Wcast-function-type"
+//#pragma GCC diagnostic ignored "-Wpragmas"
+//#pragma GCC diagnostic ignored "-Wcast-function-type"
 =

 #include <glib.h>
 =

-- =

1.9.1


--===============5142904387419582865==--

