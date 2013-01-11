Content-Type: multipart/mixed; boundary="===============0449323277131807745=="
MIME-Version: 1.0
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
Subject: Re: [PATCH v0 0/6] HFP HF: External Profile
Date: Fri, 11 Jan 2013 17:05:32 +0100
Message-ID: <CANT-zCUkhcNyW1t-iqZmM=cRSLtJzRsu+zA8RKQsL-vn2S-WhA@mail.gmail.com>
In-Reply-To: <CAKT1EBebwLntE3tvL0O_D9m1jqhATfUB1NuJ_VrrohKeaZQuVQ@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0449323277131807745==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Claudio,

On Fri, Jan 11, 2013 at 3:26 PM, Claudio Takahasi
<claudio.takahasi@openbossa.org> wrote:
> Hi Mikel:
>
>> > Remaining HFP HF patches:
>> > git://git.infradead.org/users/cktakahasi/ofono.git HF-20130109
>>
>> Regarding these remaining patches, I know it's WIP but just to make
>> sure, please consider the latest Media API changes introduced by the
>> BlueZ patchset "Media API clarifications":
>> 1. Return org.bluez.Error.NotAvailable if TryAcquire() fails because
>> SCO is down.
>
> Fixed!
>
> I think we should add InProgress error to avoid the same "owner" to
> call Acquire(or TryAcquire) for a previously "acquired" fd without
> calling Release.
> Do you agree?

I can't imagine any usage scenario where this is relevant: the client
should be aware of having acquired the transport before, so I don't
see the interest of defining a specific error for such a case.

>
>> 2. Add SpeakerGain/MicrophoneGain properties to the transport, and
>> note that they are uint8.
>
> ok. We gonna investigate it.

I'll send the updated PulseAudio patches early next week. Please note
that the last RFC v0 I sent is not up-to-date.

Cheers,
Mikel

--===============0449323277131807745==--

