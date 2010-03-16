Content-Type: multipart/mixed; boundary="===============8660474023396843285=="
MIME-Version: 1.0
From: Pekka Pessi <ppessi@gmail.com>
Subject: Barring API
Date: Tue, 16 Mar 2010 18:54:37 +0200
Message-ID: <80fd4e751003160954t96159a1y16e73844510605df@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8660474023396843285==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi all,

I had a quick peek on barring API which is currently undocumented.

It seems to me that there is a good reason for it being documented as
the properties by GetProperties() returned are different from the
properties emitted. I kinda like the the emitted properties
(VoiceIncoming and VoiceOutgoing), they seem to capture the
functionality of the barring services as well as the limitations of
both the air and AT interface pretty well.

Here is my stab at the D-Bus API documentation; as it is, the
GetProperties takes 5 air operations in the most pessimal case (~25
seconds if all goes well on UMTS). There should probably be different
atoms for Fax, Data/Video and SMS, if someone ever needs them. Adding
them to this atom does not seem feasible as any basic service might
require 5 new AT+CLCK commands with ~5 seconds delay each.

--Pekka

--8<----8<----8<----8<----8<----8<----8<----8<----8<----8<----8<----8<----8=
<----8<----8<----8<----8<--
Voice Call Barring hierarchy
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D

Service		org.ofono
Interface	org.ofono.CallBarring
Object path	[variable prefix]/{modem0,modem1,...}

Methods		dict GetProperties()

			Contains the properties for this object.

		void ChangePassword(string old_password, string new_password)

			Register new network password for the barring
			services.

		void DisableAll(string password)

			Disables all voice call barrings.

		void DisableAllIncoming(string password)

			Disables barrings for incoming voice calls.

		void DisableAllOutgoing(string password)

			Disables barrings for outgoing voice calls.

		void SetProperty(string property, variant value)

			Sets the given property value to that specified in
			call parameter.

Signals		PropertyChanged(string property, variant value)

			Signal is emitted whenever a property has changed.  The new
			value is passed as the signal argument.

Properties	string VoiceIncoming [readwrite]

			Contains the value of the barrings for the incoming
			voice calls. The possible values are
			- "always": bar all incoming calls
			- "whenroaming": bar incoming calls when roaming,
			or
			- "" if no barring is active

		string VoiceOutgoing [readwrite]

			Contains the value of the barrings for the outgoing
			voice calls. The possible values are
			- "all": bar all outgoing calls
			- "international": bar all outgoing international calls
			- "internationalnothome": bar all outgoing
			international calls except to home country
			- "" if no barring is active
--8<----8<----8<----8<----8<----8<----8<----8<----8<----8<----8<----8<----8=
<----8<----8<----8<----8<--

-- =

Pekka.Pessi mail@nokia.com

--===============8660474023396843285==--

