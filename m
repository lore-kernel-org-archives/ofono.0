Content-Type: multipart/mixed; boundary="===============3811547561916163160=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky@linux.intel.com>
Subject: [RFC patches 09/13] Add function doc headers to ofono_sms_{create,
 register}
Date: Wed, 26 May 2010 12:49:23 -0700
Message-ID: <e25f5c84bb2a1e67a9aa2253b568ee5c500c2e12.1274903142.git.inaky.perez-gonzalez@intel.com>
In-Reply-To: <cover.1274903142.git.inaky.perez-gonzalez@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3811547561916163160==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>

Signed-off-by: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>
---
 src/sms.c |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/src/sms.c b/src/sms.c
index 594481e..26b1653 100644
--- a/src/sms.c
+++ b/src/sms.c
@@ -910,6 +910,17 @@ static void sms_remove(struct ofono_atom *atom)
 	g_free(sms);
 }
 =

+
+/*
+ * Create a SMS driver
+ *
+ * This creates a SMS driver that is hung off a @modem
+ * object. However, for the driver to be used by the system, it has to
+ * be registered with the oFono core using ofono_sms_register().
+ *
+ * This is done once the modem driver determines that SMS is properly
+ * supported by the hardware.
+ */
 struct ofono_sms *ofono_sms_create(struct ofono_modem *modem,
 					unsigned int vendor,
 					const char *driver,
@@ -980,6 +991,14 @@ static void sms_load_settings(struct ofono_sms *sms, c=
onst char *imsi)
 =

 }
 =

+
+/*
+ * Indicate oFono that a SMS driver is ready for operation
+ *
+ * This is called after ofono_sms_create() was done and the modem
+ * driver determined that a modem supports SMS correctly. Once this
+ * call succeeds, the D-BUS interface for SMS goes live.
+ */
 void ofono_sms_register(struct ofono_sms *sms)
 {
 	DBusConnection *conn =3D ofono_dbus_get_connection();
-- =

1.6.6.1


--===============3811547561916163160==--

