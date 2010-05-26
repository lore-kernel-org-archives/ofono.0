Content-Type: multipart/mixed; boundary="===============2949973417907124107=="
MIME-Version: 1.0
From: Kalle Valo <kalle.valo@canonical.com>
Subject: Re: [PATCH v2] atmodem: fix crash during context deactivation
Date: Wed, 26 May 2010 18:33:47 +0300
Message-ID: <87d3wik78k.fsf@potku.valot.fi>
In-Reply-To: <33AB447FBD802F4E932063B962385B351E99720A@shsmsx501.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2949973417907124107==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

"Zhang, Zhenhua" <zhenhua.zhang@intel.com> writes:

> Hi Valo,

Hi Zhenhua,

> Kalle Valo wrote:
>> -	channel =3D g_at_chat_get_channel(gcd->chat);
>> -	g_at_chat_unref(gcd->chat);
>> +	g_at_chat_suspend(gcd->chat);
>> =

>> 	/* open ppp */
>> -	gcd->ppp =3D g_at_ppp_new(channel);
>> +	gcd->ppp =3D g_at_ppp_new_from_io(io);
>> =

>> 	if (gcd->ppp =3D=3D NULL)
>> 		return FALSE;
>
> You should use g_at_chat_resume(gcd->chat) to resume the chat before
> you returns FALSE here.

Good point. I just sent v3, but I'll send v4 immeadiately.

-- =

Kalle Valo

--===============2949973417907124107==--

