Content-Type: multipart/mixed; boundary="===============2311224276443925051=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] rilmodem: fix sim_status_cb debug logging
Date: Fri, 04 Dec 2015 16:27:15 -0600
Message-ID: <56621343.4070000@gmail.com>
In-Reply-To: <1449263703-14123-1-git-send-email-espy@canonical.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2311224276443925051==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Tony,

On 12/04/2015 03:15 PM, Tony Espy wrote:
> During the re-factoring of rilmodem's sim atom
> messaging code, the sim_status_cb function's
> RIL tracing code was converted to DBG calls.
> This change adds the same prefix to DBG/trace
> calls when a single message's parameters span
> more than one DBG call. This makes it easier
> to filter out trace messages when looking at a
> log file.
> ---
>   drivers/rilmodem/sim.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
>

Applied, thanks.

Regards,
-Denis


--===============2311224276443925051==--

