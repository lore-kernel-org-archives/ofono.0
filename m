Content-Type: multipart/mixed; boundary="===============1795159909490739860=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/5] text-telephony: add public header
Date: Fri, 26 Nov 2010 13:27:17 -0600
Message-ID: <4CF00A15.3050302@gmail.com>
In-Reply-To: <1290706920-24740-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1795159909490739860==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lucas,

I applied this patch, but amended it a bit afterwards.  See below:

<snip>

> +struct ofono_ctm_driver {
> +	const char *name;
> +	int (*probe)(struct ofono_ctm *tt, unsigned int vendor,
> +			void *data);

So I had to change the *tt variable name to *ctm everywhere

> +	void (*remove)(struct ofono_ctm *tt);
> +	void (*query_tty)(struct ofono_ctm *tt,
> +				ofono_ctm_query_cb_t cb,
> +				void *data);
> +	void (*set_tty)(struct ofono_ctm *tt,
> +				int enable,

I also changed this to ofono_bool_t enable

> +				ofono_ctm_set_cb_t cb,
> +				void *data);
> +};
> +
> +int ofono_ctm_driver_register(const struct ofono_ctm_driver *d);
> +void ofono_ctm_driver_unregister(const struct ofono_ctm_driver *d);
> +
> +struct ofono_ctm *ofono_ctm_create(struct ofono_modem *modem,
> +					unsigned int vendor,
> +					const char *driver,
> +					void *data);
> +
> +void ofono_ctm_register(struct ofono_ctm *tt);
> +void ofono_ctm_remove(struct ofono_ctm *tt);
> +
> +void ofono_ctm_set_data(struct ofono_ctm *tt, void *data);
> +void *ofono_ctm_get_data(struct ofono_ctm *tt);
> +
> +#ifdef __cplusplus
> +}
> +#endif
> +
> +#endif /* __OFONO_TEXT_TELEPHONY_H */

And I fixed up this comment.

Regards,
-Denis

--===============1795159909490739860==--

