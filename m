Content-Type: multipart/mixed; boundary="===============4562370547375982523=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: Re: [PATCH v0 00/14] External HFP Profile
Date: Mon, 17 Dec 2012 11:28:21 -0300
Message-ID: <CAKT1EBf_EnD+TNp-q_sBMo3DQcNf0=jKAU=fB7w9ihjPWPZhug@mail.gmail.com>
In-Reply-To: <1354540315-27731-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4562370547375982523==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel:

On Mon, Dec 3, 2012 at 10:11 AM, Claudio Takahasi
<claudio.takahasi@openbossa.org> wrote:
> BlueZ supports now external profile registration, see:
> bluez/doc/profile-api.txt
>
> This patch series has the initial implementation of the HFP external
> profile in oFono. HandsfreeAgent and HandsfreeGateway interfaces were
> removed from BlueZ.
>
> Modem are being registered dinamically when the new connection is
> notified instead of registering the modem when the Bluetooth device
> is created/probed.
>
> * Needs to be applied after "[PATCH v0 1/4] bluetooth: Fix reading
> Bluetooth Adapters" series
>
> Changes from RFC v1:
> - Remove optional RequireAuthorization & RequireAuthentication to
>   Register HFP profile.
>
> Next actions:
>  - Implement MediaTransport
>  - MediaEndpoint set configuration
>
> Development branch:
> git://git.infradead.org/users/cktakahasi/ofono.git hfp

Ignore this patch series also.

As discussed in the IRC, we will split the Bluetooth/HFP plugins to
keep the compatibility with BlueZ 4 and BlueZ 5.

Regards,
Claudio.

--===============4562370547375982523==--

