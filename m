Content-Type: multipart/mixed; boundary="===============4228748367211408598=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: [PATCH] Add USC-2 to UTF-8 conversion utility function.
Date: Mon, 06 Jul 2009 09:51:02 +0300
Message-ID: <cf7c4201a49ed38c71aa45b007dd821b@localhost>
In-Reply-To: <1246763625-17183-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4228748367211408598==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Sun,  5 Jul 2009 05:13:45 +0200, Andrzej Zaborowski
<andrew.zaborowski@intel.com> wrote:
> +
> +	ret =3D g_utf16_to_utf8((const gunichar2 *) buffer, i / 2,
> +			NULL, items_written, &error);

Why not use iconv() with UCS-2BE to UTF-8?

Cheers,
Aki

--===============4228748367211408598==--

