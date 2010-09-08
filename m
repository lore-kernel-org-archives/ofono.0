Content-Type: multipart/mixed; boundary="===============0979109673052930594=="
MIME-Version: 1.0
From: Petteri Tikander <petteri.tikander@ixonos.com>
Subject: [RFC PATCH 2/2] sms_util: remove unused parameter
Date: Wed, 08 Sep 2010 13:31:27 +0300
Message-ID: <1283941887-20426-2-git-send-email-petteri.tikander@ixonos.com>
In-Reply-To: <1283941887-20426-1-git-send-email-petteri.tikander@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0979109673052930594==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/smsutil.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/src/smsutil.c b/src/smsutil.c
index 0e756c7..26c7951 100644
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



--===============0979109673052930594==--

