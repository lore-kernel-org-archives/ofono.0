Content-Type: multipart/mixed; boundary="===============0776301416082837012=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 6/7] Add notify at command callback
Date: Wed, 03 Mar 2010 22:56:51 +0800
Message-ID: <1267628212-14079-6-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1267628212-14079-5-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0776301416082837012==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Search command_list to get notification node.

If the command is an action command, the type may be "action" or
"support".

If the command is a parameter command, the type may be either
"support", "query" or "set".
---
 gatchat/gatserver.c |   53 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 53 insertions(+), 0 deletions(-)

diff --git a/gatchat/gatserver.c b/gatchat/gatserver.c
index 829dc1d..bea51f5 100644
--- a/gatchat/gatserver.c
+++ b/gatchat/gatserver.c
@@ -231,10 +231,63 @@ static gboolean is_extended_character(const char c)
 	}
 }
 =

+static GAtServerRequestType get_command_type(char *buf, struct at_command =
*node)
+{
+	GAtServerRequestType type =3D G_AT_SERVER_REQUEST_TYPE_NONE;
+	char *prefix =3D node->prefix;
+	GAtServerCommandType cmd_type =3D node->type;
+
+	buf +=3D strlen(prefix);
+
+	if (cmd_type =3D=3D G_AT_SERVER_COMMAND_TYPE_ACTION) {
+		if (buf[0] =3D=3D '=3D' && buf[1] =3D=3D '?')
+			type =3D G_AT_SERVER_REQUEST_TYPE_SUPPORT;
+		else if (buf[0] =3D=3D '?')
+			type =3D G_AT_SERVER_REQUEST_TYPE_NONE;
+		else
+			type =3D G_AT_SERVER_REQUEST_TYPE_ACTION;
+	} else {
+		if (buf[0] =3D=3D '=3D' && buf[1] =3D=3D '?')
+			type =3D G_AT_SERVER_REQUEST_TYPE_SUPPORT;
+		else if (buf[0] =3D=3D '?')
+			type =3D G_AT_SERVER_REQUEST_TYPE_QUERY;
+		else {
+			/* Two cases:
+			 * A valid basic command followed by digits.
+			 * 	If no digit follows, zero is assumed.
+			 * A valid extended command followed by '=3D'.
+			 */
+			if (is_basic_command_prefix(prefix))
+				type =3D G_AT_SERVER_REQUEST_TYPE_SET;
+			else if (is_extended_command_prefix(*prefix) &&
+					buf[0] =3D=3D '=3D')
+				type =3D G_AT_SERVER_REQUEST_TYPE_SET;
+		}
+	}
+
+	return type;
+}
+
 static GAtServerResult at_notify_callback(GAtServer *server, char *command,
 					char *prefix)
 {
 	int res =3D G_AT_SERVER_RESULT_ERROR;
+	struct at_command *node;
+
+	node =3D g_hash_table_lookup(server->command_list, prefix);
+	if (node && node->notify) {
+		GAtServerRequestType type;
+		GAtResult result;
+
+		type =3D get_command_type(command, node);
+		if (type =3D=3D G_AT_SERVER_REQUEST_TYPE_NONE)
+			return res;
+
+		result.lines =3D g_slist_prepend(NULL, command);
+		result.final_or_pdu =3D 0;
+
+		res =3D node->notify(type, &result, node->user_data);
+	}
 =

 	return res;
 }
-- =

1.6.6.1


--===============0776301416082837012==--

