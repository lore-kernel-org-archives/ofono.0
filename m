Content-Type: multipart/mixed; boundary="===============8025599607360248404=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCHv3 07/12] call-forwarding: Re-run conditional queries on cfu
 removal
Date: Tue, 13 Mar 2012 15:46:28 +0200
Message-ID: <1331646393-5249-8-git-send-email-oleg.zhurakivskyy@intel.com>
In-Reply-To: <1331646393-5249-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8025599607360248404==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/call-forwarding.c |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/src/call-forwarding.c b/src/call-forwarding.c
index ad5050b..edd1891 100644
--- a/src/call-forwarding.c
+++ b/src/call-forwarding.c
@@ -691,7 +691,15 @@ static DBusMessage *set_property_request(struct ofono_=
call_forwarding *cf,
 =

 	cf->pending =3D dbus_message_ref(msg);
 	cf->query_next =3D type;
-	cf->query_end =3D type;
+
+	if (type =3D=3D CALL_FORWARDING_TYPE_UNCONDITIONAL &&
+		ph->number[0] =3D=3D '\0' && is_cfu_enabled(cf))
+		/*
+		 * CFU is removed, conditionals need to be updated
+		 */
+		cf->query_end =3D CALL_FORWARDING_TYPE_NOT_REACHABLE;
+	else
+		cf->query_end =3D type;
 =

 	DBG("Farming off request, will be erasure: %d", ph->number[0] =3D=3D '\0'=
);
 =

-- =

1.7.5.4


--===============8025599607360248404==--

