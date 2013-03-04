Content-Type: multipart/mixed; boundary="===============5870289649259474426=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: Re: [PATCH v0 09/10] handsfree-audio: Add function to get hfp version
Date: Mon, 04 Mar 2013 16:54:03 -0300
Message-ID: <CAKT1EBdK+=abT_QF71-nkidfKaJWK8qJ88SCHmurgbftNN-2Aw@mail.gmail.com>
In-Reply-To: <5134F659.9040900@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5870289649259474426==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis:

On Mon, Mar 4, 2013 at 4:30 PM, Denis Kenzior <denkenz@gmail.com> wrote:
> Hi Marcel,
>
>
>>>
>>> I don't see why not.  Both Codec Negotiation and Wide-band speech are
>>> labeled optional for HF/AG in Table 3.1.  The only note there says: "If=
 Wide
>>> Band Speech is supported, Codec Negotiation shall also be supported."
>>> However, there is no note vice-versa.  So my interpretation is that Cod=
ec
>>> Negotiation can always be supported.  Can we check the test spec?
>>>
>>> The problem I see is that by the time we register the SDP record, we
>>> still do not know for sure whether the audio framework truly supports m=
SBC.
>>
>>
>> so we want to expose HFP 1.6 and codec negogiation all the time. Even if
>> mSBC codec is not available, because PA does not support it or is not
>> running. I read the spec the same way that this fully spec compliant.
>>
>> If at some point in the future this changes, we can deal with that at th=
at
>> point. No need to over engineer it at this point.
>>
>
> Exactly,  Codec negotiation should always be supported.
> .  What my last comment was about is that:
>
> If mSBC is not supported by PA, then it would be nice to not set the
> wide-band speech bit in the SDP record to true.  However, we do not know
> this information in the current set up until too late.

F.Y.I. some results from the test plan generator consistency check:
* if wide band speech is Not supported Codec negotiation is excluded
* if wide band speech is Supported, mSBC is mandatory

Anyway, I will implementing what you are suggesting. We can fix it
later if necessary.

Regards,
Claudio

--===============5870289649259474426==--

