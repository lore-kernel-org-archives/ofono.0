Content-Type: multipart/mixed; boundary="===============6379549175129364942=="
MIME-Version: 1.0
From: Jeevaka Badrappan <jeevaka.badrappan@elektrobit.com>
Subject: [PATCH 14/16] plugins: M15 coding style fix
Date: Wed, 12 Jan 2011 12:52:16 +0200
Message-ID: <1294829538-3893-15-git-send-email-jeevaka.badrappan@elektrobit.com>
In-Reply-To: <1294829538-3893-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6379549175129364942==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/bluetooth.h         |    2 +-
 plugins/hfp.c               |    6 +++---
 plugins/push-notification.c |    4 ++--
 plugins/smart-messaging.c   |    4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/plugins/bluetooth.h b/plugins/bluetooth.h
index f187529..42b0d13 100644
--- a/plugins/bluetooth.h
+++ b/plugins/bluetooth.h
@@ -35,7 +35,7 @@ struct bluetooth_profile {
 	const char *name;
 	int (*create)(const char *device, const char *dev_addr,
 			const char *adapter_addr, const char *alias);
-	void (*remove_all)();
+	void (*remove_all)(void);
 	void (*set_alias)(const char *device, const char *);
 };
 =

diff --git a/plugins/hfp.c b/plugins/hfp.c
index d8d30b0..12d3457 100644
--- a/plugins/hfp.c
+++ b/plugins/hfp.c
@@ -453,7 +453,7 @@ static gboolean hfp_remove_each_modem(gpointer key, gpo=
inter value,
 	return TRUE;
 }
 =

-static void hfp_remove_all_modem()
+static void hfp_remove_all_modem(void)
 {
 	if (modem_hash =3D=3D NULL)
 		return;
@@ -682,7 +682,7 @@ static struct bluetooth_profile hfp_profile =3D {
 	.set_alias	=3D hfp_set_alias,
 };
 =

-static int hfp_init()
+static int hfp_init(void)
 {
 	int err;
 =

@@ -707,7 +707,7 @@ static int hfp_init()
 	return 0;
 }
 =

-static void hfp_exit()
+static void hfp_exit(void)
 {
 	bluetooth_unregister_uuid(HFP_AG_UUID);
 	ofono_modem_driver_unregister(&hfp_driver);
diff --git a/plugins/push-notification.c b/plugins/push-notification.c
index d910f70..218bf8c 100644
--- a/plugins/push-notification.c
+++ b/plugins/push-notification.c
@@ -224,7 +224,7 @@ static void call_modemwatch(struct ofono_modem *modem, =
void *user)
 	modem_watch(modem, TRUE, user);
 }
 =

-static int push_notification_init()
+static int push_notification_init(void)
 {
 	DBG("");
 =

@@ -235,7 +235,7 @@ static int push_notification_init()
 	return 0;
 }
 =

-static void push_notification_exit()
+static void push_notification_exit(void)
 {
 	DBG("");
 =

diff --git a/plugins/smart-messaging.c b/plugins/smart-messaging.c
index e7889f2..40af89f 100644
--- a/plugins/smart-messaging.c
+++ b/plugins/smart-messaging.c
@@ -345,7 +345,7 @@ static void call_modemwatch(struct ofono_modem *modem, =
void *user)
 	modem_watch(modem, TRUE, user);
 }
 =

-static int smart_messaging_init()
+static int smart_messaging_init(void)
 {
 	DBG("");
 =

@@ -356,7 +356,7 @@ static int smart_messaging_init()
 	return 0;
 }
 =

-static void smart_messaging_exit()
+static void smart_messaging_exit(void)
 {
 	DBG("");
 =

-- =

1.7.0.4


--===============6379549175129364942==--

