Content-Type: multipart/mixed; boundary="===============0748461006117484811=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] Checking PIN length based on its type (PIN / PUK / NET).
Date: Fri, 19 Mar 2010 10:03:38 -0500
Message-ID: <201003191003.38959.denkenz@gmail.com>
In-Reply-To: <80fd4e751003190801h1369413by1ecffe1f3db05bd5@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0748461006117484811==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

> 2010/3/19  <ppessi@gmail.com>:
> > -       if (!strcmp(new, old))
> > +       if (!strcmp(new, old, PIN_TYPE_PIN))
> >                return dbus_message_new_method_return(msg);
> =

> I could have sworn I compiled and run the code, but then probably not.
> =


Just resend the patch ;)

Regards,
-Denis

--===============0748461006117484811==--

