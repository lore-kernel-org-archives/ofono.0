Content-Type: multipart/mixed; boundary="===============4984864438628023979=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 02/14] ublox: drop vendor type for Toby L2 model
Date: Wed, 13 Mar 2019 13:21:39 -0500
Message-ID: <9ea72390-6eae-6c46-483a-f934125e29dd@gmail.com>
In-Reply-To: <20190312111008.29258-3-jonas@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4984864438628023979==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On 03/12/2019 06:09 AM, Jonas Bonn wrote:
> The 'Toby L2'-specific vendor type is used only to prevent the CMER
> command from attempting to set mode '3'.  For all u-blox models, mode
> '3' is just an alias for mode '1'.  As such, mode '1' can be used in
> place of mode '3', removing the model-specific quirk in favour of a
> vendor-specific quirk.
> =

> With this change, the L2-specific vendor type is no longer needed.
> ---
>   drivers/atmodem/gprs.c                 | 1 -
>   drivers/atmodem/network-registration.c | 7 +++++--
>   drivers/atmodem/sim.c                  | 1 -
>   drivers/atmodem/vendor.h               | 1 -
>   plugins/ublox.c                        | 7 +++----
>   5 files changed, 8 insertions(+), 9 deletions(-)
> =


I split this up into 3 commits in line with our patch submission guidelines.

Applied, thanks.

Regards,
-Denis


--===============4984864438628023979==--

