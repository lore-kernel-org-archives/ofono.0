Content-Type: multipart/mixed; boundary="===============8908754091499433400=="
MIME-Version: 1.0
From: Olivier Guiter <olivier.guiter@linux.intel.com>
Subject: [PATCH] gnss: fix build broken
Date: Tue, 29 Mar 2011 10:53:47 +0200
Message-ID: <1301388827-21563-1-git-send-email-olivier.guiter@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8908754091499433400==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/atmodem/gnss.c |    1 -
 plugins/phonesim.c     |    1 +
 2 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/atmodem/gnss.c b/drivers/atmodem/gnss.c
index 4954bb8..e102815 100644
--- a/drivers/atmodem/gnss.c
+++ b/drivers/atmodem/gnss.c
@@ -153,7 +153,6 @@ static gboolean gnss_parse_report(GAtResult *result, co=
nst char *prefix,
 =

 static void gnss_report(GAtResult *result, gpointer user_data)
 {
-	struct ofono_gnss *gnss =3D user_data;
 	const char *xml;
 =

 	DBG("");
diff --git a/plugins/phonesim.c b/plugins/phonesim.c
index 6bb5977..1a6703d 100644
--- a/plugins/phonesim.c
+++ b/plugins/phonesim.c
@@ -58,6 +58,7 @@
 #include <ofono/voicecall.h>
 #include <ofono/gprs.h>
 #include <ofono/gprs-context.h>
+#include <ofono/gnss.h>
 =

 #include <drivers/atmodem/vendor.h>
 #include <drivers/atmodem/sim-poll.h>
-- =

1.7.1


--===============8908754091499433400==--

