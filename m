Content-Type: multipart/mixed; boundary="===============1067124639012621000=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Trouble compiling ... Re: ofono fails to compile on gcc-6.3
Date: Sat, 29 Dec 2018 15:08:56 -0600
Message-ID: <4bfc197c-f75c-89b3-09c2-2795978a33a4@gmail.com>
In-Reply-To: <20181229203046.GA1949@amd>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1067124639012621000==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

On 12/29/2018 02:30 PM, Pavel Machek wrote:
> Hi!
> =

>>>>    CC       drivers/rilmodem/network-registration.o
>>>>    drivers/rilmodem/network-registration.c:40:32: error: unknown option
>>>>    after =E2=80=98#pragma GCC diagnostic=E2=80=99 kind [-Werror=3Dprag=
mas]
>>>>     #pragma GCC diagnostic ignored "-Wrestrict"
>>>> cc1: error: unrecognized command line option =E2=80=98-Wno-format-trun=
cation=E2=80=99
>>>>    [-Werror]
>>>>    cc1: all warnings being treated as errors
>>>>
>>>> I commented out #pragma, and this allows compilation to
>>>> continue... until I hit same issue in
>>>> drivers/rilmodem/call-forwarding.c:41:32:
>>
>> Yeah, I'm not sure what to do with these.  Marcel put in the #pragmas to
>> silence some warnings on GCC 8.x, but it seems GCC 6 doesn't know about
>> these #pragma directives and complains.
> =

> /* Test for GCC > 3.2.0 */
> #if __GNUC__ > 3 || \
>      (__GNUC__ =3D=3D 3 && (__GNUC_MINOR__ > 2 || \
>                             (__GNUC_MINOR__ =3D=3D 2 && \
> 			                           __GNUC_PATCHLEVEL__
> 						   > 0))
> #pragma...
> #endif
> =

> ?

Marcel is taking care of the build system so I let him comment, but that =

would be fine with me.  Maybe you want to send something like this to =

the list as a patch?

Of course the real fix is to rewrite rilmodem properly so none of this =

is needed...

> Would it be possible to get reasonable error message when ell is not
> found?
> =

> "ell not found, you need to install it, please see README file"? It
> took me a while to figure out...
> =


Sounds like a good idea.  Marcel?

Regards,
-Denis

--===============1067124639012621000==--

