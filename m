Content-Type: multipart/mixed; boundary="===============4142698150688446121=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] atmodem: Fix use after free in sim_state_cb
Date: Thu, 05 Oct 2017 11:11:37 -0500
Message-ID: <bcffc506-5555-e073-4750-0ddf28706729@gmail.com>
In-Reply-To: <1507217783-13414-1-git-send-email-slava.monich@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4142698150688446121==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Slava,

On 10/05/2017 10:36 AM, Slava Monich wrote:
> =3D=3D2941=3D=3D Invalid read of size 4
> =3D=3D2941=3D=3D    at 0x69338: sim_state_cb (sim.c:1301)
> =3D=3D2941=3D=3D    by 0x71DCB: cpin_check_cb (atutil.c:567)
> =3D=3D2941=3D=3D    by 0xA602B: at_chat_finish_command (gatchat.c:459)
> =3D=3D2941=3D=3D    by 0xA6277: at_chat_handle_command_response (gatchat.=
c:521)
> =3D=3D2941=3D=3D    by 0xA6587: have_line (gatchat.c:600)
> =3D=3D2941=3D=3D    by 0xA6BB7: new_bytes (gatchat.c:759)
> =3D=3D2941=3D=3D    by 0xAAFAF: received_data (gatio.c:124)
> =3D=3D2941=3D=3D    by 0x4AF606F: g_main_dispatch (gmain.c:3154)
> =3D=3D2941=3D=3D    by 0x4AF606F: g_main_context_dispatch (gmain.c:3769)
> =3D=3D2941=3D=3D    by 0x4AF658F: g_main_loop_run (gmain.c:4034)
> =3D=3D2941=3D=3D    by 0xBDDBB: main (main.c:261)
> =3D=3D2941=3D=3D  Address 0x519c344 is 4 bytes inside a block of size 12 =
free'd
> =3D=3D2941=3D=3D    at 0x4840B28: free (vg_replace_malloc.c:530)
> =3D=3D2941=3D=3D    by 0x71F33: at_util_sim_state_query_free (atutil.c:61=
3)
> =3D=3D2941=3D=3D    by 0x6930B: sim_state_cb (sim.c:1297)
> =3D=3D2941=3D=3D    by 0x71DCB: cpin_check_cb (atutil.c:567)
> =3D=3D2941=3D=3D    by 0xA602B: at_chat_finish_command (gatchat.c:459)
> =3D=3D2941=3D=3D    by 0xA6277: at_chat_handle_command_response (gatchat.=
c:521)
> =3D=3D2941=3D=3D    by 0xA6587: have_line (gatchat.c:600)
> =3D=3D2941=3D=3D    by 0xA6BB7: new_bytes (gatchat.c:759)
> =3D=3D2941=3D=3D    by 0xAAFAF: received_data (gatio.c:124)
> =3D=3D2941=3D=3D    by 0x4AF606F: g_main_dispatch (gmain.c:3154)
> =3D=3D2941=3D=3D    by 0x4AF606F: g_main_context_dispatch (gmain.c:3769)
> =3D=3D2941=3D=3D    by 0x4AF658F: g_main_loop_run (gmain.c:4034)
> =3D=3D2941=3D=3D    by 0xBDDBB: main (main.c:261)
> ---
>   drivers/atmodem/sim.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> =


Applied, thanks.

Regards,
-Denis


--===============4142698150688446121==--

