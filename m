Content-Type: multipart/mixed; boundary="===============2758875656752683532=="
MIME-Version: 1.0
From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Incoming sms problem on Motorola Droid 4
Date: Thu, 10 May 2018 08:58:56 +0200
Message-ID: <20180510065856.GA21093@amd>
In-Reply-To: <2A2ECEE1-A379-497D-B92D-54AB5E862066@holtmann.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2758875656752683532==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi!

> >>>>>> If I attempt to do AT+CNMA=3D1, AT+CNMA=3D0 or just plain At=3DCNM=
A, it does
> >>>>>> not like that, either, but with +CMS ERROR: 500.
> >>>>> =

> >>>>> CNMA=3D1 is required to work in PDU mode according to 27.005 btw.  =
How about:
> >>>>> =

> >>>>> window.open();
> >>>>> window.throw(modem);
> >>>> =

> >>>> Heh :-). Well, there are two phones with reasonable Linux support:
> >>>> N900 and Droid 4. N900 can't do voice calls of reasonable
> >>>> quality. That leaves Droid 4... so I'd really like it to work.
> >>> =

> >>> Is this actually an AT command modem or one of those modems where AT
> >>> commands were only bolted on for carrier certification?  Does it supp=
ort QMI
> >>> or something maybe?
> >> Ok, so ... this is complex. And maybe this is one of "those" modems.
> >> There's USB with AT commands, USB with QMI protocol, then serial with
> >> mux and U1234AT+XYZ commands.
> >> It seems Android uses serial, but that is being worked on, so I'm
> >> using AT commands for now.
> > =

> > Wow, okay.  You might want to try using the qmi driver family instead.
> =

> I would switch to QMI since then you can also ignore this weird multiplex=
er.

More explanation needed it seems:

I can already do USB with AT commands, no multiplexer needed. We'd
actually prefer to go over serial (with multiplexer), because USB
needs to be powered down in idle, and you still need communication
ovre serial to know that wakeup of USB is needed.

Yes, it is complex :-(.
									Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--===============2758875656752683532==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KVmVyc2lvbjogR251UEcgdjEKCmlFWUVBUkVD
QUFZRkFscno3YkFBQ2drUU1PZndhcFhiK3ZLcVh3Q2ZSZ1k4YlhHYk1SSzZnQm1XdmZrTmF6L24K
WUlVQW9KUWJIZmRDbjFoNmF0ZzR5Y3ZTOGtpM2llNlIKPU5uay8KLS0tLS1FTkQgUEdQIFNJR05B
VFVSRS0tLS0tCg==

--===============2758875656752683532==--

