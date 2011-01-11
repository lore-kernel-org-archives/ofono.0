Content-Type: multipart/mixed; boundary="===============5702327121572586889=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCHv5] plugin: Add ste modem initd integration
Date: Tue, 11 Jan 2011 15:56:14 -0600
Message-ID: <4D2CD1FE.4070601@gmail.com>
In-Reply-To: <1294782756.3873.37.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5702327121572586889==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

On 01/11/2011 03:52 PM, Marcel Holtmann wrote:
> Hi Sjur,
> =

>>> so these are declared as get_modems(void) btw. The compiler should have
>>> warned you about this.
>>
>> I don't get a compiler warning for this one, not even with -Wall
>> -Wextra -Wpedantic on GCC 4.4.3.
>> But a new rule in the coding-style should perhaps be added, e.g:
>>
>> M15: Use void if function has no parameters
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> A function with no parameters must use void in the parameter list.
>> Example:
>> 1)
>> void foo(void)
>> {
>> }
>>
>> 2)
>> void foo()	// Wrong
>> {
>> }
> =

> please go ahead and send a patch for this. I am happily adding it.
> =


Sorry I'm not following why this is a good idea?

Regards,
-Denis

--===============5702327121572586889==--

