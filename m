Content-Type: multipart/mixed; boundary="===============2947814907488827440=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCHv2 1/4] sim: header definitions for AID session APIs
Date: Fri, 03 Nov 2017 18:04:06 -0500
Message-ID: <00a7ec6c-ff37-4f4e-003d-029052dade77@gmail.com>
In-Reply-To: <1509748484-8773-1-git-send-email-james.prestwood@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2947814907488827440==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 11/03/2017 05:34 PM, James Prestwood wrote:
> ISIM and newer AID's require opening a logical channel to read
> their EF's. This requires new driver API's to discover AID's,
> open/close a channel, and reading the EF's from an opened channel.
> =

> This functionality was moved from the simauth module.
> ---
>   include/sim.h | 30 ++++++++++++++++++++++++++++++
>   src/ofono.h   | 27 +++++++++++++++++++++++++++
>   2 files changed, 57 insertions(+)
> =


Patches 1-3 applied, thanks.

Regards,
-Denis


--===============2947814907488827440==--

