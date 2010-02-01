Content-Type: multipart/mixed; boundary="===============6570809099867550752=="
MIME-Version: 1.0
From: sjur.brandeland@stericsson.com
Subject: [PATCH 2/2] Fix: Check if interface exists before creating it.
Date: Mon, 01 Feb 2010 16:50:24 +0100
Message-ID: <1265039424-1961-2-git-send-email-sjur.brandeland@stericsson.com>
In-Reply-To: <1265039424-1961-1-git-send-email-sjur.brandeland@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6570809099867550752==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Sjur Br=C3=A6ndeland <sjur.brandeland@stericsson.com>

---
 drivers/stemodem/gprs-context.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/stemodem/gprs-context.c b/drivers/stemodem/gprs-contex=
t.c
index c178fb6..79e697b 100644
--- a/drivers/stemodem/gprs-context.c
+++ b/drivers/stemodem/gprs-context.c
@@ -187,9 +187,11 @@ static gboolean caif_if_create(const char *interface, =
unsigned int connid)
 		return FALSE;
 	}
 =

-	if (ioctl(s, SIOCCAIFNETNEW, &ifr) < 0) {
-		ofono_debug("Failed to create IP interface for CAIF");
-		return FALSE;
+	if (ioctl(s, SIOCGIFINDEX, &ifr) !=3D 0) {
+		if (ioctl(s, SIOCCAIFNETNEW, &ifr) < 0) {
+			ofono_debug("Failed to create IP interface for CAIF");
+			return FALSE;
+		}
 	}
 =

 	return TRUE;
-- =

1.6.3.3


--===============6570809099867550752==--

