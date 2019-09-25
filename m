Content-Type: multipart/mixed; boundary="===============1367384004680432456=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: Re: [PATCH v2 1/1] ublox: rework device initialization sequence
Date: Wed, 25 Sep 2019 08:47:09 +0200
Message-ID: <880633c3-1a55-ba5f-80e2-59a1858401ad@norrbonn.se>
In-Reply-To: <CAHB-PjnNh4x8EwyWX0MKNvUnRZLWta0BRjpVBRZaNkARRPzcBA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1367384004680432456==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



On 25/09/2019 08:40, Richard R=C3=B6jfors wrote:
> Den tis 24 sep. 2019 kl 21:55 skrev Pavel Machek <pavel@ucw.cz =

> <mailto:pavel@ucw.cz>>:
> =

>     On Tue 2019-09-24 18:01:26, Jonas Bonn wrote:
>      > uBlox devices present their USB interfaces well before those
>     interfaces
>      > are ready to respond to any commands.=C2=A0 The documentation says=
 to
>     monitor
>      > the 'greeting text' to detect readiness, but this 'greeting text'
>     is not
>      > actually specified for any device other than the TOBY L4.
> =

>     Collecting "greeting texts" from all the modems we want to support
>     should not be hard, right?

...given that one has access to all the devices!

Honestly, I suspect the documentation is garbage.  There are no greeting =

texts for devices other than the L4; probing is just a matter of waiting =

for AT to respond to with OK.

> =

> =

> I don't think that's a good idea. What if ofono is restated and the =

> modem is still running?

In this case, the TOBY-L4 does not provide a greeting text.

/Jonas


> =

> --Richard

--===============1367384004680432456==--

