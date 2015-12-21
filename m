Content-Type: multipart/mixed; boundary="===============8208755009462004740=="
MIME-Version: 1.0
From: John Ernberg <john.ernberg@actia.se>
Subject: [PATCH] network: Fix use-after-free caused by Scan() in poor
 reception.
Date: Mon, 21 Dec 2015 10:03:28 +0000
Message-ID: <1450692223-29284-1-git-send-email-john.ernberg@actia.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8208755009462004740==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: John Ernberg <john.ernberg@actia.se>

When issuing a Scan() in poor reception while attached to an operator it's
fully possible to get no results, which causes the attached operator to be
cleaned up. In certain scenarios this would cause a use-after-free.
Make sure to clean up all the references to the operator when it's destroye=
d.
---
 src/network.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/network.c b/src/network.c
index 1dddcac..5329c28 100644
--- a/src/network.c
+++ b/src/network.c
@@ -257,6 +257,9 @@ static void network_operator_destroy(gpointer user_data)
 {
 	struct network_operator_data *op =3D user_data;
 =

+	if (op->netreg->current_operator =3D=3D op)
+		op->netreg->current_operator =3D NULL;
+
 	g_free(op);
 }
 =

-- =

1.9.1

--===============8208755009462004740==--

