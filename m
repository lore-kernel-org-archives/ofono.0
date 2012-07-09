Content-Type: multipart/mixed; boundary="===============4805239218145417298=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 0/4] phonesim: CBS/USSD improvments
Date: Mon, 09 Jul 2012 11:04:03 -0500
Message-ID: <4FFB00F3.7020808@gmail.com>
In-Reply-To: <1340985183-22049-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4805239218145417298==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

On 06/29/2012 10:52 AM, Philippe Nunes wrote:
> -mDataCodingScheme is set when we need to apply the same scheme in case of
> multi-page CBS message.
> -The method 'shouldsplit' is removed since we are using directly the meth=
od
> compute size in order to check the number of pages.
> -When the text is too long, the text truncation is done directly by the m=
ethod
> 'split'.
>
> Philippe Nunes (4):
>    controbase: Remove entries in CBM UI
>    qcbsmessage: apply the same coding scheme for all the pages
>    hardwaremanipulator: Use the best scheme for CBS message
>    hardwaremanipulator: Add multi-page support for CBS message
>
>   src/control.cpp             |    9 +--
>   src/controlbase.ui          |  184 ++++++++++++++++--------------------=
-------
>   src/hardwaremanipulator.cpp |   59 +++++++-------
>   src/hardwaremanipulator.h   |    6 +-
>   src/qcbsmessage.cpp         |   38 ++++-----
>   src/qcbsmessage.h           |    1 -
>   6 files changed, 117 insertions(+), 180 deletions(-)
>

All patches in this series have been applied, thanks.

Regards,
-Denis

--===============4805239218145417298==--

