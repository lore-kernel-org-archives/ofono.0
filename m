Content-Type: multipart/mixed; boundary="===============7464166155575045926=="
MIME-Version: 1.0
From: Bertrand Aygon <bertrand.aygon@intel.com>
Subject: [PATCH] Add the possibility to specify the modem in test/hangup-all
Date: Mon, 14 Mar 2011 14:07:32 +0100
Message-ID: <1300108052-4670-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7464166155575045926==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 test/hangup-all |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/test/hangup-all b/test/hangup-all
index a8b9db5..32933db 100755
--- a/test/hangup-all
+++ b/test/hangup-all
@@ -9,9 +9,12 @@ manager =3D dbus.Interface(bus.get_object('org.ofono', '/'=
),
 						'org.ofono.Manager')
 =

 modems =3D manager.GetModems()
-path =3D modems[0][0]
+modem =3D modems[0][0]
 =

-manager =3D dbus.Interface(bus.get_object('org.ofono', path),
+if (len(sys.argv) =3D=3D 2):
+	modem =3D sys.argv[1]
+
+manager =3D dbus.Interface(bus.get_object('org.ofono', modem),
 						'org.ofono.VoiceCallManager')
 =

 manager.HangupAll()
-- =

1.7.1

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

--===============7464166155575045926==--

