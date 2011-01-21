Content-Type: multipart/mixed; boundary="===============6179812313073991696=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/3] Use default ACCM (0xffffffff) to trasmit package
Date: Fri, 21 Jan 2011 14:07:18 -0600
Message-ID: <4D39E776.6030307@gmail.com>
In-Reply-To: <FC2FB65B4D919844ADE4BE3C2BB739AD34F6CD0C@shsmsx501.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6179812313073991696==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Martin,

On 01/20/2011 07:51 PM, Xu, Martin wrote:
>> -----Original Message-----
>> From: Denis Kenzior [mailto:denkenz(a)gmail.com]
>> Sent: Friday, January 21, 2011 3:11 AM
>> To: ofono(a)ofono.org
>> Cc: Xu, Martin
>> Subject: Re: [PATCH 2/3] Use default ACCM (0xffffffff) to trasmit package
>>
>> Hi Martin,
>>
>> On 01/19/2011 11:45 PM, martin.xu(a)intel.com wrote:
>>> From: Martin Xu <martin.xu@intel.com>
>>>
>>> Using my Huawei EM770W modem, if set ACCM as 0x00000000, RXJ-
>>> event breaks PPP link, after IP package transmit for a while.
>>> Using default ACCM, the issue can be fixed.
>>> I tested it at China Unicom networks.
>>
>> Does the Huawei NAK our ACCM by any chance?
> The modem can accept our 0x0 ACCM. But with the ACCM, PPP does not work.
> If there is not any issue at the modem firmware, can we understand it as:
> Modem can transmit ACCM with 0x0, but we have no capability to receive it=
, so we can't ask modem transmit as 0x0 ACCM?
> =


We should be able to receive ACCM of 0 just fine.  I double checked the
code, but maybe you want to put a pair of eyeballs on it as well.

Regards,
-Denis

--===============6179812313073991696==--

