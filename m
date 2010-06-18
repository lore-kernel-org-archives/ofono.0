Content-Type: multipart/mixed; boundary="===============6271518401720061501=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 11/11] gsmdial: Delay ppp_unref after IO processing
Date: Fri, 18 Jun 2010 12:51:45 -0500
Message-ID: <201006181251.45666.denkenz@gmail.com>
In-Reply-To: <33AB447FBD802F4E932063B962385B351F309A0F@shsmsx501.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6271518401720061501==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Zhenhua,

> I think we should delay the ppp shutdown stage until the LCP packet was
>  well processed. I got valgrind result as below before I have patches 10/=
11
>  and 11/11.
> =

> Entering new phase: 0
> PPP Link down: 6
> =3D=3D5332=3D=3D Invalid write of size 2
> =3D=3D5332=3D=3D    at 0x805520D: new_bytes (gathdlc.c:154)
> =3D=3D5332=3D=3D    by 0x804F2E6: received_data (gatio.c:119)
> =3D=3D5332=3D=3D    by 0x40AFDAA: g_io_unix_dispatch (giounix.c:162)
> =3D=3D5332=3D=3D    by 0x4078E87: g_main_context_dispatch (gmain.c:1960)
> =3D=3D5332=3D=3D    by 0x407C72F: g_main_context_iterate (gmain.c:2591)
> =3D=3D5332=3D=3D    by 0x407CB9E: g_main_loop_run (gmain.c:2799)
> =3D=3D5332=3D=3D    by 0x804BE5D: main (gsmdial.c:702)
> =3D=3D5332=3D=3D  Address 0x4382130 is 24 bytes inside a block of size 88=
 free'd
> =3D=3D5332=3D=3D    at 0x4024886: free (vg_replace_malloc.c:325)
> =3D=3D5332=3D=3D    by 0x4081195: g_free (gmem.c:190)
> =3D=3D5332=3D=3D    by 0x805557D: g_at_hdlc_unref (gathdlc.c:270)
> =3D=3D5332=3D=3D    by 0x8056316: g_at_ppp_unref (gatppp.c:463)
> =3D=3D5332=3D=3D    by 0x804AF20: ppp_disconnect (gsmdial.c:272)
> =3D=3D5332=3D=3D    by 0x8055CE9: ppp_dead (gatppp.c:204)
> =3D=3D5332=3D=3D    by 0x8055D1E: ppp_enter_phase (gatppp.c:214)
> =3D=3D5332=3D=3D    by 0x8055FE0: ppp_lcp_finished_notify (gatppp.c:317)
> =3D=3D5332=3D=3D    by 0x8057E27: lcp_finished (ppp_lcp.c:140)
> =3D=3D5332=3D=3D    by 0x80568DF: pppcp_this_layer_finished (ppp_cp.c:340)
> =3D=3D5332=3D=3D    by 0x8057446: pppcp_generate_event (ppp_cp.c:688)
> =3D=3D5332=3D=3D    by 0x8057B5B: pppcp_process_packet (ppp_cp.c:965)

Good catch, however I fixed it slightly differently in GAtHDLC itself.  Can=
 you =

test and make sure my fix works?

Thanks,
-Denis

--===============6271518401720061501==--

