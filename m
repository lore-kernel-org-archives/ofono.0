Content-Type: multipart/mixed; boundary="===============0098350894262939340=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/1] sim: fix segfault in sim atom
Date: Thu, 07 Mar 2019 10:25:27 -0600
Message-ID: <c0a93dca-c3d3-3c5b-e563-7c6317e257ac@gmail.com>
In-Reply-To: <1551936218-4164-1-git-send-email-anirudh.gargi@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0098350894262939340==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Anirudh,

On 03/06/2019 11:23 PM, Anirudh Gargi wrote:
> While adding the sim pin cache feature, pin_name could cause issue in
> cases when sim pin is not there.
> =

> log:
> ofonod[27810]: drivers/atmodem/sim.c:at_cpin_cb() crsm_pin_cb: READY
> ofonod[27810]: src/sim.c:sim_pin_query_cb() sim->pin_type: 0, pin_type: 0
> ofonod[27810]: Aborting (signal 11) [./src/ofonod]
> ofonod[27810]: ++++++++ backtrace ++++++++
> ofonod[27810]: #0  0x7fb7a7586cb0 in /lib/x86_64-linux-gnu/libc.so.6
> ofonod[27810]: #1  0x7fb7a7693cd8 in /lib/x86_64-linux-gnu/libc.so.6
> ofonod[27810]: #2  0x4d899b in sim_pin_query_cb() at src/sim.c:3174
> ofonod[27810]: #3  0x4649e7 in at_cpin_cb() at drivers/atmodem/sim.c:1304
> ofonod[27810]: #4  0x4a5d70 in at_chat_finish_command() at gatchat/gatcha=
t.c:462
> ---
>   src/sim.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> =


Applied, thanks.

Regards,
-Denis


--===============0098350894262939340==--

