Content-Type: multipart/mixed; boundary="===============6884776265058329518=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH v2 12/12] huaweicdmamodem: Fix sysinfo parsing
Date: Thu, 08 Dec 2011 15:50:03 +0100
Message-ID: <1323355803-22096-13-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1323355803-22096-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6884776265058329518==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In practice, the service domain is set to 255 (cdma not supported)
with an EV-DO capable hardware.
---
 drivers/huaweicdmamodem/network-registration.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/huaweicdmamodem/network-registration.c b/drivers/huawe=
icdmamodem/network-registration.c
index 8b6378c..ca746f8 100644
--- a/drivers/huaweicdmamodem/network-registration.c
+++ b/drivers/huaweicdmamodem/network-registration.c
@@ -134,13 +134,13 @@ static gboolean parse_sysinfo(GAtResult *result, gint=
 *status)
 =

 	switch (srv_domain) {
 	case 0: /* No service */
-	case 255: /* CDMA not supported */
 		*status =3D CDMA_NETWORK_REGISTRATION_STATUS_NOT_REGISTERED;
 		break;
 	case 1: /* Only CS */
 	case 2: /* Only PS */
 	case 3: /* CS  PS */
 	case 4: /* CS registered, PS in searching state */
+	case 255: /* CDMA not supported */
 		break;
 	}
 =

-- =

1.7.1


--===============6884776265058329518==--

