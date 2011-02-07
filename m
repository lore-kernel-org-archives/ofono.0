Content-Type: multipart/mixed; boundary="===============2605154035118840716=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] voicecall: fix transfer
Date: Mon, 07 Feb 2011 16:00:41 -0600
Message-ID: <4D506B89.5050701@gmail.com>
In-Reply-To: <AANLkTik2cQV=xUygaK8Q-5Fdt=UuyyQ93tLAG0kqJEE0@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2605154035118840716==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andre,

On 02/07/2011 03:48 PM, andre matos wrote:
> Hi Denis,
> =

> On Mon, Feb 7, 2011 at 10:30 PM, Denis Kenzior <denkenz@gmail.com
> <mailto:denkenz@gmail.com>> wrote:
> =

>     Hi Andre,
> =

>     > Are we reading the same code?
>     >
>     > for this case we have:
>     > numactive !=3D 1  =3D=3D> true
>     > numheld !=3D 1  =3D=3D> false
>     >
>     > (numactive !=3D 1) && (numheld !=3D 1)  =3D=3D>  false
>     >
> =

>     Then shouldn't the patch simply be modified to if (numactive !=3D 1 ||
>     numheld !=3D 1)?
> =

> =

> Yes, if you wish to sacrifice readability for simplicity.
> =


Don't get too offended, the || was intended instead of && in the first
place.  My brain just had wired crossed and I wasn't seeing why you
needed a 6 line patch to fix this.

> I find my version self explanatory.
> =


Sorry, but I do not find your style more readable, less actually. Also,
when submitting patches please follow our coding style guidelines.  You
had at least 1 style violation, namely rule M4.

Regards,
-Denis

--===============2605154035118840716==--

