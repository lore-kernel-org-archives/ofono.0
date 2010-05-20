Content-Type: multipart/mixed; boundary="===============0007832715766524644=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v4 2/3] Move report_signal_strength to atutil
Date: Wed, 19 May 2010 19:36:23 -0500
Message-ID: <201005191936.23348.denkenz@gmail.com>
In-Reply-To: <20100520080414.17288.40729.stgit@potku.valot.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0007832715766524644==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kalle,

> =

>  static void csq_notify(GAtResult *result, gpointer user_data)
> @@ -490,7 +489,8 @@ static void csq_notify(GAtResult *result, gpointer
>  user_data) if (!g_at_result_iter_next_number(&iter, &strength))
>  		return;
> =

> -	report_signal_strength(netreg, strength);
> +	ofono_netreg_strength_notify(netreg,
> +				at_util_convert_signal_strength(strength));
>  }

How about fixing all other instances of report_signal_strength and removing=
 it =

from this file as well? ;)

Regards,
-Denis

--===============0007832715766524644==--

