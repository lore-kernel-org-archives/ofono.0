Content-Type: multipart/mixed; boundary="===============5798091607185048165=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: UIM manager atom APIs review request
Date: Wed, 18 Aug 2010 18:55:03 +0200
Message-ID: <1282150503.23399.154.camel@localhost.localdomain>
In-Reply-To: <D87B22B1FE8C0F479CA9BEAD6C25AAE8055DC99D@ism-mail03.corp.ad.wrs.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5798091607185048165==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Caiwen,

> I am going to implement an UIM manager atom for CDMA extension. Its APIs =
will be almost the same as =

> current SIM manger atom's APIs.  But I suggest maybe will can do some cha=
nges:
> =

> 	1. Add PIN remain retry count support
> 	2. replace properties 'Present' 'PinRequired' and 'LockedPins' with a ne=
w add property 'Status'
> =

> Properties	string Status [readonly]
> 			=

> 			Contains the string type of the status of the SIM.  =

> 			The possible values are:
> 			"ready" - Not waiting for a password
> 			"pin" - SIM PIN is required
> 			"phone" - Phone-to-SIM PIN is required  [GSM only]
> 			"firstphone" - Phone-to-very-first SIM
> 						PIN is required  [GSM only]
> 			"pin2" - SIM PIN2 is required
> 			"network" - Network Personalization password is
> 						required  [GSM only]
> 			"netsub" - Network subset personalization
> 						password is required  [GSM only]
> 			"service" - Service Provider personalization
> 						password is required  [GSM only]
> 			"corp" - Corporate personalization password
> 						is required  [GSM only]
> 			"puk" - SIM PUK is required
> 			"firstphonepuk" - Phone-to-very-first SIM PUK is
> 						required  [GSM only]
> 			"puk2" - SIM PUK2 is required
> 			"networkpuk" - Network personalization unblocking
> 						password is required  [GSM only]
> 			"netsubpuk" - Network subset personalization
> 						unblocking password is required  [GSM only]
> 			"servicepuk" - Service provider personalization
> 						unblocking password is required  [GSM only]
> 			"corppuk" - Corporate personalization unblocking
> 						password is required  [GSM only]
> 			"absent" - No SIM inserted

why? What is wrong with the current properties? I like to see this from
the UI point of view (and ConnMan as one user) why we should change it.

> 		array{uint8} PinRetryCount [readonly]
> 		=

> 			 Contains the remain retry count of PIN,PIN2,PUK and PUK2

Only uint8 is needed here. The UI doesn't care about the retries other
PINs. I only care about the current one it needs to enter.

Regards

Marcel



--===============5798091607185048165==--

