Content-Type: multipart/mixed; boundary="===============1830818324862166885=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] phonesim: Extend STK menu for BIP commands sanity testing
Date: Fri, 08 Jul 2011 14:42:22 -0500
Message-ID: <4E175D9E.9070306@gmail.com>
In-Reply-To: <1309796760-27584-1-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1830818324862166885==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

On 07/04/2011 11:26 AM, Philippe Nunes wrote:
> For sanity testing regarding the BIP commands, the BIP  menu is enriched =
with the Open channel TCP and Open channel UDP items.
> For both, the destination adress is set as the locahost port '12348'
> With a TCP/UDP server listen to this destination address (like netcat), i=
t's possible to check the connection (for TCP) and the data exchange (sendi=
ng/receiving).
> ---
>  src/simapplication.cpp |  126 +++++++++++++++++++++++++++++++++++++++---=
------
>  1 files changed, 103 insertions(+), 23 deletions(-)
> =


Patch has been applied, thanks.

Regards,
-Denis

--===============1830818324862166885==--

