Content-Type: multipart/mixed; boundary="===============1617718727658494568=="
MIME-Version: 1.0
From: Rajyalakshmi Bommaraju <Rajyalakshmi.Bommaraju@intel.com>
Subject: [PATCH] plugins: Adding implementation for persisting voice call
 history
Date: Thu, 16 Sep 2010 17:13:07 -0700
Message-ID: <1284682387-22768-2-git-send-email-Rajyalakshmi.Bommaraju@intel.com>
In-Reply-To: <1284682387-22768-1-git-send-email-Rajyalakshmi.Bommaraju@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1617718727658494568==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 Makefile.am           |    3 +
 plugins/callhistory.c |  594 +++++++++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 597 insertions(+), 0 deletions(-)
 create mode 100644 plugins/callhistory.c

diff --git a/Makefile.am b/Makefile.am
index aa66907..1b7f4d4 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -261,6 +261,9 @@ builtin_sources +=3D plugins/ste.c
 =

 builtin_modules +=3D caif
 builtin_sources +=3D plugins/caif.c
+
+builtin_modules +=3D callhistory
+builtin_sources +=3D plugins/callhistory.c
 endif
 =

 if MAINTAINER_MODE
diff --git a/plugins/callhistory.c b/plugins/callhistory.c
new file mode 100644
index 0000000..1579652
--- /dev/null
+++ b/plugins/callhistory.c
@@ -0,0 +1,594 @@
+/*
+ *
+ * oFono - Open Source Telephony
+ *
+ * Copyright (C) 2008-2010  Intel Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 =
 USA
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#define OFONO_API_SUBJECT_TO_CHANGE
+#include <string.h>
+#include <stdio.h>
+#include <stdint.h>
+#include <stdlib.h>
+#include <errno.h>
+#include <glib.h>
+#include <time.h>
+#include <unistd.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <sys/dir.h>
+#include <sys/mman.h>
+#include <semaphore.h>
+#include <fcntl.h>
+#include <ofono/dbus.h>
+#include <dbus/dbus-glib.h>
+#include <ofono/types.h>
+#include <ofono/plugin.h>
+#include <ofono/log.h>
+#include <ofono/history.h>
+#include "gdbus.h"
+#include "common.h"
+
+#define HISTORY_FILE_PATH "/var/cache/callhistory/"
+#define HISTORY_FILE HISTORY_FILE_PATH"voicecallhistorydata"
+#define OFONO_MANAGER_PATH "/"
+#define PHONE_NUMBER_SIZE 64
+#define RECORD_SIZE 78
+#define HEADER_SIZE 16
+#define MAX_ITEMS 50
+
+#define TOTAL_SIZE (MAX_ITEMS * RECORD_SIZE + HEADER_SIZE)
+
+enum VOICE_CALL_TYPE {
+	OUTGOING =3D 0,
+	INCOMING,
+	MISSED
+};
+
+struct file_header {
+	int head;
+	int tail;
+	int unread;
+	unsigned int lastid;
+};
+
+struct voice_history {
+	int id;
+	char lineid[PHONE_NUMBER_SIZE];
+	short int calltype;
+	time_t starttime;
+	time_t endtime;
+};
+
+struct shared_info {
+	struct file_header header;
+	void *dataMap;
+	sem_t mutex;
+	int temp_unread;
+	int temp_tail;
+};
+
+static struct shared_info *shared_data;
+
+static int call_history_probe(struct ofono_history_context *context)
+{
+	DBG("History Probe for modem: %p", context->modem);
+	return 0;
+}
+
+static void call_history_remove(struct ofono_history_context *context)
+{
+	DBG("Example History Remove for modem: %p", context->modem);
+}
+
+static void clean_up()
+{
+	g_return_if_fail(shared_data !=3D NULL);
+
+	sem_wait(&(shared_data->mutex));
+	/* unmap */
+	munmap(shared_data->dataMap, TOTAL_SIZE);
+	sem_post(&(shared_data->mutex));
+
+	/* remove semaphore */
+	if (sem_destroy(&(shared_data->mutex)) < 0)
+		perror("sem_destroy failed");
+
+	g_free(shared_data);
+}
+
+static int init_sem()
+{
+	unsigned int value =3D 1;
+	g_return_val_if_fail(shared_data !=3D NULL, -1);
+
+	if (sem_init(&(shared_data->mutex), TRUE, value) < 0) {
+		perror("sem_init failed");
+		return -1;
+	}
+
+	return 0;
+}
+
+/* Start of DBus stuff */
+/* ***********************************************************************=
**
+ * Expose an interface, properties and signals for querying storage backend
+ * ***********************************************************************=
**/
+#define OFONO_CALL_HISTORY_INTERFACE OFONO_SERVICE".CallHistory"
+
+static void callhistory_emit_voice_history_changed(int userdata)
+{
+	int *valint =3D &userdata;
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+	g_dbus_emit_signal(conn,
+		OFONO_MANAGER_PATH,
+		OFONO_CALL_HISTORY_INTERFACE,
+		"VoiceHistoryChanged",
+		DBUS_TYPE_UINT32,
+		valint,
+		DBUS_TYPE_INVALID);
+}
+
+static DBusMessage *call_history_set_voice_history_read(DBusConnection *co=
nn,
+							DBusMessage *msg,
+							void *userdata)
+{
+	DBusMessage *reply;
+	DBusMessageIter iter;
+	g_return_val_if_fail((shared_data !=3D NULL), NULL);
+
+	ofono_debug("Read ack received");
+
+	reply =3D dbus_message_new_method_return(msg);
+
+	if (!reply)
+		return NULL;
+
+	dbus_message_iter_init_append(reply, &iter);
+	sem_wait(&(shared_data->mutex));
+	shared_data->header.unread =3D (shared_data->header).unread -
+					shared_data->temp_unread;
+	shared_data->header.tail =3D shared_data->temp_tail;
+	/* write to file */
+	memcpy(shared_data->dataMap, &(shared_data->header), HEADER_SIZE);
+	sem_post(&(shared_data->mutex));
+	msync(shared_data->dataMap, TOTAL_SIZE, MS_ASYNC);
+	return reply;
+}
+
+static int init_header(void *dataPtr)
+{
+	int unread =3D 0;
+
+	g_return_val_if_fail((shared_data !=3D NULL), -1);
+	g_return_val_if_fail((dataPtr !=3D NULL), -1);
+	unread =3D (shared_data->header).unread;
+
+	sem_wait(&(shared_data->mutex));
+	memcpy(&(shared_data->header), (struct file_header *)(dataPtr),
+							HEADER_SIZE);
+
+	ofono_debug("Unread: %d, Header: %d, Tail: %d, serialno: %d\n",
+					unread,
+					(shared_data->header).head,
+					(shared_data->header).tail,
+					(shared_data->header).lastid);
+	sem_post(&(shared_data->mutex));
+	if (unread > 0)
+		callhistory_emit_voice_history_changed(unread);
+
+	return 0;
+}
+
+static void sync_mem_file(struct voice_history *vcall)
+{
+	void *writeMap =3D NULL;
+	int unread =3D 0;
+
+	g_return_if_fail(vcall !=3D NULL);
+	g_return_if_fail(shared_data !=3D NULL);
+	g_return_if_fail(shared_data->dataMap !=3D NULL);
+
+	sem_wait(&(shared_data->mutex));
+
+	writeMap =3D shared_data->dataMap;
+	writeMap =3D writeMap + (shared_data->header).head;
+	vcall->id =3D (shared_data->header).lastid;
+	(shared_data->header).lastid++;
+	memcpy(writeMap, vcall, RECORD_SIZE);
+
+	/* update header */
+	((shared_data->header).unread)++;
+	(shared_data->header).head +=3D RECORD_SIZE;
+
+	if ((shared_data->header).lastid >=3D UINT_MAX)
+		(shared_data->header).lastid =3D 0;
+
+	unread =3D (shared_data->header).unread;
+
+	/* header reaches end of file */
+	if ((shared_data->header).head >=3D TOTAL_SIZE) {
+		/* reset head back to front */
+		(shared_data->header).head =3D HEADER_SIZE;
+
+		ofono_debug("Header =3D %d, Tail =3D %d",
+				(shared_data->header).head,
+				(shared_data->header).tail);
+
+		if (unread >=3D MAX_ITEMS)
+			ofono_error("No one reading history data");
+
+	}
+
+	memcpy(shared_data->dataMap, &(shared_data->header), HEADER_SIZE);
+	msync(shared_data->dataMap, TOTAL_SIZE, MS_ASYNC);
+
+	sem_post(&(shared_data->mutex));
+
+	callhistory_emit_voice_history_changed(unread);
+}
+
+/**
+ * Creates file  "callhistory"
+ */
+static gboolean init_file()
+{
+	int historyFile;
+	struct stat statbuf;
+	DIR *dirptr;
+	char *fill =3D NULL;
+
+	g_return_val_if_fail((shared_data !=3D NULL), FALSE);
+
+	dirptr =3D opendir(HISTORY_FILE_PATH);
+
+	if (!dirptr) {
+		ofono_debug("%s: doesnt exist", HISTORY_FILE_PATH);
+
+		if (mkdir(HISTORY_FILE_PATH,
+			S_IRWXU|S_IRGRP|S_IXGRP|S_IROTH|S_IXOTH) < 0) {
+			perror("Error creating callhistory dir");
+			return FALSE;
+		}
+
+	}
+
+	historyFile =3D open(HISTORY_FILE,
+				O_RDWR|O_CREAT|O_APPEND,
+				S_IRWXU);
+	if (historyFile < 0) {
+		perror("Open file failed");
+		return FALSE;
+	}
+
+	if (stat(HISTORY_FILE, &statbuf) < -1) {
+		perror("stat failed");
+		return FALSE;
+	}
+
+	ofono_debug("stat file: %d", (int) (statbuf.st_size));
+
+	if (statbuf.st_size =3D=3D 0) {
+		int byteswritten =3D 0;
+		/* write header to the file */
+		(shared_data->header).head =3D HEADER_SIZE;
+		(shared_data->header).tail =3D (shared_data->header).head;
+		(shared_data->header).unread =3D 0;
+		ofono_debug("setting head: %d, tail: %d, unread: %d",
+						(shared_data->header).head,
+						(shared_data->header).tail,
+						(shared_data->header).unread);
+
+		/*  fill the file with zeros */
+		ofono_debug("Trying to allocate %d size", TOTAL_SIZE);
+		fill =3D (char *) g_try_malloc0(TOTAL_SIZE);
+
+		if (!fill) {
+			ofono_debug("Error allocating init memory");
+			return FALSE;
+		}
+
+		/* Predefine file size and fill with some data */
+		bzero(fill, TOTAL_SIZE);
+		memcpy(fill, &(shared_data->header), HEADER_SIZE);
+
+		byteswritten =3D write(historyFile, fill, TOTAL_SIZE);
+
+		if (byteswritten < 0) {
+			ofono_debug("Error writing to file");
+			return FALSE;
+		}
+
+		g_free(fill);
+
+		statbuf.st_size =3D TOTAL_SIZE;
+		ofono_debug("History file %d size created\n", byteswritten);
+	}
+
+	/* create semaphor */
+	if (init_sem() < 0)
+		return FALSE;
+
+	sem_wait(&(shared_data->mutex));
+	shared_data->dataMap =3D mmap((caddr_t)NULL,
+				statbuf.st_size,
+				PROT_READ|PROT_WRITE|PROT_EXEC,
+				MAP_SHARED,
+				historyFile,
+				0);
+	sem_post(&(shared_data->mutex));
+
+	if (shared_data->dataMap =3D=3D (void *)(-1)) {
+		perror("mmap falied");
+		return FALSE;
+	}
+
+	close(historyFile);
+
+	init_header(shared_data->dataMap);
+
+	return TRUE;
+}
+
+/**
+ * call_history_call_ended:
+ * ofono calls this method with the call information
+ */
+static void call_history_call_ended(struct ofono_history_context *context,
+					const struct ofono_call *call,
+					time_t start,
+					time_t end)
+{
+	const char *from =3D "Unknown";
+	struct tm tmstart, tmend;
+	char sttime[128], endtime[128];
+	int fromlen =3D 0;
+	struct voice_history vcall;
+
+	ofono_debug("Call Ended on modem: %p", context->modem);
+
+	if (call->type !=3D 0)
+		return;
+
+	ofono_debug("Voice Call, %s",
+		call->direction ? "Incoming" : "Outgoing");
+
+	if (call->direction)
+		vcall.calltype =3D INCOMING;
+	else
+		vcall.calltype =3D OUTGOING;
+
+	if (call->clip_validity =3D=3D 0)
+		from =3D phone_number_to_string(&call->phone_number);
+
+	fromlen =3D strlen(from);
+	strcpy(vcall.lineid, from);
+
+	vcall.lineid[fromlen] =3D '\0';
+
+	vcall.starttime =3D start;
+	gmtime_r(&start, &tmstart);
+	strftime(sttime, 127, "%a, %d %b %Y %H:%M:%S %z", &tmstart);
+	sttime[127] =3D '\0';
+
+	ofono_debug("StartTime: %s", sttime);
+
+	vcall.endtime =3D end;
+	gmtime_r(&end, &tmend);
+	strftime(endtime, 127, "%a, %d %b %Y %H:%M:%S %z", &tmend);
+	endtime[127] =3D '\0';
+	ofono_debug("EndTime: %s", endtime);
+
+	sync_mem_file(&vcall);
+}
+/**
+ * call_history_call_missed:
+ * ofono calls this method with the call information
+ */
+static void call_history_call_missed(struct ofono_history_context *context,
+					const struct ofono_call *call,
+					time_t when)
+{
+	const char *from =3D "Unknown";
+	struct tm mtime;
+	char sttime[128];
+	struct voice_history vcall;
+	int fromlen =3D 0;
+
+	ofono_debug("Call Missed on modem: %p", context->modem);
+
+	if (call->type !=3D 0)
+		return;
+
+	ofono_debug("Voice Call, Missed");
+	ofono_debug("Voice Call, %s",
+		call->direction ? "Incoming" : "Outgoing");
+
+	vcall.calltype =3D MISSED;
+
+	if (call->clip_validity =3D=3D 0)
+		from =3D phone_number_to_string(&call->phone_number);
+
+	fromlen =3D strlen(from);
+	strncpy(vcall.lineid, from, fromlen);
+	vcall.lineid[fromlen] =3D '\0';
+
+	vcall.starttime =3D when;
+
+	gmtime_r(&when, &mtime);
+	ofono_debug("From: %s", vcall.lineid);
+	strftime(sttime, 127, "%a, %d %b %Y %H:%M:%S %z", &mtime);
+	sttime[127] =3D '\0';
+	ofono_debug("Missed Time: %s", sttime);
+
+	vcall.endtime =3D when;
+
+	sync_mem_file(&vcall);
+}
+
+static void read_data(struct voice_history *data, int temp)
+{
+	void *readMap =3D NULL;
+	g_return_if_fail(shared_data !=3D NULL);
+	g_return_if_fail(shared_data->dataMap !=3D NULL);
+
+	sem_wait(&(shared_data->mutex));
+	readMap =3D shared_data->dataMap+temp;
+
+	/* read a chunk into *data */
+	memcpy(data, readMap, RECORD_SIZE);
+	shared_data->temp_unread++;
+	sem_post(&(shared_data->mutex));
+}
+
+static DBusMessage *call_history_get_voice_history(DBusConnection *conn,
+						DBusMessage *msg,
+						void *userdata)
+{
+	DBusMessage     *reply;
+	DBusMessageIter  iter;
+	DBusMessageIter  array, struct_s;
+	int i;
+	char *lineid;
+	struct voice_history data;
+	int unread =3D 0;
+
+	reply =3D dbus_message_new_method_return(msg);
+
+	if (!reply)
+		return NULL;
+
+	g_return_val_if_fail(shared_data !=3D NULL, NULL);
+
+	dbus_message_iter_init_append(reply, &iter);
+
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+					DBUS_STRUCT_BEGIN_CHAR_AS_STRING
+					DBUS_TYPE_UINT32_AS_STRING
+					DBUS_TYPE_STRING_AS_STRING
+					DBUS_TYPE_UINT16_AS_STRING
+					DBUS_TYPE_INT32_AS_STRING
+					DBUS_TYPE_INT32_AS_STRING
+					DBUS_STRUCT_END_CHAR_AS_STRING
+					, &array);
+
+	sem_wait(&(shared_data->mutex));
+	shared_data->temp_unread =3D 0;
+
+	shared_data->temp_tail =3D (shared_data->header).tail;
+	unread =3D (shared_data->header).unread;
+	sem_post(&(shared_data->mutex));
+
+	for (i =3D 0; i < unread; i++) {
+		read_data(&data, shared_data->temp_tail);
+		lineid =3D data.lineid;
+		dbus_message_iter_open_container(&array,
+						DBUS_TYPE_STRUCT,
+						NULL,
+						&struct_s);
+		dbus_message_iter_append_basic(&struct_s,
+						DBUS_TYPE_UINT32,
+						&(data.id));
+		dbus_message_iter_append_basic(&struct_s,
+						DBUS_TYPE_STRING,
+						&(lineid));
+		dbus_message_iter_append_basic(&struct_s,
+						DBUS_TYPE_UINT16,
+						&(data.calltype));
+		dbus_message_iter_append_basic(&struct_s,
+						DBUS_TYPE_INT32,
+						&(data.starttime));
+		dbus_message_iter_append_basic(&struct_s,
+						DBUS_TYPE_INT32,
+						&(data.endtime));
+		dbus_message_iter_close_container(&array, &struct_s);
+
+		shared_data->temp_tail =3D shared_data->temp_tail + RECORD_SIZE;
+
+		if (shared_data->temp_tail =3D=3D TOTAL_SIZE) {
+			ofono_debug("End of Queue: %d",
+					shared_data->temp_tail);
+			/* reset back to front */
+			shared_data->temp_tail =3D HEADER_SIZE;
+		}
+
+	}
+	dbus_message_iter_close_container(&iter, &array);
+
+	return reply;
+}
+
+static GDBusMethodTable call_history_methods[] =3D {
+	{ "GetVoiceHistory", "", "a(usqii)", call_history_get_voice_history },
+	{ "SetVoiceHistoryRead", "", "", call_history_set_voice_history_read },
+	{ }
+};
+
+static GDBusSignalTable call_history_signals[] =3D {
+	{ "VoiceHistoryChanged", "u" },
+	{}
+};
+
+/* End of DBus stuff */
+static struct ofono_history_driver call_history_driver =3D {
+	.name =3D "callhistory",
+	.probe =3D call_history_probe,
+	.remove =3D call_history_remove,
+	.call_ended =3D call_history_call_ended,
+	.call_missed =3D call_history_call_missed,
+};
+
+static int call_history_init(void)
+{
+	DBusConnection *conn =3D ofono_dbus_get_connection();
+
+	if (!shared_data) {
+		shared_data =3D g_try_new0(struct shared_info, 1);
+
+		if (!shared_data)
+			return -ENOMEM;
+	}
+
+	if (!g_dbus_register_interface(conn,
+					OFONO_MANAGER_PATH,
+					OFONO_CALL_HISTORY_INTERFACE,
+					call_history_methods,
+					call_history_signals,
+					NULL,    /* Properties */
+					shared_data,    /* Userdata   */
+					NULL))    /* Destroy func */
+		return -EIO;
+
+	if (!init_file())
+		return -ENOENT;
+
+	return ofono_history_driver_register(&call_history_driver);
+}
+
+static void call_history_exit(void)
+{
+	clean_up();
+	ofono_history_driver_unregister(&call_history_driver);
+}
+
+OFONO_PLUGIN_DEFINE(callhistory, "Call History Plugin",
+		OFONO_VERSION, OFONO_PLUGIN_PRIORITY_DEFAULT,
+		call_history_init, call_history_exit)
-- =

1.6.3.3


--===============1617718727658494568==--

