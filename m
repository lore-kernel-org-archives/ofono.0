Content-Type: multipart/mixed; boundary="===============3181639541336122429=="
MIME-Version: 1.0
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
Subject: [PATCH 06/11] Add notify at command callback
Date: Wed, 17 Mar 2010 22:30:36 +0800
Message-ID: <1268836241-4834-6-git-send-email-zhenhua.zhang@intel.com>
In-Reply-To: <1268836241-4834-5-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3181639541336122429==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 gatchat/gatserver.c |   38 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/gatchat/gatserver.c b/gatchat/gatserver.c
index bbaef52..6e3347c 100644
--- a/gatchat/gatserver.c
+++ b/gatchat/gatserver.c
@@ -227,10 +227,48 @@ static gboolean is_extended_character(const char c)
 	}
 }
 =

+static GAtServerRequestType get_command_type(char *buf, char *prefix)
+{
+	GAtServerRequestType type =3D G_AT_SERVER_REQUEST_TYPE_ERROR;
+
+	buf +=3D strlen(prefix);
+
+	if (buf[0] =3D=3D '\0')
+		/* Action command could have no sub-parameters */
+		type =3D G_AT_SERVER_REQUEST_TYPE_COMMAND_ONLY;
+	else if (buf[0] =3D=3D '?')
+		type =3D G_AT_SERVER_REQUEST_TYPE_QUERY;
+	else if (buf[0] =3D=3D '=3D' && buf[1] =3D=3D '?')
+		type =3D G_AT_SERVER_REQUEST_TYPE_SUPPORT;
+	else if (buf[0] =3D=3D '=3D')
+		type =3D G_AT_SERVER_REQUEST_TYPE_SET;
+	else if (is_basic_command_prefix(prefix))
+		/* Basic command could follow digits value, like ATE1 */
+		type =3D G_AT_SERVER_REQUEST_TYPE_SET;
+
+	return type;
+}
+
 static GAtServerResult at_command_notify(GAtServer *server, char *command,
 						char *prefix)
 {
 	GAtServerResult res =3D G_AT_SERVER_RESULT_ERROR;
+	struct at_command *node;
+
+	node =3D g_hash_table_lookup(server->command_list, prefix);
+	if (node && node->notify) {
+		GAtServerRequestType type;
+		GAtResult result;
+
+		type =3D get_command_type(command, prefix);
+		if (type =3D=3D G_AT_SERVER_REQUEST_TYPE_ERROR)
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


--===============3181639541336122429==--

