Content-Type: multipart/mixed; boundary="===============9043543460355539508=="
MIME-Version: 1.0
From: Antara Borwankar <antara.borwankar@intel.com>
Subject: [PATCH] xmm7modem: Fix to set gateway in pdp context
Date: Wed, 18 Sep 2019 18:23:27 +0530
Message-ID: <1568811207-10491-1-git-send-email-antara.borwankar@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9043543460355539508==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

gateway was not being listed in context settings. Fixed teh bug
to show correct gateway address.
---
 drivers/ifxmodem/gprs-context.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ifxmodem/gprs-context.c b/drivers/ifxmodem/gprs-contex=
t.c
index 7bacb73..7c58b24 100644
--- a/drivers/ifxmodem/gprs-context.c
+++ b/drivers/ifxmodem/gprs-context.c
@@ -354,6 +354,9 @@ static void cgcontrdp_cb(gboolean ok, GAtResult *result=
, gpointer user_data)
 =

 	DBG("DNS: %s, %s\n", gcd->dns1, gcd->dns2);
 =

+	if (gw)
+		l_strlcpy(gcd->gateway, gw, sizeof(gcd->gateway));
+
 	if (gcd->proto =3D=3D OFONO_GPRS_PROTO_IP) {
 		if (!laddrnetmask ||
 			at_util_get_ipv4_address_and_netmask(laddrnetmask,
@@ -391,9 +394,6 @@ static void cgcontrdp_cb(gboolean ok, GAtResult *result=
, gpointer user_data)
 						IPV6_DEFAULT_PREFIX_LEN);
 	}
 =

-	if (gw)
-		l_strlcpy(gcd->gateway, gw, sizeof(gcd->gateway));
-
 	gcd->state =3D STATE_ACTIVE;
 =

 	DBG("address: %s\n", gcd->address);
-- =

1.9.1


--===============9043543460355539508==--

