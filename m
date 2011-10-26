Content-Type: multipart/mixed; boundary="===============0099098967898056278=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: Re: [PATCH v3 0/5] udev rules update
Date: Wed, 26 Oct 2011 15:21:42 +0200
Message-ID: <4EA80966.60607@linux.intel.com>
In-Reply-To: <1314782795-9816-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0099098967898056278==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis and Marcel,

On 31/08/2011 11:26, Philippe Nunes wrote:
> The modification I did in udevng.c to prevent overiding of the OFONO_LABE=
L based assignment, could break the default assignment.
> I fixed this with this new patch.
>
> Philippe Nunes (5):
>    udev: Add rules to support ZTE MF668 dongle
>    udev: Add rules to support ZTE MF190 dongle
>    udevng.c: tty assignment according OFONO_LABEL should take precedence
>    udev: Add rules to support Speedup 7300 dongle
>    udev: Add rules to support SpeedUp 9800 dongle
>
>   plugins/ofono.rules |   20 ++++++++++++++++
>   plugins/udevng.c    |   61 +++++++++++++++++++++++++++++++-------------=
------
>   2 files changed, 58 insertions(+), 23 deletions(-)
>
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono
>

As we would need this update to make some CDMA dongles working to test =

UIM implementation, do you plan to apply those patches?
Do you have another solution?
Thanks.

Kind regards,
Guillaume

--===============0099098967898056278==--

