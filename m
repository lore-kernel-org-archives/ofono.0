Content-Type: multipart/mixed; boundary="===============7688459333764263499=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] emulator: force creation of atom at modem offline state
Date: Thu, 17 Feb 2011 11:26:23 -0600
Message-ID: <4D5D5A3F.8010705@gmail.com>
In-Reply-To: <1297963409-9798-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7688459333764263499==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Fr=C3=A9d=C3=A9ric,

On 02/17/2011 11:23 AM, Fr=C3=A9d=C3=A9ric Danis wrote:
> this allows to fix problem when atom created in online state
> are destroyed when modem goes to offline state
> ---
>  src/emulator.c |    3 ++-
>  src/modem.c    |   14 ++++++++++++++
>  src/ofono.h    |    5 +++++
>  3 files changed, 21 insertions(+), 1 deletions(-)
> =


Patch has been applied, thanks.

Regards,
-Denis

--===============7688459333764263499==--

