Content-Type: multipart/mixed; boundary="===============5935599234419024055=="
MIME-Version: 1.0
From: Andres Salomon <dilinger@collabora.co.uk>
Subject: [PATCH 2/2] atmodem: add serial line debugging to gatchat
Date: Wed, 05 Aug 2009 17:33:13 -0400
Message-ID: <20090805173313.450a0e20@mycelium.queued.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5935599234419024055==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When debugging G1 stuff, it's really much more helpful to see exactly
what's going across the serial line.  A debug zone for the parser is
also useful, but that'll have to wait for denkenz's pluggable parser
stuff.



From 4402edf0bd4c782229259e7ec17d6da5809d1deb Mon Sep 17 00:00:00 2001
From: Andres Salomon <dilinger@collabora.co.uk>
Date: Wed, 5 Aug 2009 17:18:34 -0400
Subject: [PATCH 2/2] atmodem: add serial line debugging to gatchat

This patch adds debugging support to GAtChat (specifically of what's going
across the serial line).  A callback is passed to g_at_chat_new*, and that
callback is called after any channel reads/writes.

From the atmodem driver perspective, this adds an additional bit to the
debugging flags, and allows the user to select it via --debug=3Datio.
---
 drivers/atmodem/atmodem.c |   13 ++++++++++++-
 gatchat/gatchat.c         |   33 ++++++++++++++++++++++++++++++---
 gatchat/gatchat.h         |    7 +++++--
 include/log.h             |    5 +++++
 src/log.c                 |   39 +++++++++++++++++++++++++++++++++------
 src/main.c                |    1 +
 6 files changed, 86 insertions(+), 12 deletions(-)

diff --git a/drivers/atmodem/atmodem.c b/drivers/atmodem/atmodem.c
index fc255b3..56f5503 100644
--- a/drivers/atmodem/atmodem.c
+++ b/drivers/atmodem/atmodem.c
@@ -320,11 +320,21 @@ static void msg_destroy(gpointer user)
 	dbus_message_unref(msg);
 }
 =

+static void atmodem_debug(const char *format, ...)
+{
+	va_list ap;
+
+	va_start(ap, format);
+	__ofono_vdebug(OFONO_DEBUG_AT_IO, format, ap);
+	va_end(ap);
+}
+
 static void create_cb(GIOChannel *io, gboolean success, gpointer user)
 {
 	DBusConnection *conn =3D ofono_dbus_get_connection();
 	DBusMessage *msg =3D user;
 	DBusMessage *reply;
+	GAtDebugFunc debugf;
 	struct at_data *at =3D NULL;
 	const char *path;
 	const char *target, *driver;
@@ -337,7 +347,8 @@ static void create_cb(GIOChannel *io, gboolean success,=
 gpointer user)
 =

 	at =3D g_new0(struct at_data, 1);
 =

-	at->parser =3D g_at_chat_new(io, 0);
+	debugf =3D ofono_debug_flag_isset(OFONO_DEBUG_AT_IO) ? atmodem_debug : NU=
LL; =

+	at->parser =3D g_at_chat_new(io, 0, debugf);
 =

 	if (!at->parser)
 		goto out;
diff --git a/gatchat/gatchat.c b/gatchat/gatchat.c
index 15cc934..ff07136 100644
--- a/gatchat/gatchat.c
+++ b/gatchat/gatchat.c
@@ -96,6 +96,7 @@ struct _GAtChat {
 	guint read_so_far;			/* Number of bytes processed */
 	gboolean disconnecting;			/* Whether we're disconnecting */
 	enum chat_state state;		/* Current chat state */
+	GAtDebugFunc debugf;			/* debugging output function */
 	int flags;
 	char *pdu_notify;			/* Unsolicited Resp w/ PDU */
 	GSList *response_lines;			/* char * lines of the response */
@@ -713,6 +714,27 @@ static void new_bytes(GAtChat *p)
 	}
 }
 =

+static void g_at_chat_debug_log(GAtChat *chat, gboolean is_read,
+		char *str, gsize len)
+{
+	char type =3D is_read ? '<' : '>';
+	char *tmp;
+
+	if (!chat->debugf || !len)
+		return;
+
+	if (len > 1024) {
+		/* let's keep it to a reasonable length.. */
+		chat->debugf("%c (ignoring string of length %d)\n", type, len);
+		return;
+	}
+
+	str[len] =3D '\0';	/* XXX: is it safe to overwrite this byte? */
+	tmp =3D g_strescape(str, "\"");
+	chat->debugf("%c %s\n", type, tmp);
+	g_free(tmp);
+}
+
 static gboolean received_data(GIOChannel *channel, GIOCondition cond,
 				gpointer data)
 {
@@ -747,6 +769,7 @@ static gboolean received_data(GIOChannel *channel, GIOC=
ondition cond,
 		buf =3D ring_buffer_write_ptr(chat->buf);
 =

 		err =3D g_io_channel_read(channel, (char *) buf, toread, &rbytes);
+		g_at_chat_debug_log(chat, TRUE, buf, rbytes);
 =

 		total_read +=3D rbytes;
 =

@@ -876,6 +899,8 @@ static gboolean can_write_data(GIOChannel *channel, GIO=
Condition cond,
 		return FALSE;
 	}
 =

+	g_at_chat_debug_log(chat, FALSE, cmd->cmd + chat->cmd_bytes_written,
+			bytes_written);
 	chat->cmd_bytes_written +=3D bytes_written;
 =

 	if (bytes_written < towrite)
@@ -900,7 +925,7 @@ static void g_at_chat_wakeup_writer(GAtChat *chat)
 				(GDestroyNotify)write_watcher_destroy_notify);
 }
 =

-GAtChat *g_at_chat_new(GIOChannel *channel, int flags)
+GAtChat *g_at_chat_new(GIOChannel *channel, int flags, GAtDebugFunc debugf)
 {
 	GAtChat *chat;
 	GIOFlags io_flags;
@@ -915,6 +940,7 @@ GAtChat *g_at_chat_new(GIOChannel *channel, int flags)
 =

 	chat->next_cmd_id =3D 1;
 	chat->next_notify_id =3D 1;
+	chat->debugf =3D debugf;
 	chat->flags =3D flags;
 =

 	chat->buf =3D ring_buffer_new(4096);
@@ -1002,7 +1028,8 @@ static int open_device(const char *device)
 	return fd;
 }
 =

-GAtChat *g_at_chat_new_from_tty(const char *device, int flags)
+GAtChat *g_at_chat_new_from_tty(const char *device, int flags,
+		GAtDebugFunc debugf)
 {
 	GIOChannel *channel;
 	int fd;
@@ -1017,7 +1044,7 @@ GAtChat *g_at_chat_new_from_tty(const char *device, i=
nt flags)
 		return NULL;
 	}
 =

-	return g_at_chat_new(channel, flags);
+	return g_at_chat_new(channel, flags, debugf);
 }
 =

 GAtChat *g_at_chat_ref(GAtChat *chat)
diff --git a/gatchat/gatchat.h b/gatchat/gatchat.h
index 969f6f4..4353e08 100644
--- a/gatchat/gatchat.h
+++ b/gatchat/gatchat.h
@@ -36,6 +36,8 @@ typedef void (*GAtResultFunc)(gboolean success, GAtResult=
 *result,
 				gpointer user_data);
 typedef void (*GAtNotifyFunc)(GAtResult *result, gpointer user_data);
 typedef void (*GAtDisconnectFunc)(gpointer user_data);
+typedef void (*GAtDebugFunc)(const char *format, ...)
+		__attribute__((format(printf, 1, 2)));
 =

 enum _GAtChatFlags {
 	G_AT_CHAT_FLAG_NO_LEADING_CRLF =3D 1,	/* Some emulators are broken */
@@ -44,8 +46,9 @@ enum _GAtChatFlags {
 =

 typedef enum _GAtChatFlags GAtChatFlags;
 =

-GAtChat *g_at_chat_new(GIOChannel *channel, int flags);
-GAtChat *g_at_chat_new_from_tty(const char *device, int flags);
+GAtChat *g_at_chat_new(GIOChannel *channel, int flags, GAtDebugFunc debugf=
);
+GAtChat *g_at_chat_new_from_tty(const char *device, int flags,
+		GAtDebugFunc debugf);
 =

 int g_at_chat_get_flags(GAtChat *chat);
 void g_at_chat_set_flags(GAtChat *chat, int flags);
diff --git a/include/log.h b/include/log.h
index ef2c663..153308a 100644
--- a/include/log.h
+++ b/include/log.h
@@ -28,6 +28,7 @@ extern "C" {
 =

 typedef enum {
 	OFONO_DEBUG_CORE =3D 1 << 0,
+	OFONO_DEBUG_AT_IO =3D 1 << 1,
 } ofono_debug_flags;
 =

 /**
@@ -42,9 +43,13 @@ extern void ofono_error(const char *format, ...)
 				__attribute__((format(printf, 1, 2)));
 extern void __ofono_debug(ofono_debug_flags flag, const char *format, ...)
 				__attribute__((format(printf, 2, 3)));
+extern void __ofono_vdebug(ofono_debug_flags flag, const char *format,
+				va_list ap);
 #define ofono_debug(format, ...) \
 		__ofono_debug(OFONO_DEBUG_CORE, (format), ##__VA_ARGS__)
 =

+extern gboolean ofono_debug_flag_isset(ofono_debug_flags flag);
+
 /**
  * DBG:
  * @fmt: format string
diff --git a/src/log.c b/src/log.c
index 167fe21..c8c4d99 100644
--- a/src/log.c
+++ b/src/log.c
@@ -68,6 +68,38 @@ void ofono_error(const char *format, ...)
 }
 =

 /**
+ * __ofono_vdebug:
+ * @flag: zone flag (ie, OFONO_DEBUG_CORE)
+ *
+ * Determine whether a specific debug flag is set or not
+ *
+ * Whether or not debugging is enabled is not considered.
+ */ =

+gboolean ofono_debug_flag_isset(ofono_debug_flags flag)
+{
+	return (debug_flags & flag) ? TRUE : FALSE;
+}
+
+/**
+ * __ofono_vdebug:
+ * @flag: zone flag (ie, OFONO_DEBUG_CORE)
+ * @format: format string
+ * @ap: valist of arguments
+ *
+ * Output debug message
+ *
+ * The actual output of the debug message is controlled via a command line
+ * switch. If not enabled, these messages will be ignored.
+ */
+void __ofono_vdebug(ofono_debug_flags flag, const char *format, va_list ap)
+{
+	if (!debug_enabled || !(debug_flags & flag))
+		return;
+
+	vsyslog(LOG_DEBUG, format, ap);
+}
+
+/**
  * __ofono_debug:
  * @flag: zone flag (ie, OFONO_DEBUG_CORE)
  * @format: format string
@@ -82,13 +114,8 @@ void __ofono_debug(ofono_debug_flags flag, const char *=
format, ...)
 {
 	va_list ap;
 =

-	if (!debug_enabled || !(debug_flags & flag))
-		return;
-
 	va_start(ap, format);
-
-	vsyslog(LOG_DEBUG, format, ap);
-
+	__ofono_vdebug(flag, format, ap);
 	va_end(ap);
 }
 =

diff --git a/src/main.c b/src/main.c
index 7227bde..93f6f74 100644
--- a/src/main.c
+++ b/src/main.c
@@ -58,6 +58,7 @@ static guint debug_flags =3D 0;
 =

 static GDebugKey keys[] =3D {
 	{ "core", OFONO_DEBUG_CORE },
+	{ "atio", OFONO_DEBUG_AT_IO },
 };
 =

 static gboolean parse_debug_flags(const gchar *option_name, const gchar *v=
alue,
-- =

1.6.3.3


--===============5935599234419024055==--

