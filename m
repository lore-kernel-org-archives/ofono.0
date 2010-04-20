Content-Type: multipart/mixed; boundary="===============2816369276107409861=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 10/17] Add parser for remote entity address objects
Date: Tue, 20 Apr 2010 16:58:27 -0500
Message-ID: <201004201658.27461.denkenz@gmail.com>
In-Reply-To: <1271744112-32285-10-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2816369276107409861==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Yang,

>  /*
> + * According to TS 102.223 Section 8.68, remote entity address can be
>  either + * 6-bytes IEEE-802 address, or 4-bytes IrDA device address. So
>  the maximum + * size of address is 6 bytes.
> + */
> +struct stk_remote_entity_address {
> +	unsigned char coding_type;
> +	unsigned char addr[6];
> +};
> +

I suggest you use a union here, see stk_other_address for an idea.

Regards,
-Denis

--===============2816369276107409861==--

