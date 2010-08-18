Content-Type: multipart/mixed; boundary="===============8457687817969379074=="
MIME-Version: 1.0
From: Zhang, Caiwen <Caiwen.Zhang@windriver.com>
Subject: UIM manager atom APIs review request
Date: Wed, 18 Aug 2010 18:03:24 +0200
Message-ID: <D87B22B1FE8C0F479CA9BEAD6C25AAE8055DC99D@ism-mail03.corp.ad.wrs.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8457687817969379074==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi all,

I am going to implement an UIM manager atom for CDMA extension. Its APIs wi=
ll be almost the same as =

current SIM manger atom's APIs. =C2=A0But I suggest maybe will can do some =
changes:

	1. Add PIN remain retry count support
	2. replace properties 'Present' 'PinRequired' and 'LockedPins' with a new =
add property 'Status'

Properties	string Status [readonly]
			=

			Contains the string type of the status of the SIM.  =

			The possible values are:
			"ready" - Not waiting for a password
			"pin" - SIM PIN is required
			"phone" - Phone-to-SIM PIN is required  [GSM only]
			"firstphone" - Phone-to-very-first SIM
						PIN is required  [GSM only]
			"pin2" - SIM PIN2 is required
			"network" - Network Personalization password is
						required  [GSM only]
			"netsub" - Network subset personalization
						password is required  [GSM only]
			"service" - Service Provider personalization
						password is required  [GSM only]
			"corp" - Corporate personalization password
						is required  [GSM only]
			"puk" - SIM PUK is required
			"firstphonepuk" - Phone-to-very-first SIM PUK is
						required  [GSM only]
			"puk2" - SIM PUK2 is required
			"networkpuk" - Network personalization unblocking
						password is required  [GSM only]
			"netsubpuk" - Network subset personalization
						unblocking password is required  [GSM only]
			"servicepuk" - Service provider personalization
						unblocking password is required  [GSM only]
			"corppuk" - Corporate personalization unblocking
						password is required  [GSM only]
			"absent" - No SIM inserted

		array{uint8} PinRetryCount [readonly]
		=

			 Contains the remain retry count of PIN,PIN2,PUK and PUK2


I marked all the values that only support in GSM with [GSM only]. =C2=A0=C2=
=A0

Yes, ofono current API is OK. This is just my suggestion. Maybe I should co=
mpletely =

follow current SIM manger atom's APIs.

Any suggestion? =


Thanks!

Caiwen


--===============8457687817969379074==--

