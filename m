Content-Type: multipart/mixed; boundary="===============7104609166016768267=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC] HFP support into oFono and BlueZ
Date: Sun, 17 Jan 2010 16:37:21 -0600
Message-ID: <201001171637.22263.denkenz@gmail.com>
In-Reply-To: <2d5a2c101001180338n2a37f0e9y76942650b755166@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7104609166016768267==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Luiz,

> having it as a MediaEndpoint I guess it is probably a good idea to
> have a similar design as we will have in endpoints, so the
> registration actually happen in adapter path rather than device path,
> which probably should avoid the having to resolve the device path
> while probing if we just send the device path as a parameter of
> NewConnection so we can do while in DEFER_SETUP stage so we don't risk
> missing or getting timeouts while transferring the the fd to ofono.

Personally I like this to be a per-device agent rather than per-adapter as =
it =

will make agent code inside oFono a bit easier to write.  Marcel / Johan, c=
are =

to weigh in?

Regards,
-Denis

--===============7104609166016768267==--

