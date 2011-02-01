Content-Type: multipart/mixed; boundary="===============4119860623992997342=="
MIME-Version: 1.0
From: Andreas WESTIN <andreas.westin@stericsson.com>
Subject: Re: [PATCH v2 3/3] isimodem: header updates for ISI2.5
Date: Tue, 01 Feb 2011 17:29:41 +0100
Message-ID: <4D4834F5.2030802@stericsson.com>
In-Reply-To: <1296574993.1520.272.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4119860623992997342==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

On 2011-02-01 16:43, Marcel Holtmann wrote:
> Hi Jessica,
>
>>   drivers/isimodem/debug.c   |  132 ++++++++++++++++++++++++++++++++++++=
++++++++
>>   drivers/isimodem/debug.h   |    9 +++
>>   drivers/isimodem/mtc.h     |   38 +++++++++++++
>>   drivers/isimodem/version.h |   26 +++++++++
>>   4 files changed, 205 insertions(+), 0 deletions(-)
>>   create mode 100644 drivers/isimodem/version.h
>
> <snip>
>
>> +enum isi_version {
>> +	ISI_20 =3D 0,
>> +	ISI_25 =3D 1
>> +};
>
> so what is the final decision here now. ISI doing auto-detection and
> this gets not exposed to the modem drivers or we do.
>
> Aki, I remember you saying that this is not needed at all.
>

We need to know which version of ISI we are using in the driver, =

messages differ. But we are open to other suggestions.

Marcel, as to your other comments we will correct them and send new patches.

Regards
Andreas

--===============4119860623992997342==--

