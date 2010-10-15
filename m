Content-Type: multipart/mixed; boundary="===============5282891859682359212=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC PATCH 7/8] sim: check if Fixed Dialing is enabled in the
 SIM-card
Date: Fri, 15 Oct 2010 07:33:27 -0500
Message-ID: <4CB84A17.80805@gmail.com>
In-Reply-To: <1287090175-3018-8-git-send-email-petteri.tikander@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5282891859682359212==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Petteri,

On 10/14/2010 04:02 PM, Petteri Tikander wrote:
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


Can you update this patch to use the sim_fs_read_info API?  Otherwise it
looks good.  Have you tested this with real modems / sim cards?

Regards,
-Denis

--===============5282891859682359212==--

