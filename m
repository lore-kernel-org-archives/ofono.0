Content-Type: multipart/mixed; boundary="===============7090152173072986243=="
MIME-Version: 1.0
From: Ronald Tessier <ronald.tessier@linux.intel.com>
Subject: [PATCHv2 3/4] service: Sort conversation list by message date
Date: Thu, 03 May 2012 15:20:02 +0200
Message-ID: <1336051203-15512-4-git-send-email-ronald.tessier@linux.intel.com>
In-Reply-To: <1336051203-15512-1-git-send-email-ronald.tessier@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7090152173072986243==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/service.c |   28 +++++++++++++++++++++++++++-
 1 files changed, 27 insertions(+), 1 deletions(-)

diff --git a/src/service.c b/src/service.c
index 93beceb..6bcdede 100644
--- a/src/service.c
+++ b/src/service.c
@@ -698,6 +698,31 @@ static DBusMessage *get_messages(DBusConnection *conn,
 	return reply;
 }

+static gint fill_conversation_sort(gconstpointer a, gconstpointer b)
+{
+	const struct mms_message *msg1 =3D a;
+	const struct mms_message *msg2 =3D b;
+	time_t date1, date2;
+
+	if (msg1->type =3D=3D MMS_MESSAGE_TYPE_SEND_REQ)
+		date1 =3D msg1->sr.date;
+	else
+		date1 =3D msg1->rc.date;
+
+	if (msg2->type =3D=3D MMS_MESSAGE_TYPE_SEND_REQ)
+		date2 =3D msg2->sr.date;
+	else
+		date2 =3D msg2->rc.date;
+
+	if (date1 > date2)
+		return 1;
+
+	if (date1 < date2)
+		return -1;
+
+	return 0;
+}
+
 static gboolean is_recipient(const char *recipients, const char *number)
 {
 	const char *subrecpts, *subnum;
@@ -766,7 +791,8 @@ static GList *fill_conversation(const struct mms_servic=
e *service,
 			continue;

 		if (is_recipient(recipients, number) =3D=3D TRUE)
-			conversation =3D g_list_prepend(conversation, value);
+			conversation =3D g_list_insert_sorted(conversation, value,
+							fill_conversation_sort);
 	}

 	return conversation;
--
1.7.4.1


--===============7090152173072986243==--

