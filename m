Content-Type: multipart/mixed; boundary="===============7977249223179935414=="
MIME-Version: 1.0
From: Navik, Ankit P <ankit.p.navik@intel.com>
Subject: RE: [PATCH 3/3] coex: modified ofono.conf for coex agent
Date: Sun, 02 Dec 2018 07:27:12 +0000
Message-ID: <2F886D5F95ED3A47BC8C177EADCD1CC7282E635F@BGSMSX104.gar.corp.intel.com>
In-Reply-To: <1543571019-20631-1-git-send-email-antara.borwankar@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7977249223179935414==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Antara, =


On 11/30/2018 03:14 PM, Antara Borwankar wrote:
> From: Antara <antara.borwankar@intel.com>
> =

> Added coex agent interface to ofono.conf
> ---
>  src/ofono.conf | 1 +
>  1 file changed, 1 insertion(+)
> =

> diff --git a/src/ofono.conf b/src/ofono.conf index 61e0bde..5a3afaa 100644
> --- a/src/ofono.conf
> +++ b/src/ofono.conf
> @@ -16,6 +16,7 @@
>      <allow send_interface=3D"org.ofono.PositioningRequestAgent"/>
>      <allow send_interface=3D"org.ofono.HandsfreeAudioAgent"/>
>      <allow send_interface=3D"org.ofono.NetworkMonitorAgent"/>
> +    <allow send_interface=3D"org.ofono.LTECoexAgent"/>
Should be org.ofono.intel.LteCoexistenceAgent as per coex-api.txt

Regards, Ankit

>    </policy>
> =

>    <policy at_console=3D"true">
> --
> 1.9.1

--===============7977249223179935414==--

