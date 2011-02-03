Content-Type: multipart/mixed; boundary="===============8383600958286862231=="
MIME-Version: 1.0
From: Andreas WESTIN <andreas.westin@stericsson.com>
Subject: Re: [PATCH v2 3/3] isimodem: header updates for ISI2.5
Date: Thu, 03 Feb 2011 10:32:17 +0100
Message-ID: <4D4A7621.6030508@stericsson.com>
In-Reply-To: <1296651827.2619.119.camel@tucson>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8383600958286862231==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Aki,

On 2011-02-02 14:03, Aki Niemi wrote:
> I don't see what that has to do with the device supporting the "PC
> suite" USB profile, which allows modem access using cdc_phonet.

Currently our platform does not support this.

> That is exactly what I meant. This version allows building quirks inside
> the drivers. An example in pseudo-code:
>
> if GIsiVersion.major =3D=3D 15 and GIsiVersion.minor>=3D 3:
> 	send( { FOO, value, filler, filler}, callback1 )
> else:
> 	send( { FOO, value }, callback2 )
>

Yes, we use a similar solution in gisi, but R=C3=A9mi pointed out that it =

would be a maintenance problem once there are more versions to support =

and I tend to agree. A solution could be to use a lookup function, but =

this function would need to return something to compare with, an enum =

perhaps.
Also are you certain that e.g major =3D=3D 15 and minor =3D=3D 25 is still =
the =

same ISI version, if not then the lookup function could become messy.

Regards
Andreas

--===============8383600958286862231==--

