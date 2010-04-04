Content-Type: multipart/mixed; boundary="===============8840421936419189018=="
MIME-Version: 1.0
From: Dario <djdas@djdas.net>
Subject: [PATCH 2/2] Added SQLite history plugin
Date: Sun, 04 Apr 2010 23:51:19 +0200
Message-ID: <4BB909D7.9020403@djdas.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8840421936419189018==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


---
 plugins/oFono_History_DB.sql |   27 ++++
 plugins/sqlite_history.c     |  324 =

++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 351 insertions(+), 0 deletions(-)
 create mode 100644 plugins/oFono_History_DB.sql
 create mode 100644 plugins/sqlite_history.c

diff --git a/plugins/oFono_History_DB.sql b/plugins/oFono_History_DB.sql
new file mode 100644
index 0000000..cf3180a
--- /dev/null
+++ b/plugins/oFono_History_DB.sql
@@ -0,0 +1,27 @@
+CREATE TABLE "ofono_history_calls" (
+    "ohc_modem_path" TEXT, -- Modem path string i.e. "/modem0"
+    "ohc_type" INTEGER, -- Call type ( 0 =3D Call ended, 1 =3D Call missed=
 )
+    "ohc_direction" INTEGER, -- Call direction ( 0 =3D Mobile Originated, =

1 =3D Mobile Terminated )
+    "ohc_phone_number" TEXT, -- Other party phone number
+    "ohc_start_time" TEXT, -- Starting date/time
+    "ohc_end_time" TEXT -- Ending date/time
+);
+CREATE TABLE "ofono_history_incoming_messages" (
+    "ohim_modem_path" TEXT, -- Modem path string i.e. "/modem0"
+    "ohim_msg_id" INTEGER, -- oFono unique message id number
+    "ohim_sender" TEXT, -- Sender phone number
+    "ohim_text" TEXT, -- Message text
+    "ohim_local_date" TEXT, -- Local sent date/time
+    "ohim_remote_date" TEXT -- Remote sent date/time
+);
+CREATE TABLE "ofono_history_outgoing_messages" (
+    "ohom_modem_path" TEXT, -- Modem path string i.e. "/modem0"
+    "ohom_msg_id" INTEGER, -- oFono unique message id number
+    "ohom_recipient" TEXT, -- Recipient phone number
+    "ohom_text" TEXT, -- Message text
+    "ohom_creation_date" TEXT, -- Message creation date/time
+    "ohom_send_status" INTEGER, -- Sending status ( 0 =3D Pending, 1 =3D =

Submitted, 2 =3D Failed )
+    "ohom_status_update_date" TEXT -- Last row update date/time
+);
+CREATE UNIQUE INDEX "ohim_idx_msg_id" on =

ofono_history_incoming_messages (ohim_msg_id ASC);
+CREATE UNIQUE INDEX "ohom_idx_msg_id" on =

ofono_history_outgoing_messages (ohom_msg_id ASC);
diff --git a/plugins/sqlite_history.c b/plugins/sqlite_history.c
new file mode 100644
index 0000000..9015403
--- /dev/null
+++ b/plugins/sqlite_history.c
@@ -0,0 +1,324 @@
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
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  =

02110-1301  USA
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
+#define INSERT_CALLS "INSERT INTO ofono_history_calls VALUES (%s)"
+#define INSERT_IN_MSGS "INSERT INTO ofono_history_incoming_messages =

VALUES (%s)"
+#define UPDATE_IN_MSGS "UPDATE ofono_history_incoming_messages SET %s =

WHERE ohim_msg_id =3D %d"
+#define INSERT_OUT_MSGS "INSERT INTO ofono_history_outgoing_messages =

VALUES (%s)"
+#define UPDATE_OUT_MSGS "UPDATE ofono_history_outgoing_messages SET %s =

WHERE ohom_msg_id =3D %d"
+
+sqlite3 *db =3D NULL;
+
+int check_db()
+{
+    int ret_val =3D 0;
+    =

+    ofono_debug("Checking if DB is empty");
+        =

+    if (sqlite3_table_column_metadata(db, NULL, "ofono_history_calls",
+                      "ohc_modem_path", NULL, NULL, NULL, NULL,
+                      NULL) !=3D SQLITE_OK) {
+        char *systemcmd;
+        systemcmd =3D g_strdup_printf("sqlite3 -batch %s < %s", =

SQL_HISTORY_DB_PATH, SQL_HISTORY_DB_SQL);
+        =

+        ofono_debug("Initializing DB: %s", systemcmd);
+        =

+        ret_val =3D system(systemcmd);
+        g_free(systemcmd);        =

+    }
+    return ret_val;
+}
+
+static int sqlite_history_probe(struct ofono_history_context *context)
+{
+    ofono_debug("SQLite History Probe for modem: %p", context->modem);
+    if (sqlite3_open(SQL_HISTORY_DB_PATH, &db) !=3D SQLITE_OK) {
+        ofono_debug("Error opening DB: %s", sqlite3_errmsg(db));
+        sqlite3_close(db);
+        return -1;
+    }
+
+    if (check_db() !=3D 0)
+        return -1;
+
+    return 0;
+}
+
+static void sqlite_history_remove(struct ofono_history_context *context)
+{
+    ofono_debug("SQLite History Remove for modem: %p", context->modem);
+    if (db !=3D NULL)
+        sqlite3_close(db);
+}
+
+static void sqlite_history_call_ended(struct ofono_history_context =

*context,
+                      const struct ofono_call *call,
+                      time_t start, time_t end)
+{
+    const char *from =3D "Unknown";
+    char buf[128];
+    char *query;
+    char *params;
+    char *tmpparams;
+    char *errormsg;
+
+    ofono_debug("Call Ended on modem: %p", context->modem);
+
+    if (call->type !=3D 0)
+        return;
+
+    if (db =3D=3D NULL)
+        return;
+
+    from =3D phone_number_to_string(&call->phone_number);
+
+    strftime(buf, 127, "%Y-%m-%dT%H:%M:%S%z", localtime(&start));
+    buf[127] =3D '\0';
+    tmpparams =3D g_strdup_printf("\"%s\",0,%d,\"%s\",\"%s\",",
+                    ofono_modem_get_path(context->modem),
+                    call->direction, from, buf);
+
+    strftime(buf, 127, "\"%Y-%m-%dT%H:%M:%S%z\"", localtime(&end));
+    buf[127] =3D '\0';
+    params =3D g_strconcat(tmpparams, buf, NULL);
+
+    query =3D g_strdup_printf(INSERT_CALLS, params);
+
+    ofono_debug("Executing query: %s", query);
+
+    if (sqlite3_exec(db, query, NULL, NULL, &errormsg) !=3D SQLITE_OK) {
+        ofono_debug("Error: %s", errormsg);
+        sqlite3_free(errormsg);
+    }
+
+    g_free(tmpparams);
+    g_free(params);
+    g_free(query);
+}
+
+static void sqlite_history_call_missed(struct ofono_history_context =

*context,
+                       const struct ofono_call *call,
+                       time_t when)
+{
+    const char *from =3D "Unknown";
+    char buf[128];
+    char *query;
+    char *params;
+    char *errormsg;
+
+    ofono_debug("Call Missed on modem: %p", context->modem);
+
+    if (call->type !=3D 0)
+        return;
+
+    if (db =3D=3D NULL)
+        return;
+
+    from =3D phone_number_to_string(&call->phone_number);
+
+    strftime(buf, 127, "%Y-%m-%dT%H:%M:%S%z", localtime(&when));
+    buf[127] =3D '\0';
+
+    params =3D g_strdup_printf("\"%s\",1,%d,\"%s\",\"%s\",\"%s\"",
+                 ofono_modem_get_path(context->modem),
+                 call->direction, from, buf, buf);
+
+    query =3D g_strdup_printf(INSERT_CALLS, params);
+
+    ofono_debug("Executing query: %s", query);
+
+    if (sqlite3_exec(db, query, NULL, NULL, &errormsg) !=3D SQLITE_OK) {
+        ofono_debug("Error: %s", errormsg);
+        sqlite3_free(errormsg);
+    }
+
+    g_free(params);
+    g_free(query);
+}
+
+static void sqlite_history_sms_received(struct ofono_history_context =

*context,
+                    unsigned int msg_id,
+                    const char *from,
+                    const struct tm *remote,
+                    const struct tm *local,
+                    const char *text)
+{
+    char buf[128];
+    char *query;
+    char *params;
+    char *tmpparams;
+    char *errormsg;
+
+    ofono_debug("Incoming SMS on modem: %p", context->modem);
+
+    if (db =3D=3D NULL)
+        return;
+
+    strftime(buf, 127, "%Y-%m-%dT%H:%M:%S%z", local);
+    buf[127] =3D '\0';
+
+    tmpparams =3D g_strdup_printf("\"%s\",%d,\"%s\",\"%s\",\"%s\",",
+                    ofono_modem_get_path(context->modem),
+                    msg_id, from, text, buf);
+
+    strftime(buf, 127, "\"%Y-%m-%dT%H:%M:%S%z\"", remote);
+    buf[127] =3D '\0';
+    params =3D g_strconcat(tmpparams, buf, NULL);
+
+    query =3D g_strdup_printf(INSERT_IN_MSGS, params);
+
+    ofono_debug("Executing query: %s", query);
+
+    if (sqlite3_exec(db, query, NULL, NULL, &errormsg) !=3D SQLITE_OK) {
+        ofono_debug("Error: %s", errormsg);
+        sqlite3_free(errormsg);
+    }
+
+    g_free(tmpparams);
+    g_free(params);
+    g_free(query);
+}
+
+static void sqlite_history_sms_send_pending(struct ofono_history_context
+                        *context, unsigned int msg_id,
+                        const char *to, time_t when,
+                        const char *text)
+{
+    char buf[128];
+    char *query;
+    char *params;
+    char *tmpparams;
+    char *errormsg;
+    time_t currtime;
+
+    ofono_debug("Sending SMS on modem: %p", context->modem);
+
+    if (db =3D=3D NULL)
+        return;
+
+    strftime(buf, 127, "%Y-%m-%dT%H:%M:%S%z", localtime(&when));
+    buf[127] =3D '\0';
+
+    tmpparams =3D g_strdup_printf("\"%s\",%d,\"%s\",\"%s\",\"%s\",%d,",
+                    ofono_modem_get_path(context->modem),
+                    msg_id, to, text, buf,
+                    OFONO_HISTORY_SMS_STATUS_PENDING);
+
+    currtime =3D time(NULL);
+    strftime(buf, 127, "\"%Y-%m-%dT%H:%M:%S%z\"", localtime(&currtime));
+    buf[127] =3D '\0';
+    params =3D g_strconcat(tmpparams, buf, NULL);
+
+    query =3D g_strdup_printf(INSERT_OUT_MSGS, params);
+
+    ofono_debug("Executing query: %s", query);
+
+    if (sqlite3_exec(db, query, NULL, NULL, &errormsg) !=3D SQLITE_OK) {
+        ofono_debug("Error: %s", errormsg);
+        sqlite3_free(errormsg);
+    }
+
+    g_free(tmpparams);
+    g_free(params);
+    g_free(query);
+
+}
+
+static void sqlite_history_sms_send_status(struct ofono_history_context
+                       *context, unsigned int msg_id,
+                       time_t when,
+                       enum ofono_history_sms_status s)
+{
+    char buf[128];
+    char *query;
+    char *setclause;
+    char *errormsg;
+
+    ofono_debug("SMS status on modem: %p", context->modem);
+
+    if (db =3D=3D NULL)
+        return;
+
+    strftime(buf, 127, "%Y-%m-%dT%H:%M:%S%z", localtime(&when));
+    buf[127] =3D '\0';
+
+    setclause =3D
+        g_strdup_printf
+        ("ohom_send_status=3D%d, ohom_status_update_date=3D\"%s\"", s, buf=
);
+    query =3D g_strdup_printf(UPDATE_OUT_MSGS, setclause, msg_id);
+
+    ofono_debug("Executing query: %s", query);
+
+    if (sqlite3_exec(db, query, NULL, NULL, &errormsg) !=3D SQLITE_OK) {
+        ofono_debug("Error: %s", errormsg);
+        sqlite3_free(errormsg);
+    }
+
+    g_free(setclause);
+    g_free(query);
+}
+
+static struct ofono_history_driver sqlite_driver =3D {
+    .name =3D "SQLite History",
+    .probe =3D sqlite_history_probe,
+    .remove =3D sqlite_history_remove,
+    .call_ended =3D sqlite_history_call_ended,
+    .call_missed =3D sqlite_history_call_missed,
+    .sms_received =3D sqlite_history_sms_received,
+    .sms_send_pending =3D sqlite_history_sms_send_pending,
+    .sms_send_status =3D sqlite_history_sms_send_status,
+};
+
+static int sqlite_history_init(void)
+{
+    return ofono_history_driver_register(&sqlite_driver);
+}
+
+static void sqlite_history_exit(void)
+{
+    ofono_history_driver_unregister(&sqlite_driver);
+}
+
+OFONO_PLUGIN_DEFINE(sqlite_history, "SQLite History Plugin",
+            VERSION, OFONO_PLUGIN_PRIORITY_DEFAULT,
+            sqlite_history_init, sqlite_history_exit)
-- =

1.6.3.3


--===============8840421936419189018==--

