Content-Type: multipart/mixed; boundary="===============3032102091631240541=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] dbus: fix appending on dict for types other than string
Date: Tue, 04 Jan 2011 10:56:13 -0800
Message-ID: <1294167373.5852.104.camel@aeonflux>
In-Reply-To: <AANLkTimLCUKC_+_qsHbs5-C9WVbEPax=D1KR2qEoUw2j@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3032102091631240541==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lucas,

> >> >>
> >> >>            dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING,
> >> >>                                            &(val_array[i + 0]));
> >> >> -          dbus_message_iter_append_basic(&entry, type,
> >> >> -                                          &(val_array[i + 1]));
> >> >> +          if (type =3D=3D DBUS_TYPE_STRING) {
> >> >> +                  dbus_message_iter_append_basic(&entry, type,
> >> >> +                                                  &(val_array[i + =
1]));
> >> >> +          } else {
> >> >> +                  dbus_message_iter_append_basic(&entry, type,
> >> >> +                                                  val_array[i + 1]=
);
> >> >> +          }
> >> >
> >> > this does looks a bit hackish. Can you put it into context please. It
> >> > might be that our call chain is wrong.
> >> >
> >>
> >> We only ever needed (and thus ever added) support for string:string
> >> dicts.  E.g. ones that could be g_strfreev-ed.  No other dicts were
> >> supported by this function.
> >
> > so it is the g_strfreev part that makes this hackish. Fine by me then,
> > but we might need to comment on why string arrays in this case are
> > special.
> =

> I don't think so. You use g_strfreev if you are using { string, string
> } dict to free all strings. Why is this hackish?
> =

> Even if we had another interface that didn't required the g_strfreev,
> the issue with calling dbus_message_iter_append_basic() would not
> change once we continue using a void** to store pointers to different
> types at the same time..

the append_basic D-Bus function works fine on **char and *uint8. So
either a pointer to a string (*char) or pointer to a byte (uint8.

You differentiate between pointer to a string and pointer to a byte in
that function. So it is different since normally it is the caller that
has to give the right pointer in the first place.

Regards

Marcel



--===============3032102091631240541==--

