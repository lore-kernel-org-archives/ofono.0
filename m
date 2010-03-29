Content-Type: multipart/mixed; boundary="===============1753481074855679801=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 9/9] Add parser for item icon identifier list objects
Date: Mon, 29 Mar 2010 17:21:09 -0500
Message-ID: <201003291721.09804.denkenz@gmail.com>
In-Reply-To: <1269879884-12741-9-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1753481074855679801==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Yang,

> =

> +/* Defined in TS 102.223 Section 8.32 */
> +struct stk_item_icon_id_list {
> +	unsigned char qualifier;
> +	unsigned char len;
> +	unsigned char *array;
> +};
> +

And again here, the maximum size of the array is 126, so let us avoid =

g_mallocs.

Regards,
-Denis

--===============1753481074855679801==--

