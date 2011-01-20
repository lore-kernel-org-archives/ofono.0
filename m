Content-Type: multipart/mixed; boundary="===============6536985889341280297=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH]] gatchat: improve large file Downlink data transfer
Date: Thu, 20 Jan 2011 13:03:21 +0100
Message-ID: <1295525001.3873.291.camel@aeonflux>
In-Reply-To: <2A84145621092446B6659B8A0F28E26F47006AA7B7@irsmsx501.ger.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6536985889341280297==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Carlos,

please don't use our Exchange servers. They do make me mad :(

The email From: field should be first name first. Problem with Exchange
is that it ends like this: Pargada, Carlos <carlos.pargada@intel.com>

Have a proper .gitconfig and use linux.intel.com as SMTP server and
really all your problem will go away. It is magic ;)

> Fix large file Downlink data transfer on IFX modem.
>   Increase buffer size of ring buffer to support close received Packets f=
rom the Modem
>   Set highest priority for write data on tun device

Watch out of ]] on your subject line.

Please keep the subject short and the commit message at max 72 chars per
line.

If you wanna know what happens, save this email, use "git am" and then
view the result with "git log"

> ---
>  gatchat/gatio.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)

I fixed it all up for you and the patch has been applied now.

Regards

Marcel



--===============6536985889341280297==--

