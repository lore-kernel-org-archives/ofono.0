Content-Type: multipart/mixed; boundary="===============7422795192185961129=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] gril: Fix access to notify callbacks
Date: Mon, 02 Nov 2015 12:41:14 -0600
Message-ID: <5637AE4A.6020907@gmail.com>
In-Reply-To: <1446482921-16956-1-git-send-email-alfonso.sanchez-beato@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7422795192185961129==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alfonso,

On 11/02/2015 10:48 AM, Alfonso Sanchez-Beato wrote:
> Entries to the table of notification callbacks can be added by the
> callbacks while being called. This caused a glib error as gril was
> using an iterator to the hash table while the table was being modified.
> Fixed by avoiding the unnecesary loop.
> ---
>   gril/gril.c | 36 ++++++++++++------------------------
>   1 file changed, 12 insertions(+), 24 deletions(-)
>

Applied, thanks.

Regards,
-Denis


--===============7422795192185961129==--

