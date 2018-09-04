Content-Type: multipart/mixed; boundary="===============3118427795745597503=="
MIME-Version: 1.0
From: Bassem Boubaker <bassem.boubaker@actia.fr>
Subject: [PATCH] Add missing unhandled "+CGEV: ME DEACT" URC That forces a
 context to be down by UE
Date: Tue, 04 Sep 2018 17:32:06 +0200
Message-ID: <1536075126-12888-1-git-send-email-bassem.boubaker@actia.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3118427795745597503==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The URC is:
+CGEV: ME DEACT <PDP_type>, <PDP_addr>, [<cid>]

This inform us  that the mobile termination has forced a context desactivat=
ion.
This implies that the active cid context must be down.
---
 drivers/atmodem/gprs-context.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/atmodem/gprs-context.c b/drivers/atmodem/gprs-context.c
index 79ac4c8..6d4f0ce 100644
--- a/drivers/atmodem/gprs-context.c
+++ b/drivers/atmodem/gprs-context.c
@@ -365,6 +365,9 @@ static void cgev_notify(GAtResult *result, gpointer use=
r_data)
 	if (g_str_has_prefix(event, "NW DEACT") =3D=3D FALSE)
 		return;
 =

+	if (g_str_has_prefix(event, "ME DEACT") =3D=3D FALSE)
+		return;
+
 	if (!g_at_result_iter_skip_next(&iter))
 		return;
 =

-- =

2.7.4


--===============3118427795745597503==--

