Content-Type: multipart/mixed; boundary="===============3962956767585097989=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@norrbonn.se>
Subject: Re: [PATCH 1/1] Remove superfluous definitions of _GNU_SOURCE
Date: Wed, 17 Oct 2018 18:32:20 +0200
Message-ID: <a89f93d2-f1c7-e231-258e-50f8dd2f54c6@norrbonn.se>
In-Reply-To: <0c3424d8-7346-3db7-3161-ba70a80723c2@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3962956767585097989==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 17/10/18 17:03, Denis Kenzior wrote:
> Hi Jonas,
> =

> On 10/17/2018 05:23 AM, Jonas Bonn wrote:
>> There are a large number of files in the tree that define _GNU_SOURCE
>> despite not actually using features hidden behind this flag.=C2=A0 This =
patch
>> removes all these definitions in one fell swoop...
>> ---
>>
>> I realize that it's not quite kosher in ofono to send pathes that touch
>> more than directory.=C2=A0 Breaking this up into separate patches doesn't
>> really make sense though, given its nature.=C2=A0 If the list insists,
>> though, I can break this up into a series of ~50 patches...
>>
> =

> Yes, fair enough.=C2=A0 But:
> =

> drivers/mbimmodem/mbim.c: In function =E2=80=98receive_header=E2=80=99:
> drivers/mbimmodem/mbim.c:423:16: error: implicit declaration of function =

> =E2=80=98TEMP_FAILURE_RETRY=E2=80=99 [-Werror=3Dimplicit-function-declara=
tion]
>  =C2=A0 ssize_t len =3D TEMP_FAILURE_RETRY(read(fd,
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ^~~~~~~~~~~~~~~~~~
> =

> =

> tools/tty-redirector.c: In function =E2=80=98accept_handler=E2=80=99:
> tools/tty-redirector.c:249:8: error: implicit declaration of function =

> =E2=80=98accept4=E2=80=99; did you mean =E2=80=98accept=E2=80=99? [-Werro=
r=3Dimplicit-function-declaration]
>  =C2=A0 nfd =3D accept4(fd, (struct sockaddr *) &addr, &addrlen, SOCK_CLO=
EXEC);
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^~~~~~~
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 accept
> =

> =


Right.  mbim and tools are not in my configuration...

> Anyway, I was nice and fixed these for you.=C2=A0 It compiles cleanly for=
 me =

> and I applied this patch.


Thanks.  Good of you!

/Jonas

> =

> Regards,
> -Denis

--===============3962956767585097989==--

