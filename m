Content-Type: multipart/mixed; boundary="===============2388577240822533919=="
MIME-Version: 1.0
From: Lei Yu <lei.2.yu@nokia.com>
Subject: Re: [PATCH 3/5] cdma-atmodem: Add CDMA SMS Support
Date: Mon, 20 Dec 2010 13:31:34 -0800
Message-ID: <4D0FCB36.8040606@nokia.com>
In-Reply-To: <4D0FBF0A.1080100@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2388577240822533919==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 12/20/2010 12:39 PM, ext Denis Kenzior wrote:
> On 12/08/2010 06:35 PM, Lei Yu wrote:
>> ---
>>   Makefile.am                    |    7 ++
>>   configure.ac                   |    5 ++
>>   drivers/cdma-atmodem/atmodem.c |   47 ++++++++++++
>>   drivers/cdma-atmodem/atmodem.h |   23 ++++++
>
> You need to synchronize with Dara on this one.  Both of you are sending
> the same stub implementation.  I suggest submitting this as a separate
> patch.  And please name it cdmamodem/cdmamodem.c&  .h.  Dara has this
> right actually.
>

I will synchronize with Dara. Most likely, I will hold of submitting
update to my patch at least for 3/5 till Dara's patch is finalized and
accepted.

>>   drivers/cdma-atmodem/atutil.c  |   45 ++++++++++++
>>   drivers/cdma-atmodem/atutil.h  |   64 +++++++++++++++++
>
> As I mentioned before, please use the atutil.[ch] from atmodem directly.
>   No need to create a new set of these...
>

I will fix this and resubmit after Dara's patch is finalized.

>>   drivers/cdma-atmodem/sms.c     |  151 ++++++++++++++++++++++++++++++++=
++++++++
>
> And this one should be in a separate patch ;)
>

Will fix this.

> Regards,
> -Denis

Regards,
Lei


--===============2388577240822533919==--

