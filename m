Content-Type: multipart/mixed; boundary="===============1208960722843414554=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] huawei: do not set timer more than once
Date: Wed, 19 Jan 2011 14:22:03 +0100
Message-ID: <1295443323.3873.244.camel@aeonflux>
In-Reply-To: <1295442463-7151-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1208960722843414554==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lucas,

> If a "^SYSINFO" arrives after the timer for query_sim_locked() has been
> set up, it'd would set a new timer, signaling a sim state change more
> than once.
> ---
>  plugins/huawei.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)

patch looks fine to me and so I applied it.

Regards

Marcel



--===============1208960722843414554==--

