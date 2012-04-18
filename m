Content-Type: multipart/mixed; boundary="===============3508111585068659713=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v3] SpeedUp: enable online/offline
Date: Wed, 18 Apr 2012 04:03:17 -0500
Message-ID: <4F8E8355.4050703@gmail.com>
In-Reply-To: <1334581808-5380-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3508111585068659713==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Bertrand,

On 04/16/2012 08:10 AM, Bertrand Aygon wrote:
> Add speedup_set_online.
> Add a polling mechanism since most speedup dongles failed in couple of
> AT commands following the CFUN=3D1 when they are offline.
> Cleanup online polling in case modem is removed during online process.
> =

> ---
>  plugins/speedup.c |  113 +++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 files changed, 113 insertions(+), 0 deletions(-)
> =


Patch has been applied, thanks.

Regards,
-Denis

--===============3508111585068659713==--

