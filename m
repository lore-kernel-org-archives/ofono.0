Content-Type: multipart/mixed; boundary="===============6727115530135159200=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Error in setting "VoiceNoReplyTimeout" property in call-forwarding
Date: Tue, 05 Oct 2010 19:44:27 -0500
Message-ID: <4CABC66B.8040208@gmail.com>
In-Reply-To: <AANLkTinv1TVbNL0-vzgm+UN8mV_HUq5xbfjBX69QaUsi@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6727115530135159200==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sai,

On 10/05/2010 09:49 AM, sai koushik wrote:
> Hi,
> =

> we are working on use-case to activate call-forwarding rule when no
> reply , but ofono is returning error "Invalid arguments in method
> call" when trying to set the reply-timeout value.
> =

> below is the code for the use-case
> =

> GValue val=3D{0,{{0}}};
> g_value_init(&val,G_TYPE_UINT);
> =

> uint value=3D30;
> g_value_set_uint(&val,value);
> =

> GError *error=3DNULL;
> dbus_g_proxy_call (proxy,"SetProperty", &error,
> G_TYPE_STRING,"VoiceNoReplyTimeout", G_TYPE_VALUE,&val,
> G_TYPE_INVALID, G_TYPE_INVALID);
> =

> =

> in our observation , when preparing DBusMessage, it is taking uint32
> as basic type for uint ,
> and in ofono after receiving DBusMessage it is expecting for value of
> type DBUS_TYPE_UINT16 but the message contains DBUS_TYPE_UINT32 type
> value.
> =

> is there is any specific reason to expect the time-out value as uint16 ty=
pe.

You need to be constructing the message with the type that oFono
expects.  In this particular case it is a uint16.

Just as a heads up, this API will change to use 'byte' instead of
'uint16' since the Timeout value can only be between 1 and 30.

Regards,
-Denis

--===============6727115530135159200==--

