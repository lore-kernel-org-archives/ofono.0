Content-Type: multipart/mixed; boundary="===============2396136188600733360=="
MIME-Version: 1.0
From: Sjur =?unknown-8bit?q?Br=C3=A6ndeland?= <sjurbren@gmail.com>
Subject: [PATCH 1/3] stedriver: remove unsupported CAIF socket IOCTLs.
Date: Mon, 09 Aug 2010 23:29:38 +0200
Message-ID: <1281389380-12219-1-git-send-email-sjurbren@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2396136188600733360==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Sjur Br=C3=A6ndeland <sjur.brandeland@stericsson.com>

---
 drivers/stemodem/gprs-context.c |   48 +----------------------------------=
---
 1 files changed, 2 insertions(+), 46 deletions(-)

diff --git a/drivers/stemodem/gprs-context.c b/drivers/stemodem/gprs-contex=
t.c
index 2e54f9f..29ee446 100644
--- a/drivers/stemodem/gprs-context.c
+++ b/drivers/stemodem/gprs-context.c
@@ -173,26 +173,7 @@ static struct conn_info *conn_info_create(unsigned int=
 device,
  */
 static gboolean caif_if_create(const char *interface, unsigned int connid)
 {
-	int s;
-	static struct ifcaif_param param;
-	static struct ifreq ifr;
-
-	param.ipv4_connid =3D connid;
-	ifr.ifr_data =3D (void *) &param;
-	strcpy(ifr.ifr_name, interface);
-
-	s =3D socket(AF_CAIF, SOCK_SEQPACKET, CAIFPROTO_AT);
-	if (s < 0) {
-		DBG("Failed to create socket for CAIF interface");
-		return FALSE;
-	}
-
-	if (ioctl(s, SIOCCAIFNETNEW, &ifr) < 0) {
-		DBG("Failed to create IP interface for CAIF");
-		return FALSE;
-	}
-
-	return TRUE;
+	return FALSE;
 }
 =

 /*
@@ -200,32 +181,7 @@ static gboolean caif_if_create(const char *interface, =
unsigned int connid)
  */
 static gboolean caif_if_remove(const char *interface, unsigned int connid)
 {
-	int s;
-	static struct ifcaif_param param;
-	static struct ifreq ifr;
-
-	param.ipv4_connid =3D connid;
-	ifr.ifr_data =3D (void *) &param;
-	strcpy(ifr.ifr_name, interface);
-
-	s =3D socket(AF_CAIF, SOCK_SEQPACKET, CAIFPROTO_AT);
-	if (s < 0) {
-		DBG("Failed to create socket for CAIF interface");
-		return FALSE;
-	}
-
-	if (ioctl(s, SIOCGIFINDEX, &ifr) !=3D 0) {
-		DBG("Did not find interface (%s) to remove",
-				interface);
-		return FALSE;
-	}
-
-	if (ioctl(s, SIOCCAIFNETREMOVE, &ifr) < 0) {
-		DBG("Failed to remove IP interface for CAIF");
-		return FALSE;
-	}
-
-	return TRUE;
+	return FALSE;
 }
 =

 static void ste_eppsd_down_cb(gboolean ok, GAtResult *result,
-- =

1.6.3.3


--===============2396136188600733360==--

