Content-Type: multipart/mixed; boundary="===============8982582271498610378=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/2] Fix __ofono_voicecall_is_busy()
Date: Thu, 23 Sep 2010 13:30:58 -0500
Message-ID: <4C9B9CE2.3060002@gmail.com>
In-Reply-To: <1285263737-9017-2-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8982582271498610378==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

> @@ -2171,7 +2171,7 @@ int ofono_voicecall_get_next_callid(struct ofono_vo=
icecall *vc)
>  ofono_bool_t __ofono_voicecall_is_busy(struct ofono_voicecall *vc,
>  					enum ofono_voicecall_interaction type)
>  {
> -	if (vc->pending)
> +	if (vc->pending || vc->dial_req)
>  		return TRUE;
>  =

>  	switch (type) {

This particular change breaks __ofono_voicecall_dial which would return
EBUSY in all cases as a result.

Regards,
-Denis

--===============8982582271498610378==--

