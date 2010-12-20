Content-Type: multipart/mixed; boundary="===============8037359683305353878=="
MIME-Version: 1.0
From: Dara Spieker-Doyle <dara.spieker-doyle@nokia.com>
Subject: Re: [PATCH v2 8/9] udev: Add cdmagen
Date: Mon, 20 Dec 2010 10:31:00 -0800
Message-ID: <4D0FA0E4.8030207@nokia.com>
In-Reply-To: <1292696967.2658.12.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8037359683305353878==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel

Thank you for reviewing these patches

On 12/18/2010 10:29 AM, ext Marcel Holtmann wrote:
> Hi Dara,
>
>>   	struct ofono_modem *modem;
>> @@ -533,6 +552,8 @@ done:
>>   		add_isi(modem, udev_device);
>>   	else if (g_strcmp0(driver, "n900") =3D=3D 0)
>>   		add_isi(modem, udev_device);
>> +	else if (g_strcmp0(driver, "cdmagen") =3D=3D 0)
>> +		add_cdmagen(modem, udev_device);
>>   }
>
> this is actually wrong. The generic drivers running against phonesim
> should not be done via udev. We did remove atgen for a reason actually
> since it was not really useful.

Actually, this driver is not for running against phonesim at all. This =

plugin is intended for use against the majority of CDMA AT Modem devices =

(phones and usb sticks) connected in a tethered mode.
Please see the other email thread in this series ([Patch v2 7/9]) for =

alternative name suggestion to clarify this.

Thanks
Dara

--===============8037359683305353878==--

