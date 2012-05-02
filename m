Content-Type: multipart/mixed; boundary="===============7722819277730336258=="
MIME-Version: 1.0
From: Pablo Neira Ayuso <pablo@gnumonks.org>
Subject: Re: [PATCH] wavecom: add support for Wavecom Q2403/Q2686 modems
Date: Wed, 02 May 2012 09:45:30 +0200
Message-ID: <20120502074530.GA17031@1984>
In-Reply-To: <4F9E0C35.2060404@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7722819277730336258==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Sun, Apr 29, 2012 at 10:51:17PM -0500, Denis Kenzior wrote:
> Hi Pablo,
> =

> >>> +	/* AT+CRSM not supported by Q2403. */
> >>> +	if (sd->vendor =3D=3D OFONO_VENDOR_WAVECOM_Q) {
> >>> +		unsigned char access[3] =3D { 0x00, 0x00, 0x00 };
> >>> +
> >>> +		CALLBACK_WITH_SUCCESS(cb, 4, 0, 0, access,
> >>> +					EF_STATUS_VALID, data);
> >>
> >> Why don't you simply return an error here?
> > =

> > Without it, the modem initialization does not complete.
> =

> Can you fallback to CSIM?

I don't know what you mean, could you provide more information?

<snip>
> >>> -		for (mem =3D 0; mem < 3; mem++) {
> >>> +		/* Wavecom Q replies something like this:
> >>> +		 *
> >>> +		 * +CPMS: (("SM","BM","SR"),("SM"))
> >>> +		 *
> >>> +		 * It does not provide the way income messages are stored.
> >>> +		 * 3GPP TS 07.05 allows mem2 and mem3 to be optional.
> >>> +		 */
> >>
> >> Just how old is this modem and what version of 07.05 are you using?
> >>
> >> For reference, 07.05 version 7.0.1 from July 1999:
> >> "
> >> +CPMS=3D?
> >> +CPMS: (list of supported <mem1>s),(list of supported <mem2>s),
> >> (list of supported <mem3>s)
> >> "
> >>
> >> So the comment should probably be changed to indicate that this modem =
is
> >> just broken.
> >>
> > =

> > From: "3.2.2 Preferred Message Storage +CPMS" (TS 07.05 July 1999):
> > =

> > +CPMS=3D<mem1>[, <mem2>[,<mem3>]]
> =

> That is a set operation, we're doing a support query.

You're right, then it's a broken modem indeed.

> >> Are you sure you can't reuse the same behavior as OFONO_VENDOR_WAVECOM
> >> quirk inside drivers/atmodem/sim.c?
> > =

> > Yes, I remember to have tried that. That quirk didn't work for me
> > though.
> =

> I think we need to dig a bit deeper as to why, the VENDOR_WAVECOM
> behavior seems to be addressing exactly this case.

I think the other wavecom vendor provides a different reply. I can add
a different quirk to at_cpin_cb instead and see how it goes.

> >> This is probably wrong, I suspect we need to add a generic function to
> >> register (real) serial tty based modems.
> > =

> > I should have added some add_wavecom function instead.
> > =

> > I used that because I noticed that:
> > =

> > add_sim900
> > add_nokiacdma
> > add_tc65
> > ...
> > and so on.
> > =

> > look the same. So I guess that it is indeed a good idea to remove
> > redundant code and provide some generic one.
> > =

> =

> If they are all the same, then adding a generic function is fine.

I'll send you a patch for this.

> <snip>
> =

> >>> +OFONO_PLUGIN_DEFINE(wavecom_q, "Wavecom-Q driver", VERSION,
> >>> +		OFONO_PLUGIN_PRIORITY_DEFAULT, wavecom_q_init, wavecom_q_exit)
> >>
> >> Is there a way to just re-use the wavecom driver instead of creating a
> >> brand new one?
> > =

> > I didn't find any cleaner solution I could like, but if you propose any
> > other solution, I'll make it.
> =

> Right now to me it seems like the differences between the -Q version is
> a slightly different set of quirks.  Can't we query the model / firmware
> versions and set the quirks accordingly?

Is there any facility that ofono provides to do this? If so, please
point to some existing code.

Thank you.

--===============7722819277730336258==--

