Content-Type: multipart/mixed; boundary="===============2795489465701910812=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: Re: [PATCH v0 0/6] HFP HF: External Profile
Date: Fri, 11 Jan 2013 11:26:55 -0300
Message-ID: <CAKT1EBebwLntE3tvL0O_D9m1jqhATfUB1NuJ_VrrohKeaZQuVQ@mail.gmail.com>
In-Reply-To: <CANT-zCVAf7_hzO1a4PsuC_EbhhxjEKdLF7M_HPg3X2ZAaEx1dA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2795489465701910812==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mikel:

> > Remaining HFP HF patches:
> > git://git.infradead.org/users/cktakahasi/ofono.git HF-20130109
>
> Regarding these remaining patches, I know it's WIP but just to make
> sure, please consider the latest Media API changes introduced by the
> BlueZ patchset "Media API clarifications":
> 1. Return org.bluez.Error.NotAvailable if TryAcquire() fails because
> SCO is down.

Fixed!

I think we should add InProgress error to avoid the same "owner" to
call Acquire(or TryAcquire) for a previously "acquired" fd without
calling Release.
Do you agree?

> 2. Add SpeakerGain/MicrophoneGain properties to the transport, and
> note that they are uint8.

ok. We gonna investigate it.

Regards,
Claudio

--===============2795489465701910812==--

