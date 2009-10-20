Content-Type: multipart/mixed; boundary="===============4991545220012868338=="
MIME-Version: 1.0
From: Ryan Raasch <ryan.raasch@gmail.com>
Subject: Re: [PATCH] When setting the serial port,
 the previous settings need to be preserved.
Date: Tue, 20 Oct 2009 17:51:20 +0200
Message-ID: <4ADDDC78.8030605@gmail.com>
In-Reply-To: <200910201013.52644.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4991545220012868338==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



Denis Kenzior wrote:
> Hi Ryan,
> =

>> Sorry. I have had a long few days. The last patch was just COMPLETELY
>> wrong :(
>>
>> I think i got it right this time...
> =

> So the patch is still wrong :)
> =

>  	memset(&ti, 0, sizeof(ti));
>  	cfmakeraw(&ti);
>  =

> +	fd =3D open(tty, O_RDWR | O_NOCTTY | O_NONBLOCK);
> +	if (fd < 0)
> +		return -1;
> +
> +	tcgetattr(fd,&ti);
> +
> =

> You're blowing away the result of cfmakeraw.  Most of the devices are not=
 true =

> serial devices and so do not need any of the special options.  Passing a =
NULL =

> options GHashTable should result in cfmakeraw.  Why don't you just pass a=
ll =

> the options you need instead of using tcgetattr?
> =


Should i just move the tcgetattr() to happen before cfmakeraw()?

> The other parts of the patch look good to me.

Ok. Why don't i just add the string options ("read", others...) in gattty.c?

Thanks,
Ryan
> =

> Regards,
> -Denis
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono

--===============4991545220012868338==--

