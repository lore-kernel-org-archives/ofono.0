Content-Type: multipart/mixed; boundary="===============1865711407863397962=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCHv5 2/5] call-forwarding: Don't query cfs if CFU is active
Date: Thu, 07 Jun 2012 10:21:41 +0300
Message-ID: <1339053704-8749-3-git-send-email-oleg.zhurakivskyy@intel.com>
In-Reply-To: <1339053704-8749-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1865711407863397962==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/call-forwarding.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/src/call-forwarding.c b/src/call-forwarding.c
index 7b0a10e..343f958 100644
--- a/src/call-forwarding.c
+++ b/src/call-forwarding.c
@@ -565,7 +565,8 @@ static DBusMessage *cf_get_properties(DBusConnection *c=
onn, DBusMessage *msg,
 	struct ofono_modem *modem =3D __ofono_atom_get_modem(cf->atom);
 =

 	if ((cf->flags & CALL_FORWARDING_FLAG_CACHED) ||
-			ofono_modem_get_online(modem) =3D=3D FALSE)
+			ofono_modem_get_online(modem) =3D=3D FALSE ||
+			is_cfu_enabled(cf))
 		return cf_get_properties_reply(msg, cf);
 =

 	if (cf->driver->query =3D=3D NULL)
-- =

1.7.5.4


--===============1865711407863397962==--

