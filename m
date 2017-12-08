Content-Type: multipart/mixed; boundary="===============1371841510012860671=="
MIME-Version: 1.0
From: Slava Monich <slava.monich@jolla.com>
Subject: Re: [PATCH] sim: Handle multiple EFpl read completions
Date: Fri, 08 Dec 2017 17:50:28 +0300
Message-ID: <35c9eada-9f54-f189-3111-75ce20a5408b@jolla.com>
In-Reply-To: <39fc4107-7a38-ed25-0863-1f7c9179a9e9@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1371841510012860671==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 08/12/17 17:14, Denis Kenzior wrote:
> ...
>
> Can we do something like
> if (sim->language_prefs_update)
> =C2=A0=C2=A0=C2=A0=C2=A0return;
>
> ?
>

Yes, of course! Forget this patch then, I'll send a new one.

Cheers,
-Slava

--===============1371841510012860671==--

