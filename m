Content-Type: multipart/mixed; boundary="===============6741899359118503607=="
MIME-Version: 1.0
From: Antara Borwankar <antara.borwankar@intel.com>
Subject: [PATCH] ifxmodem: removing TAP/TUN support check for XMM vendor
Date: Fri, 11 Jan 2019 16:05:47 +0530
Message-ID: <1547202947-2741-1-git-send-email-antara.borwankar@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6741899359118503607==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

skipping TAP/TUN support check from gprs-context probe for
xmm vendor. xmm modem does not require TAP/TUN support. Also
it is not enabled by default in enbedded yocto bsp.
---
 drivers/ifxmodem/gprs-context.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/ifxmodem/gprs-context.c b/drivers/ifxmodem/gprs-contex=
t.c
index 5d1da2d..7f3628b 100644
--- a/drivers/ifxmodem/gprs-context.c
+++ b/drivers/ifxmodem/gprs-context.c
@@ -616,9 +616,11 @@ static int ifx_gprs_context_probe(struct ofono_gprs_co=
ntext *gc,
 =

 	DBG("");
 =

-	if (stat(TUN_DEV, &st) < 0) {
-		ofono_error("Missing support for TUN/TAP devices");
-		return -ENODEV;
+	if (vendor !=3D OFONO_VENDOR_XMM) {
+		if (stat(TUN_DEV, &st) < 0) {
+			ofono_error("Missing support for TUN/TAP devices");
+			return -ENODEV;
+		}
 	}
 =

 	if (vendor !=3D OFONO_VENDOR_XMM) {
-- =

1.9.1


--===============6741899359118503607==--

