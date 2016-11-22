Content-Type: multipart/mixed; boundary="===============2492147091148306034=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] lte: fix early imsi free
Date: Tue, 22 Nov 2016 10:04:14 -0600
Message-ID: <58346C7E.5040309@gmail.com>
In-Reply-To: <1479819614-25999-1-git-send-email-dragos@endocode.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2492147091148306034==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Dragos,

On 11/22/2016 07:00 AM, Dragos Tatulea wrote:
> storage_close was creating an empty sync file in /var/lib/ofono/lte
> when it should have been closing the proper file
> /var/lig/ofono/<imsi>/lte.
>
> ---
>   src/lte.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>

Looks like I screwed this one up.  Thanks for fixing this.

Applied.

Regards,
-Denis


--===============2492147091148306034==--

