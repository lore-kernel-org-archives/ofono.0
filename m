Content-Type: multipart/mixed; boundary="===============6939908095257746778=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCHv3] network: query signal strength
Date: Wed, 05 Jan 2011 21:08:16 -0800
Message-ID: <1294290496.2521.37.camel@aeonflux>
In-Reply-To: <1294240316-5035-1-git-send-email-maritsofie.henriksen8@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6939908095257746778==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marit,

> Signal strength is set to -1 whenever registration status changes
> and differs from registered or roaming. When registration status
> changes again to registered or roaming, the signal strength needs to
> be updated, added query towards driver to get it.
> ---
>  src/network.c |   29 +++++++++++++++++------------
>  1 files changed, 17 insertions(+), 12 deletions(-)

patch has been applied.

I also put back the check to ignore signal strength notifications when
not registered. With this fix that change should become obsolete.

Aki, since you remove that check originally, please double check that
this does not break for you.

Regards

Marcel



--===============6939908095257746778==--

