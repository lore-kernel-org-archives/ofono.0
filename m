Content-Type: multipart/mixed; boundary="===============2304475458166189550=="
MIME-Version: 1.0
From: Yang Gu <yang.gu@intel.com>
Subject: [PATCH 1/7] stkutil: Move advance of ctlv to parse_dataobj
Date: Tue, 27 Apr 2010 17:47:06 +0800
Message-ID: <1272361632-21352-1-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2304475458166189550==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Not all the proactive commands have comprehension tlv other than command
details and device identities. So the appropriate code should be moved to
parse_dataobj() from stk_command_new_from_pdu().
---
 src/stkutil.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/src/stkutil.c b/src/stkutil.c
index b4279c1..3323550 100644
--- a/src/stkutil.c
+++ b/src/stkutil.c
@@ -2030,6 +2030,10 @@ static gboolean parse_dataobj(struct comprehension_t=
lv_iter *iter,
 		entries =3D g_slist_prepend(entries, entry);
 	}
 =

+
+	if (comprehension_tlv_iter_next(iter) !=3D TRUE)
+		goto out;
+
 	entries =3D g_slist_reverse(entries);
 =

 	for (l =3D entries; l; l =3D l->next) {
@@ -2048,6 +2052,7 @@ static gboolean parse_dataobj(struct comprehension_tl=
v_iter *iter,
 		}
 	}
 =

+out:
 	for (l =3D entries; l; l =3D l->next) {
 		struct dataobj_handler_entry *entry =3D l->data;
 =

@@ -2295,9 +2300,6 @@ struct stk_command *stk_command_new_from_pdu(const un=
signed char *pdu,
 	command->src =3D data[0];
 	command->dst =3D data[1];
 =

-	if (comprehension_tlv_iter_next(&iter) !=3D TRUE)
-		return FALSE;
-
 	switch (command->type) {
 	case STK_COMMAND_TYPE_DISPLAY_TEXT:
 		ok =3D parse_display_text(command, &iter);
-- =

1.7.0.4


--===============2304475458166189550==--

