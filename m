Content-Type: multipart/mixed; boundary="===============4402482714973356038=="
MIME-Version: 1.0
From: Joey Hewitt <joey@joeyhewitt.com>
Subject: [PATCH 2/2] gobi/qmi: support smdpkt device (MSM kernel forks)
Date: Fri, 13 Apr 2018 12:14:40 -0600
Message-ID: <484afe375a0890660a8ab6ea61cd79d12aed7208.1523728975.git.joey@joeyhewitt.com>
In-Reply-To: <cover.1523728975.git.joey@joeyhewitt.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4402482714973356038==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Search udev for smdpkt devices, work around smdpkt's poll() not
reporting when writable (we make writes block, and don't poll)
and plumb the subystem type through so we can activate that
workaround.
---
 drivers/qmimodem/qmi.c | 33 +++++++++++++++++++++++++++++----
 drivers/qmimodem/qmi.h |  6 +++++-
 plugins/gobi.c         |  7 +++++--
 plugins/udevng.c       |  5 +++++
 4 files changed, 44 insertions(+), 7 deletions(-)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 19ec130..8dd293d 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -29,6 +29,7 @@
 #include <dirent.h>
 #include <errno.h>
 #include <fcntl.h>
+#include <sys/ioctl.h>
 #include <unistd.h>
 #include <stdlib.h>
 #include <string.h>
@@ -82,6 +83,7 @@ struct qmi_device {
 	guint shutdown_source;
 	bool shutting_down : 1;
 	bool destroyed : 1;
+	bool is_smdpkt : 1;
 };
 =

 struct qmi_service {
@@ -679,6 +681,13 @@ static gboolean can_write_data(GIOChannel *channel, GI=
OCondition cond,
 	return FALSE;
 }
 =

+static gboolean can_write_data_idle(gpointer user_data)
+{
+	struct qmi_device *device =3D user_data;
+
+	return can_write_data(device->io, G_IO_OUT, user_data);
+}
+
 static void write_watch_destroy(gpointer user_data)
 {
 	struct qmi_device *device =3D user_data;
@@ -691,9 +700,15 @@ static void wakeup_writer(struct qmi_device *device)
 	if (device->write_watch > 0)
 		return;
 =

-	device->write_watch =3D g_io_add_watch_full(device->io, G_PRIORITY_HIGH,
-				G_IO_OUT | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
-				can_write_data, device, write_watch_destroy);
+	if (!device->is_smdpkt) {
+		device->write_watch =3D g_io_add_watch_full(device->io, G_PRIORITY_HIGH,
+					G_IO_OUT | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
+					can_write_data, device, write_watch_destroy);
+	} else {
+		// Polling G_IO_OUT does not work for smdpkt, so just write on idle.
+		device->write_watch =3D g_idle_add_full(G_PRIORITY_HIGH,
+					can_write_data_idle, device, write_watch_destroy);
+	}
 }
 =

 static uint16_t __request_submit(struct qmi_device *device,
@@ -937,10 +952,11 @@ static void service_destroy(gpointer data)
 	service->device =3D NULL;
 }
 =

-struct qmi_device *qmi_device_new(int fd)
+struct qmi_device *qmi_device_new(int fd, const char *subsystem)
 {
 	struct qmi_device *device;
 	long flags;
+	unsigned int blocking_flag =3D 1;
 =

 	device =3D g_try_new0(struct qmi_device, 1);
 	if (!device)
@@ -952,6 +968,7 @@ struct qmi_device *qmi_device_new(int fd)
 =

 	device->fd =3D fd;
 	device->close_on_unref =3D false;
+	device->is_smdpkt =3D (!g_strcmp0(subsystem, "smdpkt"));
 =

 	flags =3D fcntl(device->fd, F_GETFL, NULL);
 	if (flags < 0) {
@@ -966,6 +983,14 @@ struct qmi_device *qmi_device_new(int fd)
 		}
 	}
 =

+	if (device->is_smdpkt) {
+		// Make writes block, since smdpkt doesn't support polling writability
+		if (ioctl(fd, SMD_PKT_IOCTL_BLOCKING_WRITE, &blocking_flag) < 0) {
+			g_free(device);
+			return NULL;
+		}
+	}
+
 	device->io =3D g_io_channel_unix_new(device->fd);
 =

 	g_io_channel_set_encoding(device->io, NULL, NULL);
diff --git a/drivers/qmimodem/qmi.h b/drivers/qmimodem/qmi.h
index 2665c44..d61b62b 100644
--- a/drivers/qmimodem/qmi.h
+++ b/drivers/qmimodem/qmi.h
@@ -55,6 +55,10 @@
 #define QMI_SERVICE_RMS		225	/* Remote management service */
 #define QMI_SERVICE_OMA		226	/* OMA device management service */
 =

+#define SMD_PKT_IOCTL_MAGIC (0xC2)
+#define SMD_PKT_IOCTL_BLOCKING_WRITE \
+		_IOR(SMD_PKT_IOCTL_MAGIC, 0, unsigned int)
+
 enum qmi_device_expected_data_format {
 	QMI_DEVICE_EXPECTED_DATA_FORMAT_UNKNOWN,
 	QMI_DEVICE_EXPECTED_DATA_FORMAT_802_3,
@@ -73,7 +77,7 @@ typedef void (*qmi_sync_func_t)(void *user_data);
 typedef void (*qmi_shutdown_func_t)(void *user_data);
 typedef void (*qmi_discover_func_t)(void *user_data);
 =

-struct qmi_device *qmi_device_new(int fd);
+struct qmi_device *qmi_device_new(int fd, const char *subsystem);
 =

 struct qmi_device *qmi_device_ref(struct qmi_device *device);
 void qmi_device_unref(struct qmi_device *device);
diff --git a/plugins/gobi.c b/plugins/gobi.c
index 8521891..2e83e10 100644
--- a/plugins/gobi.c
+++ b/plugins/gobi.c
@@ -317,7 +317,7 @@ static void discover_cb(void *user_data)
 static int gobi_enable(struct ofono_modem *modem)
 {
 	struct gobi_data *data =3D ofono_modem_get_data(modem);
-	const char *device;
+	const char *device, *subsystem;
 	int fd;
 =

 	DBG("%p", modem);
@@ -325,12 +325,15 @@ static int gobi_enable(struct ofono_modem *modem)
 	device =3D ofono_modem_get_string(modem, "Device");
 	if (!device)
 		return -EINVAL;
+	subsystem =3D ofono_modem_get_string(modem, "Subsystem");
+	if (!subsystem)
+		return -EINVAL;
 =

 	fd =3D open(device, O_RDWR | O_NONBLOCK | O_CLOEXEC);
 	if (fd < 0)
 		return -EIO;
 =

-	data->device =3D qmi_device_new(fd);
+	data->device =3D qmi_device_new(fd, subsystem);
 	if (!data->device) {
 		close(fd);
 		return -ENOMEM;
diff --git a/plugins/udevng.c b/plugins/udevng.c
index c85128a..1ae5b11 100644
--- a/plugins/udevng.c
+++ b/plugins/udevng.c
@@ -198,11 +198,13 @@ static gboolean setup_gobi(struct modem_info *modem)
 {
 	const char *qmi =3D NULL, *mdm =3D NULL, *net =3D NULL;
 	const char *gps =3D NULL, *diag =3D NULL;
+	const char *subsystem =3D NULL;
 	GSList *list;
 =

 	DBG("%s", modem->syspath);
 =

 	if (modem->type =3D=3D MODEM_TYPE_USB) {
+		subsystem =3D "usb";
 		for (list =3D modem->devices; list; list =3D list->next) {
 			struct device_info *info =3D list->data;
 =

@@ -237,6 +239,7 @@ static gboolean setup_gobi(struct modem_info *modem)
 		if (qmi =3D=3D NULL || mdm =3D=3D NULL || net =3D=3D NULL)
 			return FALSE;
 	} else if (modem->type =3D=3D MODEM_TYPE_SERIAL) {
+		subsystem =3D modem->serial->subsystem;
 		qmi =3D modem->serial->devnode;
 	}
 =

@@ -246,6 +249,7 @@ static gboolean setup_gobi(struct modem_info *modem)
 	ofono_modem_set_string(modem->modem, "Modem", mdm);
 	ofono_modem_set_string(modem->modem, "Diag", diag);
 	ofono_modem_set_string(modem->modem, "NetworkInterface", net);
+	ofono_modem_set_string(modem->modem, "Subsystem", subsystem);
 =

 	return TRUE;
 }
@@ -1777,6 +1781,7 @@ static void enumerate_devices(struct udev *context)
 =

 	udev_enumerate_add_match_subsystem(enumerate, "tty");
 	udev_enumerate_add_match_subsystem(enumerate, "rpmsg");
+	udev_enumerate_add_match_subsystem(enumerate, "smdpkt");
 	udev_enumerate_add_match_subsystem(enumerate, "usb");
 	udev_enumerate_add_match_subsystem(enumerate, "usbmisc");
 	udev_enumerate_add_match_subsystem(enumerate, "net");
-- =

2.7.4


--===============4402482714973356038==--

