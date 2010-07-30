Content-Type: multipart/mixed; boundary="===============0744079472968251406=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: USSD support in ofono-0.25
Date: Fri, 30 Jul 2010 00:20:40 -0700
Message-ID: <1280474440.21857.1.camel@localhost.localdomain>
In-Reply-To: <AANLkTimW8X91gm4DCw1sZXu306zd4QbHho=ku=DKv3on@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0744079472968251406==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

> Is USSD support is available and functional in ofono latest version?

yes it is.

> I found the support in SupplementaryServices interface and I am able
> to read the properties from this interface, but I am getting error
> when try to call "Initiate" method,
> from the definition of "Initiate" method in ussd.c found that out
> arguments are "sv". below is the test code.
> =

> gchar *str=3DNULL;
> GValue val=3D{0,};
> g_value_init(&val,G_TYPE_STRING);
> dbus_g_proxy_call (proxy,
> "Initiate",&error,G_TYPE_STRING,"*#43#",G_TYPE_INVALID,G_TYPE_STRING,&str=
,G_TYPE_VALUE,&val, G_TYPE_INVALID);
> =

> if above code is executed  , the error is =

> " GLib-GObject-WARNING **: gvalue.c:185: cannot initialize GValue with
> type `GValueArray_gchararray+GHashTable_gchararray+GValue__', the
> value has already been initialized as `gchararray'
> =

> Couldn't convert argument, expected "GValue" "
> =

> =

> and in generate_cw_ss_query_reply callback , message signature is
> "(sa{sv})"
> so tried with =

> =

> GArray *list;
> GHashTable *OUT_arg0=3DNULL;
> dbus_g_proxy_call (proxy,
> "Initiate",&error,G_TYPE_STRING,"*#43#",G_TYPE_INVALID,
>                                 dbus_g_type_get_struct ("GValueArray",
> G_TYPE_STRING,
>                                 dbus_g_type_get_map ("GHashTable",
> G_TYPE_STRING, G_TYPE_VALUE),G_TYPE_INVALID),
>                                 &OUT_arg0, G_TYPE_INVALID);
> =

> but it is returning error " Expected D-BUS struct, got type code 's'" =

> =

> can any body please tell me the correct return types.
> =

> in both cases ofono is getting response from phonesim.
> =

> and no proper documentation is available for USSD support .

Look at doc/supplementaryservices-api.txt for a detailed description of
the API. And test/test-ussd is an example in Python on how to use it.

Regards

Marcel



--===============0744079472968251406==--

