Content-Type: multipart/mixed; boundary="===============4565934434151482550=="
MIME-Version: 1.0
From: Dara Spieker-Doyle <dara.spieker-doyle@nokia.com>
Subject: Re: [PATCH v4, 5/5] udev: Add nokiacdma device
Date: Mon, 10 Jan 2011 15:10:16 -0800
Message-ID: <4D2B91D8.5040207@nokia.com>
In-Reply-To: <4D2B89A7.1020603@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4565934434151482550==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis

On 01/10/2011 02:35 PM, ext Denis Kenzior wrote:
> Hi Dara,
>
> On 01/03/2011 07:50 PM, Dara Spieker-Doyle wrote:
>> ---
>>   plugins/udev.c |   16 ++++++++++++++++
>>   1 files changed, 16 insertions(+), 0 deletions(-)
>>
>> diff --git a/plugins/udev.c b/plugins/udev.c
>> index 6a59b06..12402eb 100644
>> --- a/plugins/udev.c
>> +++ b/plugins/udev.c
>> @@ -462,6 +462,20 @@ static void add_calypso(struct ofono_modem *modem,
>>   	ofono_modem_register(modem);
>>   }
>>
>> +static void add_nokiacdma(struct ofono_modem *modem,
>> +					struct udev_device *udev_device)
>> +{
>> +	const char *devnode;
>> +
>> +	DBG("modem %p", modem);
>> +
>> +	devnode =3D udev_device_get_devnode(udev_device);
>> +
>> +	ofono_modem_set_string(modem, "Device", devnode);
>> +	ofono_modem_set_integer(modem, "Registered", 1);
>
> Since you told me that your modem only has a single AT command port, you
> don't really need this Registered part here.  Does this device support
> high speed USB network access or PPP only?
>

Ergh sorry, yes this is an oversight and should have been cleaned out =

with the other integration relics. I'll remove it with the patch rebase.
This device is PPP only.

Thanks
Dara

--===============4565934434151482550==--

