Content-Type: multipart/mixed; boundary="===============5619857459654668930=="
MIME-Version: 1.0
From: Martin =?unknown-8bit?q?Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: [PATCH] gprs: fix allocation of context id
Date: Wed, 02 Jan 2019 12:50:52 +0100
Message-ID: <20190102115053.79191-1-martin@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5619857459654668930==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

After the convertion to l_uintset, the creation of new contexts fails
due to a range error being returned from l_uintset_find_unused().

The error happens because the uinset is created with a min-value of 1,
but the start-value passed to l_uintset_find_unused() is initialized as
0.

Fix this by passing a start-value just past the last allocated context
id.
---
 src/gprs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/gprs.c b/src/gprs.c
index 7e9e5161..582e3207 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -2329,7 +2329,7 @@ static void provision_context(const struct ofono_gprs=
_provision_data *ap,
 			strlen(ap->message_center) > MAX_MESSAGE_CENTER_LENGTH)
 		return;
 =

-	id =3D l_uintset_find_unused(gprs->used_pids, gprs->last_context_id);
+	id =3D l_uintset_find_unused(gprs->used_pids, gprs->last_context_id + 1);
 	if (id > l_uintset_get_max(gprs->used_pids))
 		return;
 =

-- =

2.20.1


--===============5619857459654668930==--

