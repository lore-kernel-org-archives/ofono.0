Content-Type: multipart/mixed; boundary="===============4222025833582195382=="
MIME-Version: 1.0
From: Christophe Ronco <c.ronco@kerlink.fr>
Subject: [PATCH 1/2] qmimodem: get/set kernel device driver data format
Date: Wed, 01 Feb 2017 11:32:47 +0100
Message-ID: <20170201103248.26822-2-c.ronco@kerlink.fr>
In-Reply-To: <20170201103248.26822-1-c.ronco@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4222025833582195382==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add a way to get and set data format expected by kernel device driver.
This is inspired by what is done in qmicli (package libqmi).
It does not use QMI protocol but a sysfs exported by kernel driver.
To use this feature, kernel version must be equal or more than 4.5.
---
 drivers/qmimodem/qmi.c | 200 +++++++++++++++++++++++++++++++++++++++++++++=
++++
 drivers/qmimodem/qmi.h |  10 +++
 2 files changed, 210 insertions(+)

diff --git a/drivers/qmimodem/qmi.c b/drivers/qmimodem/qmi.c
index 0080f250..85b40693 100644
--- a/drivers/qmimodem/qmi.c
+++ b/drivers/qmimodem/qmi.c
@@ -26,6 +26,8 @@
 #define _GNU_SOURCE
 #include <stdio.h>
 #include <ctype.h>
+#include <dirent.h>
+#include <errno.h>
 #include <fcntl.h>
 #include <unistd.h>
 #include <stdlib.h>
@@ -33,6 +35,8 @@
 =

 #include <glib.h>
 =

+#include <ofono/log.h>
+
 #include "qmi.h"
 #include "ctl.h"
 =

@@ -1234,6 +1238,202 @@ bool qmi_device_shutdown(struct qmi_device *device,=
 qmi_shutdown_func_t func,
 	return true;
 }
 =

+static bool get_device_file_name(struct qmi_device *device,
+					char *file_name, int size)
+{
+	pid_t pid;
+	char temp[100];
+	ssize_t result;
+
+	if (size <=3D 0)
+		return false;
+
+	pid =3D getpid();
+
+	snprintf(temp, 100, "/proc/%d/fd/%d", (int) pid, device->fd);
+	temp[99] =3D 0;
+
+	result =3D readlink(temp, file_name, size - 1);
+
+	if (result =3D=3D -1 || result >=3D size - 1) {
+		DBG("Error %d in readlink", errno);
+		return false;
+	}
+
+	file_name[result] =3D 0;
+
+	return true;
+}
+
+static char *get_first_dir_in_directory(char *dir_path)
+{
+	DIR *dir;
+	struct dirent *dir_entry;
+	char *dir_name =3D NULL;
+
+	dir =3D opendir(dir_path);
+
+	if (!dir)
+		return NULL;
+
+	dir_entry =3D readdir(dir);
+
+	while ((dir_entry !=3D NULL)) {
+		if (dir_entry->d_type =3D=3D DT_DIR &&
+				strcmp(dir_entry->d_name, ".") !=3D 0 &&
+				strcmp(dir_entry->d_name, "..") !=3D 0) {
+			dir_name =3D g_strdup(dir_entry->d_name);
+			break;
+		}
+
+		dir_entry =3D readdir(dir);
+	}
+
+	closedir(dir);
+	return dir_name;
+}
+
+static char *get_device_interface(struct qmi_device *device)
+{
+	char * const driver_names[] =3D { "usbmisc", "usb" };
+	unsigned int i;
+	char file_path[PATH_MAX];
+	char *file_name;
+	char *interface =3D NULL;
+
+	if (!get_device_file_name(device, file_path, sizeof(file_path)))
+		return NULL;
+
+	file_name =3D basename(file_path);
+
+	for (i =3D 0; i < G_N_ELEMENTS(driver_names) && !interface; i++) {
+		gchar *sysfs_path;
+
+		sysfs_path =3D g_strdup_printf("/sys/class/%s/%s/device/net/",
+						driver_names[i], file_name);
+		interface =3D get_first_dir_in_directory(sysfs_path);
+		g_free(sysfs_path);
+	}
+
+	return interface;
+}
+
+enum qmi_device_expected_data_format qmi_device_get_expected_data_format(
+						struct qmi_device *device)
+{
+	char *sysfs_path =3D NULL;
+	char *interface =3D NULL;
+	int fd =3D -1;
+	char value;
+	enum qmi_device_expected_data_format expected =3D
+					QMI_DEVICE_EXPECTED_DATA_FORMAT_UNKNOWN;
+
+	if (!device)
+		goto done;
+
+	interface =3D get_device_interface(device);
+
+	if (!interface) {
+		DBG("Error while getting interface name");
+		goto done;
+	}
+
+	/* Build sysfs file path and open it */
+	sysfs_path =3D g_strdup_printf("/sys/class/net/%s/qmi/raw_ip", interface);
+
+	fd =3D open(sysfs_path, O_RDONLY);
+	if (fd < 0) {
+		/* maybe not supported by kernel */
+		DBG("Error %d in open(%s)", errno, sysfs_path);
+		goto done;
+	}
+
+	if (read(fd, &value, 1) !=3D 1) {
+		DBG("Error %d in read(%s)", errno, sysfs_path);
+		goto done;
+	}
+
+	if (value =3D=3D 'Y')
+		expected =3D QMI_DEVICE_EXPECTED_DATA_FORMAT_RAW_IP;
+	else if (value =3D=3D 'N')
+		expected =3D QMI_DEVICE_EXPECTED_DATA_FORMAT_802_3;
+	else
+		DBG("Unexpected sysfs file contents");
+
+done:
+	if (fd >=3D 0)
+		close(fd);
+
+	if (sysfs_path)
+		g_free(sysfs_path);
+
+	if (interface)
+		g_free(interface);
+
+	return expected;
+}
+
+bool qmi_device_set_expected_data_format(struct qmi_device *device,
+			enum qmi_device_expected_data_format format)
+{
+	bool res =3D false;
+	char *sysfs_path =3D NULL;
+	char *interface =3D NULL;
+	int fd =3D -1;
+	char value;
+
+	if (!device)
+		goto done;
+
+	switch (format) {
+	case QMI_DEVICE_EXPECTED_DATA_FORMAT_802_3:
+		value =3D 'N';
+		break;
+	case QMI_DEVICE_EXPECTED_DATA_FORMAT_RAW_IP:
+		value =3D 'Y';
+		break;
+	default:
+		DBG("Unhandled firmat: %d", (int) format);
+		goto done;
+	}
+
+	interface =3D get_device_interface(device);
+
+	if (!interface) {
+		DBG("Error while getting interface name");
+		goto done;
+	}
+
+	/* Build sysfs file path and open it */
+	sysfs_path =3D g_strdup_printf("/sys/class/net/%s/qmi/raw_ip", interface);
+
+	fd =3D open(sysfs_path, O_WRONLY);
+	if (fd < 0) {
+		/* maybe not supported by kernel */
+		DBG("Error %d in open(%s)", errno, sysfs_path);
+		goto done;
+	}
+
+	if (write(fd, &value, 1) !=3D 1) {
+		DBG("Error %d in write(%s)", errno, sysfs_path);
+		goto done;
+	}
+
+	res =3D true;
+
+done:
+	if (fd >=3D 0)
+		close(fd);
+
+	if (sysfs_path)
+		g_free(sysfs_path);
+
+	if (interface)
+		g_free(interface);
+
+	return res;
+}
+
 struct qmi_param *qmi_param_new(void)
 {
 	struct qmi_param *param;
diff --git a/drivers/qmimodem/qmi.h b/drivers/qmimodem/qmi.h
index dca115c4..ac19fe01 100644
--- a/drivers/qmimodem/qmi.h
+++ b/drivers/qmimodem/qmi.h
@@ -47,6 +47,12 @@
 #define QMI_SERVICE_RMS		225	/* Remote management service */
 #define QMI_SERVICE_OMA		226	/* OMA device management service */
 =

+enum qmi_device_expected_data_format {
+	QMI_DEVICE_EXPECTED_DATA_FORMAT_UNKNOWN,
+	QMI_DEVICE_EXPECTED_DATA_FORMAT_802_3,
+	QMI_DEVICE_EXPECTED_DATA_FORMAT_RAW_IP,
+};
+
 struct qmi_version {
 	uint8_t type;
 	uint16_t major;
@@ -82,6 +88,10 @@ bool qmi_device_discover(struct qmi_device *device, qmi_=
discover_func_t func,
 bool qmi_device_shutdown(struct qmi_device *device, qmi_shutdown_func_t fu=
nc,
 				void *user_data, qmi_destroy_func_t destroy);
 =

+enum qmi_device_expected_data_format qmi_device_get_expected_data_format(
+						struct qmi_device *device);
+bool qmi_device_set_expected_data_format(struct qmi_device *device,
+			enum qmi_device_expected_data_format format);
 =

 struct qmi_param;
 =

-- =

2.11.0


--===============4222025833582195382==--

