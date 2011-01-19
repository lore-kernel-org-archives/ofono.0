Content-Type: multipart/mixed; boundary="===============7469472167145170746=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] huawei: do not query sim state on pre_sim
Date: Wed, 19 Jan 2011 15:40:25 +0100
Message-ID: <1295448025.3873.247.camel@aeonflux>
In-Reply-To: <1295447681-8193-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7469472167145170746==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lucas,

> Sim state is already known after modem is enabled and there's no need to
> query it again. Before this patch, query_sim_state() was called upon
> huawei_enable() and huawei_pre_sim(). Both functions might call
> notify_sim_state() with a valid state. Hence we could eventually end up
> sending AT+CFUN=3D5 command twice.

patch has been applied. Thanks.

Regards

Marcel



--===============7469472167145170746==--

