Content-Type: multipart/mixed; boundary="===============1130886382475691727=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 1/2] bluetooth: Rename DUN GW plugin
Date: Thu, 21 Mar 2013 10:19:45 -0500
Message-ID: <514B2511.1010000@gmail.com>
In-Reply-To: <1363093290-8723-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1130886382475691727==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Fred,

On 03/12/2013 08:01 AM, Fr=C3=A9d=C3=A9ric Danis wrote:
> As BlueZ 5 introduced backwards incompatible API changes, and we want to
> keep support for BlueZ 4 based DUN GW plugin for some time, we need to
> separate DUN GW plugin which is based on BlueZ 4 from the one based on
> BlueZ 5.
>
> The dun_gw.c plugin is renamed to dun_gw_bluez4. This will make it easy
> to add a DUN GW plugin for BlueZ 5.
> ---
>   Makefile.am                           |    4 ++--
>   plugins/{dun_gw.c =3D>  dun_gw_bluez4.c} |    5 +++--
>   2 files changed, 5 insertions(+), 4 deletions(-)
>   rename plugins/{dun_gw.c =3D>  dun_gw_bluez4.c} (96%)

Patch has been applied, thanks.

Regards,
-Denis


--===============1130886382475691727==--

