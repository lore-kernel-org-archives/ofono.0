Content-Type: multipart/mixed; boundary="===============2469201801102293978=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] hfpmodem: Fix g_at_chat leak
Date: Fri, 05 Aug 2011 17:03:43 -0500
Message-ID: <4E3C68BF.9050708@gmail.com>
In-Reply-To: <1312462082-16808-1-git-send-email-frederic.dalleau@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2469201801102293978==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Fr=C3=A9d=C3=A9ric,

On 08/04/2011 07:48 AM, Fr=C3=A9d=C3=A9ric Dalleau wrote:
> ---
>  drivers/hfpmodem/call-volume.c          |    1 +
>  drivers/hfpmodem/network-registration.c |    1 +
>  drivers/hfpmodem/voicecall.c            |    1 +
>  3 files changed, 3 insertions(+), 0 deletions(-)
> =


Patch has been applied.  Thanks for spotting this one.  This one is my
fault since I introduced it during the hfpmodem refactoring.

Regards,
-Denis

--===============2469201801102293978==--

