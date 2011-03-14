Content-Type: multipart/mixed; boundary="===============8194244239900808857=="
MIME-Version: 1.0
From: Andras Domokos <andras.domokos@nokia.com>
Subject: Re: [PATCH 0/5] Voice call SS notifications (4th version)
Date: Mon, 14 Mar 2011 09:22:16 +0200
Message-ID: <4D7DC228.6000405@nokia.com>
In-Reply-To: <4D7A7D64.3040203@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8194244239900808857==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 03/11/2011 09:52 PM, ext Denis Kenzior wrote:
> Hi Andras,
>
> On 03/04/2011 11:12 AM, Andras Domokos wrote:
>> Implementation proposal for handling some of the voice call
>> related Supplementary Services (SS) notifications.
>>
>> Implementation details:
>> - removed SSN atom and all the dependencies
>> - (re)implemented voice call SS notification handling framework
>> - added voice call SS notification handling to AT modem driver
>>    (+CSSU and +CSSI notifications)
>> - added voice call SS notification handling to ISI modem driver
>>
>> Andras Domokos (5):
>>    ssn: remove SSN atom completely
>>    voicecall: add SSN function declarations
>>    voicecall: implement SSN handling functions
>>    atmodem: implement SSN handling
>>    isimodem: implement SSN handling
> I pushed all of these patches upstream, thanks.

Thanks a lot.

> Regards,
> -Denis

Regards,
Andras

--===============8194244239900808857==--

