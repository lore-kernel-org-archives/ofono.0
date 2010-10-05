Content-Type: multipart/mixed; boundary="===============6537445741607512453=="
MIME-Version: 1.0
From: sai koushik <saikoushik539@gmail.com>
Subject: Error in setting "VoiceNoReplyTimeout" property in call-forwarding
Date: Tue, 05 Oct 2010 20:19:18 +0530
Message-ID: <AANLkTinv1TVbNL0-vzgm+UN8mV_HUq5xbfjBX69QaUsi@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6537445741607512453==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

we are working on use-case to activate call-forwarding rule when no
reply , but ofono is returning error "Invalid arguments in method
call" when trying to set the reply-timeout value.

below is the code for the use-case

GValue val=3D{0,{{0}}};
g_value_init(&val,G_TYPE_UINT);

uint value=3D30;
g_value_set_uint(&val,value);

GError *error=3DNULL;
dbus_g_proxy_call (proxy,"SetProperty", &error,
G_TYPE_STRING,"VoiceNoReplyTimeout", G_TYPE_VALUE,&val,
G_TYPE_INVALID, G_TYPE_INVALID);


in our observation , when preparing DBusMessage, it is taking uint32
as basic type for uint ,
and in ofono after receiving DBusMessage it is expecting for value of
type DBUS_TYPE_UINT16 but the message contains DBUS_TYPE_UINT32 type
value.

is there is any specific reason to expect the time-out value as uint16 type.

 we are following the pre-requisites to set the reply-timput value as
specified in call-forwarding doc.
	=

Thanks
sai.

--===============6537445741607512453==--

