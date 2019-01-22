Content-Type: multipart/mixed; boundary="===============7233247411722960256=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Trouble compiling ... Re: ofono fails to compile on gcc-6.3
Date: Tue, 22 Jan 2019 18:07:21 +0100
Message-ID: <AB4976F8-D872-433A-A242-283C84AB997C@holtmann.org>
In-Reply-To: <4bfc197c-f75c-89b3-09c2-2795978a33a4@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7233247411722960256==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

>>>>>   CC       drivers/rilmodem/network-registration.o
>>>>>   drivers/rilmodem/network-registration.c:40:32: error: unknown option
>>>>>   after =E2=80=98#pragma GCC diagnostic=E2=80=99 kind [-Werror=3Dprag=
mas]
>>>>>    #pragma GCC diagnostic ignored "-Wrestrict"
>>>>> cc1: error: unrecognized command line option =E2=80=98-Wno-format-tru=
ncation=E2=80=99
>>>>>   [-Werror]
>>>>>   cc1: all warnings being treated as errors
>>>>> =

>>>>> I commented out #pragma, and this allows compilation to
>>>>> continue... until I hit same issue in
>>>>> drivers/rilmodem/call-forwarding.c:41:32:
>>> =

>>> Yeah, I'm not sure what to do with these.  Marcel put in the #pragmas to
>>> silence some warnings on GCC 8.x, but it seems GCC 6 doesn't know about
>>> these #pragma directives and complains.
>> /* Test for GCC > 3.2.0 */
>> #if __GNUC__ > 3 || \
>>     (__GNUC__ =3D=3D 3 && (__GNUC_MINOR__ > 2 || \
>>                            (__GNUC_MINOR__ =3D=3D 2 && \
>> 			                           __GNUC_PATCHLEVEL__
>> 						   > 0))
>> #pragma...
>> #endif
>> ?
> =

> Marcel is taking care of the build system so I let him comment, but that =
would be fine with me. Maybe you want to send something like this to the li=
st as a patch?
> =

> Of course the real fix is to rewrite rilmodem properly so none of this is=
 needed...
> =

>> Would it be possible to get reasonable error message when ell is not
>> found?
>> "ell not found, you need to install it, please see README file"? It
>> took me a while to figure out...
> =

> Sounds like a good idea.  Marcel?

we can try to improve the ELL detection especially since we now have intern=
al vs external. However I need to look into this for all projects and not j=
ust oFono. So we might start with iwd here.

Regards

Marcel


--===============7233247411722960256==--

