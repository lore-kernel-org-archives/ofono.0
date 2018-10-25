Content-Type: multipart/mixed; boundary="===============7585222708379972458=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: [PATCH 1/1] gprs: detach from PS domain only if needed
Date: Thu, 25 Oct 2018 05:24:23 +0200
Message-ID: <CAKSBH7Er3-WG609Ekm=Qt=UbD0r4RJshy2kgPrQwaoDVEBwPwA@mail.gmail.com>
In-Reply-To: <63639d49-4fdf-d4b3-175b-f2aa3ea6d96d@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7585222708379972458==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Thu, Oct 25, 2018 at 5:15 AM Denis Kenzior <denkenz@gmail.com> wrote:
>
> Hi Giacinto,
>
> On 10/24/2018 09:58 PM, Giacinto Cifelli wrote:
> > Hi Denis,
> >
> >>
> >> So the ideal situation would be to turn all this off for LTE based
> >> dongles, have the ability to tell the modem not to auto-attach on 3G/2=
G,
> >> and maybe even attach only controlling 3G/2G PS domain only, not LTE.
> >>
> >
> > this is not possible, and there are all the Hand-over scenarios, for
> > example during a CSFB call, or loss of LTE coverage.
>
> What exactly is impossible?  a CSFB call goes onto the CS domain, so
> there should be no problem going from LTE -> CS only, no?

The module and network are supposed to transfer the active PDP
contexts to the fallback technology.
I have seen some modem suspending them instead (because of their
limitations), but it is not what the standard requires.

>
> >
> > It seems strange how LTE works because it is often overlooked that it
> > is just the GPRS part of 2G/3G,
> > with a small difference at the registration phase, which also performs
> > the attach (hence it is called combined attach).
>
> Yes, but roaming is also completely different with LTE and many of these
> weird historical billing quirks no longer apply.
>
> >
> > Maybe it is really worth to start an ofono 2.x branch and remove this
> > roaming control on the attach.
>
> Perhaps, but I wouldn't mind attempting to work around this without
> major surgery.  If we can't, then we can't, but lets not give up yet.
>
> > Or, more conservative, add another variable for how to control
> > roaming: attach or context activation (that can be applied also to
> > LTE).
>
> That is along the lines of what I was thinking...
>
> > And decide globall, in the plug-in for the modem, or
> > subscription-based how to set this second variable (possibly all 3,
> > with overrides).
>
> Feel free to propose something

Cool, I will work on it soon.

>
> Regards,
> -Denis

Regards,
Giacinto

--===============7585222708379972458==--

