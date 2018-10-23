Content-Type: multipart/mixed; boundary="===============1537453102951033529=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: [PATCH] src/modem: connection timeout to 60 seconds
Date: Tue, 23 Oct 2018 11:26:37 +0200
Message-ID: <CAKSBH7FhE7LKByNODgqqXQTdna37_f6cVxPvSY5PxnG3kwKYfA@mail.gmail.com>
In-Reply-To: <f7c39658-a7b4-3318-6e39-aa7763187251@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1537453102951033529==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas
>
> This is where I think adding a data item in udevng would be in order.
> ...set_int(..., "PoweredTimeout", 60)... or something like that.  It's a
> device quirk, after all.  I've dealt with modems that were slow to boot,
> but usually they don't present the USB interfaces until they are ready
> to go.

I had in mind a plugin function that would return the timeout it needs
(to be called between .probe and .enable), something like .get_params.

Your parameter should be set in a udev rule, otherwise it would apply
to all modems connected, and so it is marginally better than the
current hardcoding.
Adding udev rules is tedious, USB devices are supposed to work 'out of
the box', without manual tweaks.

So, eventually it is easier to just increase the timeout :)

Regards,
Giacinto

>
> /Jonas
>
> >>
> >> /Jonas
> >
> > Giacinto
> >
> >>
> >> On 23/10/18 09:50, Giacinto Cifelli wrote:
> >>> Changed the connection timeout to 60 seconds (from 20 seconds),
> >>> to accomodate for chipset that take time to boot-up.
> >>> ---
> >>>    src/modem.c | 4 ++--
> >>>    1 file changed, 2 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/src/modem.c b/src/modem.c
> >>> index 124a5192..e7978bb0 100644
> >>> --- a/src/modem.c
> >>> +++ b/src/modem.c
> >>> @@ -1060,7 +1060,7 @@ static DBusMessage *set_property_lockdown(struc=
t ofono_modem *modem,
> >>>                }
> >>>
> >>>                modem->pending =3D dbus_message_ref(msg);
> >>> -             modem->timeout =3D g_timeout_add_seconds(20,
> >>> +             modem->timeout =3D g_timeout_add_seconds(60,
> >>>                                                set_powered_timeout, m=
odem);
> >>>                return NULL;
> >>>        }
> >>> @@ -1138,7 +1138,7 @@ static DBusMessage *modem_set_property(DBusConn=
ection *conn,
> >>>                                return __ofono_error_failed(msg);
> >>>
> >>>                        modem->pending =3D dbus_message_ref(msg);
> >>> -                     modem->timeout =3D g_timeout_add_seconds(20,
> >>> +                     modem->timeout =3D g_timeout_add_seconds(60,
> >>>                                                set_powered_timeout, m=
odem);
> >>>                        return NULL;
> >>>                }
> >>>

--===============1537453102951033529==--

