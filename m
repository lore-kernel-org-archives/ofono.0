Content-Type: multipart/mixed; boundary="===============2660962134525096030=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 1/4] Add gatutil.c to share common APIs with GAtServer
Date: Mon, 11 Jan 2010 18:53:47 +0800
Message-ID: <1263207230-22036-1-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <y>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2660962134525096030==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Add gatutil.c/gatutil.h and move shared typedef and APIs into it.
So that they can be shared by GAtServer.
---
 Makefile.am       |    3 +-
 gatchat/gatchat.c |   98 +++-------------------------------------
 gatchat/gatchat.h |    8 +---
 gatchat/gatutil.c |  131 +++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 gatchat/gatutil.h |   46 +++++++++++++++++++
 5 files changed, 186 insertions(+), 100 deletions(-)
 create mode 100644 gatchat/gatutil.c
 create mode 100644 gatchat/gatutil.h

diff --git a/Makefile.am b/Makefile.am
index 276b478..67882b9 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -51,7 +51,8 @@ gatchat_sources =3D gatchat/gatchat.h gatchat/gatchat.c \
 				gatchat/ringbuffer.h gatchat/ringbuffer.c \
 				gatchat/gatmux.h gatchat/gatmux.c \
 				gatchat/gsm0710.h gatchat/gsm0710.c \
-				gatchat/gattty.h gatchat/gattty.c
+				gatchat/gattty.h gatchat/gattty.c \
+				gatchat/gatutil.h gatchat/gatutil.c
 =

 udev_files =3D plugins/ofono.rules
 =

diff --git a/gatchat/gatchat.c b/gatchat/gatchat.c
index 8045c6b..e5cf235 100644
--- a/gatchat/gatchat.c
+++ b/gatchat/gatchat.c
@@ -40,7 +40,6 @@
 static const char *none_prefix[] =3D { NULL };
 =

 static void g_at_chat_wakeup_writer(GAtChat *chat);
-static void debug_chat(GAtChat *chat, gboolean in, const char *str, gsize =
len);
 =

 struct at_command {
 	char *cmd;
@@ -686,81 +685,6 @@ static void new_bytes(GAtChat *p)
 	g_at_chat_unref(p);
 }
 =

-static void debug_chat(GAtChat *chat, gboolean in, const char *str, gsize =
len)
-{
-	char type =3D in ? '<' : '>';
-	gsize escaped =3D 2; /* Enough for '<', ' ' */
-	char *escaped_str;
-	const char *esc =3D "<ESC>";
-	gsize esc_size =3D strlen(esc);
-	const char *ctrlz =3D "<CtrlZ>";
-	gsize ctrlz_size =3D strlen(ctrlz);
-	gsize i;
-
-	if (!chat->debugf || !len)
-		return;
-
-	for (i =3D 0; i < len; i++) {
-		char c =3D str[i];
-
-		if (isprint(c))
-			escaped +=3D 1;
-		else if (c =3D=3D '\r' || c =3D=3D '\t' || c =3D=3D '\n')
-			escaped +=3D 2;
-		else if (c =3D=3D 26)
-			escaped +=3D ctrlz_size;
-		else if (c =3D=3D 25)
-			escaped +=3D esc_size;
-		else
-			escaped +=3D 4;
-	}
-
-	escaped_str =3D g_malloc(escaped + 1);
-	escaped_str[0] =3D type;
-	escaped_str[1] =3D ' ';
-	escaped_str[2] =3D '\0';
-	escaped_str[escaped] =3D '\0';
-
-	for (escaped =3D 2, i =3D 0; i < len; i++) {
-		char c =3D str[i];
-
-		switch (c) {
-		case '\r':
-			escaped_str[escaped++] =3D '\\';
-			escaped_str[escaped++] =3D 'r';
-			break;
-		case '\t':
-			escaped_str[escaped++] =3D '\\';
-			escaped_str[escaped++] =3D 't';
-			break;
-		case '\n':
-			escaped_str[escaped++] =3D '\\';
-			escaped_str[escaped++] =3D 'n';
-			break;
-		case 26:
-			strncpy(&escaped_str[escaped], ctrlz, ctrlz_size);
-			escaped +=3D ctrlz_size;
-			break;
-		case 25:
-			strncpy(&escaped_str[escaped], esc, esc_size);
-			escaped +=3D esc_size;
-			break;
-		default:
-			if (isprint(c))
-				escaped_str[escaped++] =3D c;
-			else {
-				escaped_str[escaped++] =3D '\\';
-				escaped_str[escaped++] =3D '0' + ((c >> 6) & 07);
-				escaped_str[escaped++] =3D '0' + ((c >> 3) & 07);
-				escaped_str[escaped++] =3D '0' + (c & 07);
-			}
-		}
-	}
-
-	chat->debugf(escaped_str, chat->debug_data);
-	g_free(escaped_str);
-}
-
 static gboolean received_data(GIOChannel *channel, GIOCondition cond,
 				gpointer data)
 {
@@ -786,7 +710,8 @@ static gboolean received_data(GIOChannel *channel, GIOC=
ondition cond,
 		buf =3D ring_buffer_write_ptr(chat->buf);
 =

 		err =3D g_io_channel_read(channel, (char *) buf, toread, &rbytes);
-		debug_chat(chat, TRUE, (char *)buf, rbytes);
+		g_at_util_debug_chat(chat->debugf, TRUE, (char *)buf, rbytes,
+							chat->debug_data);
 =

 		total_read +=3D rbytes;
 =

@@ -932,8 +857,9 @@ static gboolean can_write_data(GIOChannel *channel, GIO=
Condition cond,
 		return FALSE;
 	}
 =

-	debug_chat(chat, FALSE, cmd->cmd + chat->cmd_bytes_written,
-			bytes_written);
+	g_at_util_debug_chat(chat->debugf, FALSE,
+					cmd->cmd + chat->cmd_bytes_written,
+					bytes_written, chat->debug_data);
 	chat->cmd_bytes_written +=3D bytes_written;
 =

 	if (bytes_written < towrite)
@@ -961,7 +887,6 @@ static void g_at_chat_wakeup_writer(GAtChat *chat)
 GAtChat *g_at_chat_new(GIOChannel *channel, GAtSyntax *syntax)
 {
 	GAtChat *chat;
-	GIOFlags io_flags;
 =

 	if (!channel)
 		return NULL;
@@ -992,20 +917,9 @@ GAtChat *g_at_chat_new(GIOChannel *channel, GAtSyntax =
*syntax)
 	chat->notify_list =3D g_hash_table_new_full(g_str_hash, g_str_equal,
 				g_free, (GDestroyNotify)at_notify_destroy);
 =

-	if (g_io_channel_set_encoding(channel, NULL, NULL) !=3D
-			G_IO_STATUS_NORMAL)
-		goto error;
-
-	io_flags =3D g_io_channel_get_flags(channel);
-
-	io_flags |=3D G_IO_FLAG_NONBLOCK;
-
-	if (g_io_channel_set_flags(channel, io_flags, NULL) !=3D
-			G_IO_STATUS_NORMAL)
+	if (!g_at_util_set_io(channel))
 		goto error;
 =

-	g_io_channel_set_close_on_unref(channel, TRUE);
-
 	chat->channel =3D channel;
 	chat->read_watch =3D g_io_add_watch_full(channel, G_PRIORITY_DEFAULT,
 				G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
diff --git a/gatchat/gatchat.h b/gatchat/gatchat.h
index 999b92d..3c3fa5d 100644
--- a/gatchat/gatchat.h
+++ b/gatchat/gatchat.h
@@ -26,19 +26,13 @@
 extern "C" {
 #endif
 =

-#include "gatresult.h"
 #include "gatsyntax.h"
+#include "gatutil.h"
 =

 struct _GAtChat;
 =

 typedef struct _GAtChat GAtChat;
 =

-typedef void (*GAtResultFunc)(gboolean success, GAtResult *result,
-				gpointer user_data);
-typedef void (*GAtNotifyFunc)(GAtResult *result, gpointer user_data);
-typedef void (*GAtDisconnectFunc)(gpointer user_data);
-typedef void (*GAtDebugFunc)(const char *str, gpointer user_data);
-
 GAtChat *g_at_chat_new(GIOChannel *channel, GAtSyntax *syntax);
 =

 GIOChannel *g_at_chat_get_channel(GAtChat *chat);
diff --git a/gatchat/gatutil.c b/gatchat/gatutil.c
new file mode 100644
index 0000000..585a590
--- /dev/null
+++ b/gatchat/gatutil.c
@@ -0,0 +1,131 @@
+/*
+ *
+ *  AT chat library with GLib integration
+ *
+ *  Copyright (C) 2008-2010  Intel Corporation. All rights reserved.
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
+#include <string.h>
+#include <ctype.h>
+
+#include <glib.h>
+
+#include "gatutil.h"
+
+void g_at_util_debug_chat(GAtDebugFunc debugf, gboolean in, const char *st=
r,
+						gsize len, gpointer user_data)
+{
+	char type =3D in ? '<' : '>';
+	gsize escaped =3D 2; /* Enough for '<', ' ' */
+	char *escaped_str;
+	const char *esc =3D "<ESC>";
+	gsize esc_size =3D strlen(esc);
+	const char *ctrlz =3D "<CtrlZ>";
+	gsize ctrlz_size =3D strlen(ctrlz);
+	gsize i;
+
+	if (!debugf || !len)
+		return;
+
+	for (i =3D 0; i < len; i++) {
+		char c =3D str[i];
+
+		if (isprint(c))
+			escaped +=3D 1;
+		else if (c =3D=3D '\r' || c =3D=3D '\t' || c =3D=3D '\n')
+			escaped +=3D 2;
+		else if (c =3D=3D 26)
+			escaped +=3D ctrlz_size;
+		else if (c =3D=3D 25)
+			escaped +=3D esc_size;
+		else
+			escaped +=3D 4;
+	}
+
+	escaped_str =3D g_malloc(escaped + 1);
+	escaped_str[0] =3D type;
+	escaped_str[1] =3D ' ';
+	escaped_str[2] =3D '\0';
+	escaped_str[escaped] =3D '\0';
+
+	for (escaped =3D 2, i =3D 0; i < len; i++) {
+		char c =3D str[i];
+
+		switch (c) {
+		case '\r':
+			escaped_str[escaped++] =3D '\\';
+			escaped_str[escaped++] =3D 'r';
+			break;
+		case '\t':
+			escaped_str[escaped++] =3D '\\';
+			escaped_str[escaped++] =3D 't';
+			break;
+		case '\n':
+			escaped_str[escaped++] =3D '\\';
+			escaped_str[escaped++] =3D 'n';
+			break;
+		case 26:
+			strncpy(&escaped_str[escaped], ctrlz, ctrlz_size);
+			escaped +=3D ctrlz_size;
+			break;
+		case 25:
+			strncpy(&escaped_str[escaped], esc, esc_size);
+			escaped +=3D esc_size;
+			break;
+		default:
+			if (isprint(c))
+				escaped_str[escaped++] =3D c;
+			else {
+				escaped_str[escaped++] =3D '\\';
+				escaped_str[escaped++] =3D '0' + ((c >> 6) & 07);
+				escaped_str[escaped++] =3D '0' + ((c >> 3) & 07);
+				escaped_str[escaped++] =3D '0' + (c & 07);
+			}
+		}
+	}
+
+	debugf(escaped_str, user_data);
+	g_free(escaped_str);
+}
+
+gboolean g_at_util_set_io(GIOChannel *io)
+{
+	GIOFlags io_flags;
+
+	if (g_io_channel_set_encoding(io, NULL, NULL) !=3D
+			G_IO_STATUS_NORMAL)
+		return FALSE;
+
+	io_flags =3D g_io_channel_get_flags(io);
+
+	io_flags |=3D G_IO_FLAG_NONBLOCK;
+	io_flags |=3D G_IO_FLAG_IS_READABLE;
+	io_flags |=3D G_IO_FLAG_IS_WRITEABLE;
+
+	if (g_io_channel_set_flags(io, io_flags, NULL) !=3D
+			G_IO_STATUS_NORMAL)
+		return FALSE;
+
+	g_io_channel_set_close_on_unref(io, TRUE);
+
+	return TRUE;
+}
+
diff --git a/gatchat/gatutil.h b/gatchat/gatutil.h
new file mode 100644
index 0000000..63bbfff
--- /dev/null
+++ b/gatchat/gatutil.h
@@ -0,0 +1,46 @@
+/*
+ *
+ *  AT chat library with GLib integration
+ *
+ *  Copyright (C) 2008-2010  Intel Corporation. All rights reserved.
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
+#ifndef __GATUTIL_H
+#define __GATUTIL_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#include "gatresult.h"
+
+typedef void (*GAtResultFunc)(gboolean success, GAtResult *result,
+				gpointer user_data);
+typedef void (*GAtNotifyFunc)(GAtResult *result, gpointer user_data);
+typedef void (*GAtDisconnectFunc)(gpointer user_data);
+typedef void (*GAtDebugFunc)(const char *str, gpointer user_data);
+
+void g_at_util_debug_chat(GAtDebugFunc debugf, gboolean in, const char *st=
r,
+						gsize len, gpointer user_data);
+
+gboolean g_at_util_set_io(GIOChannel *io);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __GATUTIL_H */
-- =

1.6.3.3


--===============2660962134525096030==--

