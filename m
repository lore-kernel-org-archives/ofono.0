Content-Type: multipart/mixed; boundary="===============7907095533040803984=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH_v2 0/2] Create sim atom for CDMA modems
Date: Wed, 11 Jan 2012 06:50:57 -0600
Message-ID: <4F0D85B1.1060702@gmail.com>
In-Reply-To: <1326299314-13617-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7907095533040803984==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Guillaume,

On 01/11/2012 10:28 AM, Guillaume Zajac wrote:
> Hi,
> =

> This new version contains patches from updated tree.
> =

> Kind regards,
> Guillaume
> =

> Guillaume Zajac (2):
>   atmodem: Create new sim driver without EF entries
>   huawei: Create sim atom for cdma modems
> =

>  drivers/atmodem/sim.c |   16 ++++++++++++++++
>  plugins/huawei.c      |   12 ++++++++++++
>  2 files changed, 28 insertions(+), 0 deletions(-)
> =


Both patches have been applied, however I refactored the second one
slightly in a follow-on commit.  Please make sure I didn't screw
anything up.

Regards,
-Denis

--===============7907095533040803984==--

