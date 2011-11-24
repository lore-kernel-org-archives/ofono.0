Content-Type: multipart/mixed; boundary="===============8711868494899281246=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH 6/7] cdma-netreg: Make use of the new driver entry point
 serving_system
Date: Thu, 24 Nov 2011 18:46:23 +0100
Message-ID: <1322156784-10402-7-git-send-email-philippe.nunes@linux.intel.com>
In-Reply-To: <1322156784-10402-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8711868494899281246==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/cdma-netreg.c |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/src/cdma-netreg.c b/src/cdma-netreg.c
index 739d1ef..222c3b7 100644
--- a/src/cdma-netreg.c
+++ b/src/cdma-netreg.c
@@ -104,6 +104,24 @@ static GDBusSignalTable cdma_netreg_manager_signals[] =
=3D {
 	{ }
 };
 =

+static void serving_system_callback(const struct ofono_error *error,
+					const char *sid, void *data)
+{
+	struct ofono_cdma_netreg *cdma_netreg =3D data;
+
+	if (cdma_netreg->status !=3D CDMA_NETWORK_REGISTRATION_STATUS_REGISTERED
+			&& cdma_netreg->status !=3D
+				CDMA_NETWORK_REGISTRATION_STATUS_ROAMING)
+		return;
+
+	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
+		DBG("Error during serving system query");
+		return;
+	}
+
+	DBG("Serving system Identifier: %s", sid);
+}
+
 static void set_registration_status(struct ofono_cdma_netreg *cdma_netreg,
 						enum cdma_netreg_status status)
 {
@@ -117,6 +135,13 @@ static void set_registration_status(struct ofono_cdma_=
netreg *cdma_netreg,
 				OFONO_CDMA_NETWORK_REGISTRATION_INTERFACE,
 				"Status", DBUS_TYPE_STRING,
 				&str_status);
+
+	if (cdma_netreg->status =3D=3D CDMA_NETWORK_REGISTRATION_STATUS_REGISTERED
+			|| cdma_netreg->status =3D=3D
+				CDMA_NETWORK_REGISTRATION_STATUS_ROAMING)
+		if (cdma_netreg->driver->serving_system !=3D NULL)
+			cdma_netreg->driver->serving_system(cdma_netreg,
+				serving_system_callback, cdma_netreg);
 }
 =

 void ofono_cdma_netreg_status_notify(struct ofono_cdma_netreg *cdma_netreg,
-- =

1.7.1


--===============8711868494899281246==--

