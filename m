Content-Type: multipart/mixed; boundary="===============7077259084258842397=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: [PATCH] src/modem: connection timeout to 60 seconds
Date: Tue, 23 Oct 2018 10:40:07 +0200
Message-ID: <CAKSBH7FvFdN4Eiv0pFFgWC5EhjEKwM8Wf77ZMare7UZmpc_XiQ@mail.gmail.com>
In-Reply-To: <b1046725-7e10-8fb1-f654-6e4f4fff3bb2@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7077259084258842397==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Oct 23, 2018 at 10:34 AM Jonas Bonn <jonas@norrbonn.se> wrote:
>
> Hi,
>
> Do the USB interfaces show up long before the modem is ready to accept
> AT commands?  Or do the AT commands take a long time to complete?

The USB shows up long before the modem is ready to accept AT commands,
and - if supported - the MBIM OPEN takes a long time to complete.

>
> /Jonas

Giacinto

>
> On 23/10/18 09:50, Giacinto Cifelli wrote:
> > Changed the connection timeout to 60 seconds (from 20 seconds),
> > to accomodate for chipset that take time to boot-up.
> > ---
> >   src/modem.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/src/modem.c b/src/modem.c
> > index 124a5192..e7978bb0 100644
> > --- a/src/modem.c
> > +++ b/src/modem.c
> > @@ -1060,7 +1060,7 @@ static DBusMessage *set_property_lockdown(struct =
ofono_modem *modem,
> >               }
> >
> >               modem->pending =3D dbus_message_ref(msg);
> > -             modem->timeout =3D g_timeout_add_seconds(20,
> > +             modem->timeout =3D g_timeout_add_seconds(60,
> >                                               set_powered_timeout, mode=
m);
> >               return NULL;
> >       }
> > @@ -1138,7 +1138,7 @@ static DBusMessage *modem_set_property(DBusConnec=
tion *conn,
> >                               return __ofono_error_failed(msg);
> >
> >                       modem->pending =3D dbus_message_ref(msg);
> > -                     modem->timeout =3D g_timeout_add_seconds(20,
> > +                     modem->timeout =3D g_timeout_add_seconds(60,
> >                                               set_powered_timeout, mode=
m);
> >                       return NULL;
> >               }
> >

--===============7077259084258842397==--

