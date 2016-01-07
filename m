Content-Type: multipart/mixed; boundary="===============0662648457939948263=="
MIME-Version: 1.0
From: John Ernberg <john.ernberg@actia.se>
Subject: [PATCH v2] network: Fix use-after-free caused by Scan() in poor
 reception.
Date: Thu, 07 Jan 2016 10:46:21 +0000
Message-ID: <1452163577-23146-2-git-send-email-john.ernberg@actia.se>
In-Reply-To: <1452163577-23146-1-git-send-email-john.ernberg@actia.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0662648457939948263==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: John Ernberg <john.ernberg@actia.se>

When issuing a Scan() in poor reception while attached to an operator it's
fully possible to get no results, which causes the attached operator to be
cleaned up. In certain scenarios this would cause a use-after-free as there
are still references to this operator.
Transfer the attached operator to the new list regardless of removal caused
by the Scan() results.
---
 src/network.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/src/network.c b/src/network.c
index 1dddcac..8ad11d3 100644
--- a/src/network.c
+++ b/src/network.c
@@ -710,6 +710,7 @@ static gboolean update_operator_list(struct ofono_netre=
g *netreg, int total,
 	GSList *o;
 	GSList *compressed;
 	GSList *c;
+	struct network_operator_data *current_op =3D NULL;
 	gboolean changed =3D FALSE;
 =

 	compressed =3D compress_operator_list(list, total);
@@ -754,8 +755,19 @@ static gboolean update_operator_list(struct ofono_netr=
eg *netreg, int total,
 	if (netreg->operator_list)
 		changed =3D TRUE;
 =

-	for (o =3D netreg->operator_list; o; o =3D o->next)
-		network_operator_dbus_unregister(netreg, o->data);
+	for (o =3D netreg->operator_list; o; o =3D o->next) {
+		struct network_operator_data *op =3D o->data;
+		if (op !=3D op->netreg->current_operator)
+			network_operator_dbus_unregister(netreg, op);
+		else
+			current_op =3D op;
+	}
+
+	if (current_op) {
+		n =3D g_slist_prepend(n, current_op);
+		netreg->operator_list =3D
+			g_slist_remove(netreg->operator_list, current_op);
+	}
 =

 	g_slist_free(netreg->operator_list);
 =

-- =

1.9.1

--===============0662648457939948263==--

