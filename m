Content-Type: multipart/mixed; boundary="===============7432647569087004110=="
MIME-Version: 1.0
From: JH <jupiter.hce@gmail.com>
Subject: Re: Unsalble cellular connection
Date: Wed, 07 Aug 2019 20:27:26 +1000
Message-ID: <CAA=hcWQ9=UkLmxT-3oRQah8ArUBExz=khvGGt8sMSOD4gv-ogA@mail.gmail.com>
In-Reply-To: <CAKSBH7Fnrhdq8HAkD8TtEmfnauj9Je9A++wQzhksss=F3xDWXg@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7432647569087004110==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Giacinto,

Just got response from the hardware contractor.

On 8/3/19, Giacinto Cifelli <gciofono@gmail.com> wrote:
> Hi jupiter,

> This signal level is output periodically by ofono in a signal.
> You can try to catch all ofono signals (these are dbus events, not to
> be confused with signal level and network signaling) with
> dbus-monitor.
> But I think the signal is ok.
> Only the network disables the PDP context. maybe without informing the
> modem.
> This is done by several networks.
>
>> The trouble is it connected well at
>> startup, then dropped it, it is hard to convince the hardware
>> contractor it is hardware problem unless I have strong evidence that
>> is not the software problem.
>
> Ask uBlox how to capture a protocol stack trace, and if it is feasible
> for your application, do it and have it analyzed by uBlox.
>
> Are you on GSM, on LTE catM or on LTE NB-IOT when this happens? On
> which network operator and country?

It is LTE Cat-M1, the operator is Telstra in Australia. I will be very
interested in finding out what is going on.

Thank you.

Kind regards,

- jupiter

--===============7432647569087004110==--

