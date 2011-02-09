Content-Type: multipart/mixed; boundary="===============8677770098515758038=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 0/3] gprs-provision: Add SPN to provision API
Date: Tue, 08 Feb 2011 21:58:07 -0600
Message-ID: <4D5210CF.2030307@gmail.com>
In-Reply-To: <1297159428-2409-1-git-send-email-jukka.saunamaki@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8677770098515758038==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jukka,

On 02/08/2011 04:03 AM, Jukka Saunamaki wrote:
> Hello
> =

> This patchset adds Service Provider Name (SPN) into GPRS context provisio=
ning API.
> SPN is read (asynchronously) in the middle of gprs atom registration, if =
provisioning is needed.
> =

> --Jukka
> =

> Jukka Saunamaki (3):
>       gprs-provision: add SPN to provisioning API header
>       gprs,gprs-provision: add SPN to provisioning API
>       gprs-provision: update example with SPN
> =

>  examples/provision.c     |    8 +++--
>  include/gprs-provision.h |    2 +-
>  src/gprs-provision.c     |    4 +-
>  src/gprs.c               |   87 ++++++++++++++++++++++++++++++++++------=
-----
>  src/ofono.h              |    2 +-
>  5 files changed, 74 insertions(+), 29 deletions(-)

All patches in this series have been applied, however I made one small
fix after patch 2.  Let me know if I broke anything by any chance.

Regards,
-Denis

--===============8677770098515758038==--

