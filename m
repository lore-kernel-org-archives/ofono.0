Content-Type: multipart/mixed; boundary="===============5660850015140877402=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] skip modem port checking when create NDIS gprs context
Date: Thu, 02 Jun 2011 16:04:44 -0500
Message-ID: <4DE7FAEC.8020201@gmail.com>
In-Reply-To: <1307092447-23510-1-git-send-email-caiwen.zhang@windriver.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5660850015140877402==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Caiwen,

On 06/03/2011 04:14 AM, Caiwen Zhang wrote:
> When create NDIS gprs context, It doesn't depend on modem port,
> don't need to check modem port.
> =

> ---
>  plugins/huawei.c |    7 +++----
>  1 files changed, 3 insertions(+), 4 deletions(-)
> =


Patch has been applied with a slightly modified commit message.  Thanks.

Regards,
-Denis

--===============5660850015140877402==--

