Content-Type: multipart/mixed; boundary="===============2114327465198004543=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 4/4] Add a MessageWaiting interface to track message
 waiting indications.
Date: Mon, 03 Aug 2009 14:29:59 -0500
Message-ID: <200908031430.00876.denkenz@gmail.com>
In-Reply-To: <fb249edb0908031209r63798d93mc4191e47dda6cfc3@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2114327465198004543==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

> > Perhaps you want to break up the attributes into two:
> >
> > FooMailWaiting -> True / False
> > FooMessages -> Number, with 0 in case we're not sure
>
> We can do that although I think the setting to 0 or 1 when we're not
> sure is a good enough approximation?  The 1 being a little lie.

Lets go with two attributes.  It should give the UI a chance to display the =

indicators differently, depending on what the carrier supports.

> Err, yes we can, but then we don't account for the little corner cases
> like the two mentioned:
>
>  * Special Message Indication IEI says discard the message but DCS
> says store it.

Sure we do, =

if sms_contains_special_vm_iei(sms):
	discard =3D extract_discard_from_iei_data
	// Quote relevant part of the spec here
	if mwi_dcs_decode(sms, ... ,dcsdiscard)
		discard =3D discard || dcsdiscard  <--- here
	return

>  * Special IEI says there are 3 emails waiting and DCS says there's a
> voicemail message.

While the spec doesn't really forbid this, its not really in the spirit of =

what is intended: "The third level is described here, and provides the maxi=
mum =

detail level for analysis by the mobile, i.e. an indication of the number a=
nd =

type of messages waiting in systems connected to the PLMN."  =


I say we don't worry about this case, just assume that the network provider=
 is =

sane.


> >  This should not happen on any modern network, and  we should not
> > give it to the MessageWaiting interface anyway, since there's nothing
> > useful it can do with it.
>
> It still gives us one piece of information: the message is concerning
> waiting messages.  So perhaps it should be that interface providing
> the message and from there it can be displayed on the screen.

Yes, so we leave the option to do something about it later, but for now pur=
e =

"return call" messages are useless.

Regards,
-Denis


--===============2114327465198004543==--

