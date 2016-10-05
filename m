Content-Type: multipart/mixed; boundary="===============4652495830771927610=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] gatmux: fix read channel remove on error.
Date: Wed, 05 Oct 2016 13:04:00 -0500
Message-ID: <57F54090.2080602@gmail.com>
In-Reply-To: <1475649748-20537-1-git-send-email-a.aubert@overkiz.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4652495830771927610==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Antoine,

On 10/05/2016 01:42 AM, Antoine Aubert wrote:
> In case of invalid IO, read_watch is not reset. This fix crash on destroy=
 gatmux.
> ---
>   gatchat/gatmux.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
>

Applied, thanks.

Regards,
-Denis


--===============4652495830771927610==--

