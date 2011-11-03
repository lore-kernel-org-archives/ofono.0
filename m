Content-Type: multipart/mixed; boundary="===============8295038296127058130=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH 1/3] uim: Add CDMA UIM APIs documentation
Date: Thu, 03 Nov 2011 10:45:53 +0100
Message-ID: <1320313555-10320-2-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1320313555-10320-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8295038296127058130==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/cdma-uim-api.txt |  152 ++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 152 insertions(+), 0 deletions(-)
 create mode 100644 doc/cdma-uim-api.txt

diff --git a/doc/cdma-uim-api.txt b/doc/cdma-uim-api.txt
new file mode 100644
index 0000000..44f42df
--- /dev/null
+++ b/doc/cdma-uim-api.txt
@@ -0,0 +1,152 @@
+CDMA UimManager hierarchy
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Service		org.ofono
+Interface	org.ofono.cdma.UimManager
+Object path	[variable prefix]/{modem0,modem1,...}
+
+Methods		dict GetProperties()
+
+			Returns UIM properties for the modem object.  See
+			the properties section for available properties.
+
+		void ChangePin(string type, string oldpin, string newpin)
+
+			Changes the pin given by string type.
+
+			Possible Errors: [service].Error.NotImplemented
+					 [service].Error.InProgress
+					 [service].Error.InvalidArguments
+					 [service].Error.InvalidFormat
+					 [service].Error.Failed
+
+		void EnterPin(string type, string pin)
+
+			Enters the currently pending pin.  The type value must
+			match the pin type being asked in the PinRequired
+			property.
+
+			Possible Errors: [service].Error.NotImplemented
+					 [service].Error.InProgress
+					 [service].Error.InvalidArguments
+					 [service].Error.InvalidFormat
+					 [service].Error.Failed
+
+		void ResetPin(string type, string puk, string newpin)
+
+			Provides the unblock key to the modem and if correct
+			resets the pin to the new value of newpin.
+
+			Possible Errors: [service].Error.NotImplemented
+					 [service].Error.InProgress
+					 [service].Error.InvalidArguments
+					 [service].Error.InvalidFormat
+					 [service].Error.Failed
+
+		void LockPin(string type, string pin)
+
+			Activates the lock for the particular pin type.  The
+			device will ask for a PIN automatically next time the
+			device is turned on or the SIM is removed and
+			re-inserted.  The current PIN is required for the
+			operation to succeed.
+
+			Possible Errors: [service].Error.NotImplemented
+					 [service].Error.InProgress
+					 [service].Error.InvalidArguments
+					 [service].Error.InvalidFormat
+					 [service].Error.Failed
+
+		void UnlockPin(string type, string pin)
+
+			Deactivates the lock for the particular pin type.  The
+			current PIN is required for the operation to succeed.
+
+			Possible Errors: [service].Error.NotImplemented
+					 [service].Error.InProgress
+					 [service].Error.InvalidArguments
+					 [service].Error.InvalidFormat
+					 [service].Error.Failed
+
+Signals		PropertyChanged(string name, variant value)
+
+			This signal indicates a changed value of the given
+			property.
+
+Properties	boolean Present [readonly]
+
+			True if a UIM card is detected.  There are
+			no other properties if false.
+
+		string SubscriberIdentity [readonly, optional]
+
+			Contains the IMSI of the UIM, if available.
+
+		string MobileCountryCode [readonly, optional]
+
+			Contains the Mobile Country Code (MCC) of the home
+			network (not to be confused with the currently
+			registered network reported on NetworkRegistration
+			interface) and is read directly from the UIM if
+			available.
+
+		string MobileNetworkCode [readonly, optional]
+
+			Contains the Mobile Network Code (MNC) of the home
+			network (not to be confused with the currently
+			registered network reported on NetworkRegistration
+			interface) and is read directly from the UIM if
+			available.
+
+		string PinRequired [readonly]
+
+			Contains the string type of the pin required by the
+			modem.  The possible values are:
+				"none" - Nothing is required
+				"pin" - UIM PIN is required
+				"phone" - Phone-to-UIM PIN is required
+				"firstphone" - Phone-to-very-first SIM
+						PIN is required
+				"pin2" - UIM PIN2 is required
+				"network" - Network Personalization password is
+						required
+				"netsub" - Network subset personalization
+						password is required
+				"service" - Service Provider personalization
+						password is required
+				"corp" - Corporate personalization password
+						is required
+				"puk" - UIM PUK is required
+				"firstphonepuk" - Phone-to-very-first UIM PUK is
+						required
+				"puk2" - UIM PUK2 is required
+				"networkpuk" - Network personalization unblocking
+						password is required
+				"netsubpuk" - Network subset personalization
+						unblocking password is required
+				"servicepuk" - Service provider personalization
+						unblocking password is required
+				"corppuk" - Corporate personalization unblocking
+						password is required
+
+		array{string} LockedPins [readonly]
+
+			Contains the pins that are currently locked and will
+			require the user to enter the password at startup.
+			Using LockPin and UnlockPin will result in changes to
+			this property.
+
+			The list contains elements of the same format as the
+			PinRequired property.
+
+		dict{string,byte} Retries [readonly]
+
+			Contains all the retry counters available. The possible
+			values for the first field are the same as in
+			PinRequired property. The second field contains is the
+			counter for that pin type.
+
+			This property is updated after each operation that
+			might have changed the retry counters, i.e. calls to
+			ChangePin(), EnterPin(), ResetPin() LockPin(),
+			UnlockPin().
-- =

1.7.1


--===============8295038296127058130==--

