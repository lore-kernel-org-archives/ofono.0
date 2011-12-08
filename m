Content-Type: multipart/mixed; boundary="===============3059603300412491338=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH_v1 0/4] Manage Dormant property notification for CDMA
 modems
Date: Thu, 08 Dec 2011 06:24:49 -0600
Message-ID: <4EE0AC91.4080506@gmail.com>
In-Reply-To: <1323342030-9175-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3059603300412491338==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Guillaume,

On 12/08/2011 05:00 AM, Guillaume Zajac wrote:
> Hi,
> =

> Change log from v0:
> 	- Only notify the dormant state to the cdma-connman atom
> 	- A new set of patches will be sent to control dormancy
> 	  mode.
> =

> Kind regards,
> Guillaume
> =

> Guillaume Zajac (4):
>   cdma-connman: Add dormant state notification API
>   cdma-connman: Add dormant state notification API definition
>   huaweicdma: Tweak plugin to notify dormant state
>   cdmamodem: Register dormant state callback for huawei modems
> =

>  drivers/cdmamodem/connman.c |   42 +++++++++++++++++++++++++++++++++++++=
+++++
>  include/cdma-connman.h      |    3 +++
>  plugins/huaweicdma.c        |    7 ++++++-
>  src/cdma-connman.c          |   17 +++++++++++++++++
>  4 files changed, 68 insertions(+), 1 deletions(-)
> =


I applied all four patches with minor amendments.  In the future please
pay attention to keeping your commit headers under 50 characters per
doc/coding-style.txt item M5.

Regards,
-Denis

--===============3059603300412491338==--

