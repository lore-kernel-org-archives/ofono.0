Content-Type: multipart/mixed; boundary="===============9007561986328652358=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH] Move struct ussd_data definition out of the header.
Date: Thu, 18 Jun 2009 06:04:13 +0200
Message-ID: <1245297853-15286-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9007561986328652358==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

No fuctional change.
---
 src/ussd.c |    7 +++++++
 src/ussd.h |    7 -------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/src/ussd.c b/src/ussd.c
index c9796e5..7225398 100644
--- a/src/ussd.c
+++ b/src/ussd.c
@@ -49,6 +49,13 @@ enum ussd_state {
 	USSD_STATE_USER_ACTION =3D 2
 };
 =

+struct ussd_data {
+	struct ofono_ussd_ops *ops;
+	int state;
+	DBusMessage *pending;
+	int flags;
+};
+
 static struct ussd_data *ussd_create()
 {
 	struct ussd_data *r;
diff --git a/src/ussd.h b/src/ussd.h
index bfd707f..5b956e5 100644
--- a/src/ussd.h
+++ b/src/ussd.h
@@ -19,13 +19,6 @@
  *
  */
 =

-struct ussd_data {
-	struct ofono_ussd_ops *ops;
-	int state;
-	DBusMessage *pending;
-	int flags;
-};
-
 typedef gboolean (*ss_control_cb_t)(struct ofono_modem *modem,
 					enum ss_control_type type,
 					const char *sc,
-- =

1.6.0


--===============9007561986328652358==--

