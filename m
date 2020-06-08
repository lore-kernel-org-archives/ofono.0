Content-Type: multipart/mixed; boundary="===============1216258323011171702=="
MIME-Version: 1.0
From: Pavel Machek <pavel@ucw.cz>
Subject: Weird Droid 4 modem protocol and a way to support it
Date: Tue, 09 Jun 2020 01:59:41 +0200
Message-ID: <20200608235941.GA4835@amd>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1216258323011171702==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi!

I'd really like to get support for Droid 4 modem... unfortunately it
is quite special. Few words about Droid 4 modem protocol:

diff --git a/drivers/motorolamodem/README b/drivers/motorolamodem/README
new file mode 100644
index 00000000..fe3a1e83
--- /dev/null
+++ b/drivers/motorolamodem/README
@@ -0,0 +1,40 @@
+
+This is really "interesting". The protocol looks like AT commands on
+the first look, and some commands are same (ATD does the call, ATA
+answers it), but often they are subtly different (ATD takes ,0
+parameter to work with caller id), and overall protocol is very
+different.
+
+1) protocol is packet-based, not character-based.
+
+Whole command needs to be sent as one packet, in one write() call to
+the kernel. Replies came back in packets, too, you can get them with
+single read() call.
+
+2) protocol semantics is really different.
+
+You don't have command, responses to the command, then response
+terminator. You send one packet and get one packet with the reply.
+
+In AT you got:
+
+> AT+TELL_ME_SOMETHING
+< IT_IS_42
+< OK
+
+While in motmdm it is:
+
+> U0005AT+TELL_ME
+< U0005OK:IT_IS_42
+
+
+AFAICT lot of complexity in atchat is collecting the multiple lines,
+including handling stuff like
+
+IT_IS=3D"Arbitrary
+text including
+OK
+here"
+OK
+
+I don't believe we need that for d4.
\ No newline@end of file

I'm not sure what is the best way to support it. I was not able to get
atchat.c to work with it (and I don't think it is quite suitable), so
I ended up copying it and modifying it for Droid 4 protocol.

Is that acceptable? Can you see a better way?

I do have code for basic voicecall support, SMSes and some kind of
netreg support. But it is quite simple, needs more cleanups, and this
mail is already too long.

Best regards,
								Pavel

diff --git a/gatchat/motchat.c b/gatchat/motchat.c
new file mode 100644
index 00000000..bf5979a8
--- /dev/null
+++ b/gatchat/motchat.c
@@ -0,0 +1,1220 @@
+/*
+ *
+ *  MOTMDM chat library with GLib integration
+ *
+ *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
+ *  Copyright (C) 2020 Pavel Machek <pavel@ucw.cz>
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
+/* FIXME: remove: terminators?
+
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <stdio.h>
+#include <unistd.h>
+#include <string.h>
+#include <assert.h>
+#include <ctype.h>
+#include <errno.h>
+
+#include <glib.h>
+
+#include "ringbuffer.h"
+#include "motchat.h"
+#include "gatio.h"
+
+/* #define WRITE_SCHEDULER_DEBUG 1 */
+
+struct mot_chat;
+static void chat_wakeup_writer(struct mot_chat *chat);
+
+struct at_command {
+	char *cmd;
+	char **prefixes;
+	guint flags;
+	guint id;
+	guint gid;
+	GAtResultFunc callback;
+	GAtNotifyFunc listing;
+	gpointer user_data;
+	GDestroyNotify notify;
+};
+
+struct at_notify_node {
+	guint id;
+	guint gid;
+	GAtNotifyFunc callback;
+	gpointer user_data;
+	GDestroyNotify notify;
+	gboolean destroyed;
+};
+
+typedef gboolean (*node_remove_func)(struct at_notify_node *node,
+					gpointer user_data);
+
+struct at_notify {
+	GSList *nodes;
+	gboolean pdu;
+};
+
+static gboolean node_is_destroyed(struct at_notify_node *node, gpointer us=
er)
+{
+	return node->destroyed;
+}
+
+static gint at_notify_node_compare_by_id(gconstpointer a, gconstpointer b)
+{
+	const struct at_notify_node *node =3D a;
+	guint id =3D GPOINTER_TO_UINT(b);
+
+	if (node->id < id)
+		return -1;
+
+	if (node->id > id)
+		return 1;
+
+	return 0;
+}
+
+static void at_notify_node_destroy(gpointer data, gpointer user_data)
+{
+	struct at_notify_node *node =3D data;
+
+	if (node->notify)
+		node->notify(node->user_data);
+
+	g_free(node);
+}
+
+static void at_notify_destroy(gpointer user_data)
+{
+	struct at_notify *notify =3D user_data;
+
+	g_slist_foreach(notify->nodes, at_notify_node_destroy, NULL);
+	g_slist_free(notify->nodes);
+	g_free(notify);
+}
+
+static gint at_command_compare_by_id(gconstpointer a, gconstpointer b)
+{
+	const struct at_command *command =3D a;
+	guint id =3D GPOINTER_TO_UINT(b);
+
+	if (command->id < id)
+		return -1;
+
+	if (command->id > id)
+		return 1;
+
+	return 0;
+}
+
+static gboolean mot_chat_unregister_all(struct mot_chat *chat,
+					gboolean mark_only,
+					node_remove_func func,
+					gpointer userdata)
+{
+	GHashTableIter iter;
+	struct at_notify *notify;
+	struct at_notify_node *node;
+	gpointer key, value;
+	GSList *p;
+	GSList *c;
+	GSList *t;
+
+	if (chat->notify_list =3D=3D NULL)
+		return FALSE;
+
+	g_hash_table_iter_init(&iter, chat->notify_list);
+
+	while (g_hash_table_iter_next(&iter, &key, &value)) {
+		notify =3D value;
+
+		p =3D NULL;
+		c =3D notify->nodes;
+
+		while (c) {
+			node =3D c->data;
+
+			if (func(node, userdata) !=3D TRUE) {
+				p =3D c;
+				c =3D c->next;
+				continue;
+			}
+
+			if (mark_only) {
+				node->destroyed =3D TRUE;
+				p =3D c;
+				c =3D c->next;
+				continue;
+			}
+
+			if (p)
+				p->next =3D c->next;
+			else
+				notify->nodes =3D c->next;
+
+			at_notify_node_destroy(node, NULL);
+
+			t =3D c;
+			c =3D c->next;
+			g_slist_free_1(t);
+		}
+
+		if (notify->nodes =3D=3D NULL)
+			g_hash_table_iter_remove(&iter);
+	}
+
+	return TRUE;
+}
+
+static struct at_command *at_command_create(guint gid, const char *cmd,
+						const char **prefix_list,
+						guint flags,
+						GAtNotifyFunc listing,
+						GAtResultFunc func,
+						gpointer user_data,
+						GDestroyNotify notify,
+						gboolean wakeup)
+{
+	struct at_command *c;
+	gsize len;
+	char **prefixes =3D NULL;
+
+	if (prefix_list) {
+		int num_prefixes =3D 0;
+		int i;
+
+		while (prefix_list[num_prefixes])
+			num_prefixes +=3D 1;
+
+		prefixes =3D g_new(char *, num_prefixes + 1);
+
+		for (i =3D 0; i < num_prefixes; i++)
+			prefixes[i] =3D strdup(prefix_list[i]);
+
+		prefixes[num_prefixes] =3D NULL;
+	}
+
+	c =3D g_try_new0(struct at_command, 1);
+	if (c =3D=3D NULL)
+		return 0;
+
+	len =3D strlen(cmd);
+	c->cmd =3D g_try_new(char, len + 2);
+	if (c->cmd =3D=3D NULL) {
+		g_free(c);
+		return 0;
+	}
+
+	memcpy(c->cmd, cmd, len);
+
+	printf("Have command of length %d (%s)\n", len, cmd);
+
+	/* If we have embedded '\r' then this is a command expecting a prompt
+	 * from the modem.  Embed Ctrl-Z at the very end automatically
+	 */
+	if (wakeup =3D=3D FALSE) {
+	  printf("Adding \r or ^z\n");
+	  if (strchr(cmd, '\r')) {
+			c->cmd[len++] =3D 26;
+	    =

+#if 0
+			c->cmd[len++] =3D 26;
+			c->cmd[len++] =3D '\n';			=

+			c->cmd[len] =3D '\r';
+#endif
+	  } else
+			c->cmd[len] =3D '\r';
+
+		len +=3D 1;
+	}
+
+	c->cmd[len] =3D '\0';
+
+	c->gid =3D gid;
+	c->flags =3D flags;
+	c->prefixes =3D prefixes;
+	c->callback =3D func;
+	c->listing =3D listing;
+	c->user_data =3D user_data;
+	c->notify =3D notify;
+
+	return c;
+}
+
+static void at_command_destroy(struct at_command *cmd)
+{
+	if (cmd->notify)
+		cmd->notify(cmd->user_data);
+
+	g_strfreev(cmd->prefixes);
+	g_free(cmd->cmd);
+	g_free(cmd);
+}
+
+static void chat_cleanup(struct mot_chat *chat)
+{
+	struct at_command *c;
+
+	/* Cleanup pending commands */
+	while ((c =3D g_queue_pop_head(chat->command_queue)))
+		at_command_destroy(c);
+
+	g_queue_free(chat->command_queue);
+	chat->command_queue =3D NULL;
+
+	/* Cleanup registered notifications */
+	g_hash_table_destroy(chat->notify_list);
+	chat->notify_list =3D NULL;
+
+	if (chat->pdu_notify) {
+		g_free(chat->pdu_notify);
+		chat->pdu_notify =3D NULL;
+	}
+
+	if (chat->wakeup) {
+		g_free(chat->wakeup);
+		chat->wakeup =3D NULL;
+	}
+
+	if (chat->wakeup_timer) {
+		g_timer_destroy(chat->wakeup_timer);
+		chat->wakeup_timer =3D 0;
+	}
+
+	if (chat->timeout_source) {
+		g_source_remove(chat->timeout_source);
+		chat->timeout_source =3D 0;
+	}
+}
+
+static void io_disconnect(gpointer user_data)
+{
+	struct mot_chat *chat =3D user_data;
+
+	chat_cleanup(chat);
+	g_at_io_unref(chat->io);
+	chat->io =3D NULL;
+
+	if (chat->user_disconnect)
+		chat->user_disconnect(chat->user_disconnect_data);
+}
+
+static void at_notify_call_callback(gpointer data, gpointer user_data)
+{
+	struct at_notify_node *node =3D data;
+	GAtResult *result =3D user_data;
+
+	node->callback(result, node->user_data);
+}
+
+static gboolean mot_chat_match_notify(struct mot_chat *chat, char *line)
+{
+	GHashTableIter iter;
+	struct at_notify *notify;
+	gpointer key, value;
+	gboolean ret =3D FALSE;
+	GAtResult result;
+
+	g_hash_table_iter_init(&iter, chat->notify_list);
+	result.lines =3D 0;
+	result.final_or_pdu =3D 0;
+
+	chat->in_notify =3D TRUE;
+
+	while (g_hash_table_iter_next(&iter, &key, &value)) {
+		notify =3D value;
+
+		if (!g_str_has_prefix(line, key))
+			continue;
+
+		if (notify->pdu) {
+			chat->pdu_notify =3D line;
+			return TRUE;
+		}
+
+		if (result.lines =3D=3D NULL)
+			result.lines =3D g_slist_prepend(NULL, line);
+
+		g_slist_foreach(notify->nodes, at_notify_call_callback,
+					&result);
+		ret =3D TRUE;
+	}
+
+	chat->in_notify =3D FALSE;
+
+	if (ret) {
+		g_slist_free(result.lines);
+		g_free(line);
+
+		mot_chat_unregister_all(chat, FALSE, node_is_destroyed, NULL);
+	}
+
+	return ret;
+}
+
+static void mot_chat_finish_command(struct mot_chat *p, gboolean ok, char =
*final)
+{
+	struct at_command *cmd =3D g_queue_pop_head(p->command_queue);
+
+	printf("Finish command, final: %s\n", final);
+	/* Cannot happen, but lets be paranoid */
+	if (cmd =3D=3D NULL)
+		return;
+
+	p->cmd_bytes_written =3D 0;
+
+	if (g_queue_peek_head(p->command_queue))
+		chat_wakeup_writer(p);
+
+	if (cmd->callback) {
+		GAtResult result;
+
+		result.final_or_pdu =3D final;
+		result.lines =3D NULL;
+
+		cmd->callback(ok, &result, cmd->user_data);
+	}
+
+	g_free(final);
+	at_command_destroy(cmd);
+}
+
+static gboolean mot_chat_handle_command_response(struct mot_chat *p,
+							struct at_command *cmd,
+							char *line)
+{
+	printf("command response: %s\n", line);
+
+	if (!strncmp(line, "U0000", 5) && (line[5] !=3D '~')) {
+	  mot_chat_finish_command(p, TRUE, line);
+	  return TRUE;
+	}
+	=

+	if (cmd->prefixes) {
+		int n;
+
+		for (n =3D 0; cmd->prefixes[n]; n++) {
+		  printf("Command prefixes: %s / %s\n", line, cmd->prefixes[n]);
+
+			if (g_str_has_prefix(line, cmd->prefixes[n]))
+				goto out;
+		}
+
+		printf("Prefix not found\n");
+		return FALSE;
+	}
+
+out:
+	printf("Going out... pdu/multiline?!\n");
+
+	/* FIXME: cmd->listing support can be removed? */
+
+	return TRUE;
+}
+
+static void have_line(struct mot_chat *p, char *str)
+{
+	/* We're not going to copy terminal <CR><LF> */
+	struct at_command *cmd;
+
+	if (str =3D=3D NULL)
+		return;
+
+	printf("Have line: %s\n", str);
+
+	if (str[0] =3D=3D 'U' && isdigit(str[1]) && isdigit(str[2]) && isdigit(st=
r[3]) && isdigit(str[4])) {
+	  str[1] =3D '0';
+	  str[2] =3D '0';
+	  str[3] =3D '0';
+	  str[4] =3D '0';
+	}
+	=

+	/* Check for echo, this should not happen, but lets be paranoid */
+	if (!strncmp(str, "AT", 2))
+		goto done;
+
+	cmd =3D g_queue_peek_head(p->command_queue);
+
+	if (cmd && p->cmd_bytes_written > 0) {
+		char c =3D cmd->cmd[p->cmd_bytes_written - 1];
+
+		printf("Last character is %d\n", c);
+
+		/* We check that we have submitted a terminator, in which case
+		 * a command might have failed or completed successfully
+		 *
+		 * In the generic case, \r is at the end of the command, so we
+		 * know the entire command has been submitted.  In the case of
+		 * commands like CMGS, every \r or Ctrl-Z might result in a
+		 * final response from the modem, so we check this as well.
+		 */
+		if ((c =3D=3D '\n' || c =3D=3D 26 || c =3D=3D 13) &&
+		    mot_chat_handle_command_response(p, cmd, str)) {
+		  printf("handle command response\n");
+			return;
+		}
+	}
+
+	if (mot_chat_match_notify(p, str) =3D=3D TRUE) {
+	  printf("match notify said true\n");
+		return;
+	}
+
+done:
+	printf("ignoring line\n");
+	/* No matches & no commands active, ignore line */
+	g_free(str);
+}
+
+static char *extract_line(struct mot_chat *p, struct ring_buffer *rbuf)
+{
+	unsigned int wrap =3D ring_buffer_len_no_wrap(rbuf);
+	unsigned int pos =3D 0;
+	unsigned char *buf =3D ring_buffer_read_ptr(rbuf, pos);
+	gboolean in_string =3D FALSE;
+	int strip_front =3D 0;
+	int line_length =3D 0;
+	char *line;
+
+	while (pos < p->read_so_far) {
+	  /* FIXME: is the in_string handling neccessary? */
+		if (in_string =3D=3D FALSE && *buf =3D=3D '\n') {
+			if (!line_length)
+				strip_front +=3D 1;
+			else
+				break;
+		} else {
+			if (*buf =3D=3D '"')
+				in_string =3D !in_string;
+
+			line_length +=3D 1;
+		}
+
+		buf +=3D 1;
+		pos +=3D 1;
+
+		if (pos =3D=3D wrap)
+			buf =3D ring_buffer_read_ptr(rbuf, pos);
+	}
+
+	line =3D g_try_new(char, line_length + 1);
+	if (line =3D=3D NULL) {
+		ring_buffer_drain(rbuf, p->read_so_far);
+		return NULL;
+	}
+
+	ring_buffer_drain(rbuf, strip_front);
+	ring_buffer_read(rbuf, line, line_length);
+	ring_buffer_drain(rbuf, p->read_so_far - strip_front - line_length);
+
+	line[line_length] =3D '\0';
+
+	return line;
+}
+
+static void new_bytes(struct ring_buffer *rbuf, gpointer user_data)
+{
+	struct mot_chat *p =3D user_data;
+	unsigned int len =3D ring_buffer_len(rbuf);
+	unsigned int wrap =3D ring_buffer_len_no_wrap(rbuf);
+	unsigned char *buf =3D ring_buffer_read_ptr(rbuf, p->read_so_far);
+
+	p->in_read_handler =3D TRUE;
+
+	while (p->suspended =3D=3D FALSE && (p->read_so_far < len)) {
+		gsize rbytes =3D MIN(len - p->read_so_far, wrap - p->read_so_far);
+		printf("new bytes %d\n", rbytes);
+
+		buf +=3D rbytes;
+		p->read_so_far +=3D rbytes;
+
+		if (p->read_so_far =3D=3D wrap) {
+			buf =3D ring_buffer_read_ptr(rbuf, p->read_so_far);
+			wrap =3D len;
+		}
+
+		have_line(p, extract_line(p, rbuf));
+
+		len -=3D p->read_so_far;
+		wrap -=3D p->read_so_far;
+		p->read_so_far =3D 0;
+	}
+
+	p->in_read_handler =3D FALSE;
+
+	if (p->destroyed)
+		g_free(p);
+}
+
+
+static gboolean can_write_data(gpointer data)
+{
+	struct mot_chat *chat =3D data;
+	struct at_command *cmd;
+	gsize bytes_written;
+	gsize towrite;
+	gsize len;
+	char *cr;
+#ifdef WRITE_SCHEDULER_DEBUG
+	int limiter;
+#endif
+
+	/* Grab the first command off the queue and write as
+	 * much of it as we can
+	 */
+	cmd =3D g_queue_peek_head(chat->command_queue);
+
+	/* For some reason command queue is empty, cancel write watcher */
+	if (cmd =3D=3D NULL)
+		return FALSE;
+
+	len =3D strlen(cmd->cmd);
+
+	/* For some reason write watcher fired, but we've already
+	 * written the entire command out to the io channel,
+	 * cancel write watcher
+	 */
+	if (chat->cmd_bytes_written >=3D len)
+		return FALSE;
+
+	towrite =3D len - chat->cmd_bytes_written;
+
+	cr =3D strchr(cmd->cmd + chat->cmd_bytes_written, '\r');
+
+	if (cr) {
+	  //printf("FIXME: hack, not limiting to first r\n");
+	  towrite =3D cr - (cmd->cmd + chat->cmd_bytes_written) + 1;
+	}
+
+#ifdef WRITE_SCHEDULER_DEBUG
+	limiter =3D towrite;
+
+	if (limiter > 1)
+		limiter =3D 1;
+#endif
+
+	bytes_written =3D g_at_io_write(chat->io,
+					cmd->cmd + chat->cmd_bytes_written,
+#ifdef WRITE_SCHEDULER_DEBUG
+					limiter
+#else
+					towrite
+#endif
+					);
+
+	if (bytes_written =3D=3D 0)
+		return FALSE;
+
+	chat->cmd_bytes_written +=3D bytes_written;
+
+	if (bytes_written < towrite)
+		return TRUE;
+
+	return FALSE;
+}
+
+static void chat_wakeup_writer(struct mot_chat *chat)
+{
+	g_at_io_set_write_handler(chat->io, can_write_data, chat);
+}
+
+static void mot_chat_suspend(struct mot_chat *chat)
+{
+	chat->suspended =3D TRUE;
+
+	g_at_io_set_write_handler(chat->io, NULL, NULL);
+	g_at_io_set_read_handler(chat->io, NULL, NULL);
+	g_at_io_set_debug(chat->io, NULL, NULL);
+}
+
+static void mot_chat_resume(struct mot_chat *chat)
+{
+	chat->suspended =3D FALSE;
+
+	if (g_at_io_get_channel(chat->io) =3D=3D NULL) {
+		io_disconnect(chat);
+		return;
+	}
+
+	g_at_io_set_disconnect_function(chat->io, io_disconnect, chat);
+
+	g_at_io_set_debug(chat->io, chat->debugf, chat->debug_data);
+	g_at_io_set_read_handler(chat->io, new_bytes, chat);
+
+	if (g_queue_get_length(chat->command_queue) > 0)
+		chat_wakeup_writer(chat);
+}
+
+static void mot_chat_unref(struct mot_chat *chat)
+{
+	gboolean is_zero;
+
+	is_zero =3D g_atomic_int_dec_and_test(&chat->ref_count);
+
+	if (is_zero =3D=3D FALSE)
+		return;
+
+	if (chat->io) {
+		mot_chat_suspend(chat);
+		g_at_io_unref(chat->io);
+		chat->io =3D NULL;
+		chat_cleanup(chat);
+	}
+
+	if (chat->in_read_handler)
+		chat->destroyed =3D TRUE;
+	else
+		g_free(chat);
+}
+
+static gboolean mot_chat_set_disconnect_function(struct mot_chat *chat,
+						GAtDisconnectFunc disconnect,
+						gpointer user_data)
+{
+	chat->user_disconnect =3D disconnect;
+	chat->user_disconnect_data =3D user_data;
+
+	return TRUE;
+}
+
+static gboolean mot_chat_set_debug(struct mot_chat *chat,
+					GAtDebugFunc func, gpointer user_data)
+{
+
+	chat->debugf =3D func;
+	chat->debug_data =3D user_data;
+
+	if (chat->io)
+		g_at_io_set_debug(chat->io, func, user_data);
+
+	return TRUE;
+}
+
+static guint mot_chat_send_common(struct mot_chat *chat, guint gid,
+					const char *cmd,
+					const char **prefix_list,
+					guint flags,
+					GAtNotifyFunc listing,
+					GAtResultFunc func,
+					gpointer user_data,
+					GDestroyNotify notify)
+{
+	struct at_command *c;
+
+	if (chat =3D=3D NULL || chat->command_queue =3D=3D NULL)
+		return 0;
+
+	c =3D at_command_create(gid, cmd, prefix_list, flags, listing, func,
+				user_data, notify, FALSE);
+	if (c =3D=3D NULL)
+		return 0;
+
+	c->id =3D chat->next_cmd_id++;
+
+	g_queue_push_tail(chat->command_queue, c);
+
+	if (g_queue_get_length(chat->command_queue) =3D=3D 1)
+		chat_wakeup_writer(chat);
+
+	return c->id;
+}
+
+static struct at_notify *at_notify_create(struct mot_chat *chat,
+						const char *prefix,
+						gboolean pdu)
+{
+	struct at_notify *notify;
+	char *key;
+
+	key =3D g_strdup(prefix);
+	if (key =3D=3D NULL)
+		return 0;
+
+	notify =3D g_try_new0(struct at_notify, 1);
+	if (notify =3D=3D NULL) {
+		g_free(key);
+		return 0;
+	}
+
+	notify->pdu =3D pdu;
+
+	g_hash_table_insert(chat->notify_list, key, notify);
+
+	return notify;
+}
+
+static gboolean mot_chat_cancel(struct mot_chat *chat, guint group, guint =
id)
+{
+	GList *l;
+	struct at_command *c;
+
+	if (chat->command_queue =3D=3D NULL)
+		return FALSE;
+
+	l =3D g_queue_find_custom(chat->command_queue, GUINT_TO_POINTER(id),
+				at_command_compare_by_id);
+
+	if (l =3D=3D NULL)
+		return FALSE;
+
+	c =3D l->data;
+
+	if (c->gid !=3D group)
+		return FALSE;
+
+	if (c =3D=3D g_queue_peek_head(chat->command_queue) &&
+			chat->cmd_bytes_written > 0) {
+		/* We can't actually remove it since it is most likely
+		 * already in progress, just null out the callback
+		 * so it won't be called
+		 */
+		c->callback =3D NULL;
+	} else {
+		at_command_destroy(c);
+		g_queue_remove(chat->command_queue, c);
+	}
+
+	return TRUE;
+}
+
+static gboolean mot_chat_cancel_group(struct mot_chat *chat, guint group)
+{
+	int n =3D 0;
+	struct at_command *c;
+
+	if (chat->command_queue =3D=3D NULL)
+		return FALSE;
+
+	while ((c =3D g_queue_peek_nth(chat->command_queue, n)) !=3D NULL) {
+		if (c->id =3D=3D 0 || c->gid !=3D group) {
+			n +=3D 1;
+			continue;
+		}
+
+		if (n =3D=3D 0 && chat->cmd_bytes_written > 0) {
+			c->callback =3D NULL;
+			n +=3D 1;
+			continue;
+		}
+
+		at_command_destroy(c);
+		g_queue_remove(chat->command_queue, c);
+	}
+
+	return TRUE;
+}
+
+static gpointer mot_chat_get_userdata(struct mot_chat *chat,
+						guint group, guint id)
+{
+	GList *l;
+	struct at_command *c;
+
+	if (chat->command_queue =3D=3D NULL)
+		return NULL;
+
+	l =3D g_queue_find_custom(chat->command_queue, GUINT_TO_POINTER(id),
+				at_command_compare_by_id);
+
+	if (l =3D=3D NULL)
+		return NULL;
+
+	c =3D l->data;
+
+	if (c->gid !=3D group)
+		return NULL;
+
+	return c->user_data;
+}
+
+static guint mot_chat_register(struct mot_chat *chat, guint group,
+				const char *prefix, GAtNotifyFunc func,
+				gboolean expect_pdu, gpointer user_data,
+				GDestroyNotify destroy_notify)
+{
+	struct at_notify *notify;
+	struct at_notify_node *node;
+
+	if (chat->notify_list =3D=3D NULL)
+		return 0;
+
+	if (func =3D=3D NULL)
+		return 0;
+
+	if (prefix =3D=3D NULL)
+		return 0;
+
+	notify =3D g_hash_table_lookup(chat->notify_list, prefix);
+
+	if (notify =3D=3D NULL)
+		notify =3D at_notify_create(chat, prefix, expect_pdu);
+
+	if (notify =3D=3D NULL || notify->pdu !=3D expect_pdu)
+		return 0;
+
+	node =3D g_try_new0(struct at_notify_node, 1);
+	if (node =3D=3D NULL)
+		return 0;
+
+	node->id =3D chat->next_notify_id++;
+	node->gid =3D group;
+	node->callback =3D func;
+	node->user_data =3D user_data;
+	node->notify =3D destroy_notify;
+
+	notify->nodes =3D g_slist_prepend(notify->nodes, node);
+
+	return node->id;
+}
+
+static gboolean mot_chat_unregister(struct mot_chat *chat, gboolean mark_o=
nly,
+					guint group, guint id)
+{
+	GHashTableIter iter;
+	struct at_notify *notify;
+	struct at_notify_node *node;
+	gpointer key, value;
+	GSList *l;
+
+	if (chat->notify_list =3D=3D NULL)
+		return FALSE;
+
+	g_hash_table_iter_init(&iter, chat->notify_list);
+
+	while (g_hash_table_iter_next(&iter, &key, &value)) {
+		notify =3D value;
+
+		l =3D g_slist_find_custom(notify->nodes, GUINT_TO_POINTER(id),
+					at_notify_node_compare_by_id);
+
+		if (l =3D=3D NULL)
+			continue;
+
+		node =3D l->data;
+
+		if (node->gid !=3D group)
+			return FALSE;
+
+		if (mark_only) {
+			node->destroyed =3D TRUE;
+			return TRUE;
+		}
+
+		at_notify_node_destroy(node, NULL);
+		notify->nodes =3D g_slist_remove(notify->nodes, node);
+
+		if (notify->nodes =3D=3D NULL)
+			g_hash_table_iter_remove(&iter);
+
+		return TRUE;
+	}
+
+	return FALSE;
+}
+
+static gboolean node_compare_by_group(struct at_notify_node *node,
+					gpointer userdata)
+{
+	guint group =3D GPOINTER_TO_UINT(userdata);
+
+	if (node->gid =3D=3D group)
+		return TRUE;
+
+	return FALSE;
+}
+
+static struct mot_chat *create_chat(GIOChannel *channel, GIOFlags flags)
+{
+	struct mot_chat *chat;
+
+	if (channel =3D=3D NULL)
+		return NULL;
+
+	chat =3D g_try_new0(struct mot_chat, 1);
+	if (chat =3D=3D NULL)
+		return chat;
+
+	chat->ref_count =3D 1;
+	chat->next_cmd_id =3D 1;
+	chat->next_notify_id =3D 1;
+	chat->debugf =3D NULL;
+
+	if (flags & G_IO_FLAG_NONBLOCK)
+		chat->io =3D g_at_io_new(channel);
+	else
+		chat->io =3D g_at_io_new_blocking(channel);
+
+	if (chat->io =3D=3D NULL)
+		goto error;
+
+	g_at_io_set_disconnect_function(chat->io, io_disconnect, chat);
+
+	chat->command_queue =3D g_queue_new();
+	if (chat->command_queue =3D=3D NULL)
+		goto error;
+
+	chat->notify_list =3D g_hash_table_new_full(g_str_hash, g_str_equal,
+						g_free, at_notify_destroy);
+
+	g_at_io_set_read_handler(chat->io, new_bytes, chat);
+
+	return chat;
+
+error:
+	g_at_io_unref(chat->io);
+
+	if (chat->command_queue)
+		g_queue_free(chat->command_queue);
+
+	if (chat->notify_list)
+		g_hash_table_destroy(chat->notify_list);
+
+	g_free(chat);
+	return NULL;
+}
+
+static GMotChat *g_mot_chat_new_common(GIOChannel *channel, GIOFlags flags)
+{
+	GMotChat *chat;
+
+	chat =3D g_try_new0(GMotChat, 1);
+	if (chat =3D=3D NULL)
+		return NULL;
+
+	chat->parent =3D create_chat(channel, flags);
+	if (chat->parent =3D=3D NULL) {
+		g_free(chat);
+		return NULL;
+	}
+
+	chat->group =3D chat->parent->next_gid++;
+	chat->ref_count =3D 1;
+
+	return chat;
+}
+
+GMotChat *g_mot_chat_new(GIOChannel *channel)
+{
+	return g_mot_chat_new_common(channel, G_IO_FLAG_NONBLOCK);
+}
+
+GMotChat *g_mot_chat_new_blocking(GIOChannel *channel)
+{
+	return g_mot_chat_new_common(channel, 0);
+}
+
+GMotChat *g_mot_chat_clone(GMotChat *clone)
+{
+	GMotChat *chat;
+
+	if (clone =3D=3D NULL)
+		return NULL;
+
+	chat =3D g_try_new0(GMotChat, 1);
+	if (chat =3D=3D NULL)
+		return NULL;
+
+	chat->parent =3D clone->parent;
+	chat->group =3D chat->parent->next_gid++;
+	chat->ref_count =3D 1;
+	g_atomic_int_inc(&chat->parent->ref_count);
+
+	if (clone->slave !=3D NULL)
+		chat->slave =3D g_mot_chat_clone(clone->slave);
+
+	return chat;
+}
+
+GMotChat *g_mot_chat_set_slave(GMotChat *chat, GMotChat *slave)
+{
+	if (chat =3D=3D NULL)
+		return NULL;
+
+	if (chat->slave !=3D NULL)
+		g_mot_chat_unref(chat->slave);
+
+	if (slave !=3D NULL)
+		chat->slave =3D g_mot_chat_ref(slave);
+	else
+		chat->slave =3D NULL;
+
+	return chat->slave;
+}
+
+GMotChat *g_mot_chat_get_slave(GMotChat *chat)
+{
+	if (chat =3D=3D NULL)
+		return NULL;
+
+	return chat->slave;
+}
+
+GIOChannel *g_mot_chat_get_channel(GMotChat *chat)
+{
+	if (chat =3D=3D NULL || chat->parent->io =3D=3D NULL)
+		return NULL;
+
+	return g_at_io_get_channel(chat->parent->io);
+}
+
+GAtIO *g_mot_chat_get_io(GMotChat *chat)
+{
+	if (chat =3D=3D NULL)
+		return NULL;
+
+	return chat->parent->io;
+}
+
+GMotChat *g_mot_chat_ref(GMotChat *chat)
+{
+	if (chat =3D=3D NULL)
+		return NULL;
+
+	g_atomic_int_inc(&chat->ref_count);
+
+	return chat;
+}
+
+void g_mot_chat_suspend(GMotChat *chat)
+{
+	if (chat =3D=3D NULL)
+		return;
+
+	mot_chat_suspend(chat->parent);
+}
+
+void g_mot_chat_resume(GMotChat *chat)
+{
+	if (chat =3D=3D NULL)
+		return;
+
+	mot_chat_resume(chat->parent);
+}
+
+void g_mot_chat_unref(GMotChat *chat)
+{
+	gboolean is_zero;
+
+	if (chat =3D=3D NULL)
+		return;
+
+	is_zero =3D g_atomic_int_dec_and_test(&chat->ref_count);
+
+	if (is_zero =3D=3D FALSE)
+		return;
+
+	if (chat->slave !=3D NULL)
+		g_mot_chat_unref(chat->slave);
+
+	mot_chat_cancel_group(chat->parent, chat->group);
+	g_mot_chat_unregister_all(chat);
+	mot_chat_unref(chat->parent);
+
+	g_free(chat);
+}
+
+gboolean g_mot_chat_set_disconnect_function(GMotChat *chat,
+			GAtDisconnectFunc disconnect, gpointer user_data)
+{
+	if (chat =3D=3D NULL || chat->group !=3D 0)
+		return FALSE;
+
+	return mot_chat_set_disconnect_function(chat->parent, disconnect,
+						user_data);
+}
+
+gboolean g_mot_chat_set_debug(GMotChat *chat,
+				GAtDebugFunc func, gpointer user_data)
+{
+
+	if (chat =3D=3D NULL || chat->group !=3D 0)
+		return FALSE;
+
+	return mot_chat_set_debug(chat->parent, func, user_data);
+}
+
+guint g_mot_chat_send(GMotChat *chat, const char *cmd,
+			const char **prefix_list, GAtResultFunc func,
+			gpointer user_data, GDestroyNotify notify)
+{
+	return mot_chat_send_common(chat->parent, chat->group,
+					cmd, prefix_list, 0, NULL,
+					func, user_data, notify);
+}
+
+gboolean g_mot_chat_cancel(GMotChat *chat, guint id)
+{
+	/* We use id 0 for wakeup commands */
+	if (chat =3D=3D NULL || id =3D=3D 0)
+		return FALSE;
+
+	return mot_chat_cancel(chat->parent, chat->group, id);
+}
+
+gboolean g_mot_chat_cancel_all(GMotChat *chat)
+{
+	if (chat =3D=3D NULL)
+		return FALSE;
+
+	return mot_chat_cancel_group(chat->parent, chat->group);
+}
+
+gpointer g_mot_chat_get_userdata(GMotChat *chat, guint id)
+{
+	if (chat =3D=3D NULL)
+		return NULL;
+
+	return mot_chat_get_userdata(chat->parent, chat->group, id);
+}
+
+guint g_mot_chat_register(GMotChat *chat, const char *prefix,
+				GAtNotifyFunc func, gboolean expect_pdu,
+				gpointer user_data,
+				GDestroyNotify destroy_notify)
+{
+	if (chat =3D=3D NULL)
+		return 0;
+
+	return mot_chat_register(chat->parent, chat->group, prefix,
+				func, expect_pdu, user_data, destroy_notify);
+}
+
+gboolean g_mot_chat_unregister(GMotChat *chat, guint id)
+{
+	if (chat =3D=3D NULL)
+		return FALSE;
+
+	return mot_chat_unregister(chat->parent, chat->parent->in_notify,
+					chat->group, id);
+}
+
+gboolean g_mot_chat_unregister_all(GMotChat *chat)
+{
+	if (chat =3D=3D NULL)
+		return FALSE;
+
+	return mot_chat_unregister_all(chat->parent,
+					chat->parent->in_notify,
+					node_compare_by_group,
+					GUINT_TO_POINTER(chat->group));
+}
diff --git a/gatchat/motchat.h b/gatchat/motchat.h
new file mode 100644
index 00000000..f778d0d4
--- /dev/null
+++ b/gatchat/motchat.h
@@ -0,0 +1,209 @@
+/*
+ *
+ *  AT chat library with GLib integration
+ *
+ *  Copyright (C) 2008-2011  Intel Corporation. All rights reserved.
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
+#ifndef __GMOTCHAT_H
+#define __GMOTCHAT_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#include "gatresult.h"
+#include "gatutil.h"
+#include "gatio.h"
+
+struct _GMotChat;
+
+typedef struct _GMotChat GMotChat;
+
+typedef void (*GAtResultFunc)(gboolean success, GAtResult *result,
+				gpointer user_data);
+typedef void (*GAtNotifyFunc)(GAtResult *result, gpointer user_data);
+
+enum _GMotChatTerminator {
+	G_MOT_CHAT_TERMINATOR_OK,
+	G_MOT_CHAT_TERMINATOR_ERROR,
+	G_MOT_CHAT_TERMINATOR_NO_DIALTONE,
+	G_MOT_CHAT_TERMINATOR_BUSY,
+	G_MOT_CHAT_TERMINATOR_NO_CARRIER,
+	G_MOT_CHAT_TERMINATOR_CONNECT,
+	G_MOT_CHAT_TERMINATOR_NO_ANSWER,
+	G_MOT_CHAT_TERMINATOR_CMS_ERROR,
+	G_MOT_CHAT_TERMINATOR_CME_ERROR,
+	G_MOT_CHAT_TERMINATOR_EXT_ERROR,
+};
+
+typedef enum _GMotChatTerminator GMotChatTerminator;
+
+GMotChat *g_mot_chat_new(GIOChannel *channel);
+GMotChat *g_mot_chat_new_blocking(GIOChannel *channel);
+
+GIOChannel *g_mot_chat_get_channel(GMotChat *chat);
+GAtIO *g_mot_chat_get_io(GMotChat *chat);
+
+GMotChat *g_mot_chat_ref(GMotChat *chat);
+void g_mot_chat_unref(GMotChat *chat);
+
+GMotChat *g_mot_chat_clone(GMotChat *chat);
+
+GMotChat *g_mot_chat_set_slave(GMotChat *chat, GMotChat *slave);
+GMotChat *g_mot_chat_get_slave(GMotChat *chat);
+
+void g_mot_chat_suspend(GMotChat *chat);
+void g_mot_chat_resume(GMotChat *chat);
+
+gboolean g_mot_chat_set_disconnect_function(GMotChat *chat,
+			GAtDisconnectFunc disconnect, gpointer user_data);
+
+/*!
+ * If the function is not NULL, then on every read/write from the GIOChann=
el
+ * provided to GMotChat the logging function will be called with the
+ * input/output string and user data
+ */
+gboolean g_mot_chat_set_debug(GMotChat *chat,
+				GAtDebugFunc func, gpointer user_data);
+
+/*!
+ * Queue an AT command for execution.  The command contents are given
+ * in cmd.  Once the command executes, the callback function given by
+ * func is called with user provided data in user_data.
+ *
+ * Returns an id of the queued command which can be canceled using
+ * g_mot_chat_cancel.  If an error occurred, an id of 0 is returned.
+ *
+ * This function can be used in three ways:
+ * 	- Send a simple command such as g_mot_chat_send(p, "AT+CGMI?", ...
+ *
+ * 	- Send a compound command: g_mot_chat_send(p, "AT+CMD1;+CMD2", ...
+ *
+ * 	- Send a command requiring a prompt.  The command up to '\r' is sent
+ * 	  after which time a '> ' prompt is expected from the modem.  Further
+ * 	  contents of the command are sent until a '\r' or end of string is
+ * 	  encountered.  If end of string is encountered, the Ctrl-Z character
+ * 	  is sent automatically.  There is no need to include the Ctrl-Z
+ * 	  by the caller.
+ *
+ * The valid_resp field can be used to send an array of strings which will
+ * be accepted as a valid response for this command.  This is treated as a
+ * simple prefix match.  If a response line comes in from the modem and it
+ * does not match any of the prefixes in valid_resp, it is treated as an
+ * unsolicited notification.  If valid_resp is NULL, then all response
+ * lines after command submission and final response line are treated as
+ * part of the command response.  This can be used to get around broken
+ * modems which send unsolicited notifications during command processing.
+ */
+guint g_mot_chat_send(GMotChat *chat, const char *cmd,
+				const char **valid_resp, GAtResultFunc func,
+				gpointer user_data, GDestroyNotify notify);
+
+/*!
+ * Same as the above command, except that the caller wishes to receive the
+ * intermediate responses immediately through the GAtNotifyFunc callback.
+ * The final response will still be sent to GAtResultFunc callback.  The
+ * final GAtResult will not contain any lines from the intermediate respon=
ses.
+ * This is useful for listing commands such as CPBR.
+ */
+guint g_mot_chat_send_listing(GMotChat *chat, const char *cmd,
+				const char **valid_resp,
+				GAtNotifyFunc listing, GAtResultFunc func,
+				gpointer user_data, GDestroyNotify notify);
+
+/*!
+ * Same as g_mot_chat_send_listing except every response line in valid_resp
+ * is expected to be followed by a PDU.  The listing function will be call=
ed
+ * with the intermediate response and the following PDU line.
+ *
+ * This is useful for PDU listing commands like the +CMGL
+ */
+guint g_mot_chat_send_pdu_listing(GMotChat *chat, const char *cmd,
+				const char **valid_resp,
+				GAtNotifyFunc listing, GAtResultFunc func,
+				gpointer user_data, GDestroyNotify notify);
+
+/*!
+ * Same as g_mot_chat_send except parser will know to expect short prompt =
syntax
+ * used with +CPOS.
+ */
+guint g_mot_chat_send_and_expect_short_prompt(GMotChat *chat, const char *=
cmd,
+				const char **valid_resp, GAtResultFunc func,
+				gpointer user_data, GDestroyNotify notify);
+
+gboolean g_mot_chat_cancel(GMotChat *chat, guint id);
+gboolean g_mot_chat_cancel_all(GMotChat *chat);
+
+gpointer g_mot_chat_get_userdata(GMotChat *chat, guint id);
+
+guint g_mot_chat_register(GMotChat *chat, const char *prefix,
+				GAtNotifyFunc func, gboolean expect_pdu,
+				gpointer user_data, GDestroyNotify notify);
+
+gboolean g_mot_chat_unregister(GMotChat *chat, guint id);
+gboolean g_mot_chat_unregister_all(GMotChat *chat);
+
+gboolean g_mot_chat_set_wakeup_command(GMotChat *chat, const char *cmd,
+					guint timeout, guint msec);
+
+void g_mot_chat_add_terminator(GMotChat *chat, char *terminator,
+				int len, gboolean success);
+void g_mot_chat_blacklist_terminator(GMotChat *chat,
+						GMotChatTerminator terminator);
+
+struct _GMotChat {
+	gint ref_count;
+	struct mot_chat *parent;
+	guint group;
+	GMotChat *slave;
+};
+
+struct mot_chat {
+	gint ref_count;				/* Ref count */
+	guint next_cmd_id;			/* Next command id */
+	guint next_notify_id;			/* Next notify id */
+	guint next_gid;				/* Next group id */
+	GAtIO *io;				/* AT IO */
+	GQueue *command_queue;			/* Command queue */
+	guint cmd_bytes_written;		/* bytes written from cmd */
+	GHashTable *notify_list;		/* List of notification reg */
+	GAtDisconnectFunc user_disconnect;	/* user disconnect func */
+	gpointer user_disconnect_data;		/* user disconnect data */
+	guint read_so_far;			/* Number of bytes processed */
+	gboolean suspended;			/* Are we suspended? */
+	GAtDebugFunc debugf;			/* debugging output function */
+	gpointer debug_data;			/* Data to pass to debug func */
+	char *pdu_notify;			/* Unsolicited Resp w/ PDU */
+	GSList *response_lines;			/* char * lines of the response */
+	char *wakeup;				/* command sent to wakeup modem */
+	gint timeout_source;
+	gdouble inactivity_time;		/* Period of inactivity */
+	guint wakeup_timeout;			/* How long to wait for resp */
+	GTimer *wakeup_timer;			/* Keep track of elapsed time */
+	gboolean destroyed;			/* Re-entrancy guard */
+	gboolean in_read_handler;		/* Re-entrancy guard */
+	gboolean in_notify;
+	GSList *terminator_list;		/* Non-standard terminator */
+	guint16 terminator_blacklist;		/* Blacklisted terinators */
+};
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __GATCHAT_H */



--===============1216258323011171702==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjEKCmlFWUVBUkVD
QUFZRkFsN2UwTzBBQ2drUU1PZndhcFhiK3ZJWmVBQ2ZTY0lOdHc4dTd1UHBmTmhKaWNtN1NnejMK
aTVrQW9LVmpBS3FvSk5kZzRsNlFmVzZxMDcvTFM3YzMKPVllMXkKLS0tLS1FTkQgUEdQIFNJR05B
VFVSRS0tLS0tCg==

--===============1216258323011171702==--

