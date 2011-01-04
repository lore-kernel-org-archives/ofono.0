Content-Type: multipart/mixed; boundary="===============4872012577261617231=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: Re: [PATCH] dbus: fix appending on dict for types other than string
Date: Tue, 04 Jan 2011 16:13:07 -0200
Message-ID: <AANLkTimLCUKC_+_qsHbs5-C9WVbEPax=D1KR2qEoUw2j@mail.gmail.com>
In-Reply-To: <1294163874.5852.102.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4872012577261617231==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 4, 2011 at 3:57 PM, Marcel Holtmann <marcel@holtmann.org> wro=
te:
> Hi Denis,
>
>> >>
>> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dbus_message_iter_append_bas=
ic(&entry, DBUS_TYPE_STRING,
>> >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0&(val_array[i + 0]));
>> >> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dbus_message_iter_append_basic(&e=
ntry, type,
>> >> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0&(val_array[i + 1]));
>> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (type =3D=3D DBUS_TYPE_STRING)=
 {
>> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dbus_=
message_iter_append_basic(&entry, type,
>> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&(val_array[i + 1]));
>> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {
>> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dbus_=
message_iter_append_basic(&entry, type,
>> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0val_array[i + 1]);
>> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>> >
>> > this does looks a bit hackish. Can you put it into context please. It
>> > might be that our call chain is wrong.
>> >
>>
>> We only ever needed (and thus ever added) support for string:string
>> dicts. =C2=A0E.g. ones that could be g_strfreev-ed. =C2=A0No other dicts=
 were
>> supported by this function.
>
> so it is the g_strfreev part that makes this hackish. Fine by me then,
> but we might need to comment on why string arrays in this case are
> special.

I don't think so. You use g_strfreev if you are using { string, string
} dict to free all strings. Why is this hackish?

Even if we had another interface that didn't required the g_strfreev,
the issue with calling dbus_message_iter_append_basic() would not
change once we continue using a void** to store pointers to different
types at the same time..


Lucas De Marchi

--===============4872012577261617231==--

