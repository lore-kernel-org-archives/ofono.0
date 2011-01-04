Content-Type: multipart/mixed; boundary="===============6502280168784889541=="
MIME-Version: 1.0
From: Dara Spieker-Doyle <dara.spieker-doyle@nokia.com>
Subject: Re: [PATCH v3, Part2, 3/3] udev: Add nokiacdma device
Date: Mon, 03 Jan 2011 17:49:53 -0800
Message-ID: <4D227CC1.8000507@nokia.com>
In-Reply-To: <4D12B2AB.2000000@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6502280168784889541==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis

On 12/22/2010 06:23 PM, ext Denis Kenzior wrote:
> Hi Dara,
>
> On 12/21/2010 01:23 PM, Dara Spieker-Doyle wrote:
>> ---
>>   plugins/udev.c |   21 +++++++++++++++++++++
>>   1 files changed, 21 insertions(+), 0 deletions(-)
>>
>> diff --git a/plugins/udev.c b/plugins/udev.c
>> index 255755e..9447e5c 100644
>> --- a/plugins/udev.c
>> +++ b/plugins/udev.c
>> @@ -449,6 +449,25 @@ static void add_isi(struct ofono_modem *modem,
>>   	ofono_modem_register(modem);
>>   }
>>
>> +static void add_nokiacdma(struct ofono_modem *modem,
>> +					struct udev_device *udev_device)
>> +{
>> +	const char *devnode;
>> +	int registered;
>> +
>> +	DBG("modem %p", modem);
>> +
>> +	devnode =3D udev_device_get_devnode(udev_device);
>> +
>> +	registered =3D ofono_modem_get_integer(modem, "Registered");
>> +	if (registered !=3D 0)
>> +		return;
>> +
>> +	ofono_modem_set_string(modem, "Device", devnode);
>> +	ofono_modem_set_integer(modem, "Registered", 1);
>> +	ofono_modem_register(modem);
>
> This looks a little fishy to me.  How many ttys are created when this
> device is plugged in?  Is it really just one or are you relying on luck
> to select the right tty?
>
When the current nokiacdma (Nokia 7205) device is plugged in there is =

only one TTY created.

Thanks
Dara

--===============6502280168784889541==--

