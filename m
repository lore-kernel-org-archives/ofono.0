Content-Type: multipart/mixed; boundary="===============0353994339199681112=="
MIME-Version: 1.0
From: Dara Spieker-Doyle <dara.spieker-doyle@nokia.com>
Subject: Re: [PATCH 2/3] cdmamodem: Add CDMA devinfo support
Date: Thu, 13 Jan 2011 10:20:39 -0800
Message-ID: <4D2F4277.8030700@nokia.com>
In-Reply-To: <4D2E95C1.40209@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0353994339199681112==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis

On 01/12/2011 10:03 PM, ext Denis Kenzior wrote:
> Hi Dara,
>
> On 01/11/2011 03:45 PM, Dara Spieker-Doyle wrote:
>> ---
>>   Makefile.am                   |    3 +-
>>   drivers/cdmamodem/cdmamodem.c |    2 +
>>   drivers/cdmamodem/cdmamodem.h |    2 +
>>   drivers/cdmamodem/devinfo.c   |  169 +++++++++++++++++++++++++++++++++=
++++++++
>>   4 files changed, 175 insertions(+), 1 deletions(-)
>>   create mode 100644 drivers/cdmamodem/devinfo.c
>>
>
> Can you please rebase and resubmit this patch?  Further comments below:
>
>> diff --git a/drivers/cdmamodem/cdmamodem.h b/drivers/cdmamodem/cdmamodem=
.h
>> index a5991cf..ef4fad3 100644
>> --- a/drivers/cdmamodem/cdmamodem.h
>> +++ b/drivers/cdmamodem/cdmamodem.h
>> @@ -23,3 +23,5 @@
>>
>>   extern void cdma_at_voicecall_init();
>>   extern void cdma_at_voicecall_exit();
>> +extern void cdma_at_devinfo_init();
>> +extern void cdma_at_devinfo_exit();
>
> Please name this cdma_devinfo_init/exit
>
>
> <snip>
>
>> +static struct ofono_devinfo_driver driver =3D {
>> +	.name 			=3D "cdmamodem",
>> +	.probe	 		=3D cdma_at_devinfo_probe,
>> +	.remove			=3D cdma_at_devinfo_remove,
>> +	.query_manufacturer	=3D cdma_at_query_manufacturer,
>> +	.query_model		=3D cdma_at_query_model,
>> +	.query_revision		=3D cdma_at_query_revision,
>> +	.query_serial		=3D cdma_at_query_serial
>
> Please drop the 'at' from these.  Use cdma_devinfo_probe, etc.
>
>> +};
>> +
>
> Regards,
> -Denis

Yes, I will fix up and resubmit today.

Thank you
Dara



--===============0353994339199681112==--

