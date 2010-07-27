Content-Type: multipart/mixed; boundary="===============7608140688487406559=="
MIME-Version: 1.0
From: Kalle Valo <kalle.valo@canonical.com>
Subject: Re: [PATCH v2] Fix busylooped in ppp_disconnect for huawei modem
Date: Tue, 27 Jul 2010 22:45:14 +0300
Message-ID: <87pqy8k8tx.fsf@potku.valot.fi>
In-Reply-To: <1280206726-2133-1-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7608140688487406559==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Zhenhua Zhang <zhenhua.zhang@intel.com> writes:

> Huawei modem closes the modem port after PPP disconnect. So the channel
> of gatchat is NULL in ppp_disconnect. In such case, we resume the chat
> and it causes huawei_disconnect() get called and the gprs context is
> removed later.
>
> Before removing this gprs context, we should reply the pending DBus
> message to the client.

I tested the patch with my Huawei E1552 and it worked perfectly. Earlier
it was very easy to trigger the crash. I even tried some of my evil
tests and found no issues.

Tested-by: Kalle Valo <kalle.valo@canonical.com> :-)

-- =

Kalle Valo

--===============7608140688487406559==--

