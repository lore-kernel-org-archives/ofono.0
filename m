Content-Type: multipart/mixed; boundary="===============6754003292741589746=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCHv3 2/2] quectel: support own cmux implementation over
 kernel line discipline
Date: Fri, 11 Oct 2019 12:20:51 -0500
Message-ID: <d5cc6e8a-09e6-3846-dd10-af4159f4a0e7@gmail.com>
In-Reply-To: <20191007213959.20110-2-martin@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6754003292741589746==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Martin,

On 10/7/19 4:39 PM, Martin Hundeb=C3=B8ll wrote:
> The in-kernel implementation of gsm0710 causes deadlocks in the
> kernel[1], so switch the default back to the user-space implementation
> in ofono.
> =

> The change also removes the timeout-callback used to defer disabling the
> n_gsm line discipline, as that is no longer needed[2]
> =

> To enable use of the kernel line discipline, add an udev env entry with
> OFONO_QUECTEL_MUX=3D"n_gsm".
> =

> [1] https://lore.kernel.org/lkml/4b2455c0-25ba-0187-6df6-c63b4ccc6a6e(a)g=
eanix.com/
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/?id=3D7030082a7415d18e3befdf1f9ec05b3d5de98de4
> ---
> =

> Changes since v2:
>   * keep kernel line discipline support
>   * remove unrelated check in quectel_disable()
>   * remove unrelated setting of AT+IFC=3D0,0
>   * revert to using at_util_open_device()
> =

>   plugins/quectel.c | 202 ++++++++++++++++++++++++++++++++++++----------
>   plugins/udevng.c  |   5 ++
>   2 files changed, 166 insertions(+), 41 deletions(-)
> =



I split this patch up into two and squashed this warning:

plugins/quectel.c:936:14: error: unused variable =E2=80=98device=E2=80=99 =

[-Werror=3Dunused-variable]
   936 |  GIOChannel *device;
       |              ^~~~~~

by taking out the offending variable declaration.

Applied, thanks.

Regards,
-Denis
--===============6754003292741589746==--

