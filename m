Content-Type: multipart/mixed; boundary="===============1924906421557030439=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH v10] ifx: Adding modem selftest for Infineon modem
Date: Mon, 07 Feb 2011 13:41:26 -0800
Message-ID: <1297114886.1520.450.camel@aeonflux>
In-Reply-To: <1297113905-3061-1-git-send-email-anandx.ramakrishna@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1924906421557030439==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Anand,

> Infineon modem selftest, during ifx_enable().
> Two steps trigger, with timeout. In case one fails, modem will not power =
up
> =

> ---
>  plugins/ifx.c |   66 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++++-
>  1 files changed, 64 insertions(+), 2 deletions(-)

patch has been applied, but I had to fix it up :(

> -	data->mux_init_timeout =3D g_timeout_add_seconds(5, mux_timeout_cb,
> +	/*
> +	 * Total self test execution ... 2 seconds. Use
> +	 * 10 seconds timeout to cover self tests and multiplexer setup.
> +	 */
> +	data->mux_init_timeout =3D g_timeout_add_seconds(10, mux_timeout_cb,
>  								modem);

The ... in my review meant to keep the rest of the sentence. It needs to
be proper English so people can understand what it means.

I did fix this by myself since having v11 of this simple patch becomes a
little bit too ridiculous.

Regards

Marcel



--===============1924906421557030439==--

