Content-Type: multipart/mixed; boundary="===============3492184454253006782=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: [PATCH 1/4] n900: Use consistent naming in GPIO API
Date: Mon, 14 May 2012 21:03:08 +0300
Message-ID: <1337018591-6553-1-git-send-email-aki.niemi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3492184454253006782==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

In addition, add header guards as the API can be used from more than
one plugin.
---
 plugins/n900.c       |   12 +++---
 plugins/nokia-gpio.c |  106 ++++++++++++++++++++++------------------------=
----
 plugins/nokia-gpio.h |   37 +++++++++++++++--
 3 files changed, 85 insertions(+), 70 deletions(-)

diff --git a/plugins/n900.c b/plugins/n900.c
index 44e2e75..420fd0c 100644
--- a/plugins/n900.c
+++ b/plugins/n900.c
@@ -308,7 +308,7 @@ static void n900_power_cb(enum power_state state, void =
*data)
 	struct ofono_modem *modem =3D data;
 	struct isi_data *isi =3D ofono_modem_get_data(modem);
 =

-	DBG("power state %s", gpio_power_state_name(state));
+	DBG("power state %s", nokia_gpio_power_state_name(state));
 =

 	isi->power_state =3D state;
 =

@@ -358,7 +358,7 @@ static int n900_probe(struct ofono_modem *modem)
 	if (getenv("OFONO_ISI_TRACE"))
 		g_isi_modem_set_trace(isimodem, isi_trace);
 =

-	if (gpio_probe(isimodem, address, n900_power_cb, modem) !=3D 0) {
+	if (nokia_gpio_probe(isimodem, address, n900_power_cb, modem) !=3D 0) {
 		DBG("gpio for %s: %s", ifname, strerror(errno));
 		goto error;
 	}
@@ -382,7 +382,7 @@ static int n900_probe(struct ofono_modem *modem)
 =

 error:
 	g_isi_modem_destroy(isimodem);
-	gpio_remove(modem);
+	nokia_gpio_remove(modem);
 	g_free(isi);
 =

 	return -errno;
@@ -397,7 +397,7 @@ static void n900_remove(struct ofono_modem *modem)
 	if (!isi)
 		return;
 =

-	gpio_remove(modem);
+	nokia_gpio_remove(modem);
 =

 	if (isi->timeout)
 		g_source_remove(isi->timeout);
@@ -523,7 +523,7 @@ static int n900_enable(struct ofono_modem *modem)
 =

 	isi->enabled =3D TRUE;
 =

-	return gpio_enable(modem);
+	return nokia_gpio_enable(modem);
 }
 =

 static int n900_disable(struct ofono_modem *modem)
@@ -534,7 +534,7 @@ static int n900_disable(struct ofono_modem *modem)
 =

 	isi->enabled =3D FALSE;
 =

-	return gpio_disable(modem);
+	return nokia_gpio_disable(modem);
 }
 =

 static struct ofono_modem_driver n900_driver =3D {
diff --git a/plugins/nokia-gpio.c b/plugins/nokia-gpio.c
index 57aad8d..d9e05f3 100644
--- a/plugins/nokia-gpio.c
+++ b/plugins/nokia-gpio.c
@@ -60,18 +60,6 @@ enum phonet_link {
 	PHONET_LINK_UP,
 };
 =

-enum power_event {
-	POWER_EVENT_PHONET_LINK_UP =3D 1,
-	POWER_EVENT_PHONET_LINK_DOWN,
-	POWER_EVENT_ON,
-	POWER_EVENT_ON_TIMEOUT,
-	POWER_EVENT_REBOOT_TIMEOUT,
-	POWER_EVENT_OFF,
-	POWER_EVENT_OFF_IMMEDIATELY,
-	POWER_EVENT_OFF_TIMEOUT,
-	POWER_EVENT_OFF_COMPLETE,
-};
-
 struct gpio_data {
 	GIsiPhonetNetlink *link;
 	gpio_finished_cb_t callback;
@@ -98,41 +86,6 @@ struct gpio_data {
 =

 static struct gpio_data self;
 =

-#define _(X) case X: return #X
-
-static inline char const *gpio_power_event_name(enum power_event value)
-{
-	switch (value) {
-		_(POWER_EVENT_PHONET_LINK_UP);
-		_(POWER_EVENT_PHONET_LINK_DOWN);
-		_(POWER_EVENT_ON);
-		_(POWER_EVENT_ON_TIMEOUT);
-		_(POWER_EVENT_REBOOT_TIMEOUT);
-		_(POWER_EVENT_OFF);
-		_(POWER_EVENT_OFF_IMMEDIATELY);
-		_(POWER_EVENT_OFF_TIMEOUT);
-		_(POWER_EVENT_OFF_COMPLETE);
-	}
-	return "<UNKNOWN>";
-}
-
-char const *gpio_power_state_name(enum power_state value)
-{
-	switch (value) {
-		_(POWER_STATE_NONE);
-		_(POWER_STATE_ON_STARTED);
-		_(POWER_STATE_ON);
-		_(POWER_STATE_ON_RESET);
-		_(POWER_STATE_ON_FAILED);
-		_(POWER_STATE_OFF_STARTED);
-		_(POWER_STATE_OFF_WAITING);
-		_(POWER_STATE_OFF);
-	}
-	return "<UNKNOWN>";
-}
-
-#undef _
-
 static void gpio_power_state_machine(enum power_event event);
 static void gpio_power_set_state(enum power_state new_state);
 =

@@ -324,14 +277,13 @@ static gboolean gpio_power_timer_cb(gpointer user)
 	return FALSE;
 }
 =

-
 static void gpio_power_state_machine(enum power_event event)
 {
 	enum power_state new_state;
 =

 	DBG("(%s) @ state %s",
-		gpio_power_event_name(event),
-		gpio_power_state_name(self.state));
+		nokia_gpio_power_event_name(event),
+		nokia_gpio_power_state_name(self.state));
 =

 	switch (event) {
 	case POWER_EVENT_ON:
@@ -491,10 +443,10 @@ static void gpio_power_state_machine(enum power_event=
 event)
 		return;
 	}
 =

-	DBG("Event %s (%d) not handled", gpio_power_event_name(event), event);
+	DBG("Event %s (%d) not handled", nokia_gpio_power_event_name(event),
+		event);
 }
 =

-
 static void gpio_power_set_state(enum power_state new_state)
 {
 	enum power_state old_state =3D self.state;
@@ -502,8 +454,8 @@ static void gpio_power_set_state(enum power_state new_s=
tate)
 	enum power_event timer_event;
 =

 	DBG("(%s) at (%s)%s",
-		gpio_power_state_name(new_state),
-		gpio_power_state_name(old_state),
+		nokia_gpio_power_state_name(new_state),
+		nokia_gpio_power_state_name(old_state),
 		new_state =3D=3D old_state ? " - already" : "");
 =

 	switch (old_state) {
@@ -707,8 +659,8 @@ static int gpio_probe_links(void)
 	return -(errno =3D ENODEV);
 }
 =

-
-int gpio_probe(GIsiModem *idx, unsigned addr, gpio_finished_cb_t cb, void =
*data)
+int nokia_gpio_probe(GIsiModem *idx, unsigned addr, gpio_finished_cb_t cb,
+			void *data)
 {
 	int error;
 =

@@ -774,7 +726,7 @@ int gpio_probe(GIsiModem *idx, unsigned addr, gpio_fini=
shed_cb_t cb, void *data)
 	return 0;
 }
 =

-int gpio_remove(void *data)
+int nokia_gpio_remove(void *data)
 {
 	if (self.data !=3D data)
 		return -EINVAL;
@@ -792,7 +744,7 @@ int gpio_remove(void *data)
 	return 0;
 }
 =

-int gpio_enable(void *data)
+int nokia_gpio_enable(void *data)
 {
 	if (self.data !=3D data)
 		return -EINVAL;
@@ -805,7 +757,7 @@ int gpio_enable(void *data)
 	return -EINPROGRESS;
 }
 =

-int gpio_disable(void *data)
+int nokia_gpio_disable(void *data)
 {
 	if (self.data !=3D data)
 		return -EINVAL;
@@ -818,3 +770,39 @@ int gpio_disable(void *data)
 =

 	return -EINPROGRESS;
 }
+
+
+#define _(X) case X: return #X
+
+const char *nokia_gpio_power_event_name(enum power_event value)
+{
+	switch (value) {
+		_(POWER_EVENT_PHONET_LINK_UP);
+		_(POWER_EVENT_PHONET_LINK_DOWN);
+		_(POWER_EVENT_ON);
+		_(POWER_EVENT_ON_TIMEOUT);
+		_(POWER_EVENT_REBOOT_TIMEOUT);
+		_(POWER_EVENT_OFF);
+		_(POWER_EVENT_OFF_IMMEDIATELY);
+		_(POWER_EVENT_OFF_TIMEOUT);
+		_(POWER_EVENT_OFF_COMPLETE);
+	}
+	return "<UNKNOWN>";
+}
+
+const char *nokia_gpio_power_state_name(enum power_state value)
+{
+	switch (value) {
+		_(POWER_STATE_NONE);
+		_(POWER_STATE_ON_STARTED);
+		_(POWER_STATE_ON);
+		_(POWER_STATE_ON_RESET);
+		_(POWER_STATE_ON_FAILED);
+		_(POWER_STATE_OFF_STARTED);
+		_(POWER_STATE_OFF_WAITING);
+		_(POWER_STATE_OFF);
+	}
+	return "<UNKNOWN>";
+}
+
+#undef _
diff --git a/plugins/nokia-gpio.h b/plugins/nokia-gpio.h
index b653bb8..991c10a 100644
--- a/plugins/nokia-gpio.h
+++ b/plugins/nokia-gpio.h
@@ -19,6 +19,13 @@
  *
  */
 =

+#ifndef __NOKIA_GPIO_H
+#define __NOKIA_GPIO_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
 enum power_state {
 	POWER_STATE_NONE,
 	POWER_STATE_ON_STARTED,
@@ -30,11 +37,31 @@ enum power_state {
 	POWER_STATE_OFF,
 };
 =

+enum power_event {
+	POWER_EVENT_PHONET_LINK_UP =3D 1,
+	POWER_EVENT_PHONET_LINK_DOWN,
+	POWER_EVENT_ON,
+	POWER_EVENT_ON_TIMEOUT,
+	POWER_EVENT_REBOOT_TIMEOUT,
+	POWER_EVENT_OFF,
+	POWER_EVENT_OFF_IMMEDIATELY,
+	POWER_EVENT_OFF_TIMEOUT,
+	POWER_EVENT_OFF_COMPLETE,
+};
+
 typedef void (*gpio_finished_cb_t)(enum power_state value, void *opaque);
 =

-int gpio_probe(GIsiModem *idx, unsigned addr, gpio_finished_cb_t cb, void =
*data);
-int gpio_enable(void *opaque);
-int gpio_disable(void *opaque);
-int gpio_remove(void *opaque);
+int nokia_gpio_probe(GIsiModem *idx, unsigned addr, gpio_finished_cb_t cb,
+			void *data);
+int nokia_gpio_enable(void *opaque);
+int nokia_gpio_disable(void *opaque);
+int nokia_gpio_remove(void *opaque);
+
+const char *nokia_gpio_power_event_name(enum power_event value);
+const char *nokia_gpio_power_state_name(enum power_state value);
+
+#ifdef __cplusplus
+};
+#endif
 =

-char const *gpio_power_state_name(enum power_state value);
+#endif /* !__NOKIA_GPIO_H */
-- =

1.7.5.4


--===============3492184454253006782==--

