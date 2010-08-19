Content-Type: multipart/mixed; boundary="===============9209295555374960433=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: RE: UIM manager atom APIs review request
Date: Thu, 19 Aug 2010 12:57:34 +0200
Message-ID: <1282215454.23399.174.camel@localhost.localdomain>
In-Reply-To: <D87B22B1FE8C0F479CA9BEAD6C25AAE8055DCC91@ism-mail03.corp.ad.wrs.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9209295555374960433==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Caiwen,

> > > I am going to implement an UIM manager atom for CDMA extension. Its
> > APIs will be almost the same as
> > > current SIM manger atom's APIs.  But I suggest maybe will can do
> some
> > changes:
> > >
> > > 	1. Add PIN remain retry count support
> > > 	2. replace properties 'Present' 'PinRequired' and 'LockedPins'
> > with a new add property 'Status'
> > >
> > > Properties	string Status [readonly]
> > >
> > > 			Contains the string type of the status of the
> SIM.
> > > 			The possible values are:
> > > 			"ready" - Not waiting for a password
> > > 			"pin" - SIM PIN is required
> > > 			"phone" - Phone-to-SIM PIN is required  [GSM
> only]
> > > 			"firstphone" - Phone-to-very-first SIM
> > > 						PIN is required  [GSM
> only]
> > > 			"pin2" - SIM PIN2 is required
> > > 			"network" - Network Personalization password is
> > > 						required  [GSM only]
> > > 			"netsub" - Network subset personalization
> > > 						password is required
> [GSM only]
> > > 			"service" - Service Provider personalization
> > > 						password is required
> [GSM only]
> > > 			"corp" - Corporate personalization password
> > > 						is required  [GSM only]
> > > 			"puk" - SIM PUK is required
> > > 			"firstphonepuk" - Phone-to-very-first SIM PUK is
> > > 						required  [GSM only]
> > > 			"puk2" - SIM PUK2 is required
> > > 			"networkpuk" - Network personalization
> unblocking
> > > 						password is required
> [GSM only]
> > > 			"netsubpuk" - Network subset personalization
> > > 						unblocking password is
> required
> > [GSM only]
> > > 			"servicepuk" - Service provider personalization
> > > 						unblocking password is
> required
> > [GSM only]
> > > 			"corppuk" - Corporate personalization unblocking
> > > 						password is required
> [GSM only]
> > > 			"absent" - No SIM inserted
> > =

> > why? What is wrong with the current properties? I like to see this
> from
> > the UI point of view (and ConnMan as one user) why we should change
> it.
> > =

> Current properties are OK. I think maybe we can improve it. Generally,
> user
> Only care the SIM status, e.g. whether SIM is insert or need input
> password.
> In fact, He/she doesn't care which Pins are locked. So we can simplify
> it. =

> replace 'Present' 'PinRequired' with "Status" and remove 'LockedPins'.
> =

> In fact, there is no way to get all the Locked Pins, 'LockedPins'
> property
> Value maybe incorrect.

actually the user and the UI cares about which PIN is locked. It has to
tell the user which PIN to enter and how long it is. So that is
important.

> > > 		array{uint8} PinRetryCount [readonly]
> > >
> > > 			 Contains the remain retry count of PIN,PIN2,PUK
> and
> > PUK2
> > =

> > Only uint8 is needed here. The UI doesn't care about the retries other
> > PINs. I only care about the current one it needs to enter.
> > =

> There are some cases that need show PIN remain retry count  but the SIM
> status =

> is ready (Not waiting for a password). =

> such as, activates/ deactivate PIN lock. =


And when is that. I don't see that use case. Why would you show the
remaining entries if your SIM card is active and unlocked?

Please provide clear examples where this would be needed.

Regards

Marcel



--===============9209295555374960433==--

