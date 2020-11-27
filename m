Content-Type: multipart/mixed; boundary="===============0604558212005638039=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: Re: Failed to reconnect after 4G LTE signaling strength level is back
Date: Fri, 27 Nov 2020 07:53:56 +0100
Message-ID: <fac7c56a-a5e5-5c75-2857-4be345015aca@norrbonn.se>
In-Reply-To: <CAA=hcWRa0pe3fWUZKHrkFkbHLhHmcYdBtjPtB2WYdtzGDUNvwA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0604558212005638039==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 20/11/2020 00:39, Jupiter wrote:
> Hi,
> =

> I am running ofono version 1.30 for uBlox SARA-R4 QMI on iMX6, it is
> functional well, but there is one problem, it failed to be reconnected
> when the 4G LTE signaling strength level is back to normal. Here is
> what I tested:
> =

> - Connect antenna, it was running fine, network is connected.
> =

> - Remove the antenna, the network is down.
> =

> - Wait for a while, reconnect the antenna, the ofono could not
> reconnect, the driver was still there.
> =

> - If I restart ofnono the connection would be back.
> =

> I tested the same sequence on SARA EVK which is not running ofono, it
> is capable of re-register automatically.
> =

> Appreciate your sight comments if it is ofono issue or QMI issue or
> something else, please find the attached debug file.

You really need to annotate the log file because I can't see the problem =

you're describing there.

The log file shows the modem being reset a couple of times; there is no =

loss of signal before those events though.  My first thought was that =

you were crashing the modem while removing the antenna; however, it =

seems to me that the the reset is more controlled than that so it seems =

more likely that you are disabling the modem from some other program.

Like I said... annotate the logged events with some description of =

what's going on around them so that the problem can be debugged.

/Jonas

> =

> Thank you.
> =

> Kind regards,
> =

> - jupiter
> =

> =

> _______________________________________________
> ofono mailing list -- ofono(a)ofono.org
> To unsubscribe send an email to ofono-leave(a)ofono.org
>=20
--===============0604558212005638039==--

