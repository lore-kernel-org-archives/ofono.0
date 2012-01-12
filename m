Content-Type: multipart/mixed; boundary="===============2548519750194945833=="
MIME-Version: 1.0
From: Renat Zaripov <r.r.zaripov@gmail.com>
Subject: Re: [PATCH v4 2/3] Add SIM900 detection support.
Date: Thu, 12 Jan 2012 13:11:03 +0300
Message-ID: <CAGNC_aNn=ai5cDUUR10wxQbSSzpTTy94KhChL7tDEC60xLdT1Q@mail.gmail.com>
In-Reply-To: <1326293655.6454.236.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2548519750194945833==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

2012/1/11 Marcel Holtmann <marcel@holtmann.org>:
> Hi Renat,
>
>> This allows for detection of SIM900 modem module in case of
>> appropriate driver specified in udev rules.
>>
>> Example rule:
>> KERNEL=3D=3D"gsmtty3", ENV{OFONO_DRIVER}=3D"sim900"
>
> you could also use the 27.010 support that is included in oFono itself
> and set it up from within the plugin. I assume you have a reason for
> using N_GSM.
>
>>
>> ---
>> =C2=A0plugins/udev.c | =C2=A0 15 +++++++++++++++
>> =C2=A01 files changed, 15 insertions(+), 0 deletions(-)
>>
>> diff --git a/plugins/udev.c b/plugins/udev.c
>> index d0673f7..f05af48 100644
>> --- a/plugins/udev.c
>> +++ b/plugins/udev.c
>> @@ -193,6 +193,19 @@ static void add_nokiacdma(struct ofono_modem *modem,
>> =C2=A0 =C2=A0 =C2=A0 ofono_modem_register(modem);
>> =C2=A0}
>>
>> +static void add_sim900(struct ofono_modem *modem,
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 struct udev_device *udev_device)
>> +{
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *devnode;
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0DBG("modem %p", modem);
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0devnode =3D udev_device_get_devnode(udev_de=
vice);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0ofono_modem_set_string(modem, "Device", dev=
node);
>> +
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0ofono_modem_register(modem);
>> +}
>> +
>> =C2=A0static void add_modem(struct udev_device *udev_device)
>> =C2=A0{
>> =C2=A0 =C2=A0 =C2=A0 struct ofono_modem *modem;
>> @@ -271,6 +284,8 @@ done:
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 add_tc65(modem, udev_de=
vice);
>> =C2=A0 =C2=A0 =C2=A0 else if (g_strcmp0(driver, "nokiacdma") =3D=3D 0)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 add_nokiacdma(modem, ud=
ev_device);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0else if (g_strcmp0(driver, "sim900") =3D=3D=
 0)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0add_sim900(mode=
m, udev_device);
>> =C2=A0}
>
> Something went wrong here. Spaces?
>
> Regards
>
> Marcel
>
>
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono

Hi Marcel,

We know about GAtMux, but for our device we have some reasons to use
N_GSM. SIM900 modem module may be used without multiplexer, we use it
only for our specific purposes.

Best regards,

Renat

--===============2548519750194945833==--

