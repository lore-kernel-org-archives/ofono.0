Content-Type: multipart/mixed; boundary="===============6850301016023827335=="
MIME-Version: 1.0
From: Andres Salomon <dilinger@collabora.co.uk>
Subject: Re: [PATCH 2/2] atmodem: add serial line debugging to gatchat
Date: Thu, 06 Aug 2009 01:21:05 -0400
Message-ID: <20090806012105.5e85fac7@mycelium.queued.net>
In-Reply-To: <200908051709.12869.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6850301016023827335==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 5 Aug 2009 17:09:12 -0500
Denis Kenzior <denkenz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:

> Hi Andres,
> =

> >  drivers/atmodem/atmodem.c |   13 ++++++++++++-
> >  gatchat/gatchat.c         |   33 ++++++++++++++++++++++++++++++---
> >  gatchat/gatchat.h         |    7 +++++--
> >  include/log.h             |    5 +++++
> >  src/log.c                 |   39
> > +++++++++++++++++++++++++++++++++------ src/main.c
> > |    1 + 6 files changed, 86 insertions(+), 12 deletions(-)
> =

> Send two separate patches, one for gatchat related functionality.
> One for the ofono integration.
> =


How's the following?  I didn't create any g_at_chat_get_debug*
functions; I figure those can be created later when someone has a use
for them.

From 61cd909200acde95e42f39fa8949668460531c50 Mon Sep 17 00:00:00 2001
From: Andres Salomon <dilinger@collabora.co.uk>
Date: Wed, 5 Aug 2009 17:18:34 -0400
Subject: [PATCH 2/3] gatchat: add debugging infrastructure

This patch adds debugging support to GAtChat (specifically of what's going
across the serial line).  Callbacks can be set via g_at_chat_set_debugging,
and that callback is called after any channel reads or writes.
---
 gatchat/gatchat.c |   46 ++++++++++++++++++++++++++++++++++++++++++++++
 gatchat/gatchat.h |    4 ++++
 2 files changed, 50 insertions(+), 0 deletions(-)

diff --git a/gatchat/gatchat.c b/gatchat/gatchat.c
index 15cc934..031890f 100644
--- a/gatchat/gatchat.c
+++ b/gatchat/gatchat.c
@@ -96,6 +96,8 @@ struct _GAtChat {
 	guint read_so_far;			/* Number of bytes processed */
 	gboolean disconnecting;			/* Whether we're disconnecting */
 	enum chat_state state;		/* Current chat state */
+	GAtDebugFunc debugf;			/* debugging output function */
+	gpointer debug_func_user_data;
 	int flags;
 	char *pdu_notify;			/* Unsolicited Resp w/ PDU */
 	GSList *response_lines;			/* char * lines of the response */
@@ -713,6 +715,35 @@ static void new_bytes(GAtChat *p)
 	}
 }
 =

+static void g_at_chat_debug_log(GAtChat *chat, gboolean is_read,
+		const char *str, gsize len)
+{
+	char type =3D is_read ? '<' : '>';
+	char *t1, *t2;
+
+	if (!chat->debugf || !len)
+		return;
+
+	if (len > 2048) {
+		/* 27.007 specifies a max command result length of 2048 */
+		t1 =3D g_strdup_printf("%c (ignoring string of length %d)", type, len);
+		chat->debugf(t1, chat->debug_func_user_data);
+		g_free(t1);
+		return;
+	}
+
+	/* prefix with "> " or "< ", and ensure null-termination */
+	t1 =3D g_malloc(len + 3);
+	g_sprintf(t1, "%c ", type);
+	g_memmove(t1 + 2, str, len);
+	t1[len + 2] =3D '\0';
+
+	t2 =3D g_strescape(t1, "\"");
+	chat->debugf(t2, chat->debug_func_user_data);
+	g_free(t1);
+	g_free(t2);
+}
+
 static gboolean received_data(GIOChannel *channel, GIOCondition cond,
 				gpointer data)
 {
@@ -747,6 +778,7 @@ static gboolean received_data(GIOChannel *channel, GIOC=
ondition cond,
 		buf =3D ring_buffer_write_ptr(chat->buf);
 =

 		err =3D g_io_channel_read(channel, (char *) buf, toread, &rbytes);
+		g_at_chat_debug_log(chat, TRUE, buf, rbytes);
 =

 		total_read +=3D rbytes;
 =

@@ -876,6 +908,8 @@ static gboolean can_write_data(GIOChannel *channel, GIO=
Condition cond,
 		return FALSE;
 	}
 =

+	g_at_chat_debug_log(chat, FALSE, cmd->cmd + chat->cmd_bytes_written,
+			bytes_written);
 	chat->cmd_bytes_written +=3D bytes_written;
 =

 	if (bytes_written < towrite)
@@ -915,6 +949,7 @@ GAtChat *g_at_chat_new(GIOChannel *channel, int flags)
 =

 	chat->next_cmd_id =3D 1;
 	chat->next_notify_id =3D 1;
+	chat->debugf =3D NULL;
 	chat->flags =3D flags;
 =

 	chat->buf =3D ring_buffer_new(4096);
@@ -1075,6 +1110,17 @@ gboolean g_at_chat_set_disconnect_function(GAtChat *=
chat,
 	return TRUE;
 }
 =

+gboolean g_at_chat_set_debugging(GAtChat *chat, GAtDebugFunc func,
+		gpointer user_data)
+{
+	if (chat =3D=3D NULL)
+		return FALSE;
+
+	chat->debugf =3D func;
+	chat->debug_func_user_data =3D user_data;
+	return TRUE;
+}
+
 static guint send_common(GAtChat *chat, const char *cmd,
 			const char **prefix_list,
 			GAtNotifyFunc listing, GAtResultFunc func,
diff --git a/gatchat/gatchat.h b/gatchat/gatchat.h
index 969f6f4..dcf600f 100644
--- a/gatchat/gatchat.h
+++ b/gatchat/gatchat.h
@@ -36,6 +36,7 @@ typedef void (*GAtResultFunc)(gboolean success, GAtResult=
 *result,
 				gpointer user_data);
 typedef void (*GAtNotifyFunc)(GAtResult *result, gpointer user_data);
 typedef void (*GAtDisconnectFunc)(gpointer user_data);
+typedef void (*GAtDebugFunc)(const char *str, gpointer user_data);
 =

 enum _GAtChatFlags {
 	G_AT_CHAT_FLAG_NO_LEADING_CRLF =3D 1,	/* Some emulators are broken */
@@ -58,6 +59,9 @@ gboolean g_at_chat_shutdown(GAtChat *chat);
 gboolean g_at_chat_set_disconnect_function(GAtChat *chat,
 			GAtDisconnectFunc disconnect, gpointer user_data);
 =

+gboolean g_at_chat_set_debugging(GAtChat *chat, GAtDebugFunc func,
+		gpointer user_data);
+
 /*!
  * Queue an AT command for execution.  The command contents are given
  * in cmd.  Once the command executes, the callback function given by
-- =

1.6.3.3


From 6e63802adfcfd3f780a02329d4457350fc2c05c9 Mon Sep 17 00:00:00 2001
From: Andres Salomon <dilinger@collabora.co.uk>
Date: Thu, 6 Aug 2009 01:15:02 -0400
Subject: [PATCH 3/3] atmodem: make use of gatchat debugging

This provides hooks for GAtChat's debugging infrastructure, and exposes
that to users via --debug=3Datio.
---
 drivers/atmodem/atmodem.c |    8 ++++++++
 include/log.h             |    3 +++
 src/log.c                 |   15 ++++++++++++++-
 src/main.c                |    1 +
 4 files changed, 26 insertions(+), 1 deletions(-)

diff --git a/drivers/atmodem/atmodem.c b/drivers/atmodem/atmodem.c
index fc255b3..e32e2fb 100644
--- a/drivers/atmodem/atmodem.c
+++ b/drivers/atmodem/atmodem.c
@@ -320,6 +320,11 @@ static void msg_destroy(gpointer user)
 	dbus_message_unref(msg);
 }
 =

+static void atmodem_debug(const char *str, gpointer user_data)
+{
+	__ofono_debug(OFONO_DEBUG_AT_IO, "%s", str);
+}
+
 static void create_cb(GIOChannel *io, gboolean success, gpointer user)
 {
 	DBusConnection *conn =3D ofono_dbus_get_connection();
@@ -342,6 +347,9 @@ static void create_cb(GIOChannel *io, gboolean success,=
 gpointer user)
 	if (!at->parser)
 		goto out;
 =

+	if (ofono_debug_flag_isset(OFONO_DEBUG_AT_IO))
+		g_at_chat_set_debugging(at->parser, atmodem_debug, NULL);
+
 	ofono_debug("Seting up AT channel");
 =

 	dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &target,
diff --git a/include/log.h b/include/log.h
index ef2c663..61b4495 100644
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
@@ -45,6 +46,8 @@ extern void __ofono_debug(ofono_debug_flags flag, const c=
har *format, ...)
 #define ofono_debug(format, ...) \
 		__ofono_debug(OFONO_DEBUG_CORE, (format), ##__VA_ARGS__)
 =

+extern gboolean ofono_debug_flag_isset(ofono_debug_flags flag);
+
 /**
  * DBG:
  * @fmt: format string
diff --git a/src/log.c b/src/log.c
index 167fe21..d027fa9 100644
--- a/src/log.c
+++ b/src/log.c
@@ -68,6 +68,19 @@ void ofono_error(const char *format, ...)
 }
 =

 /**
+ * ofono_debug_flag_isset:
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
  * __ofono_debug:
  * @flag: zone flag (ie, OFONO_DEBUG_CORE)
  * @format: format string
@@ -82,7 +95,7 @@ void __ofono_debug(ofono_debug_flags flag, const char *fo=
rmat, ...)
 {
 	va_list ap;
 =

-	if (!debug_enabled || !(debug_flags & flag))
+	if (!debug_enabled || !ofono_debug_flag_isset(flag))
 		return;
 =

 	va_start(ap, format);
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


--===============6850301016023827335==--

