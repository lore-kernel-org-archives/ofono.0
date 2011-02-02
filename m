Content-Type: multipart/mixed; boundary="===============3628791898564676583=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/2] voicecall: try harder to avoid Dial mismatches
Date: Wed, 02 Feb 2011 10:41:03 -0600
Message-ID: <4D49891F.9050608@gmail.com>
In-Reply-To: <AANLkTi===2oFMMLP-DAeyTRTdnX6anHHQ7c40KNVHO_h@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3628791898564676583==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

On 02/02/2011 08:57 AM, Pekka Pessi wrote:
> Hi Denis,
> =

> 2011/2/2 Denis Kenzior <denkenz@gmail.com>:
>> On 02/01/2011 04:22 PM, Pekka.Pessi(a)nokia.com wrote:
>>> From: Pekka Pessi <Pekka.Pessi@nokia.com>
>>>
>>> There were some cases where Dial returned an incorrect call object,
>>> e.g., after oFono crash and recover.
>>> ---
>>>  src/voicecall.c |   15 +++++++++++++++
>>>  1 files changed, 15 insertions(+), 0 deletions(-)
>>
>> So I'm guessing that you're restarting oFono and get
>> ofono_voicecall_notify events without setting dial_result_handled proper=
ly.
>>
>> Do you think it is a better idea to resurrect the old list_calls driver
>> method and fire this off explicitly when the atom is registered?  The
>> callback can then take care of setting dial_result_handled appropriately.
> =

> That is one possibility.The belt-and-suspenders approach of
> prepare_to_dial() makes oFono more robust in case there is someone
> talking directly to modem behind oFono's back, however.
> =


This is not a case we support or will ever be willing to support in the
core anyway.  oFono performs too many optimizations internally and the
assumption is that oFono has exclusive control.

Which brings up a question, do we even want to bother performing crash
recovery or simply stipulate to the modem driver that the state should
be reset completely in case oFono crashes?  Remember that crash recovery
involves sim toolkit, voicecalls, gprs, ussd, etc.  It is pretty much
impossible to handle this properly...

Regards,
-Denis

--===============3628791898564676583==--

