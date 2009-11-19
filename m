Content-Type: multipart/mixed; boundary="===============8697414601383175415=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] Fix: Poll CLCC to replace the code in call_held=1
Date: Thu, 19 Nov 2009 07:39:07 +0100
Message-ID: <1258612747.2003.174.camel@violet>
In-Reply-To: <1258600876.5440.0.camel@zzhan17-mobl.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8697414601383175415==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Zhenhua,

> When using CHLD=3D2x in multiparty call, call_held is 1 and we
> should not swap all active->held. So we cannot save this pull
> in private chat.
> ---
>  drivers/hfpmodem/voicecall.c |   50
> +++++------------------------------------
>  1 files changed, 6 insertions(+), 44 deletions(-)

patch is corrupted. Please send again or better even use git send-email
for sending it.

Regards

Marcel



--===============8697414601383175415==--

