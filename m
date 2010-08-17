Content-Type: multipart/mixed; boundary="===============7519925363107021476=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH v5 2/8] stemodem: Add polling for SIM ready.
Date: Tue, 17 Aug 2010 14:58:43 +0200
Message-ID: <1282049923.23399.96.camel@localhost.localdomain>
In-Reply-To: <1282047754-15562-3-git-send-email-sjur.brandeland@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7519925363107021476==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sjur,

> Interim solution until support for SIM 'ready' notification is supported.
> ---
> Change: AT-channel configuration is moved to separate patch.
> =

>  plugins/ste.c |   52 ++++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 files changed, 50 insertions(+), 2 deletions(-)

patch has been applied.

Denis, if you don't like it then feel free to revert it. For me it
looked fine until we have better solution for this.

Regards

Marcel



--===============7519925363107021476==--

