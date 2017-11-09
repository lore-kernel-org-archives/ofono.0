Content-Type: multipart/mixed; boundary="===============1700995888125480714=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] simauth: use new sim atom functionality for simauth
Date: Wed, 08 Nov 2017 20:54:50 -0600
Message-ID: <5730eb1c-752c-ff68-65d4-3e0edbc4526d@gmail.com>
In-Reply-To: <1510162079-9726-1-git-send-email-james.prestwood@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1700995888125480714==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi James,

On 11/08/2017 11:27 AM, James Prestwood wrote:
> All the functionality for the simauth driver was moved
> into the sim atom. This patch transitions the simauth
> atom to using those API's instead of the simauth driver
> API's.
> =

> With this change it made more sense to store each AID
> as its own object structure so the AID and object path
> could be re-used rather than generating it on the fly.
> =

> Renamed the simauth 'sim' variable to 'sa' to keep it
> consistent now that the simauth structure references
> the sim atom as 'sim'.
> ---
>   src/sim-auth.c | 400 +++++++++++++++++++++++++++++++++-----------------=
-------
>   1 file changed, 229 insertions(+), 171 deletions(-)
> =


Applied, thanks.

Regards,
-Denis


--===============1700995888125480714==--

