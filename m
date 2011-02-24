Content-Type: multipart/mixed; boundary="===============8981239810982904011=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v4 3/6] mbmmodem: add location-reporting driver
 implementation
Date: Wed, 23 Feb 2011 22:21:03 -0600
Message-ID: <4D65DCAF.8070508@gmail.com>
In-Reply-To: <AANLkTin82oSxJrih9ZwidVSQCGvzoz7xNpdDEmud+FiQ@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8981239810982904011==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lucas,

On 02/23/2011 08:26 PM, Lucas De Marchi wrote:
> Hi Denis
> =

> On Wed, Feb 23, 2011 at 9:57 PM, Denis Kenzior <denkenz@gmail.com> wrot=
e:
>> Hi Lucas,
>>
>>> +static int mbm_create_data_chat(struct ofono_location_reporting *lr)
>>> +{
>>> +     struct gps_data *gd =3D ofono_location_reporting_get_data(lr);
>>> +     struct ofono_modem *modem;
>>> +     const char *gps_dev;
>>> +     GAtSyntax *syntax;
>>> +     GIOChannel *channel;
>>> +     int fd;
>>> +
>>> +     modem =3D ofono_location_reporting_get_modem(lr);
>>> +     gps_dev =3D ofono_modem_get_string(modem, "GPSDevice");
>>> +
>>> +     channel =3D g_at_tty_open(gps_dev, NULL);
>>> +     if (channel =3D=3D NULL)
>>> +             return -1;
>>> +
>>> +     syntax =3D g_at_syntax_new_gsm_permissive();
>>> +     gd->data_chat =3D g_at_chat_new(channel, syntax);
>>> +     fd =3D g_io_channel_unix_get_fd(channel);
>>> +
>>> +     g_at_syntax_unref(syntax);
>>> +     g_io_channel_unref(channel);
>>> +
>>> +     if (gd->data_chat =3D=3D NULL)
>>> +             return -1;
>>> +
>>> +     return fd;
>>> +}
>>> +
>>
>> Why do you bother creating a GAtChat for the NMEA port?  It seems that a
>> GIOChannel or a simple fd would be enough.
> =

> This is because of this line:
> =

> +       if (g_at_chat_send(gd->data_chat, "AT*E2GPSNPD", NULL, NULL, NULL,
> +                                                               NULL) > 0=
) {
> =

> AT*E2GPSNPD is sent on the tty that will contain the nmea stream, not
> the control one.
> =


Then I'm confused how this even works.  The GAtChat is installing its
own IO watches on this channel and would be reading from the stream.
Wouldn't this cause you to have a race between the location reporting
client and ofono itself?

Maybe you should be sending the E2GPSNPD, unrefing the data_chat and
then sending the fd upwards?

>> Also, what happens if the channel is hupped by the modem?  Shouldn't we
>> have a watch in the core for that and set Enabled accordingly?
> =

> Humn... maybe. Though client should have called Release(). Otherwise,
> isn't the Release() method superfluous?
> =


Assuming the client is well behaved..

Also, what are we doing with the open socket if oFono is forcefully shut
down?  Shouldn't we shut it down as well?

Regards,
-Denis

--===============8981239810982904011==--

