Content-Type: multipart/mixed; boundary="===============8892129107924615183=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] gprs:Add code to handle AT+CGDCONT
Date: Wed, 16 Feb 2011 00:32:11 -0600
Message-ID: <4D5B6F6B.9030805@gmail.com>
In-Reply-To: <1297775963-3426-2-git-send-email-olivier.guiter@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8892129107924615183==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Olivier,

On 02/15/2011 07:19 AM, Olivier Guiter wrote:
> ---
>  include/gprs.h |    2 +
>  src/gprs.c     |   63 ++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 65 insertions(+), 0 deletions(-)
> =


So I went in a slightly different direction with the emulator API.  Can
you please have a look?

Also, I'd really rather hold off trying to implement CGDCONT right now.
 That piece is quite nasty and generally of lower priority.  I'd like to
get the emulator a bit more hashed out first and implement the base BT
DUN & BT HFP profiles.

Regards,
-Denis

--===============8892129107924615183==--

