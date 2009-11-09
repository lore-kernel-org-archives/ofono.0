Content-Type: multipart/mixed; boundary="===============3376998938815131195=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/4] add create/destroy_interface to
 ofono_gprs_context_driver
Date: Mon, 09 Nov 2009 10:59:11 -0600
Message-ID: <200911091059.11821.denkenz@gmail.com>
In-Reply-To: <1257752281-22251-2-git-send-email-martin.xu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3376998938815131195==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Martin,

> @@ -57,6 +57,10 @@ struct ofono_gprs_context_driver {
>  	void (*deactivate_primary)(struct ofono_gprs_context *gc,
>  					unsigned int id,
>  					ofono_gprs_context_cb_t cb, void *data);
> +	void (*create_interface)(struct ofono_gprs_context *gc,
> +				struct ofono_gprs_primary_context *ctx);
> +	void (*destroy_interface)(struct ofono_gprs_context *gc,
> +				struct ofono_gprs_primary_context *ctx);
>  };

I suggest we don't do this, but instead notify the core of the interface na=
me =

in 'activate_primary' callback, assuming the activate was successful.

Regards,
-Denis

--===============3376998938815131195==--

