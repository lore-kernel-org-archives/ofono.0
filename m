Content-Type: multipart/mixed; boundary="===============0055647744557088452=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] mbmmodem: don't let chat open after fd is sent
Date: Thu, 03 Mar 2011 09:21:51 -0800
Message-ID: <1299172911.2519.68.camel@aeonflux>
In-Reply-To: <1299172479-11086-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0055647744557088452==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lucas,

>  struct gps_data {
>  	GAtChat *chat;
> -	GAtChat *data_chat;
> +
> +	struct {
> +		GIOChannel *channel;
> +		guint idle_source;
> +		gsize written;
> +		ofono_location_reporting_enable_cb_t cb;
> +		void *cb_data;
> +	} stream;
>  };

why do you bother with the struct in struct here?

Regards

Marcel



--===============0055647744557088452==--

