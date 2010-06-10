Content-Type: multipart/mixed; boundary="===============1564995340475290270=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 17/20] stkutil: Add the Event Download envelope builder
Date: Wed, 09 Jun 2010 20:06:00 -0500
Message-ID: <201006092006.01114.denkenz@gmail.com>
In-Reply-To: <1275905322-14768-17-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1564995340475290270==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

>  		/* Network Byte Order */
> -		unsigned int ipv4;
> +		guint32 ipv4;

Why?

> @@ -799,7 +909,9 @@ struct stk_frame_layout {
>   */
>  struct stk_frames_info {
>  	unsigned char id;
> -	unsigned char list[126];
> +	struct {
> +		unsigned int width, height;

do you mean unsigned char here?

> +	} list[66];

Do you mean 63 here?

>  	unsigned int len;
>  };
> =

> +		struct stk_reader_status card_reader_status;
> +		const char *language_selection;

Per IRC conversation, lets not use const pointers in these structures.

Can you resubmit patches 12, 13 and 17-20.  All others have been pushed.

Thanks,
-Denis

--===============1564995340475290270==--

