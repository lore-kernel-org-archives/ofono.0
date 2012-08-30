Content-Type: multipart/mixed; boundary="===============3809529283762079132=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: [PATCH] sms: Fix to find SMS entry posted by STK
Date: Thu, 30 Aug 2012 18:24:07 +0200
Message-ID: <1346343847-27266-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3809529283762079132==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

SMS initiated by proactive command are not exposed on D-BUS.
Therefore, there is no message associated with the entry created from
STK.
---
 src/sms.c |   11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/src/sms.c b/src/sms.c
index acfc39b..743f725 100644
--- a/src/sms.c
+++ b/src/sms.c
@@ -2114,16 +2114,15 @@ int __ofono_sms_txq_set_submit_notify(struct ofono_=
sms *sms,
 					void *data,
 					ofono_destroy_func destroy)
 {
-	struct message *m;
+	GList *l;
 	struct tx_queue_entry *entry;
 =

-	m =3D g_hash_table_lookup(sms->messages, uuid);
-	if (m =3D=3D NULL)
+	l =3D g_queue_find_custom(sms->txq, uuid, entry_compare_by_uuid);
+
+	if (l =3D=3D NULL)
 		return -ENOENT;
 =

-	entry =3D message_get_data(m);
-	if (entry =3D=3D NULL)
-		return -ENOTSUP;
+	entry =3D l->data;
 =

 	tx_queue_entry_set_submit_notify(entry, cb, data, destroy);
 =

-- =

1.7.9.5


--===============3809529283762079132==--

