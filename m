Content-Type: multipart/mixed; boundary="===============5444545061293171950=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Unable to use DataConnectionManager
Date: Tue, 18 May 2010 04:43:59 -0500
Message-ID: <201005180443.59221.denkenz@gmail.com>
In-Reply-To: <24A9345B397CD24AA76A4E82E2379565317D9CFEC0@XCHTS.tmt.telital.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5444545061293171950==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Daniele,

> Hi Denis,
> =

> >Since telit devices have not been properly integrated yet I assume you're
> >using the atgen driver, correct?
> =

> Correct, I am using the atgen driver. I'm planning to add support for Tel=
it
>  devices, but first I would like to see how the atgen driver behaves.

That would be great! I have a Telit UC864 but never had enough time to enab=
le =

it properly.

> =

> >The atgen driver would need generic PPP context support to enable GPRS
> >properly.  This is something that is not quite ready in oFono today.  Th=
is
> > is why the atgen driver does not enable support for GPRS.
> >
> >If you want you can try to enable this in the atgen driver and try it ou=
t,
> > but the code is still highly experimental.
> =

> Ok, if you tell me how I can give it a try and make some tests. Is it
>  possible to use 0.20 version or should I use the GIT tree?

You would need to use the git tree.  Simply add the following lines to atge=
n's =

post_sim function:
        gprs =3D ofono_gprs_create(modem, 0, "atmodem", data->chat);
        gc =3D ofono_gprs_context_create(modem, 0, "atmodem", data->chat);

        if (gprs && gc)
                ofono_gprs_add_context(gprs, gc);

See plugins/phonesim.c for an example.

Regards,
-Denis

--===============5444545061293171950==--

