Content-Type: multipart/mixed; boundary="===============3303509554605570313=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/4] atmodem/sim.c: Pass allowed response prefixes to
 gatchat.
Date: Wed, 12 May 2010 12:23:35 -0500
Message-ID: <201005121223.35421.denkenz@gmail.com>
In-Reply-To: <1273627253-7316-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3303509554605570313==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

> Not doing this creates a race condition where any notification
> comming in in the middle of a sequence of commands may be counted
> as a response to one of the commands and get lost.
> =

> Instead gatchat could be changed to give priority to registered
> unsolicited responses if a line matches one of the registered
> prefixes, especially since some non-compliant modems regularly
> send unsolicited responses in the middle of a command response.

This is why I invented prefixes in GAtChat.  Giving higher priority to =

unsolicited notifications didn't really work in the case of CGREG/CREG or o=
ther =

commands which share the same prefix on a response and unsolicited notifica=
tion.  =

Calypso is 'fun' in that respect, as you're finding out now ;)

> ---
>  drivers/atmodem/sim.c |   15 +++++++++------
>  1 files changed, 9 insertions(+), 6 deletions(-)
> =


Patch has been applied, thanks.

Regards,
-Denis

--===============3303509554605570313==--

