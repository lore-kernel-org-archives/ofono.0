Content-Type: multipart/mixed; boundary="===============6122167195683309532=="
MIME-Version: 1.0
From: James Prestwood <james.prestwood@linux.intel.com>
Subject: [PATCHv3 7/7] doc: documentation for SimAuth dbus interfaces
Date: Wed, 11 Oct 2017 11:57:48 -0700
Message-ID: <1507748268-4799-7-git-send-email-james.prestwood@linux.intel.com>
In-Reply-To: <1507748268-4799-1-git-send-email-james.prestwood@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6122167195683309532==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/sim-auth-api.txt | 101 +++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 file changed, 101 insertions(+)
 create mode 100644 doc/sim-auth-api.txt

diff --git a/doc/sim-auth-api.txt b/doc/sim-auth-api.txt
new file mode 100644
index 0000000..ce54ea4
--- /dev/null
+++ b/doc/sim-auth-api.txt
@@ -0,0 +1,101 @@
+SimAuthentication heiarchy [experimental]
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Service		org.ofono
+Interface	org.ofono.SimAuthentication
+Object path	[variable prefix]/{modem0,modem1,...}
+
+Methods		array{object,dict} GetApplications()
+
+			Get an array of all SIM applications found during
+			discovery. In the format "a{oa{sv}}" where 'o' is
+			the object path for the application e.g.
+
+			o =3D "/modem1/A0000000871004FFFFFFFF8906190000"
+
+			Each dictionary will contain 'Type' e.g. 'Ims' and
+			'Name' e.g. 'ISim'
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
+Methods		dict GetProperties()
+
+			Returns properties for the USimApplication. See
+			properties section for available properties.
+
+		array{string, dict} GsmAuthenticate(array{array{byte}} rands)
+
+			Run the USIM application GSM AUTHENTICATE algorithm
+			with N random challenges 'rands'. This should be an
+			array of an array of bytes ("aay"). The number of
+			random challenges is limited to a maximum of 3.
+
+			Returns the derived Kc/SRES values as an array of
+			dictionaries. The index of each dictionary matches
+			the index of the rand value in the method call. The
+			keys for each dictionary are "Kc" and "SRES" and both
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
+			returned containing 'RES', 'CK', 'IK' and possibly
+			'Kc' if service 27 is available. If there was a
+			sync error 'auts' will be returned.
+
+			Possible Errors: [service].Error.NotSupported
+
+Properties	string Type [readonly]
+
+			Type of application: 'Umts'
+
+		string Name [readonly]
+
+			Human readable name: 'USim'
+
+SimAuth ISIM application heiarchy [experimental]
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Service		org.ofono
+Interface	org.ofono.ISimApplication
+Object		[variable prefix]/{modem0,modem1,...}/{AID name}
+
+Methods		dict GetProperties()
+
+			Returns properties for the ISimApplication. See
+			the properties section for available properties.
+
+		dict ImsAuthenticate(array{byte} rand, array{byte} autn)
+
+			Run the UMTS AUTHENTICATE algorithm in the IMS
+			context with 'rand' and 'autn'. A dictionary will be
+			returned containing 'RES', 'CK', 'IK' and possibly
+			'Kc' if service 27 is available. If there was a
+			sync error 'auts' will be returned.
+
+			Possible Errors: [service].Error.NotSupported
+
+Properties	string Type [readonly]
+
+			Type of application: 'Ims'
+
+		string Name [readonly]
+
+			Human readable name: 'ISim'
-- =

2.7.4


--===============6122167195683309532==--

