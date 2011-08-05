Content-Type: multipart/mixed; boundary="===============0283477067634710380=="
MIME-Version: 1.0
From: Bertrand Aygon <bertrand.aygon@intel.com>
Subject: [PATCH_v6 04/14] cdmamodem: define cdma network status.
Date: Fri, 05 Aug 2011 15:21:05 +0200
Message-ID: <1312550475-8537-5-git-send-email-bertrand.aygon@intel.com>
In-Reply-To: <1312550475-8537-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0283477067634710380==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 include/cdma-netreg.h |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/include/cdma-netreg.h b/include/cdma-netreg.h
index 8ee7737..126a5a5 100644
--- a/include/cdma-netreg.h
+++ b/include/cdma-netreg.h
@@ -28,6 +28,12 @@ extern "C" {
 =

 #include <ofono/types.h>
 =

+enum cdma_netreg_status {
+	CDMA_NETWORK_REGISTRATION_STATUS_NOT_REGISTERED =3D	0,
+	CDMA_NETWORK_REGISTRATION_STATUS_REGISTERED =3D		1,
+	CDMA_NETWORK_REGISTRATION_STATUS_ROAMING =3D		2,
+};
+
 struct ofono_cdma_netreg;
 =

 struct ofono_cdma_netreg_driver {
@@ -38,6 +44,9 @@ struct ofono_cdma_netreg_driver {
 	void (*remove)(struct ofono_cdma_netreg *cdma_netreg);
 };
 =

+void ofono_cdma_netreg_status_notify(struct ofono_cdma_netreg *netreg,
+				enum cdma_netreg_status status);
+
 int ofono_cdma_netreg_driver_register(
 				const struct ofono_cdma_netreg_driver *d);
 void ofono_cdma_netreg_driver_unregister(
-- =

1.7.4.1

---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

--===============0283477067634710380==--

