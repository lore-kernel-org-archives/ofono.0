Content-Type: multipart/mixed; boundary="===============4819980828923530011=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@intel.com>
Subject: [PATCHv4 04/13] call-forwarding: Streamline number assignment
Date: Tue, 10 Apr 2012 15:17:25 +0300
Message-ID: <1334060254-29547-5-git-send-email-oleg.zhurakivskyy@intel.com>
In-Reply-To: <1334060254-29547-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4819980828923530011==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/call-forwarding.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/src/call-forwarding.c b/src/call-forwarding.c
index cda54e7..5e68bba 100644
--- a/src/call-forwarding.c
+++ b/src/call-forwarding.c
@@ -420,11 +420,8 @@ static void set_new_cond_list(struct ofono_call_forwar=
ding *cf,
 			if (lc =3D=3D NULL)
 				continue;
 =

-			if (new_cfu)
-				number =3D "";
-			else {
+			number =3D new_cfu ? "" : phone_number_to_string(
 							&lc->phone_number);
-			}
 =

 			ofono_dbus_signal_property_changed(conn, path,
 						OFONO_CALL_FORWARDING_INTERFACE,
-- =

1.7.5.4


--===============4819980828923530011==--

