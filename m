Content-Type: multipart/mixed; boundary="===============0584183305081892189=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: Re: [PATCH v4 3/6] mbmmodem: add location-reporting driver
 implementation
Date: Wed, 23 Feb 2011 23:26:38 -0300
Message-ID: <AANLkTin82oSxJrih9ZwidVSQCGvzoz7xNpdDEmud+FiQ@mail.gmail.com>
In-Reply-To: <4D65ACF3.9040508@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0584183305081892189==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis

On Wed, Feb 23, 2011 at 9:57 PM, Denis Kenzior <denkenz@gmail.com> wrote:
> Hi Lucas,
>
>> +static int mbm_create_data_chat(struct ofono_location_reporting *lr)
>> +{
>> + =C2=A0 =C2=A0 struct gps_data *gd =3D ofono_location_reporting_get_dat=
a(lr);
>> + =C2=A0 =C2=A0 struct ofono_modem *modem;
>> + =C2=A0 =C2=A0 const char *gps_dev;
>> + =C2=A0 =C2=A0 GAtSyntax *syntax;
>> + =C2=A0 =C2=A0 GIOChannel *channel;
>> + =C2=A0 =C2=A0 int fd;
>> +
>> + =C2=A0 =C2=A0 modem =3D ofono_location_reporting_get_modem(lr);
>> + =C2=A0 =C2=A0 gps_dev =3D ofono_modem_get_string(modem, "GPSDevice");
>> +
>> + =C2=A0 =C2=A0 channel =3D g_at_tty_open(gps_dev, NULL);
>> + =C2=A0 =C2=A0 if (channel =3D=3D NULL)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;
>> +
>> + =C2=A0 =C2=A0 syntax =3D g_at_syntax_new_gsm_permissive();
>> + =C2=A0 =C2=A0 gd->data_chat =3D g_at_chat_new(channel, syntax);
>> + =C2=A0 =C2=A0 fd =3D g_io_channel_unix_get_fd(channel);
>> +
>> + =C2=A0 =C2=A0 g_at_syntax_unref(syntax);
>> + =C2=A0 =C2=A0 g_io_channel_unref(channel);
>> +
>> + =C2=A0 =C2=A0 if (gd->data_chat =3D=3D NULL)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -1;
>> +
>> + =C2=A0 =C2=A0 return fd;
>> +}
>> +
>
> Why do you bother creating a GAtChat for the NMEA port? =C2=A0It seems th=
at a
> GIOChannel or a simple fd would be enough.

This is because of this line:

+       if (g_at_chat_send(gd->data_chat, "AT*E2GPSNPD", NULL, NULL, NULL,
+                                                               NULL) > 0) {

AT*E2GPSNPD is sent on the tty that will contain the nmea stream, not
the control one.

> Also, what happens if the channel is hupped by the modem? =C2=A0Shouldn't=
 we
> have a watch in the core for that and set Enabled accordingly?

Humn... maybe. Though client should have called Release(). Otherwise,
isn't the Release() method superfluous?



regards,
Lucas De Marchi

--===============0584183305081892189==--

