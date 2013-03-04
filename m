Content-Type: multipart/mixed; boundary="===============3933290185932654618=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v0 09/10] handsfree-audio: Add function to get hfp version
Date: Mon, 04 Mar 2013 13:30:33 -0600
Message-ID: <5134F659.9040900@gmail.com>
In-Reply-To: <E1347878-A569-47A0-A0E1-7B2F34E8B7A6@holtmann.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3933290185932654618==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

>>
>> I don't see why not.  Both Codec Negotiation and Wide-band speech are la=
beled optional for HF/AG in Table 3.1.  The only note there says: "If Wide =
Band Speech is supported, Codec Negotiation shall also be supported."  Howe=
ver, there is no note vice-versa.  So my interpretation is that Codec Negot=
iation can always be supported.  Can we check the test spec?
>>
>> The problem I see is that by the time we register the SDP record, we sti=
ll do not know for sure whether the audio framework truly supports mSBC.
>
> so we want to expose HFP 1.6 and codec negogiation all the time. Even if =
mSBC codec is not available, because PA does not support it or is not runni=
ng. I read the spec the same way that this fully spec compliant.
>
> If at some point in the future this changes, we can deal with that at tha=
t point. No need to over engineer it at this point.
>

Exactly,  Codec negotiation should always be supported.
.  What my last comment was about is that:

If mSBC is not supported by PA, then it would be nice to not set the =

wide-band speech bit in the SDP record to true.  However, we do not know =

this information in the current set up until too late.

Regards,
-Denis

--===============3933290185932654618==--

