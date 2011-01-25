Content-Type: multipart/mixed; boundary="===============5350036078033786029=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: Re: [PATCH 00/21] Resubmit Zhenhua Zhang work on DUN server with btio
Date: Tue, 25 Jan 2011 17:07:05 -0200
Message-ID: <20110125190705.GC2205@joana>
In-Reply-To: <1294852564-1258-1-git-send-email-frederic.dalleau@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5350036078033786029==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi all,

* Fr=C3=A9d=C3=A9ric Dalleau <frederic.dalleau@intel.com> [2011-01-12 18:=
15:43 +0100]:

> This is rebased as of head of today
> =

> Zhenhua Zhang (21):
>   bluetooth: Add reference count for bluetooth utils
>   bluetooth: Add Btio library for DUN
>   bluetooth: Add bluetooth server support for DUN
>   emulator: Add emulator atom in oFono
>   dun_gw: Add DUN server plugin for oFono
>   gprs: Rename status_watch to netreg_status_watch
>   emulator: Add status watches for ofono emulator
>   emulator: Add emulator status watches in gprs atom
>   emulator: Add APIs to send GAtServer result
>   emulator: Implement dialing up for DUN
>   gprs: Make gprs_proto_to/from_string non-static
>   gprs: ignore the case of proto str when comparing
>   emulator: Register mandatory AT command handlers
>   gprs: Refactor to share remove_context method
>   gprs: Add DUN +CGATT support in gprs atom
>   gprs: Add DUN +CGDCONT support in gprs atom
>   gprs: Add DUN server GPRS connect support
>   gprs: Add status watch functions
>   gprs: Add gprs_get_status
>   emulator: Watch GPRS status changes
>   emulator: Watch netreg status changes
> =

>  Makefile.am            |   15 +-
>  btio/btio.c            | 1299 ++++++++++++++++++++++++++++++++++++++++++=
++++++
>  btio/btio.h            |   97 ++++
>  configure.ac           |    5 +
>  include/emulator.h     |   94 ++++
>  include/gprs-context.h |    4 +
>  include/gprs.h         |   11 +
>  plugins/bluetooth.c    |  441 ++++++++++++++++-
>  plugins/bluetooth.h    |   15 +
>  plugins/dun_gw.c       |  115 +++++
>  src/emulator.c         | 1072 +++++++++++++++++++++++++++++++++++++++
>  src/gprs.c             |  500 +++++++++++++++++--
>  src/modem.c            |    1 +
>  src/ofono.h            |   31 ++
>  14 files changed, 3636 insertions(+), 64 deletions(-)
>  create mode 100644 btio/btio.c
>  create mode 100644 btio/btio.h
>  create mode 100644 include/emulator.h
>  create mode 100644 plugins/dun_gw.c
>  create mode 100644 src/emulator.c

So I took this patches as a base to finish the DUN implementation on oFono.
The DUN Server is now working, it accepts a ATD*99 from the client and start
the PPP negotiation, then create the ppp interface to flow the internet
connection to the client. Code is here:

git://git.profusion.mobi/users/padovan/ofono.git dun

This not rebased upstream because I didn't touch the bluetooth patches yet,
mostly due the fact that Fr=C3=A9d=C3=A9ric Danis is working on them.

The next step is to implement the packet forwarding to the ppp interface
inside ConnMan, you can follow the discussion and implementation in the
ConnMan mailing list.

http://www.mail-archive.com/connman(a)connman.net/msg03092.html

-- =

Gustavo F. Padovan
http://profusion.mobi

--===============5350036078033786029==--

