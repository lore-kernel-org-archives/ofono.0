Content-Type: multipart/mixed; boundary="===============7342974146265406245=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 01/12] include: Expose voicecall related enums to plugins
Date: Mon, 25 Jun 2018 10:40:44 -0500
Message-ID: <71ec295d-001b-1f8b-cc67-37cc12fde5fd@gmail.com>
In-Reply-To: <1529601661-4856-1-git-send-email-slava.monich@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7342974146265406245==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Slava,

On 06/21/2018 12:20 PM, Slava Monich wrote:
> ---
>   include/types.h | 31 +++++++++++++++++++++++++++++++
>   1 file changed, 31 insertions(+)
> =


Can you help me understand what is the motivation behind this?  In the =

past we opted not to expose OFONO enums for well-known values (e.g. =

those defined in 27.007).

Internally oFono uses defines from common.h and builtin drivers can =

easily access that as well if code clarity is needed.

Also note that certain values (e.g. DISCONNECTED) are not meant to be =

used outside of the core and are not defined by 27.007.  They're special =

cases that are handled by e.g. ofono_voicecall_disconnected.

Regards,
-Denis

--===============7342974146265406245==--

