Content-Type: multipart/mixed; boundary="===============2716331661533991774=="
MIME-Version: 1.0
From: James Prestwood <james.prestwood@linux.intel.com>
Subject: [PATCHv2 11/11] doc: documentation for SimAuth dbus interfaces
Date: Tue, 10 Oct 2017 14:36:20 -0700
Message-ID: <1507671380-7625-11-git-send-email-james.prestwood@linux.intel.com>
In-Reply-To: <1507671380-7625-1-git-send-email-james.prestwood@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2716331661533991774==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/sim-auth-api.txt | 78 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 78 insertions(+)
 create mode 100644 doc/sim-auth-api.txt

diff --git a/doc/sim-auth-api.txt b/doc/sim-auth-api.txt
new file mode 100644
index 0000000..089a325
--- /dev/null
+++ b/doc/sim-auth-api.txt
@@ -0,0 +1,78 @@
+SimAuth authentication heiarchy [experimental]
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Service		org.ofono
+Interface	org.ofono.SimAuthentication
+Object path	[variable prefix]/{modem0,modem1,...}
+
+Methods		array{object,dict} GetProperties()
+
+			Returns properties for SimAuthentication interface.
+
+Properties	array{object,dict} applications [readonly]
+
+			Array of all SIM applications found during discovery.
+			In the format "{o(ss)}" where 'o' is the object
+			path for the application, 's' is the type, and 's'
+			is the human readable name e.g.
+
+			o =3D "/modem1/A0000000871004FFFFFFFF8906190000"
+			s =3D "Ims"
+			s =3D "ISim"
+
+			For each application there will be a corresponding
+			object that matches the path (o). The type will
+			signify which interfaces are under that object (below).
+
+			type =3D Umts --> org.ofono.USimApplication
+			type =3D Ims  --> org.ofono.ISimApplication
+
+SimAuth USIM application heiarchy [experimental]
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Service		org.ofono
+Interface	org.ofono.USimApplication
+Object path	[variable prefix]/{modem0,modem1,...}/{AID name}
+
+Methods		array{string, dict} GsmAuthenticate(array{array{byte}} rands)
+
+			Run the USIM application GSM AUTHENTICATE algorithm
+			with N random challenges 'rands'. This should be an
+			array of an array of bytes ("aay").
+
+			Returns the derived Kc/SRES values as an array of
+			dictionaries. The index of each dictionary matches
+			the index of the rand value in the method call. The
+			keys for each dictionary are "kc" and "sres" and both
+			are arrays of bytes.
+
+			Possible Errors:
+				[service].Error.NotSupported
+				[service].Error.Busy
+
+		dict UmtsAuthenticate(array{byte} rand, array{byte} autn)
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
+Object		[variable prefix]/{modem0,modem1,...}/{AID name}
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


--===============2716331661533991774==--

