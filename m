Content-Type: multipart/mixed; boundary="===============4475986929390237947=="
MIME-Version: 1.0
From: Andreas WESTIN <andreas.westin@stericsson.com>
Subject: Re: [PATCH v2 2/3] udev: u8500 support and style fix
Date: Tue, 01 Feb 2011 16:55:42 +0100
Message-ID: <4D482CFE.2060801@stericsson.com>
In-Reply-To: <1296574751.1520.267.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4475986929390237947==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

Jessica is out of office.

On 2011-02-01 16:39, Marcel Holtmann wrote:
> Hi Jessica,
>
>>   plugins/udev.c |    5 ++++-
>>   1 files changed, 4 insertions(+), 1 deletions(-)
>
> so you wanna combine the udev rule change and the udev change together
> actually. They both belong together. The actual modem plugin driver is
> not related.

Ok, will correct.

>> diff --git a/plugins/udev.c b/plugins/udev.c
>> index ce1efe6..49b5eb8 100644
>> --- a/plugins/udev.c
>> +++ b/plugins/udev.c
>> @@ -185,7 +185,8 @@ static void add_hso(struct ofono_modem *modem,
>>   		devnode =3D udev_device_get_devnode(udev_device);
>>
>>   		if (g_str_has_suffix(type, "Application") =3D=3D TRUE)
>> -			ofono_modem_set_string(modem, APPLICATION_PORT, devnode);
>> +			ofono_modem_set_string(modem, APPLICATION_PORT,
>> +						devnode);
>
> What is this part doing here?

Style fix, should it be removed ?

>>   		else if (g_str_has_suffix(type, "Control") =3D=3D TRUE)
>>   			ofono_modem_set_string(modem, CONTROL_PORT, devnode);
>>   	} else if (g_str_equal(subsystem, "net") =3D=3D TRUE) {
>> @@ -636,6 +637,8 @@ done:
>>   		add_nokia(modem, udev_device);
>>   	else if (g_strcmp0(driver, "isiusb") =3D=3D 0)
>>   		add_isi(modem, udev_device);
>> +	else if (g_strcmp0(driver, "u8500") =3D=3D 0)
>> +		add_isi(modem, udev_device);
>>   	else if (g_strcmp0(driver, "n900") =3D=3D 0)
>>   		add_isi(modem, udev_device);
>>   	else if (g_strcmp0(driver, "gobi") =3D=3D 0)
>

Regards
Andreas

--===============4475986929390237947==--

