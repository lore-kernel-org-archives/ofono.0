Content-Type: multipart/mixed; boundary="===============5670732811608774266=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v3 0/2] add profile version to HandsfreeAgent
Date: Mon, 08 Aug 2011 10:19:28 -0500
Message-ID: <4E3FFE80.4080508@gmail.com>
In-Reply-To: <1312814081-15279-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5670732811608774266==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Fr=C3=A9d=C3=A9ric,

On 08/08/2011 09:34 AM, Fr=C3=A9d=C3=A9ric Danis wrote:
> Some phones with HFP Audio Gateway version previous to 1.5 (i.e.
> Samsung SGH-D600 returning 0x0101 as profile version) do not accept
> an AT+BRSF with latest features.
> The Handsfree agent should adapt its AT+BRSF command depending on the
> remote version, so add version information as parameter of
> NewConnection method.
> For localhfp modem, use the highest version possible (0xFFFF) so it
> will always send all implemented features.
> =

> Fr=C3=A9d=C3=A9ric Danis (2):
>   hfpmodem: fix hf features
>   hfp_hf: retrieve AG version
> =

>  drivers/hfpmodem/slc.c |    7 ++++++-
>  drivers/hfpmodem/slc.h |    5 ++++-
>  plugins/hfp_hf.c       |    9 +++++----
>  plugins/phonesim.c     |    2 +-
>  4 files changed, 16 insertions(+), 7 deletions(-)

Both have been applied, thanks.

Regards,
-Denis

--===============5670732811608774266==--

