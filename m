Content-Type: multipart/mixed; boundary="===============2141234219410234169=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 0/2] speedup: improvement
Date: Thu, 28 Jul 2011 22:10:54 +0200
Message-ID: <1311883855.8920.117.camel@aeonflux>
In-Reply-To: <1311862570-29780-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2141234219410234169==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Bertrand,

> Remove online/offline mechanism, since speedup modem have lot of difficul=
ties to exit offline mode.
> Delay sending of &C0 to disable data carrier detect.
> =

> Bertrand Aygon (2):
>   speedup: remove online/offline mechanism.
>   speedup: delay &C0.
> =

>  plugins/speedup.c |   63 +++++++++++------------------------------------=
-----
>  1 files changed, 14 insertions(+), 49 deletions(-)

both patches have been applied. Thanks.

Regards

Marcel




--===============2141234219410234169==--

