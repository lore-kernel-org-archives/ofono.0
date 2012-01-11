Content-Type: multipart/mixed; boundary="===============2448360691249424550=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: Re: [PATCH 0/2] Create sim atom for CDMA modems
Date: Wed, 11 Jan 2012 17:25:31 +0100
Message-ID: <4F0DB7FB.2040004@linux.intel.com>
In-Reply-To: <1326299012-13084-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2448360691249424550==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis

On 11/01/2012 17:23, Guillaume Zajac wrote:
> Hi,
>
> First patch creates a new sim driver without elementary file entries name=
d "atmodem-noef"
> Second patch creates a sim atom for CDMA modem that uses this drivers in =
case sim state is not embedded.
>
> Kind regards,
> Guillaume
>
> Guillaume Zajac (2):
>    atmodem: Create new sim driver without EF entries
>    huawei: Create sim atom for cdma modems
>
>   drivers/atmodem/sim.c |   16 ++++++++++++++++
>   plugins/huawei.c      |   12 ++++++++++++
>   2 files changed, 28 insertions(+), 0 deletions(-)
>

I didn't update my tree before creating those patch. I will send a new =

version.

Kind regards,
Guillaume

--===============2448360691249424550==--

