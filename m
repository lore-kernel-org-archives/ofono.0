Content-Type: multipart/mixed; boundary="===============2980885333927660065=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: Re: [PATCH 0/5] Unify SpeedUp plugin
Date: Thu, 12 Jan 2012 11:00:58 +0100
Message-ID: <4F0EAF5A.70905@linux.intel.com>
In-Reply-To: <1326114660-10111-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2980885333927660065==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 09/01/2012 14:10, Guillaume Zajac wrote:
> Hi,
>
> Patch 1 is deleting huaweicdma label in udevng.
> I submitted it again into this set of patch to avoid conflicts.
> The 4 next patches are doing same job as for Huawei plugin on SpeedUp plu=
gin.
>
> Kind regards,
> Guillaume
>
> Guillaume Zajac (5):
>    udevng: Remove huaweicdma label from driver_list
>    speedup: Check for supported modem capabilities first
>    speedup: Create GSM/UMTS atoms only if support has been detected
>    speedup: Create CDMA atoms if support has been detected
>    udevng: Simplify vendor and driver list for SpeedUp
>
>   plugins/speedup.c |   99 ++++++++++++++++++++++++++++++++++++++++------=
------
>   plugins/udevng.c  |    3 --
>   2 files changed, 76 insertions(+), 26 deletions(-)
>
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono
>

As Marcel gave you some explanations concerning implementation are those =

patches ready to be applied or does it need some other changes?

Kind regards,
Guillaume

--===============2980885333927660065==--

