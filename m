Content-Type: multipart/mixed; boundary="===============5253465341092516182=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] todo: ifxmodem apgs support
Date: Fri, 05 Nov 2010 20:10:32 +0100
Message-ID: <1288984232.9615.129.camel@aeonflux>
In-Reply-To: <1288979728-3369-5-git-send-email-robertino.benis@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5253465341092516182==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Robertino,

>  TODO |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
> =

> diff --git a/TODO b/TODO
> index a5196f7..7ee7920 100644
> --- a/TODO
> +++ b/TODO
> @@ -484,3 +484,8 @@ Miscellaneous
>  =

>    Priority: Low
>    Complexity: C4
> +
> +- Modem support:  adding support for agps in Infenion modem driver.
> +
> +  Priority: High
> +  Complexity: C3

I was expecting to have a section for Modem support. So something like
this:

Modem support
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

- Infineon modem: Add support ...

Please run your patches through a spellchecker. It is Infineon and
either Assisted GPS or aGPS. And sentences should start with a capital
letter. There are still a few tasks in the TODO. So you have some
examples on how we expect the format.

The key point is consistency. Be it in the documentation, the TODO file
or the source code itself.

Please be also a bit more descriptive with the TODO entry so that others
have an idea what it entails.

Also please don't invent your own complexity types. The TODO file has an
introduction section that describes it pretty clearly.

I say this complexity task is clearly only a C1.

For the priority, this is a general overall oFono priority scale. So all
modem support items should be a Low. It has nothing to do with product
schedules or anything alike.

And please also add an Owner for the entry. That would be you in this
case.

Regards

Marcel



--===============5253465341092516182==--

