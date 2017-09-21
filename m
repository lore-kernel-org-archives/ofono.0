Content-Type: multipart/mixed; boundary="===============7187902447550847652=="
MIME-Version: 1.0
From: James Prestwood <james.prestwood@linux.intel.com>
Subject: [PATCH 7/7] doc: documentation for SimAuth dbus interfaces
Date: Thu, 21 Sep 2017 11:12:00 -0700
Message-ID: <1506017520-22482-7-git-send-email-james.prestwood@linux.intel.com>
In-Reply-To: <1506017520-22482-1-git-send-email-james.prestwood@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7187902447550847652==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/sim-auth-api.txt | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 doc/sim-auth-api.txt

diff --git a/doc/sim-auth-api.txt b/doc/sim-auth-api.txt
new file mode 100644
index 0000000..466ca3a
--- /dev/null
+++ b/doc/sim-auth-api.txt
@@ -0,0 +1,27 @@
+SimAuth USIM application heiarchy [experimental]
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Service		org.ofono
+
+Interface	org.ofono.USimApplication
+Object path	[variable prefix]/{modem0,modem1,...}
+
+Methods		array{byte},array{byte} GSMAuthenticate(array{byte} rand)
+
+			Run the USIM application GSM AUTHENTICATE algorithm
+			with the random challenge 'rand'. Returns the derived
+			SRES and KC values as two arrays of bytes.
+
+			Possible Errors: [service].Error.NotSupported
+
+Interface	org.ofono.ISimApplication
+
+Methods		dict UMTSAuthenticate(array{byte} rand, array{byte} autn)
+
+			Run the ISIM applications UMTS AUTHENTICATE algorithm
+			with 'rand' and 'autn'. A dictionary will be returned
+			containing either 'res', 'ck' and 'ik' OR 'auts'.
+			A dict containing 'auts' signifies there was a sync
+			failure.
+
+			Possible Errors: [service].Error.NotSupported
-- =

2.7.4


--===============7187902447550847652==--

