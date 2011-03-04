Content-Type: multipart/mixed; boundary="===============6111919534877148514=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 1/2] huawei: do not check for NULL pointer
Date: Fri, 04 Mar 2011 05:14:42 -0800
Message-ID: <1299244482.32127.3.camel@aeonflux>
In-Reply-To: <1299244214-12411-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6111919534877148514==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lucas,

> cb_data_new() uses g_new0(), hence there's no need to check the return
> value being NULL.
> ---
>  plugins/huawei.c |    4 ----
>  1 files changed, 0 insertions(+), 4 deletions(-)

patch has been applied. Thanks.

Regards

Marcel



--===============6111919534877148514==--

