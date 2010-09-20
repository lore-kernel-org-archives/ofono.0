Content-Type: multipart/mixed; boundary="===============3969773026755814035=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH v2 1/2] huawei: poll sim state
Date: Tue, 21 Sep 2010 02:09:36 +0900
Message-ID: <1285002576.20811.36.camel@localhost.localdomain>
In-Reply-To: <20100920124026.12498.53590.stgit@potku.valot.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3969773026755814035==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kalle,

> On my Huawei E1552 when I plug in the modem (ie. cold start) with PIN loc=
ked
> SIM, the sim state is 255 (HUAWEI_SIM_STATE_NOT_EXISTENT). As the modem
> doesn't send ^SIMST notifications, poll the sim state until it's ready.
> =

> In theory it might be possible to do this better, for example follow
> ^BOOT notifications or something, but it's unknown what parameter we
> should check for.
> ---
>  plugins/huawei.c |   66 +++++++++++++++++++++++++++++++++++++++++++-----=
------
>  1 files changed, 53 insertions(+), 13 deletions(-)

patch has been applied.

Regards

Marcel



--===============3969773026755814035==--

