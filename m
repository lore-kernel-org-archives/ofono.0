Content-Type: multipart/mixed; boundary="===============5982342275485186409=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] Properly skip over quoted values
Date: Tue, 10 Nov 2009 12:54:01 -0600
Message-ID: <200911101254.01405.denkenz@gmail.com>
In-Reply-To: <1257834691-22584-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5982342275485186409==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

> Otherwise a left paren in a string can bring an obscure segfault.
> ---
> +		if (line[i] =3D=3D '\"') {
> +			i +=3D 1;
> +			while (i < len && line[i] !=3D '\"')
> +				i +=3D 1;
> +
> +			if (i < len)
> +				i +=3D 1;
> +
> +			continue;
> +		}
> +

I suggest you recursively call skip_until here instead of duplicating the =

code.  It also should be moved down and treated like '(' and ')'

Regards,
-Denis

--===============5982342275485186409==--

