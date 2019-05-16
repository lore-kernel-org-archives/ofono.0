Content-Type: multipart/mixed; boundary="===============1833477072330792635=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: [RFC at-export 2/2] ublox: network-registration atom
Date: Thu, 16 May 2019 19:03:55 +0200
Message-ID: <CAKSBH7FCBQ=D27K8AjatQ51-yp2=y3d2_wQdYkh_-idvHZ==SA@mail.gmail.com>
In-Reply-To: <9aabfacb-6de4-6b7f-8a8a-a946c99d21b0@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1833477072330792635==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Thu, May 16, 2019 at 6:01 PM Denis Kenzior <denkenz@gmail.com> wrote:
>
> Hi Richard,
>
> >> So I think there's a bug where we erroneously set the Attached property
> >> to False in this situation.  It doesn't look like we trigger an actual
> >> detach, but Attached should remain 'True' while CREG shows that we're =
on
> >> EUTRAN or any related tech.  Perhaps the logic in gprs_attached_update=
()
> >> needs to be updated.
> >
> > We need to consider the "tricky" part that we consider us attached
> > first when the
> >   context is activated in EUTRAN. And we might be in a transition
> > (attaching flag).
>
> Which is why the whole 'separate context state into a bazillion
> commands' is just inherently a bad idea on 3GPP's part.  It makes it
> hard to figure out wtf just happened in an atomic way.
>

I find it a bit pathetic blaming the 3GPP for the limitations of an
old design (I did not say obsolete).

3GPP stakeholders (mainly MNOs) wanted to uncouple the technologies,
to avoid the mega
spaghetti soup of GSM+GPRS+UTRAN, and also to allow to launch the
technologies without carrying the bag of the legacy.
It is the same with the NR, that has a C5GREG indicator.
Also the chipset vendors could take advantage of this, implementing
independent stacks, and so easier-to-maintain firmwares.
This is done on purpose, and the transaction period shall be handled
by flexible enough software.

> I think we already have some magic where we only signal Attached once
> the default bearer settings are read, e.g. after .read_settings
> completes successfully.  The second part will be tricky...
>
> >
> > I'm thinking if the "combined" state in gprs wouldn't be the least
> > intrusive update for this.
> >
> > I think I saw a patch for using c*reg in atmodem/gprs.c, can we wake th=
at up?
> > Otherwise I can put some energy into this, if we decide which
> > direction to go first.
> >
>
> Since 3GPP decided to go with EREG being separate from CGREG, I think it
> makes sense to support that natively in lte.c or gprs.c.  Our philosophy
> has always been to base the driver APIs off of 27.007.  So from that
> perspective, introducing ofono_lte_status_notify would make sense.
> Whether something like this makes things easier or not is a different
> question :)

 I did propose something long time ago (in gprs.c), and was more or
less ok, except that the logic should
have been in the core atom, because it is reusable and definitely complex.

Then I didn't go further because anyway your small 80 chars screen
couldn't allow for AT+MBIM driver,
effectively cutting off most of Gemalto (now Thales) new generation of modu=
les.
But the proposal and discussion is still in the history.

>
> Regards,
> -Denis
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> https://lists.ofono.org/mailman/listinfo/ofono

Regards,
Giacinto

--===============1833477072330792635==--

