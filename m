Content-Type: multipart/mixed; boundary="===============0061804313890329850=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/4] voicecall: add ATD support for HFP emulator
Date: Thu, 19 May 2011 11:39:01 -0500
Message-ID: <4DD547A5.9090407@gmail.com>
In-Reply-To: <4DD54262.3090008@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0061804313890329850==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Frederic,

>>> So, I think that voicecall should return an OFONO_ERROR_TYPE_CME 30, and
>>> ofono_emulator_send_final should take care of replying the right string.
>>>
>>
>> Nope, you have to take your pick, either CME ERROR: 30, or NO CARRIER.
>> I'd expect most implementations to reply with a NO CARRIER in this case,
>> but can you check what other implementations do in reality?
>>
> =

> In paragraph 6.2.13.11 of tr002v15, in reply to ATD command without
> network, the flowchart shows usage of +CME ERROR: 30 or ERROR reply (no
> usage of NO CARRIER).
> =


If that is what tr002 recommends, then lets do that for now.

> Paragraph 4.33.2 of HFP 1.5 specification said that NO CARRIER (and
> BUSY, NO ANSWER, ...) "are in addition to the +CME ERROR: reponses".
> =

> My understanding of specs is that we should send the CME ERROR and, if
> we want, NO CARRIER in addition.

Yeah, I never understood that particular statement.  +CME ERROR and NO
CARRIER are both final responses, you should not send both.

Regards,
-Denis

--===============0061804313890329850==--

