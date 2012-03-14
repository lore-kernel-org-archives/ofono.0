Content-Type: multipart/mixed; boundary="===============5448963860695338674=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/4] voicecall: Improve transitions check
Date: Tue, 13 Mar 2012 21:44:35 -0500
Message-ID: <4F600613.4050404@gmail.com>
In-Reply-To: <1331306815-13424-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5448963860695338674==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Fr=C3=A9d=C3=A9ric,

On 03/09/2012 09:26 AM, Fr=C3=A9d=C3=A9ric Danis wrote:
> Indicators should not be updated if:
> - multiple separate calls are active at same time
> - a conf call and a call are active at same time
> - multiple separate calls are held at same time
> - a conf call and a call are held at same time
> - a conf call has call in active and held state
> ---
>  src/voicecall.c |   29 +++++++++++++++++------------
>  1 files changed, 17 insertions(+), 12 deletions(-)
> =


Patch has been applied, thanks.

Regards,
-Denis

--===============5448963860695338674==--

