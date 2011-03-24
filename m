Content-Type: multipart/mixed; boundary="===============6446344874200771764=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] voicecall: fix voicecalls_release_queue
Date: Thu, 24 Mar 2011 13:30:35 -0500
Message-ID: <4D8B8DCB.6060806@gmail.com>
In-Reply-To: <1300988602-12513-1-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6446344874200771764==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Fr=C3=A9d=C3=A9ric,

On 03/24/2011 12:43 PM, Fr=C3=A9d=C3=A9ric Danis wrote:
> voicecalls_release_queue uses struct ofono_call instead of
> struct voicecall (which is used in "calls" list parameter and
> function voicecalls_release_next)
> ---
>  src/voicecall.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> =


Good spot, patch has been applied, thanks.

Regards,
-Denis

--===============6446344874200771764==--

