Content-Type: multipart/mixed; boundary="===============6403021928481591358=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: Re: [PATCH] dbus: fix appending on dict for types other than string
Date: Tue, 04 Jan 2011 15:56:41 -0200
Message-ID: <AANLkTinWM87WnguUjyVBgYa4QBPZf0Pj+NVTOD0DZfG8@mail.gmail.com>
In-Reply-To: <1294162273.5852.100.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6403021928481591358==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

On Tue, Jan 4, 2011 at 3:31 PM, Marcel Holtmann <marcel@holtmann.org> wro=
te:
>> diff --git a/src/dbus.c b/src/dbus.c
>> index c24615f..292f11a 100644
>> --- a/src/dbus.c
>> +++ b/src/dbus.c
>> @@ -139,8 +139,13 @@ static void append_dict_variant(DBusMessageIter *it=
er, int type, void *val)
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dbus_message_iter_appen=
d_basic(&entry, DBUS_TYPE_STRING,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &(val_array[i + 0]));
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 dbus_message_iter_append_bas=
ic(&entry, type,
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 &(val_array[i + 1]));
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (type =3D=3D DBUS_TYPE_ST=
RING) {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
dbus_message_iter_append_basic(&entry, type,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &(val_array[i + 1]));
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
dbus_message_iter_append_basic(&entry, type,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 val_array[i + 1]);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>
> this does looks a bit hackish. Can you put it into context please. It
> might be that our call chain is wrong.

As of now there are no calls to ofono_dbus_dict_append_dict() with
type !=3D string. So, there's no problem in current code base. The
problem arrives when I call, for example:

void **array;

array =3D g_new0(void *, 4);

array[0] =3D a_string;
array[1] =3D &a_byte_var;

array[2] =3D b_string;
array[3] =3D &b_byte_var;


then if i call:
		ofono_dbus_dict_append_dict(&dict, "MyPropName", DBUS_TYPE_BYTE, &array);

It will not work, because of the following call chain:



ofono_dbus_dict_append_dict()
  append_dict_variant(... , void *val)
      const void **val_array =3D *(const void ***) val;
      (...)
      dbus_message_iter_append_basic(&entry, DBUS_TYPE_BYTE,
&(val_array[i + 1]);

So, you are passing a const void** to dbus_message_iter_append_basic
that will be dereferenced accordingly inside dbus to get the type you
told it. Then, bad things will happen. I've just tested here with my
patches for the retry counter, where this call is needed.



regards,

Lucas De Marchi

--===============6403021928481591358==--

