Content-Type: multipart/mixed; boundary="===============7340606931521338035=="
MIME-Version: 1.0
From: Djalal Harouni <djalal@endocode.com>
Subject: Re: [PATCH 4/5] ubloxmodem: intialize and register the netmon driver
Date: Wed, 30 Nov 2016 12:49:17 +0100
Message-ID: <CAH562ETrhcTZyGK48_AeCbNJs-X1+4_X-615DwPUsBFGSY2pAA@mail.gmail.com>
In-Reply-To: <583DB27E.3040403@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7340606931521338035==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 29 November 2016 at 17:53, Denis Kenzior <denkenz@gmail.com> wrote:
> Hi Djalal,
>
> On 11/25/2016 08:00 AM, djalal(a)endocode.com wrote:
>>
>> From: Djalal Harouni <djalal@endocode.com>
>>
>> This patch allows to intialize and register the ublox netmon driver.
>> ---
>>   drivers/ubloxmodem/ubloxmodem.c | 2 ++
>>   drivers/ubloxmodem/ubloxmodem.h | 3 +++
>>   plugins/ublox.c                 | 3 +++
>>   3 files changed, 8 insertions(+)
>>
>
> This patch isn't broken down properly.  See HACKING, 'Submitting patches'
> section.  Each top-level directory change should be in a separate patch.
> E.g. one patch for drivers/* and one patch for plugins/*.
>
> It might be easier to simply squash drivers/ubloxmodem/ubloxmodem.[ch]
> changes into patch 3.

Oups sorry about that. Hopefully fixed in v2.

> Regards,
> -Denis

--===============7340606931521338035==--

