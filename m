Content-Type: multipart/mixed; boundary="===============0963481789906464648=="
MIME-Version: 1.0
From: Philippe Nunes <philippe.nunes@linux.intel.com>
Subject: Re: [PATCH 0/5] udev rules update
Date: Tue, 29 Nov 2011 15:51:38 +0100
Message-ID: <4ED4F17A.2080903@linux.intel.com>
In-Reply-To: <1322569239.29909.61.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0963481789906464648==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

On 11/29/2011 01:20 PM, Marcel Holtmann wrote:
> Hi Philippe,
>
>> This set of patches have been sent this summer but not upstreamed.
>> As few bugs have been opened which could be fixed by those patches, I re=
send them
>> for review.
>>
>> - For Speedup dongles, the logic in udevng is to assign the modem port o=
n the
>> latest interface. This is not true for SpeedUp SU-7300U (BUG #23168) and
>> SpeedUp 9800 (BUG #23167). So, I added 2 specific rules for both dongles.
>>
>> - For dongle ZTE MF190, 6 interfaces are present and we shall use the in=
terface
>> ttyUSB4 for modem channel. The logic in udevng is to assign the modem ch=
annel
>> on the latest interface. To not break the support of ZTE modems with 5
>> interfaces (which are using the 4th one for PPP, like K3570), I can't ex=
tend
>> the current logic to take into account the ttyUSB4. So, I added a specif=
ic rule
>> for ZTE MF190.
>> I added also a specific rule for the dongle ZTE MF668 as the modem chann=
el is
>> not on the latest interface (BUG #23683)
>
> why is all this reasoning here and not in the commit message of the
> patches? I expect that every patch has a proper commit message that
> explains its goal. Just a non-meaningful subject line is not enough.

Yes, you're right, I should move this explanation in the commit =

messages. Before, sending a new set of patches accordingly, I would like =

to raise an issue regarding the patches for ofono.rules:

Your commit "build: do not install ofono.rules anymore" regarding =

Makefile.am makes none effective my proposed changes in ofono rules.
Could you explain why the file ofono.rules is not installed anymore =

whereas we are still supposed to consider some specific properties =

exposed by this file?

Thanks,

Regards,

Philippe.




--===============0963481789906464648==--

