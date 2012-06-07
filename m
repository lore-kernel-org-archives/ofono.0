Content-Type: multipart/mixed; boundary="===============5879612257050503792=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCHv5 1/5] call-forwarding: Streamline number assignment
Date: Thu, 07 Jun 2012 10:21:40 +0300
Message-ID: <1339053704-8749-2-git-send-email-oleg.zhurakivskyy@intel.com>
In-Reply-To: <1339053704-8749-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5879612257050503792==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/call-forwarding.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/src/call-forwarding.c b/src/call-forwarding.c
index 5acbd67..7b0a10e 100644
--- a/src/call-forwarding.c
+++ b/src/call-forwarding.c
@@ -405,10 +405,7 @@ static void set_new_cond_list(struct ofono_call_forwar=
ding *cf,
 			if (lc =3D=3D NULL)
 				continue;
 =

-			if (new_cfu)
-				number =3D "";
-			else
-				number =3D phone_number_to_string(
+			number =3D new_cfu ? "" : phone_number_to_string(
 							&lc->phone_number);
 =

 			ofono_dbus_signal_property_changed(conn, path,
-- =

1.7.5.4


--===============5879612257050503792==--

