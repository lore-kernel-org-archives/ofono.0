Content-Type: multipart/mixed; boundary="===============2430170793573826991=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] hfp_hf_bluez5: Remove error handling for
 g_io_channel_unix_new()
Date: Thu, 31 Jan 2013 16:00:04 -0600
Message-ID: <510AE964.8030703@gmail.com>
In-Reply-To: <1359657008-16198-1-git-send-email-vinicius.gomes@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2430170793573826991==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Vinicius,

On 01/31/2013 12:30 PM, Vinicius Costa Gomes wrote:
> Apart from g_io_channel_unix_new() not setting errno, it never
> returns an NULL pointer on error, because in practice it only
> calls g_new().
> ---
>   plugins/hfp_hf_bluez5.c | 5 -----
>   1 file changed, 5 deletions(-)
>

Patch has been applied, thanks.

Regards,
-Denis


--===============2430170793573826991==--

