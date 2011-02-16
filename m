Content-Type: multipart/mixed; boundary="===============3143174385780636585=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [V3 PATCH 3/3] Huawei: set Huawei EM770W modem device to 00
Date: Wed, 16 Feb 2011 12:04:15 -0600
Message-ID: <4D5C119F.8050305@gmail.com>
In-Reply-To: <FC2FB65B4D919844ADE4BE3C2BB739AD369E4E97@shsmsx501.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3143174385780636585==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Martin,

On 02/15/2011 01:03 AM, Xu, Martin wrote:
> Denis/Marcel:
>> -----Original Message-----
>> From: Denis Kenzior [mailto:denkenz(a)gmail.com]
>> Sent: Tuesday, February 15, 2011 4:28 AM
>> To: ofono(a)ofono.org
>> Cc: Xu, Martin
>> Subject: Re: [V3 PATCH 3/3] Huawei: set Huawei EM770W modem device to 00
>>
>> Hi Martin,
>>
>> On 02/12/2011 03:41 AM, martin.xu(a)intel.com wrote:
>>> From: Martin Xu <martin.xu@intel.com>
>>>
>>> Device 00 is ppp port. Setting it as 01, my Huawei EM770W modem PPP
>>> connection can't work
>>> ---
>>>  plugins/ofono.rules |    2 +-
>>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>>
>>
>> This contradicts commit bb58a729073abcb6c5b0b2fb8b120973dfa42a07.
> I can't quite understand why Dietrich needs to this commit. We formal con=
figure can just make EM770W works.
> Could you help on this?

The Huawei firmware is funny, it can actually reconfigure the modem and
pcui ports (e.g. swap them).  So we might have to be a bit smarter and
figure out which ports are actually being used for what inside the modem
driver.

Talk to Marcel, I believe he has played with the Huawei hardware the
most and might have ideas on how to fix this.

Regards,
-Denis

--===============3143174385780636585==--

