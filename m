Content-Type: multipart/mixed; boundary="===============2283554504395326743=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2 0/6] HFP HF: External Profile
Date: Wed, 16 Jan 2013 14:16:28 -0600
Message-ID: <50F70A9C.9040500@gmail.com>
In-Reply-To: <1358343091-23350-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2283554504395326743==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Claudio,

On 01/16/2013 07:31 AM, Claudio Takahasi wrote:
> This is the first group of patches which introduces the Handsfree
> BlueZ external profile.
>
> The following patches contain only initial files and basic structures
> for the HFP HF plugin (since files and plugins names are one of the
> controversial points).
>
> Remaining HFP HF patches:
> git://git.infradead.org/users/cktakahasi/ofono.git HF-20130116
>
> Changed between v0-v1:
> * Append BlueZ version to hfp_hf* files
> * --enable-bluez4 configure option
>
> Changed between v1-v2:
> * Make BLUEZ4 conditional dependent on BLUETOOTH. BlueZ 5 is enabled by
>    default(--enable-bluetooth can be omitted), BlueZ 4 support is enabled
>    only if --enable-bluez4 is informed. --disable-bluetooth disables all
>    BlueZ related plugins.
>
> Claudio Takahasi (6):
>    Makefile: Add configure option for BlueZ 4 and 5
>    bluetooth: Add versioning information to BlueZ plugins
>    bluetooth: Initial files for BlueZ 5
>    hfp_hf: Add initial file for external HFP
>    hfp_hf: Add hfp_driver
>    hfp_hf: Add BlueZ Profile handler
>
>   Makefile.am             |  31 +-
>   configure.ac            |  20 +-
>   dundee/bluetooth.c      |   2 +-
>   plugins/bluetooth.c     | 989 -----------------------------------------=
-------
>   plugins/bluetooth.h     |  84 ----
>   plugins/bluez4.c        | 989 +++++++++++++++++++++++++++++++++++++++++=
+++++++
>   plugins/bluez4.h        |  84 ++++
>   plugins/bluez5.c        | 145 +++++++
>   plugins/bluez5.h        |  31 ++
>   plugins/dun_gw.c        |   2 +-
>   plugins/hfp_ag.c        |   2 +-
>   plugins/hfp_hf.c        | 552 ---------------------------
>   plugins/hfp_hf_bluez4.c | 552 +++++++++++++++++++++++++++
>   plugins/hfp_hf_bluez5.c | 194 ++++++++++
>   plugins/sap.c           |   2 +-
>   plugins/telit.c         |   2 +-
>   16 files changed, 2035 insertions(+), 1646 deletions(-)
>   delete mode 100644 plugins/bluetooth.c
>   delete mode 100644 plugins/bluetooth.h
>   create mode 100644 plugins/bluez4.c
>   create mode 100644 plugins/bluez4.h
>   create mode 100644 plugins/bluez5.c
>   create mode 100644 plugins/bluez5.h
>   delete mode 100644 plugins/hfp_hf.c
>   create mode 100644 plugins/hfp_hf_bluez4.c
>   create mode 100644 plugins/hfp_hf_bluez5.c
>

All 6 patches have been applied.  I did split patch 5 and 6, so it =

resulted in 8 commits.

Regards,
-Denis

--===============2283554504395326743==--

