Content-Type: multipart/mixed; boundary="===============4290504147349760099=="
MIME-Version: 1.0
From: Bertrand Aygon <bertrand.aygon@intel.com>
Subject: [PATCH] Add the possibility to specify the modem to use
Date: Wed, 08 Jun 2011 15:56:28 +0200
Message-ID: <1307541388-17351-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4290504147349760099==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 test/cancel-ussd |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/test/cancel-ussd b/test/cancel-ussd
index 7379622..5246591 100755
--- a/test/cancel-ussd
+++ b/test/cancel-ussd
@@ -10,7 +10,10 @@ manager =3D dbus.Interface(bus.get_object('org.ofono', '=
/'),
 =

 modems =3D manager.GetModems()
 =

-path, properties =3D modems[0]
+if (len(sys.argv) =3D=3D 2):
+	path =3D sys.argv[1]
+else:
+	path =3D modems[0][0]
 =

 ussd =3D dbus.Interface(bus.get_object('org.ofono', path),
 					'org.ofono.SupplementaryServices')
-- =

1.7.4.1

---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

--===============4290504147349760099==--

