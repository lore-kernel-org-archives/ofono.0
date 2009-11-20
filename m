Content-Type: multipart/mixed; boundary="===============7290123860740817146=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: RE: [PATCH] Fix: Poll CLCC to replace the code in call_held=1
Date: Fri, 20 Nov 2009 09:38:18 +0100
Message-ID: <1258706298.16863.1.camel@violet>
In-Reply-To: <0463F45F3606F4428ED35AC8C709F92E089CDD1DF8@pdsmsx502.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7290123860740817146==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Zhenhua,

> >> When using CHLD=3D2x in multiparty call, call_held is 1 and we should
> >> not swap all active->held. So we cannot save this pull in private
> >> chat. ---
> >>  drivers/hfpmodem/voicecall.c |   50
> >> +++++------------------------------------
> >>  1 files changed, 6 insertions(+), 44 deletions(-)
> > =

> > patch is corrupted. Please send again or better even use git
> > send-email for sending it. =

> =

> Thanks Marcel. Patch has been attached. The evolution wrapped the line
> that over 80 characters so the patch is corrupted. I will try to use git =

> send-email next time.

patch has been applied. Thanks.

Regards

Marcel



--===============7290123860740817146==--

