Content-Type: multipart/mixed; boundary="===============6865127949923892200=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCHv4 08/13] call-forwarding: Remove unneeded variable
Date: Tue, 10 Apr 2012 15:17:29 +0300
Message-ID: <1334060254-29547-9-git-send-email-oleg.zhurakivskyy@intel.com>
In-Reply-To: <1334060254-29547-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6865127949923892200==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/call-forwarding.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/call-forwarding.c b/src/call-forwarding.c
index 20a510b..ba52609 100644
--- a/src/call-forwarding.c
+++ b/src/call-forwarding.c
@@ -539,8 +539,8 @@ static void get_query_cf_callback(const struct ofono_er=
ror *error, int total,
 	}
 =

 	if (cf->query_next =3D=3D CALL_FORWARDING_TYPE_NOT_REACHABLE) {
-		DBusMessage *reply =3D cf_get_properties_reply(cf->pending, cf);
-		__ofono_dbus_pending_reply(&cf->pending, reply);
+		__ofono_dbus_pending_reply(&cf->pending,
+				cf_get_properties_reply(cf->pending, cf));
 		return;
 	}
 =

-- =

1.7.5.4


--===============6865127949923892200==--

