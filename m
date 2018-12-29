Content-Type: multipart/mixed; boundary="===============7350689992643226191=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Trouble compiling ... Re: ofono fails to compile on gcc-6.3
Date: Sat, 29 Dec 2018 14:20:48 -0600
Message-ID: <53dd54d0-9b4d-739f-ef1c-e0268998b29c@gmail.com>
In-Reply-To: <20181229095322.GB15358@amd>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7350689992643226191==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

>>
>>    CC       drivers/rilmodem/network-registration.o
>>    drivers/rilmodem/network-registration.c:40:32: error: unknown option
>>    after =E2=80=98#pragma GCC diagnostic=E2=80=99 kind [-Werror=3Dpragma=
s]
>>     #pragma GCC diagnostic ignored "-Wrestrict"
>> cc1: error: unrecognized command line option =E2=80=98-Wno-format-trunca=
tion=E2=80=99
>>    [-Werror]
>>    cc1: all warnings being treated as errors
>>
>> I commented out #pragma, and this allows compilation to
>> continue... until I hit same issue in
>> drivers/rilmodem/call-forwarding.c:41:32:

Yeah, I'm not sure what to do with these.  Marcel put in the #pragmas to =

silence some warnings on GCC 8.x, but it seems GCC 6 doesn't know about =

these #pragma directives and complains.

> =

> Plus there's new one:
>    CC       drivers/rilmodem/sim.o
>    drivers/rilmodem/sim.c: In function =E2=80=98ril_file_io_cb=E2=80=99:
>    drivers/rilmodem/sim.c:381:49: warning: passing argument 2 of
>    =E2=80=98l_util_from_hexstring=E2=80=99 from incompatible pointer type
>      response =3D l_util_from_hexstring(hex_response, &len);
>                                                       ^
> 						     In file included
>    from ./ell/ell.h:1:0,
>                     from drivers/rilmodem/sim.c:34:
> 		   ./ell/util.h:271:16: note: expected =E2=80=98size_t *=E2=80=99 but
>    argument is of type =E2=80=98long int *=E2=80=99
>     unsigned char *l_util_from_hexstring(const char *str, size_t
>    *out_len);
>                    ^

Ah darn, thought I got them all but seems I missed one.  Should be fixed =

now.

Regards,
-Denis

--===============7350689992643226191==--

