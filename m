Content-Type: multipart/mixed; boundary="===============0790290456563948960=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 02/12] gprs: driver interface changes for IPv6
Date: Fri, 04 Feb 2011 11:24:29 -0600
Message-ID: <4D4C364D.90201@gmail.com>
In-Reply-To: <1296723809-32676-3-git-send-email-mika.liljeberg@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0790290456563948960==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mika,

> +enum ofono_gprs_addrconf {
> +	OFONO_GPRS_ADDRCONF_NONE,
> +	OFONO_GPRS_ADDRCONF_STATIC,
> +	OFONO_GPRS_ADDRCONF_DHCP,
> +};
> +

What exactly is the _NONE addrconf for?  And why don't we use a gboolean
here like before?

>  struct ofono_gprs_primary_context {
>  	unsigned int cid;
>  	int direction;
> @@ -94,6 +101,20 @@ struct ofono_modem *ofono_gprs_context_get_modem(stru=
ct ofono_gprs_context *gc);
>  =

>  void ofono_gprs_context_set_type(struct ofono_gprs_context *gc,
>  					enum ofono_gprs_context_type type);
> +void ofono_gprs_context_set_interface(struct ofono_gprs_context *gc,
> +					const char *interface);
> +void ofono_gprs_context_set_ip_addrconf(struct ofono_gprs_context *gc,
> +					enum ofono_gprs_addrconf method);
> +void ofono_gprs_context_set_ip_address(struct ofono_gprs_context *gc,
> +					const char *address);
> +void ofono_gprs_context_set_ip_netmask(struct ofono_gprs_context *gc,
> +					const char *netmask);
> +void ofono_gprs_context_set_ip_gateway(struct ofono_gprs_context *gc,
> +					const char *netmask);
> +void ofono_gprs_context_set_ipv6_address(struct ofono_gprs_context *gc,
> +					const char *address);
> +void ofono_gprs_context_set_dns_servers(struct ofono_gprs_context *gc,
> +					const char **dns);
>  =


So I'm actually fine with this approach.

>  #ifdef __cplusplus
>  }

Regards,
-Denis

--===============0790290456563948960==--

