Content-Type: multipart/mixed; boundary="===============2240236123781524847=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] Fix valid_ussd_string()
Date: Thu, 23 Sep 2010 13:27:41 -0500
Message-ID: <4C9B9C1D.6070803@gmail.com>
In-Reply-To: <1285263737-9017-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2240236123781524847==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

> -	 * According to 22.030 Figure 3.5.3.2 USSD strings can be:
> -	 *
> -	 * Supplementary service control
> -	 * SIM control
> -	 * Manufacturer defined
> -	 * Terminated by '#'
> -	 * Short String - This can be any 2 digit short string.  If the string
> -	 *                starts with a '1' and no calls are in progress then
> -	 *                this string is treated as a call setup request
> -	 *
> -	 * Everything else is not a valid USSD string
> +	 * As an exception, if a 2 digit string starts with a '1' and
> +	 * there are no calls in progress then this string is treated as
> +	 * a call setup request instead.

You are now removing any reference to 22.030 and simply stating the
'facts'.  I prefer that the spec trail be left in.  So at least these
comments should not be removed.

The rest looks fine to me.

Regards,
-Denis

--===============2240236123781524847==--

