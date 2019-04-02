Content-Type: multipart/mixed; boundary="===============0232296368725386281=="
MIME-Version: 1.0
From: richard.rojfors@gmail.com
Subject: [PATCH] gprs: Fix allocation of context id read from settings
Date: Tue, 02 Apr 2019 09:28:53 +0200
Message-ID: <20190402072853.7793-1-richard.rojfors@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0232296368725386281==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Richard R=C3=B6jfors <richard@puffinpack.se>

This fix is similar to the one in the following commit,
but fixes allocation for context ids after ap's are
read from settings.

commit c3fdf6a7c567a7507c3558a27006b6f9559493d6
Author: Denis Kenzior <denkenz@gmail.com>
Date:   Thu Jan 3 17:17:21 2019 -0600

    gprs: Fix allocation of context id
---
 src/gprs.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/src/gprs.c b/src/gprs.c
index b0d56e1e..d432c9fd 100644
--- a/src/gprs.c
+++ b/src/gprs.c
@@ -2340,7 +2340,11 @@ static void provision_context(const struct ofono_gpr=
s_provision_data *ap,
 			strlen(ap->message_center) > MAX_MESSAGE_CENTER_LENGTH)
 		return;
 =

-	id =3D l_uintset_find_unused(gprs->used_pids, gprs->last_context_id);
+	if (gprs->last_context_id)
+		id =3D l_uintset_find_unused(gprs->used_pids,
+							gprs->last_context_id);
+	else
+		id =3D l_uintset_find_unused_min(gprs->used_pids);
 	if (id > l_uintset_get_max(gprs->used_pids))
 		return;
 =

-- =

2.19.1


--===============0232296368725386281==--

