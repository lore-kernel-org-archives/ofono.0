Content-Type: multipart/mixed; boundary="===============9104668610330313357=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [RFC PATCH v1 2/2] huawei: fix online logic
Date: Fri, 17 Sep 2010 21:53:52 +0900
Message-ID: <1284728032.2405.215.camel@localhost.localdomain>
In-Reply-To: <20100917102358.8517.8873.stgit@potku.valot.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9104668610330313357==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kalle,

>  plugins/huawei.c |   79 ++++++++++++++++++++++++++++++++++++++----------=
------
>  1 files changed, 55 insertions(+), 24 deletions(-)
> =

> diff --git a/plugins/huawei.c b/plugins/huawei.c
> index ad1c3ae..0b4e65e 100644
> --- a/plugins/huawei.c
> +++ b/plugins/huawei.c
> @@ -78,6 +78,7 @@ struct huawei_data {
>  	gboolean voice;
>  	guint query_sim_state;
>  	guint sim_poll_count;
> +	struct cb_data *online_cbd;
>  };

doing it like this make me suspisious that this is the right approach.
No other modem plugin has to do it this way. Why does Huawei?

Regards

Marcel



--===============9104668610330313357==--

