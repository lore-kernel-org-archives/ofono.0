Content-Type: multipart/mixed; boundary="===============7155642546663967576=="
MIME-Version: 1.0
From: Martin =?unknown-8bit?q?Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: [PATCHv2] gprs: fix allocation of context id
Date: Fri, 04 Jan 2019 16:44:40 +0100
Message-ID: <20190104154440.61531-1-martin@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7155642546663967576==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

After the convertion to l_uintset, the creation of new contexts fails
due to a range error being returned from l_uintset_find_unused().

The error happens because the uinset is created with a min-value of 1,
but the start-value passed to l_uintset_find_unused() is initialized as
0.

Fix this by using the minimum id when last used id is not yet
initialized.
---
 src/gprs.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/src/gprs.c b/src/gprs.c
index 58a998ca..92820e60 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -2334,7 +2334,11 @@ static void provision_context(const struct ofono_gpr=
s_provision_data *ap,
 			strlen(ap->message_center) > MAX_MESSAGE_CENTER_LENGTH)
 		return;
 =

-	id =3D l_uintset_find_unused(gprs->used_pids, gprs->last_context_id);
+	if (!gprs->last_context_id)
+		id =3D l_uintset_get_min(gprs->used_pids);
+	else
+		id =3D l_uintset_find_unused(gprs->used_pids,
+						gprs->last_context_id);
 	if (id > l_uintset_get_max(gprs->used_pids))
 		return;
 =

-- =

2.20.1


--===============7155642546663967576==--

