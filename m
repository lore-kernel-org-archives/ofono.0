Content-Type: multipart/mixed; boundary="===============5294226079416363258=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v0 09/10] handsfree-audio: Add function to get hfp version
Date: Mon, 04 Mar 2013 12:04:19 -0600
Message-ID: <5134E223.1040807@gmail.com>
In-Reply-To: <CAKT1EBd2hUz1vAGbfX2rQC=5zuSdYn+g1W+OQ8sBE0gQjzL8Vw@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5294226079416363258==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Claudio,

On 03/04/2013 10:02 AM, Claudio Takahasi wrote:
> Hi Denis:
>
> On Fri, Mar 1, 2013 at 4:40 PM, Denis Kenzior<denkenz@gmail.com>  wrote:
>> Hi Claudio,
>>
>>
>> On 02/28/2013 12:52 PM, Claudio Takahasi wrote:
>>>
>>> This patch adds a new function to read the local supported Handsfree
>>> Profile version.
>>> ---
>>>    include/handsfree-audio.h | 1 +
>>>    src/handsfree-audio.c     | 5 +++++
>>>    2 files changed, 6 insertions(+)
>>>
>>> diff --git a/include/handsfree-audio.h b/include/handsfree-audio.h
>>> index c5403c7..96597c2 100644
>>> --- a/include/handsfree-audio.h
>>> +++ b/include/handsfree-audio.h
>>> @@ -34,6 +34,7 @@ struct ofono_handsfree_card
>>> *ofono_handsfree_card_create(const char *remote,
>>>                                                          const char
>>> *local);
>>>    int ofono_handsfree_card_register(struct ofono_handsfree_card *card);
>>>    void ofono_handsfree_card_remove(struct ofono_handsfree_card *card);
>>> +enum hfp_version ofono_handsfree_get_version();
>>>
>>
>> I'd like to avoid such details in the card functionality.
>>
>> Are our possible scenarios the following?
>>
>> 1. SCO defer in kernel, CVSD mSBC supported
>
> yes.
>
>> 2. SCO defer not in kernel, CVSD mSBC supported
>
> not possible. Wide band speech requires defer setup to set the SCO
> parameters properly.
>
>> 3. SCO defer in kernel, CVSD supported
>
> yes.
>
>> 4. SCO defer not in kernel, CVSD supported
>
> yes.
>
>>
>> If so, can we always advertise HFP 1.6, but only declare support for CVS=
D in
>> case 2?
>
> I am not a spec (or qualification) expert, but  I will try to expose
> my understanding of the docs:
>
> For case 2, my understanding is: if HF supports *only* CVSD
> (mandatory), it doesn't make sense to inform that codec negotiation is
> supported. HFP 1.5 (or older) shall not indicate that it supports
> codec negotiation (during service level connection negotiation) and it
> should not set the wide band speech support in the service record.
>

There are other features of 1.6 though that might be useful.  For =

example, BTRH status is properly shown in CLCC, and a few other =

niceties.  I see no reason to fall back to 1.5 just because we do not =

support wide-band speech.

Either way, the version decision is not up to the card, it is up to the =

plugin.  The function to get the version information needs to be dropped.

> One thing that I can't answer is if it is allowed to inform in the
> service record that the HF supports HFP 1.6 (version), but don't set
> the wide band speech feature in record.
>

I don't see why not.  Both Codec Negotiation and Wide-band speech are =

labeled optional for HF/AG in Table 3.1.  The only note there says: "If =

Wide Band Speech is supported, Codec Negotiation shall also be =

supported."  However, there is no note vice-versa.  So my interpretation =

is that Codec Negotiation can always be supported.  Can we check the =

test spec?

The problem I see is that by the time we register the SDP record, we =

still do not know for sure whether the audio framework truly supports mSBC.

Regards,
-Denis

--===============5294226079416363258==--

