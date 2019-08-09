Content-Type: multipart/mixed; boundary="===============5837155676581633954=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: Unsalble cellular connection
Date: Fri, 09 Aug 2019 05:59:32 +0200
Message-ID: <CAKSBH7Fy-sPKYLMxXw0bK9He7E2u1tu=b9y8cbOrRVyokFEYjA@mail.gmail.com>
In-Reply-To: <CAA=hcWQ9=UkLmxT-3oRQah8ArUBExz=khvGGt8sMSOD4gv-ogA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5837155676581633954==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Aug 7, 2019 at 12:27 PM JH <jupiter.hce@gmail.com> wrote:
>
> Hi Giacinto,
>
> Just got response from the hardware contractor.
>
> On 8/3/19, Giacinto Cifelli <gciofono@gmail.com> wrote:
> > Hi jupiter,
>
> > This signal level is output periodically by ofono in a signal.
> > You can try to catch all ofono signals (these are dbus events, not to
> > be confused with signal level and network signaling) with
> > dbus-monitor.
> > But I think the signal is ok.
> > Only the network disables the PDP context. maybe without informing the
> > modem.
> > This is done by several networks.
> >
> >> The trouble is it connected well at
> >> startup, then dropped it, it is hard to convince the hardware
> >> contractor it is hardware problem unless I have strong evidence that
> >> is not the software problem.
> >
> > Ask uBlox how to capture a protocol stack trace, and if it is feasible
> > for your application, do it and have it analyzed by uBlox.
> >
> > Are you on GSM, on LTE catM or on LTE NB-IOT when this happens? On
> > which network operator and country?
>
> It is LTE Cat-M1, the operator is Telstra in Australia. I will be very
> interested in finding out what is going on.

you need stack traces.
Most likely the chipset you are using is the MDM9205, so the trace will be =
QXDM.

>
> Thank you.
>
> Kind regards,
>
> - jupiter

BR,
Giacinto

--===============5837155676581633954==--

