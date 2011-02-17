Content-Type: multipart/mixed; boundary="===============6275724906436757280=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/9] modem.c: Go to PRE_SIM modem state on
 OFONO_SIM_STATE_INSERTED.
Date: Thu, 17 Feb 2011 15:00:04 -0600
Message-ID: <4D5D8C54.1060408@gmail.com>
In-Reply-To: <1297756739-2958-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6275724906436757280==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 02/15/2011 01:58 AM, Andrzej Zaborowski wrote:
> The assumption so far was that SIM state would only go from
> NOT_PRESENT -> INSERTED -> READY -> NOT_PRESENT because there's
> no method to unauthenticate from SIM without removing.  We need to
> be able to switch to INSERTED when SIM is being reset,
> reinitialised, etc. because going to NOT_PRESENT and then
> immediately INSERTED would be logically wrong.
> ---
>  src/modem.c |   12 ++++++++----
>  1 files changed, 8 insertions(+), 4 deletions(-)

I applied this patch, but partly refactored it in a later commit.  Can
you check that I didn't screw something up?

Regards,
-Denis

--===============6275724906436757280==--

