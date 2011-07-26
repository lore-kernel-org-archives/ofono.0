Content-Type: multipart/mixed; boundary="===============7417834325915696903=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2] hfpmodem: fix callheld indicator
Date: Mon, 25 Jul 2011 23:06:39 -0500
Message-ID: <4E2E3D4F.1090003@gmail.com>
In-Reply-To: <1311604939-10751-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7417834325915696903==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Fr=C3=A9d=C3=A9ric,

On 07/25/2011 09:42 AM, Fr=C3=A9d=C3=A9ric Danis wrote:
> Callheld move from 1 (active and held calls) to 2 (all calls on hold) may
> result of:
> - active call has been dropped by remote,
> - an intermediate state during a call swap which will be followed by a
>   move back to 1.
> So, wait a little before checking calls state.
> ---
>  drivers/hfpmodem/voicecall.c |   16 +++++++++++++++-
>  1 files changed, 15 insertions(+), 1 deletions(-)
> =


Patch has been applied, thanks.

Regards,
-Denis

--===============7417834325915696903==--

