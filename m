Content-Type: multipart/mixed; boundary="===============4790650644493685302=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCHv3 0/4] Unify SPN reading logic
Date: Wed, 18 Jan 2012 13:04:06 -0600
Message-ID: <4F1717A6.3060201@gmail.com>
In-Reply-To: <1326887789-16478-1-git-send-email-oleg.zhurakivskyy@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4790650644493685302==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Oleg,

On 01/18/2012 05:56 AM, Oleg Zhurakivskyy wrote:
> Hello,
> =

> Please find the changes in order not to duplicate the SPN reading logic i=
n src/grps.c and src/network.c.
> =

> Changes from v2:
> =

> - Removed sim_watch() capability from gprs.c
> - Corrected the operator name emission logic.
> - In order to save some memory, netreg accesses the spn directly
>   from the sim atom.
> =

> Regards,
> Oleg
> =

> Oleg Zhurakivskyy (4):
>   gprs: Use sim SPN watch API
>   network: Use sim SPN watch API
>   sim: Add ofono_sim_get_spn()
>   network: Access SPN directly from the sim atom
> =

>  include/sim.h |    1 +
>  src/gprs.c    |   71 ++++++++++-------------
>  src/network.c |  171 ++++++---------------------------------------------=
------
>  src/sim.c     |    8 +++
>  4 files changed, 58 insertions(+), 193 deletions(-)
> =


All four patches have been applied, thanks.  I did break up patch 3 into
two patches and performed some minor refactoring afterwards.  Please
review and make sure I didn't screw anything up.

Regards,
-Denis

--===============4790650644493685302==--

