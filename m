Content-Type: multipart/mixed; boundary="===============8137936509583266652=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: Unsalble cellular connection
Date: Fri, 02 Aug 2019 19:43:08 +0200
Message-ID: <CAKSBH7Fnrhdq8HAkD8TtEmfnauj9Je9A++wQzhksss=F3xDWXg@mail.gmail.com>
In-Reply-To: <CAA=hcWRsgAiz6YUVRkiFh8d6Aa_q6qdcw-5NtOerum-8vqaCbQ@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8137936509583266652==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi jupiter,

On Fri, Aug 2, 2019 at 12:46 PM JH <jupiter.hce@gmail.com> wrote:
>
> Hi Giacinto, thanks for your response.
>
> On 8/2/19, Giacinto Cifelli <gciofono@gmail.com> wrote:
> > Hi jupiter,
> > most likely the network dropped the context without signaling.
> > What kind of modem is it? And would you know also the chipset?
>
> It is uBlox SARA-R4 chipset,
not sur whether uBlox did this chipset.

> did you mean it could be caused by weak
> LTE signalling level? It is a prototype device, the hardware was
> designed by an contractor. Any simple way to show LTE signalling level
> in connman or ofono log files?
This signal level is output periodically by ofono in a signal.
You can try to catch all ofono signals (these are dbus events, not to
be confused with signal level and network signaling) with
dbus-monitor.
But I think the signal is ok.
Only the network disables the PDP context. maybe without informing the mode=
m.
This is done by several networks.

> The trouble is it connected well at
> startup, then dropped it, it is hard to convince the hardware
> contractor it is hardware problem unless I have strong evidence that
> is not the software problem.

Ask uBlox how to capture a protocol stack trace, and if it is feasible
for your application, do it and have it analyzed by uBlox.

Are you on GSM, on LTE catM or on LTE NB-IOT when this happens? On
which network operator and country?

>
> Thank you very much.
>
> Kind regards,
>
> - jupiter

BR,
Giacinto

--===============8137936509583266652==--

