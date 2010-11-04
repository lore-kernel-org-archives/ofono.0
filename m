Content-Type: multipart/mixed; boundary="===============6724952908718500679=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCHv2] isigen: increase offline timeout
Date: Thu, 04 Nov 2010 16:20:26 +0100
Message-ID: <1288884026.9615.95.camel@aeonflux>
In-Reply-To: <1288880449-13207-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6724952908718500679==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

> The modem deregisters from network before response to MTC_STATE_REQ is
> returned.  Deregistering can take up to 6 seconds.
> ---
>  drivers/isimodem/mtc.h |    1 +
>  plugins/isigen.c       |    2 +-
>  2 files changed, 2 insertions(+), 1 deletions(-)

patch has been applied.

Regards

marcel



--===============6724952908718500679==--

