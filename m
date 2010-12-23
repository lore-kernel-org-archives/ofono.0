Content-Type: multipart/mixed; boundary="===============6620498242306757837=="
MIME-Version: 1.0
From: Wei, Jun <jun.wei@intel.com>
Subject: RE: [RFC PATCH 2/5 v2] cell-info: Header file for cell-info atom
Date: Thu, 23 Dec 2010 14:31:38 +0800
Message-ID: <1A42CE6F5F474C41B63392A5F80372B231C6CC0F@shsmsx501.ccr.corp.intel.com>
In-Reply-To: <1293010539-9524-3-git-send-email-antti.paila@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6620498242306757837==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Antti,

On Wed, 2010-12-22 at 11:35 +0200, ext Antti Paila wrote:
> ---
>  include/cell-info.h |  133 =

> +++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 133 insertions(+), 0 deletions(-)  create mode =

> 100644 include/cell-info.h
> =

> diff --git a/include/cell-info.h b/include/cell-info.h new file mode =

> 100644 index 0000000..3941e69
> --- /dev/null
> +++ b/include/cell-info.h
> @@ -0,0 +1,133 @@
> +/*
>  ...
>  ...
>  ...
> +struct ofono_cell_info_driver {
> +	const char *name;
> +	int (*probe)(struct ofono_cell_info *ci,
> +			unsigned int vendor,
> +			void *data);
> +	void (*remove)(struct ofono_cell_info *ci);
> +	void (*query)(struct ofono_cell_info *ci,
> +			ofono_cell_info_query_cb_t,
> +			void *data);
> +};
> +

To be aligning with the other header files, do we need to add one 'cb' afte=
r 'ofono_cell_info_query_cb_t' here?


Regards,

Wei,Jun


--===============6620498242306757837==--

