Content-Type: multipart/mixed; boundary="===============3281895067536904703=="
MIME-Version: 1.0
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
Subject: Re: [PATCH v0 0/6] HFP HF: External Profile
Date: Fri, 11 Jan 2013 10:27:39 +0100
Message-ID: <CANT-zCVAf7_hzO1a4PsuC_EbhhxjEKdLF7M_HPg3X2ZAaEx1dA@mail.gmail.com>
In-Reply-To: <1357829089-16029-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3281895067536904703==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Claudio,

On Thu, Jan 10, 2013 at 3:44 PM, Claudio Takahasi
<claudio.takahasi@openbossa.org> wrote:
> This is the first group of the patches which introduces the Handsfree
> BlueZ external profile.
>
> The following patches contain only initial files and basic structures
> for the HFP HF plugin (since files and plugins names are one of
> controversial points).
>
> Remaining HFP HF patches:
> git://git.infradead.org/users/cktakahasi/ofono.git HF-20130109

Regarding these remaining patches, I know it's WIP but just to make
sure, please consider the latest Media API changes introduced by the
BlueZ patchset "Media API clarifications":
1. Return org.bluez.Error.NotAvailable if TryAcquire() fails because
SCO is down.
2. Add SpeakerGain/MicrophoneGain properties to the transport, and
note that they are uint8.

Cheers,
Mikel

--===============3281895067536904703==--

