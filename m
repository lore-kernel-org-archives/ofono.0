Content-Type: multipart/mixed; boundary="===============7862554481803097638=="
MIME-Version: 1.0
From: Dario <djdas@djdas.net>
Subject: [PATCH 2/2] Added SQLite history plugin
Date: Tue, 06 Apr 2010 12:43:27 +0200
Message-ID: <4BBB104F.2090604@djdas.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7862554481803097638==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/oFono_History_DB.sql |   27 ++++
 plugins/sqlite_history.c     |  301 ++++++++++++++++++++++++++++++++++++++=
++++
 2 files changed, 328 insertions(+), 0 deletions(-)
 create mode 100644 plugins/oFono_History_DB.sql
 create mode 100644 plugins/sqlite_history.c

diff --git a/plugins/oFono_History_DB.sql b/plugins/oFono_History_DB.sql
new file mode 100644
index 0000000..7cfc3ba
--- /dev/null
+++ b/plugins/oFono_History_DB.sql
@@ -0,0 +1,27 @@
+CREATE TABLE IF NOT EXISTS "ofono_history_calls" (
+    "ohc_modem_path" TEXT, -- Modem path string i.e. "/modem0"
+    "ohc_type" INTEGER, -- Call type ( 0 =3D Call ended, 1 =3D Call missed=
 )
+    "ohc_direction" INTEGER, -- Call direction ( 0 =3D Mobile Originated, =
1 =3D Mobile Terminated )
+    "ohc_phone_number" TEXT, -- Other party phone number
+    "ohc_start_time" TEXT, -- Starting date/time
+    "ohc_end_time" TEXT -- Ending date/time
+);
+CREATE TABLE IF NOT EXISTS "ofono_history_incoming_messages" (
+    "ohim_modem_path" TEXT, -- Modem path string i.e. "/modem0"
+    "ohim_msg_id" INTEGER, -- oFono unique message id number
+    "ohim_sender" TEXT, -- Sender phone number
+    "ohim_text" TEXT, -- Message text
+    "ohim_local_date" TEXT, -- Local sent date/time
+    "ohim_remote_date" TEXT -- Remote sent date/time
+);
+CREATE TABLE IF NOT EXISTS "ofono_history_outgoing_messages" (
+    "ohom_modem_path" TEXT, -- Modem path string i.e. "/modem0"
+    "ohom_msg_id" INTEGER, -- oFono unique message id number
+    "ohom_recipient" TEXT, -- Recipient phone number
+    "ohom_text" TEXT, -- Message text
+    "ohom_creation_date" TEXT, -- Message creation date/time
+    "ohom_send_status" INTEGER, -- Sending status ( 0 =3D Pending, 1 =3D S=
ubmitted, 2 =3D Failed )
+    "ohom_status_update_date" TEXT -- Last row update date/time
+);
+CREATE UNIQUE INDEX IF NOT EXISTS "ohim_idx_msg_id" on ofono_history_incom=
ing_messages (ohim_msg_id ASC);
+CREATE UNIQUE INDEX IF NOT EXISTS "ohom_idx_msg_id" on ofono_history_outgo=
ing_messages (ohom_msg_id ASC);
diff --git a/plugins/sqlite_history.c b/plugins/sqlite_history.c
new file mode 100644
index 0000000..35dce71
--- /dev/null
+++ b/plugins/sqlite_history.c
@@ -0,0 +1,301 @@
+/*
+ *
+ *  oFono - Open Source Telephony
+ *
+ *  Copyright (C) 2010 Dario 'Djdas' Conigliaro.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 as
+ *  published by the Free Software Foundation.
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
+#include <stdlib.h>
+#include <string.h>
+#include <glib.h>
+
+#define OFONO_API_SUBJECT_TO_CHANGE
+#include <ofono/plugin.h>
+#include <ofono/log.h>
+#include <ofono/history.h>
+#include <ofono/types.h>
+#include <ofono/modem.h>
+
+#include "common.h"
+
+#include <sqlite3.h>
+
+#define SQL_HISTORY_DB_PATH STORAGEDIR "/ofono_history.sqlite"
+#define SQL_HISTORY_DB_SQL STORAGEDIR "/oFono_History_DB.sql"
+
+#define SELECT_CALLS "SELECT * FROM ofono_history_calls"
+#define INSERT_CALLS "INSERT INTO ofono_history_calls VALUES (?,?,?,?,?,?)"
+#define INSERT_IN_MSGS "INSERT INTO ofono_history_incoming_messages VALUES=
 (?,?,?,?,?,?)"
+#define INSERT_OUT_MSGS "INSERT INTO ofono_history_outgoing_messages VALUE=
S (?,?,?,?,?,?,?)"
+#define UPDATE_OUT_MSGS "UPDATE ofono_history_outgoing_messages SET \
+							ohom_send_status =3D ?, \
+							ohom_status_update_date =3D ? \
+							WHERE ohom_msg_id =3D ?"
+
+sqlite3 *db =3D NULL;
+
+static int sqlite_history_probe(struct ofono_history_context *context)
+{
+	char *execerror;
+
+	ofono_debug("SQLite History Probe for modem: %p", context->modem);
+	=

+	if (sqlite3_open(SQL_HISTORY_DB_PATH, &db) !=3D SQLITE_OK) {
+		ofono_debug("Error opening DB: %s", sqlite3_errmsg(db));
+		sqlite3_close(db);
+		return -1;
+	}
+
+	if (sqlite3_exec(db, SELECT_CALLS, NULL, NULL, &execerror) !=3D SQLITE_OK=
) {
+		char *sqlscript;
+		GError *sqlerror =3D NULL;
+
+		ofono_debug("Creating DB");
+
+		g_file_get_contents(SQL_HISTORY_DB_SQL, &sqlscript, NULL, &sqlerror);
+	=

+		if (sqlerror !=3D NULL) {
+			ofono_debug("Error opening sql script: %s", sqlerror->message);
+			g_error_free(sqlerror);
+			return -1;
+		}
+	=

+		if (sqlite3_exec(db, sqlscript, NULL, NULL, &execerror) !=3D SQLITE_OK) {
+			ofono_debug("Error executing sql script: %s", execerror);
+			sqlite3_free(execerror);
+			g_free(sqlscript);
+			return -1;
+		}
+	=

+		g_free(sqlscript);
+	}
+	=

+	return 0;
+}
+
+static void sqlite_history_remove(struct ofono_history_context *context)
+{
+	ofono_debug("SQLite History Remove for modem: %p", context->modem);
+	=

+	if (db !=3D NULL)
+		sqlite3_close(db);
+}
+
+static void sqlite_history_call_ended(struct ofono_history_context *contex=
t,
+						const struct ofono_call *call,
+						time_t start, time_t end)
+{
+	const char *from =3D "Unknown";
+	char buf[128];
+	char buf1[128];
+	sqlite3_stmt *statement;
+
+	ofono_debug("Call Ended on modem: %p", context->modem);
+
+	if (call->type !=3D 0)
+		return;
+
+	if (db =3D=3D NULL)
+		return;
+
+	from =3D phone_number_to_string(&call->phone_number);
+	=

+	strftime(buf, 127, "%Y-%m-%dT%H:%M:%S%z", localtime(&start));
+	buf[127] =3D '\0';
+	=

+	sqlite3_prepare_v2(db, INSERT_CALLS, -1, &statement, NULL);
+	sqlite3_bind_text(statement, 1, ofono_modem_get_path(context->modem), =

+							-1, SQLITE_STATIC);
+	sqlite3_bind_int(statement, 2, 0);
+	sqlite3_bind_int(statement, 3, call->direction);
+	sqlite3_bind_text(statement, 4, from, -1, SQLITE_STATIC);
+	sqlite3_bind_text(statement, 5, buf, -1, SQLITE_STATIC);
+	=

+	strftime(buf1, 127, "%Y-%m-%dT%H:%M:%S%z", localtime(&end));
+	buf1[127] =3D '\0';
+	=

+	sqlite3_bind_text(statement, 6, buf1, -1, SQLITE_STATIC);
+
+	if (sqlite3_step(statement) !=3D SQLITE_DONE)
+		ofono_debug("SQLite Error: %s", sqlite3_errmsg(db));
+
+	sqlite3_finalize(statement);
+}
+
+static void sqlite_history_call_missed(struct ofono_history_context *conte=
xt,
+						const struct ofono_call *call,
+						time_t when)
+{
+	const char *from =3D "Unknown";
+	char buf[128];
+	sqlite3_stmt *statement;
+
+	ofono_debug("Call Missed on modem: %p", context->modem);
+
+	if (call->type !=3D 0)
+		return;
+
+	if (db =3D=3D NULL)
+		return;
+
+	from =3D phone_number_to_string(&call->phone_number);
+	=

+	strftime(buf, 127, "%Y-%m-%dT%H:%M:%S%z", localtime(&when));
+	buf[127] =3D '\0';
+	=

+	sqlite3_prepare_v2(db, INSERT_CALLS, -1, &statement, NULL);
+	sqlite3_bind_text(statement, 1, ofono_modem_get_path(context->modem), =

+							-1, SQLITE_STATIC);
+	sqlite3_bind_int(statement, 2, 1);
+	sqlite3_bind_int(statement, 3, call->direction);
+	sqlite3_bind_text(statement, 4, from, -1, SQLITE_STATIC);
+	sqlite3_bind_text(statement, 5, buf, -1, SQLITE_STATIC);
+	sqlite3_bind_text(statement, 6, buf, -1, SQLITE_STATIC);
+
+	if (sqlite3_step(statement) !=3D SQLITE_DONE)
+		ofono_debug("SQLite Error: %s", sqlite3_errmsg(db));
+
+	sqlite3_finalize(statement);
+}
+
+static void sqlite_history_sms_received(struct ofono_history_context *cont=
ext,
+					unsigned int msg_id, const char *from,
+					const struct tm *remote, const struct tm *local,
+					const char *text)
+{
+	char buf[128];
+	char buf1[128];
+	sqlite3_stmt *statement;
+
+	ofono_debug("Incoming SMS on modem: %p", context->modem);
+
+	if (db =3D=3D NULL)
+		return;
+
+	strftime(buf, 127, "%Y-%m-%dT%H:%M:%S%z", local);
+	buf[127] =3D '\0';
+	=

+	strftime(buf1, 127, "%Y-%m-%dT%H:%M:%S%z", remote);
+	buf1[127] =3D '\0';
+	=

+	sqlite3_prepare_v2(db, INSERT_IN_MSGS, -1, &statement, NULL);
+	sqlite3_bind_text(statement, 1, ofono_modem_get_path(context->modem), =

+							-1, SQLITE_STATIC);
+	sqlite3_bind_int(statement, 2, msg_id);
+	sqlite3_bind_text(statement, 3, from, -1, SQLITE_STATIC);
+	sqlite3_bind_text(statement, 4, text, -1, SQLITE_STATIC);
+	sqlite3_bind_text(statement, 5, buf, -1, SQLITE_STATIC);
+	sqlite3_bind_text(statement, 6, buf1, -1, SQLITE_STATIC);
+
+	if (sqlite3_step(statement) !=3D SQLITE_DONE)
+		ofono_debug("SQLite Error: %s", sqlite3_errmsg(db));
+
+	sqlite3_finalize(statement);
+}
+
+static void sqlite_history_sms_send_pending(struct ofono_history_context *=
context, =

+							unsigned int msg_id,
+							const char *to, time_t when,
+							const char *text)
+{
+	char buf[128];
+	char buf1[128];
+	sqlite3_stmt *statement;
+	time_t currtime;
+
+	ofono_debug("Sending SMS on modem: %p", context->modem);
+
+	if (db =3D=3D NULL)
+		return;
+
+	strftime(buf, 127, "%Y-%m-%dT%H:%M:%S%z", localtime(&when));
+	buf[127] =3D '\0';
+	=

+	currtime =3D time(NULL);
+	strftime(buf1, 127, "%Y-%m-%dT%H:%M:%S%z", localtime(&currtime));
+	buf1[127] =3D '\0';
+	=

+	sqlite3_prepare_v2(db, INSERT_OUT_MSGS, -1, &statement, NULL);
+	sqlite3_bind_text(statement, 1, ofono_modem_get_path(context->modem), =

+							-1, SQLITE_STATIC);
+	sqlite3_bind_int(statement, 2, msg_id);
+	sqlite3_bind_text(statement, 3, to, -1, SQLITE_STATIC);
+	sqlite3_bind_text(statement, 4, text, -1, SQLITE_STATIC);
+	sqlite3_bind_text(statement, 5, buf, -1, SQLITE_STATIC);
+	sqlite3_bind_int(statement, 6, OFONO_HISTORY_SMS_STATUS_PENDING);
+	sqlite3_bind_text(statement, 7, buf1, -1, SQLITE_STATIC);
+
+	if (sqlite3_step(statement) !=3D SQLITE_DONE)
+		ofono_debug("SQLite Error: %s", sqlite3_errmsg(db));
+
+	sqlite3_finalize(statement);
+}
+
+static void sqlite_history_sms_send_status(struct ofono_history_context *c=
ontext, =

+						unsigned int msg_id, time_t when,
+						enum ofono_history_sms_status s)
+{
+	char buf[128];
+	sqlite3_stmt *statement;
+
+	ofono_debug("SMS status on modem: %p", context->modem);
+
+	if (db =3D=3D NULL)
+		return;
+
+	strftime(buf, 127, "%Y-%m-%dT%H:%M:%S%z", localtime(&when));
+	buf[127] =3D '\0';
+	=

+	sqlite3_prepare_v2(db, UPDATE_OUT_MSGS, -1, &statement, NULL);
+	sqlite3_bind_int(statement, 1, s);
+	sqlite3_bind_text(statement, 2, buf, -1, SQLITE_STATIC);
+	sqlite3_bind_int(statement, 3, msg_id);
+
+	if (sqlite3_step(statement) !=3D SQLITE_DONE)
+		ofono_debug("SQLite Error: %s", sqlite3_errmsg(db));
+
+	sqlite3_finalize(statement);
+}
+
+static struct ofono_history_driver sqlite_driver =3D {
+	.name =3D "SQLite History",
+	.probe =3D sqlite_history_probe,
+	.remove =3D sqlite_history_remove,
+	.call_ended =3D sqlite_history_call_ended,
+	.call_missed =3D sqlite_history_call_missed,
+	.sms_received =3D sqlite_history_sms_received,
+	.sms_send_pending =3D sqlite_history_sms_send_pending,
+	.sms_send_status =3D sqlite_history_sms_send_status,
+};
+
+static int sqlite_history_init(void)
+{
+	return ofono_history_driver_register(&sqlite_driver);
+}
+
+static void sqlite_history_exit(void)
+{
+	ofono_history_driver_unregister(&sqlite_driver);
+}
+
+OFONO_PLUGIN_DEFINE(sqlite_history, "SQLite History Plugin",
+			VERSION, OFONO_PLUGIN_PRIORITY_DEFAULT,
+			sqlite_history_init, sqlite_history_exit)
-- =

1.6.3.3



--===============7862554481803097638==--

