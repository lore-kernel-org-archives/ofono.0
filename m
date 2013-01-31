Content-Type: multipart/mixed; boundary="===============0282274247742310733=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] bluetooth: Rename HFP AG plugin
Date: Thu, 31 Jan 2013 16:02:07 -0600
Message-ID: <510AE9DF.90708@gmail.com>
In-Reply-To: <1359456160-9514-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0282274247742310733==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Fr=C3=A9d=C3=A9ric,

On 01/29/2013 04:42 AM, Fr=C3=A9d=C3=A9ric Danis wrote:
> As BlueZ 5 introduced backwards incompatible API changes, and we want to
> keep support for BlueZ 4 based HFP AG plugin for some time, we need to
> separate HFP AG plugin which is based on BlueZ 4 from the one based on
> BlueZ 5.
>
> The hfp_ag.c plugin is renamed to hfp_ag_bluez4. This will make it easy
> to add an HFP AG plugin for BlueZ 5.
> ---
>   Makefile.am                           |    4 ++--
>   plugins/{hfp_ag.c =3D>  hfp_ag_bluez4.c} |    5 +++--
>   2 files changed, 5 insertions(+), 4 deletions(-)
>   rename plugins/{hfp_ag.c =3D>  hfp_ag_bluez4.c} (97%)

Patch has been applied, thanks.

Regards,
-Denis


--===============0282274247742310733==--

