Content-Type: multipart/mixed; boundary="===============1117459470005980842=="
MIME-Version: 1.0
From: Petteri Tikander <petteri.tikander@ixonos.com>
Subject: [RFC PATCH v2 3/4] sms_util: remove unused parameter
Date: Fri, 10 Sep 2010 17:28:21 +0300
Message-ID: <1284128902-16727-3-git-send-email-petteri.tikander@ixonos.com>
In-Reply-To: <1284128902-16727-2-git-send-email-petteri.tikander@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1117459470005980842==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/smsutil.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/src/smsutil.c b/src/smsutil.c
index ae8f1ef..a124f54 100644
--- a/src/smsutil.c
+++ b/src/smsutil.c
@@ -2771,7 +2771,6 @@ static gboolean sr_assembly_add_fragment_backup(const=
 char *imsi,
 }
 =

 static gboolean sr_assembly_remove_fragment_backup(const char *imsi,
-					const struct id_table_node *node,
 					const struct sms_address *addr,
 					unsigned int msg_id)
 {
@@ -2901,7 +2900,7 @@ gboolean status_report_assembly_report(struct status_=
report_assembly *assembly,
 	if (out_id)
 		*out_id =3D msg_id;
 =

-	sr_assembly_remove_fragment_backup(assembly->imsi, node,
+	sr_assembly_remove_fragment_backup(assembly->imsi,
 					&status_report->status_report.raddr,
 					msg_id);
 =

@@ -2997,7 +2996,6 @@ void status_report_assembly_expire(struct status_repo=
rt_assembly *assembly,
 =

 				sr_assembly_remove_fragment_backup(
 								assembly->imsi,
-								node,
 								&addr,
 								msg_id);
 			}
-- =

1.6.3.3



--===============1117459470005980842==--

