Content-Type: multipart/mixed; boundary="===============1648297961782027404=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 4/7] Network password has exactly 4 digits.
Date: Thu, 18 Mar 2010 11:43:14 -0500
Message-ID: <201003181143.14720.denkenz@gmail.com>
In-Reply-To: <1268923471-29059-4-git-send-email-ppessi@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1648297961782027404==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

> +/* Network password has exactly 4 digits */
> +static inline int is_valid_password(const char *pass)
> +{
> +	return is_valid_pin(pass) && strlen(pass) =3D=3D 4;
> +}
> +

So I suggest not doing it this way, instead let us modify is_valid_pin to t=
ake =

an additional argument, namely whether this is a pin/puk and check the leng=
th =

of the password there.  You might want to include a reference to 22.004 =

Section 5.2 that says the pin/pin2 is 0000 to 9999 and exactly 4 digits.

Regards,
-Denis

--===============1648297961782027404==--

