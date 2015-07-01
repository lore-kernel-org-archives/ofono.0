Content-Type: multipart/mixed; boundary="===============5318451895309387646=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] make it build against musl
Date: Wed, 01 Jul 2015 08:11:37 -0500
Message-ID: <5593E709.2000401@gmail.com>
In-Reply-To: <1432977236-31669-1-git-send-email-zl29ah@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5318451895309387646==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sergey,

On 05/30/2015 04:13 AM, Sergey Alirzaev wrote:
> ifdef away GNU libc extensions and use a POSIXly correct pointer type
> ---
>   gatchat/ppp_net.c | 2 +-
>   src/log.c         | 8 ++++++++
>   2 files changed, 9 insertions(+), 1 deletion(-)
>

Applied, thanks.

Regards,
-Denis


--===============5318451895309387646==--

