Content-Type: multipart/mixed; boundary="===============4486193938762355891=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: Re: [PATCH v2 6/6] cdmamodem: Add serving system identifier support
Date: Fri, 18 Nov 2011 14:18:20 +0100
Message-ID: <4EC65B1C.4030504@linux.intel.com>
In-Reply-To: <4EC38FB8.6040105@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4486193938762355891==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 11/16/2011 11:26 AM, Denis Kenzior wrote:
> Hi Philippe,
>
> On 11/17/2011 10:21 AM, Philippe Nunes wrote:
>> ---
>>   drivers/cdmamodem/network-registration.c |   78 ++++++++++++++++++++++=
++++++++
>>   include/cdma-netreg.h                    |    7 +++
>>   2 files changed, 85 insertions(+), 0 deletions(-)
>>
>
> So the obvious comment is that this patch should be split into two, one
> for adding new driver API and one for the driver changes.

OK, sorry to bother again with such issue.

> I would also like to see how you're planning to use this information in
> the core, before reviewing this patch in detail.  Do note that after
> taking a quick peek at Huawei CDMA manuals and ModemManager, I very much
> doubt that +CSS is what you want to use in the first place.

I'm really not familiar with Huawei CDMA AT commands but looking to the =

command interface specification from Huawei and to TIA/EIA/IS-707, I =

can't see other solution than the serving system query to retrieve the =

SID. Also, I don't see any unsolicited result codes which could bring =

such information.

Note that this AT command seems supported by Huawei cdma modem according =

the first revison of TIA/EIA/IS-707 (here, the band class is not =

supported, neither the PREV field).

Now, it's true that we would need to retrieve also the NID (as stated in =

TODO), but so far, I don't see how...

Regards,

Philippe.


>
> Regards,
> -Denis
>


--===============4486193938762355891==--

