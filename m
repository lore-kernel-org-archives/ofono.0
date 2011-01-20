Content-Type: multipart/mixed; boundary="===============2765931041184688787=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: [RFC] TODO: Move signal strength property to separate Agent API.
Date: Thu, 20 Jan 2011 12:44:17 +0200
Message-ID: <AANLkTim8A3zFQEu+3O0p+Q5V_YBy38hPNXKApjR1cQUp@mail.gmail.com>
In-Reply-To: <1295519732.3873.269.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2765931041184688787==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

2011/1/20 Marcel Holtmann <marcel@holtmann.org>:
> I don't think is needed. You do not get woken up until you tell D-Bus to
> wake you up on that PropertyChanged signal. You can even match the first
> parameter of that signal if you desire.

I think this is still a worthy optimization, because this way not even
oFono will wake up unnecessarily.

> What we might should ensure is that we delay the signal reporting from
> the modem. In case it wants to play ping-pong between two values. We
> have done that for ConnMan in the past since WiFi signals are also kinda
> flaky and made the UI go nuts.

Personally, I would just move to reporting the strength value in 0...5
bars. Most UIs I've seen report bars in their UIs, and this way these
clients will get woken up much more infrequently.

In addition if percentage is really required, we could offer that as a
separate signal, but to instruct to use with caution. Or put it in a
plugin. :)

Cheers,
Aki

> Regards
>
> Marcel
>
>
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono
>

--===============2765931041184688787==--

