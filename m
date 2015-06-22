Content-Type: multipart/mixed; boundary="===============5005315558838893713=="
MIME-Version: 1.0
From: Tommi Kenakkala <tommi.kenakkala@tieto.com>
Subject: Re: ofono Digest, Vol 74, Issue 7
Date: Mon, 22 Jun 2015 16:50:24 +0300
Message-ID: <558812A0.9010604@tieto.com>
In-Reply-To: <mailman.1.1434654002.31324.ofono@ofono.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5005315558838893713==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 18.06.2015 22:00, ofono-request(a)ofono.org wrote:
> Date: Wed, 17 Jun 2015 23:07:53 -0500
 > From: Denis Kenzior
> <denkenz@gmail.com> To: ofono(a)ofono.org Cc: tommi.kenakkala(a)tieto.c=
om
> Subject: Re: [PATCH 1/2] [sim] Emit LockedPins after pin_type is queried
> Message-ID: <55824419.5080703@gmail.com> Content-Type: text/plain;
> charset=3DISO-8859-1; format=3Dflowed
...
> There is a subtlety here.  OFONO_SIM_PASSWORD_NONE is never considered
> when emitting LockedPins.  However, in this proposal you can trigger a
> LockedPins emission even if there's no PIN set.
>
> To me it seems like emitting LockedPins with an empty value seems
> unnecessary.  Thoughts?
...
 > Regards,
 > -Denis

I agree. Initially there was a though but now I don't see any extra =

value on emitting it. Updated patch submitted.
Thanks,
-- =

Tommi

--===============5005315558838893713==--

