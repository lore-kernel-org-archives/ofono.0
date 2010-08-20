Content-Type: multipart/mixed; boundary="===============4179709812459342686=="
MIME-Version: 1.0
From: Zhang, Caiwen <Caiwen.Zhang@windriver.com>
Subject: RE: UIM manager atom APIs review request
Date: Fri, 20 Aug 2010 05:12:52 +0200
Message-ID: <D87B22B1FE8C0F479CA9BEAD6C25AAE8055DCDCF@ism-mail03.corp.ad.wrs.com>
In-Reply-To: <1282215454.23399.174.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4179709812459342686==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

> -----Original Message-----
> From: ofono-bounces(a)ofono.org [mailto:ofono-bounces(a)ofono.org] On
> Behalf Of Marcel Holtmann
> Sent: Thursday, August 19, 2010 6:58 PM
> To: ofono(a)ofono.org
> Subject: RE: UIM manager atom APIs review request
> =

> Hi Caiwen,
> =

> > > > I am going to implement an UIM manager atom for CDMA extension.
> Its
> > > APIs will be almost the same as
> > > > current SIM manger atom's APIs.  But I suggest maybe will can do
> > some
> > > changes:
> > > >
> > > > 	1. Add PIN remain retry count support
> > > > 	2. replace properties 'Present' 'PinRequired' and
> 'LockedPins'
> > > with a new add property 'Status'
> > > >
> > > > Properties	string Status [readonly]
> > > >
> > > > 			Contains the string type of the status
of the
> > SIM.
> > > > 			The possible values are:
> > > > 			"ready" - Not waiting for a password
> > > > 			"pin" - SIM PIN is required
> > > > 			"phone" - Phone-to-SIM PIN is required
[GSM
> > only]
> > > > 			"firstphone" - Phone-to-very-first SIM
> > > > 						PIN is required
[GSM
> > only]
> > > > 			"pin2" - SIM PIN2 is required
> > > > 			"network" - Network Personalization
password is
> > > > 						required  [GSM
only]
> > > > 			"netsub" - Network subset
personalization
> > > > 						password is
required
> > [GSM only]
> > > > 			"service" - Service Provider
personalization
> > > > 						password is
required
> > [GSM only]
> > > > 			"corp" - Corporate personalization
password
> > > > 						is required
[GSM only]
> > > > 			"puk" - SIM PUK is required
> > > > 			"firstphonepuk" - Phone-to-very-first
SIM PUK
> is
> > > > 						required  [GSM
only]
> > > > 			"puk2" - SIM PUK2 is required
> > > > 			"networkpuk" - Network personalization
> > unblocking
> > > > 						password is
required
> > [GSM only]
> > > > 			"netsubpuk" - Network subset
personalization
> > > > 						unblocking
password is
> > required
> > > [GSM only]
> > > > 			"servicepuk" - Service provider
personalization
> > > > 						unblocking
password is
> > required
> > > [GSM only]
> > > > 			"corppuk" - Corporate personalization
> unblocking
> > > > 						password is
required
> > [GSM only]
> > > > 			"absent" - No SIM inserted
> > >
> > > why? What is wrong with the current properties? I like to see this
> > from
> > > the UI point of view (and ConnMan as one user) why we should
change
> > it.
> > >
> > Current properties are OK. I think maybe we can improve it.
Generally,
> > user
> > Only care the SIM status, e.g. whether SIM is insert or need input
> > password.
> > In fact, He/she doesn't care which Pins are locked. So we can
> simplify
> > it.
> > replace 'Present' 'PinRequired' with "Status" and remove
'LockedPins'.
> >
> > In fact, there is no way to get all the Locked Pins, 'LockedPins'
> > property
> > Value maybe incorrect.
> =

> actually the user and the UI cares about which PIN is locked. It has
to
> tell the user which PIN to enter and how long it is. So that is
> important.
> =


Generally, SIM status (I mean +CPIN? Result) will be PIN required at two
cases: =

	1. when the modem is power on =

		a)PIN lock is enabled. or
		b) case 2 has occur Before power off last time and the
password is not reset.

	2. When user input wrong password time reach the max count,
required input relatives PUK, =

to reset the password.

In other status, the SIM status is always be 'READY'.

e.g. enable PIN lock

To achieve this, use AT command: +CLCK=3D "SC", 1, <PIN> =

At this time the SIM status is still be 'READY' =

Even after input PIN error twice. =


Once input PIN incorrect three times the Status changes to PUK required
(case 2 of above case).

That's to say, once the modem is power on. SIM status =

Will always be ready. Except above case 2 occurs. =

When case 1 or 2 occurs, user have to input password, otherwise,
Modem enter function limited mode.

For other cases that user must input password, they are independent on
The SIM status, it is always required. Such as when enable/disable PIN
lock (above example), =

Always require PIN; When Enable/disable FDN (fixed dialing number)
always required input PIN2.

That's to say, when enter password wrong, it doesn't mean it is locked,
it just subtract the retry count 1. When must input password, it not
always due to SIM status
changes to password required case.

> > > > 		array{uint8} PinRetryCount [readonly]
> > > >
> > > > 			 Contains the remain retry count of
> PIN,PIN2,PUK
> > and
> > > PUK2
> > >
> > > Only uint8 is needed here. The UI doesn't care about the retries
> other
> > > PINs. I only care about the current one it needs to enter.
> > >
> > There are some cases that need show PIN remain retry count  but the
> SIM
> > status
> > is ready (Not waiting for a password).
> > such as, activates/ deactivate PIN lock.
> =

> And when is that. I don't see that use case. Why would you show the
> remaining entries if your SIM card is active and unlocked?
> =

> Please provide clear examples where this would be needed.
> =

e.g.
	I'd like to protect my phone. So I enter the setting to enable
PIN lock.
Before do this, I see I have ever try this twice (as the description
above at =

this time the SIM status is still 'READY')and failed due to I'm not sure
the =

PIN code. It is very useful, because if I am not sure the PIN code and
PUK code
I will not try, otherwise if fail again my device will be locked.

Best regards,
Caiwen


--===============4179709812459342686==--

