Content-Type: multipart/mixed; boundary="===============2510260956160517252=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC PATCH 3/5] sim: check if Fixed Dial is enabled in SIM-card
Date: Fri, 22 Oct 2010 12:22:04 -0500
Message-ID: <4CC1C83C.1050109@gmail.com>
In-Reply-To: <1287673093-3022-4-git-send-email-petteri.tikander@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2510260956160517252==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Petteri,

On 10/21/2010 09:58 AM, Petteri Tikander wrote:
> If SIM-card is inserted, status is checked from EFsst
> (is FDN activated) and EFadn (is ADN invalidated).
> If USIM-card is inserted, status is checked from EFest
> (is FDN activated).
> =

> If FD is enabled, halt SIM initialization procedure.
> New property (FixedDialing) is added. If FD is enabled,
> this has been signalled via DBUS.
> ---
>  src/sim.c |   68 +++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 files changed, 68 insertions(+), 0 deletions(-)
> =


Patch has been applied, but I made some style fixes afterwards.  Please
make sure that I haven't broken anything.  I tested this briefly with
phonesim and everything was working as expected, so I went ahead and
marked this task as done on the TODO list.

Can you test this on both 3G and 2G enabled FDN sims and report back if
everything is working as expected on real hardware?

Regards,
-Denis

--===============2510260956160517252==--

