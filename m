Content-Type: multipart/mixed; boundary="===============3198654448713816679=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/4] Add SIM filesystem watch api.
Date: Mon, 07 Feb 2011 13:48:57 -0600
Message-ID: <4D504CA9.4010608@gmail.com>
In-Reply-To: <1296782434-11008-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3198654448713816679==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 02/03/2011 07:20 PM, Andrzej Zaborowski wrote:
> This allows code that reads files from the SIM card to also watch for
> changes in these files signalled in a Refresh command by the SIM.
> ---
>  include/sim.h |    9 +++++++++
>  1 files changed, 9 insertions(+), 0 deletions(-)
> =


So I pushed my own implementation of these based on ofono_watchlist.  I
think it was a bit cleaner than your proposal.  Can you check that these
patches make sense to you?

Regards,
-Denis

--===============3198654448713816679==--

