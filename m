Content-Type: multipart/mixed; boundary="===============4864339089069643343=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v0 4/4] hfp_hf_bluez5: Fix missing fd close
Date: Tue, 29 Jan 2013 15:59:30 -0600
Message-ID: <51084642.9070305@gmail.com>
In-Reply-To: <1359491920-15963-5-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4864339089069643343==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 01/29/2013 02:38 PM, Claudio Takahasi wrote:
> This patch fix an unusual scenario, service_level_connection() fails if
> GIOChannel or GAtChat memory allocation fails.
> ---
>   plugins/hfp_hf_bluez5.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>

Patch has been applied, thanks.

Regards,
-Denis


--===============4864339089069643343==--

