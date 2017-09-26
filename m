Content-Type: multipart/mixed; boundary="===============0068460452780289071=="
MIME-Version: 1.0
From: James Prestwood <james.prestwood@linux.intel.com>
Subject: [PATCH 7/7] doc: documentation for SimAuth dbus interfaces
Date: Tue, 26 Sep 2017 09:26:09 -0700
Message-ID: <1506443169-19755-7-git-send-email-james.prestwood@linux.intel.com>
In-Reply-To: <1506443169-19755-1-git-send-email-james.prestwood@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0068460452780289071==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/sim-auth-api.txt | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 doc/sim-auth-api.txt

diff --git a/doc/sim-auth-api.txt b/doc/sim-auth-api.txt
new file mode 100644
index 0000000..f9c666f
--- /dev/null
+++ b/doc/sim-auth-api.txt
@@ -0,0 +1,41 @@
+SimAuth USIM application heiarchy [experimental]
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Service		org.ofono
+Interface	org.ofono.USimApplication
+Object path	[variable prefix]/{modem0,modem1,...}
+
+Methods		array{byte},array{byte} GsmAuthenticate(array{byte} rand)
+
+			Run the USIM application GSM AUTHENTICATE algorithm
+			with the random challenge 'rand'. Returns the derived
+			SRES and KC values as two arrays of bytes.
+
+			Possible Errors: [service].Error.NotSupported
+
+Methods		dict UmtsAuthenticate(array{byte} rand, array{byte} autn)
+
+			Run the UMTS AUTHENTICATE algorithm in the 3G
+			context with 'rand' and 'autn'. A dictionary will be
+			returned containing 'res', 'ck', 'ik' and possibly
+			'kc' if service 27 is available. If there was a
+			sync error 'auts' will be returned.
+
+			Possible Errors: [service].Error.NotSupported
+
+SimAuth ISIM application heiarchy [experimental]
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Service		org.ofono
+Interface	org.ofono.ISimApplication
+Object		[variable prefix]/{modem0,modem1,...}
+
+Methods		dict ImsAuthenticate(array{byte} rand, array{byte} autn)
+
+			Run the UMTS AUTHENTICATE algorithm in the IMS
+			context with 'rand' and 'autn'. A dictionary will be
+			returned containing 'res', 'ck', 'ik' and possibly
+			'kc' if service 27 is available. If there was a
+			sync error 'auts' will be returned.
+
+			Possible Errors: [service].Error.NotSupported
-- =

2.7.4


--===============0068460452780289071==--

