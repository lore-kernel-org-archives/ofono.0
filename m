Content-Type: multipart/mixed; boundary="===============8506013569152686013=="
MIME-Version: 1.0
From: Zhang, Zhenhua <zhenhua.zhang@intel.com>
Subject: RE: [PATCH 11/11] gsmdial: Delay ppp_unref after IO processing
Date: Sat, 12 Jun 2010 14:03:15 +0800
Message-ID: <33AB447FBD802F4E932063B962385B351F309A0F@shsmsx501.ccr.corp.intel.com>
In-Reply-To: <1276321850-13307-12-git-send-email-zhenhua.zhang@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8506013569152686013==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

Zhenhua Zhang wrote:
> ---
> gatchat/gsmdial.c |   17 +++++++++++++++--
> 1 files changed, 15 insertions(+), 2 deletions(-)
> =

> diff --git a/gatchat/gsmdial.c b/gatchat/gsmdial.c
> index 59f1a5c..d6cacc5 100644
> --- a/gatchat/gsmdial.c
> +++ b/gatchat/gsmdial.c

I think we should delay the ppp shutdown stage until the LCP packet was wel=
l processed. I got valgrind result as below before I have patches 10/11 and=
 11/11.

Entering new phase: 0
PPP Link down: 6
=3D=3D5332=3D=3D Invalid write of size 2
=3D=3D5332=3D=3D    at 0x805520D: new_bytes (gathdlc.c:154)
=3D=3D5332=3D=3D    by 0x804F2E6: received_data (gatio.c:119)
=3D=3D5332=3D=3D    by 0x40AFDAA: g_io_unix_dispatch (giounix.c:162)
=3D=3D5332=3D=3D    by 0x4078E87: g_main_context_dispatch (gmain.c:1960)
=3D=3D5332=3D=3D    by 0x407C72F: g_main_context_iterate (gmain.c:2591)
=3D=3D5332=3D=3D    by 0x407CB9E: g_main_loop_run (gmain.c:2799)
=3D=3D5332=3D=3D    by 0x804BE5D: main (gsmdial.c:702)
=3D=3D5332=3D=3D  Address 0x4382130 is 24 bytes inside a block of size 88 f=
ree'd
=3D=3D5332=3D=3D    at 0x4024886: free (vg_replace_malloc.c:325)
=3D=3D5332=3D=3D    by 0x4081195: g_free (gmem.c:190)
=3D=3D5332=3D=3D    by 0x805557D: g_at_hdlc_unref (gathdlc.c:270)
=3D=3D5332=3D=3D    by 0x8056316: g_at_ppp_unref (gatppp.c:463)
=3D=3D5332=3D=3D    by 0x804AF20: ppp_disconnect (gsmdial.c:272)
=3D=3D5332=3D=3D    by 0x8055CE9: ppp_dead (gatppp.c:204)
=3D=3D5332=3D=3D    by 0x8055D1E: ppp_enter_phase (gatppp.c:214)
=3D=3D5332=3D=3D    by 0x8055FE0: ppp_lcp_finished_notify (gatppp.c:317)
=3D=3D5332=3D=3D    by 0x8057E27: lcp_finished (ppp_lcp.c:140)
=3D=3D5332=3D=3D    by 0x80568DF: pppcp_this_layer_finished (ppp_cp.c:340)
=3D=3D5332=3D=3D    by 0x8057446: pppcp_generate_event (ppp_cp.c:688)
=3D=3D5332=3D=3D    by 0x8057B5B: pppcp_process_packet (ppp_cp.c:965)
=3D=3D5332=3D=3D =

=3D=3D5332=3D=3D Invalid write of size 4
=3D=3D5332=3D=3D    at 0x8055216: new_bytes (gathdlc.c:155)
=3D=3D5332=3D=3D    by 0x804F2E6: received_data (gatio.c:119)
=3D=3D5332=3D=3D    by 0x40AFDAA: g_io_unix_dispatch (giounix.c:162)
=3D=3D5332=3D=3D    by 0x4078E87: g_main_context_dispatch (gmain.c:1960)
=3D=3D5332=3D=3D    by 0x407C72F: g_main_context_iterate (gmain.c:2591)
=3D=3D5332=3D=3D    by 0x407CB9E: g_main_loop_run (gmain.c:2799)
=3D=3D5332=3D=3D    by 0x804BE5D: main (gsmdial.c:702)
=3D=3D5332=3D=3D  Address 0x438212c is 20 bytes inside a block of size 88 f=
ree'd
=3D=3D5332=3D=3D    at 0x4024886: free (vg_replace_malloc.c:325)
=3D=3D5332=3D=3D    by 0x4081195: g_free (gmem.c:190)
=3D=3D5332=3D=3D    by 0x805557D: g_at_hdlc_unref (gathdlc.c:270)
=3D=3D5332=3D=3D    by 0x8056316: g_at_ppp_unref (gatppp.c:463)
=3D=3D5332=3D=3D    by 0x804AF20: ppp_disconnect (gsmdial.c:272)
=3D=3D5332=3D=3D    by 0x8055CE9: ppp_dead (gatppp.c:204)
=3D=3D5332=3D=3D    by 0x8055D1E: ppp_enter_phase (gatppp.c:214)
=3D=3D5332=3D=3D    by 0x8055FE0: ppp_lcp_finished_notify (gatppp.c:317)
=3D=3D5332=3D=3D    by 0x8057E27: lcp_finished (ppp_lcp.c:140)
=3D=3D5332=3D=3D    by 0x80568DF: pppcp_this_layer_finished (ppp_cp.c:340)
=3D=3D5332=3D=3D    by 0x8057446: pppcp_generate_event (ppp_cp.c:688)
=3D=3D5332=3D=3D    by 0x8057B5B: pppcp_process_packet (ppp_cp.c:965)
=3D=3D5332=3D=3D =

=3D=3D5332=3D=3D Invalid read of size 4
=3D=3D5332=3D=3D    at 0x80552CB: new_bytes (gathdlc.c:167)
=3D=3D5332=3D=3D    by 0x804F2E6: received_data (gatio.c:119)
=3D=3D5332=3D=3D    by 0x40AFDAA: g_io_unix_dispatch (giounix.c:162)
=3D=3D5332=3D=3D    by 0x4078E87: g_main_context_dispatch (gmain.c:1960)
=3D=3D5332=3D=3D    by 0x407C72F: g_main_context_iterate (gmain.c:2591)
=3D=3D5332=3D=3D    by 0x407CB9E: g_main_loop_run (gmain.c:2799)
=3D=3D5332=3D=3D    by 0x804BE5D: main (gsmdial.c:702)
=3D=3D5332=3D=3D  Address 0x438216c is 84 bytes inside a block of size 88 f=
ree'd
=3D=3D5332=3D=3D    at 0x4024886: free (vg_replace_malloc.c:325)
=3D=3D5332=3D=3D    by 0x4081195: g_free (gmem.c:190)
=3D=3D5332=3D=3D    by 0x805557D: g_at_hdlc_unref (gathdlc.c:270)
=3D=3D5332=3D=3D    by 0x8056316: g_at_ppp_unref (gatppp.c:463)
=3D=3D5332=3D=3D    by 0x804AF20: ppp_disconnect (gsmdial.c:272)
=3D=3D5332=3D=3D    by 0x8055CE9: ppp_dead (gatppp.c:204)
=3D=3D5332=3D=3D    by 0x8055D1E: ppp_enter_phase (gatppp.c:214)
=3D=3D5332=3D=3D    by 0x8055FE0: ppp_lcp_finished_notify (gatppp.c:317)
=3D=3D5332=3D=3D    by 0x8057E27: lcp_finished (ppp_lcp.c:140)
=3D=3D5332=3D=3D    by 0x80568DF: pppcp_this_layer_finished (ppp_cp.c:340)
=3D=3D5332=3D=3D    by 0x8057446: pppcp_generate_event (ppp_cp.c:688)
=3D=3D5332=3D=3D    by 0x8057B5B: pppcp_process_packet (ppp_cp.c:965)
=3D=3D5332=3D=3D =

: > AT+CFUN=3D0\r
=3D=3D5332=3D=3D =

=3D=3D5332=3D=3D HEAP SUMMARY:
=3D=3D5332=3D=3D     in use at exit: 8,854 bytes in 31 blocks
=3D=3D5332=3D=3D   total heap usage: 860 allocs, 829 frees, 3,139,527 bytes=
 allocated
=3D=3D5332=3D=3D =

=3D=3D5332=3D=3D 248 bytes in 1 blocks are possibly lost in loss record 13 =
of 23
=3D=3D5332=3D=3D    at 0x4023E7E: memalign (vg_replace_malloc.c:532)
=3D=3D5332=3D=3D    by 0x4023EDB: posix_memalign (vg_replace_malloc.c:660)
=3D=3D5332=3D=3D    by 0x409661D: slab_allocator_alloc_chunk (gslice.c:1136)
=3D=3D5332=3D=3D    by 0x4097580: g_slice_alloc (gslice.c:661)
=3D=3D5332=3D=3D    by 0x4076D75: g_list_prepend (glist.c:169)
=3D=3D5332=3D=3D    by 0x4085A82: add_pending_null (goption.c:1119)
=3D=3D5332=3D=3D    by 0x40868C6: parse_short_option (goption.c:1397)
=3D=3D5332=3D=3D    by 0x4087EC1: g_option_context_parse (goption.c:1858)
=3D=3D5332=3D=3D    by 0x804BB35: main (gsmdial.c:631)
=3D=3D5332=3D=3D =

=3D=3D5332=3D=3D 360 bytes in 3 blocks are possibly lost in loss record 14 =
of 23
=3D=3D5332=3D=3D    at 0x4023E7E: memalign (vg_replace_malloc.c:532)
=3D=3D5332=3D=3D    by 0x4023EDB: posix_memalign (vg_replace_malloc.c:660)
=3D=3D5332=3D=3D    by 0x409661D: slab_allocator_alloc_chunk (gslice.c:1136)
=3D=3D5332=3D=3D    by 0x40975AC: g_slice_alloc (gslice.c:666)
=3D=3D5332=3D=3D    by 0x40987B1: g_slist_prepend (gslist.c:160)
=3D=3D5332=3D=3D    by 0x4079859: g_source_add_poll (gmain.c:972)
=3D=3D5332=3D=3D    by 0x40AFF04: g_io_unix_create_watch (giounix.c:357)
=3D=3D5332=3D=3D    by 0x406D828: g_io_create_watch (giochannel.c:516)
=3D=3D5332=3D=3D    by 0x4070712: g_io_add_watch_full (giochannel.c:550)
=3D=3D5332=3D=3D    by 0x804F503: create_io (gatio.c:207)
=3D=3D5332=3D=3D    by 0x804F555: g_at_io_new (gatio.c:225)
=3D=3D5332=3D=3D    by 0x804D1E6: create_chat (gatchat.c:825)
=3D=3D5332=3D=3D =

=3D=3D5332=3D=3D 496 bytes in 2 blocks are possibly lost in loss record 15 =
of 23
=3D=3D5332=3D=3D    at 0x4023E7E: memalign (vg_replace_malloc.c:532)
=3D=3D5332=3D=3D    by 0x4023EDB: posix_memalign (vg_replace_malloc.c:660)
=3D=3D5332=3D=3D    by 0x409661D: slab_allocator_alloc_chunk (gslice.c:1136)
=3D=3D5332=3D=3D    by 0x40975AC: g_slice_alloc (gslice.c:666)
=3D=3D5332=3D=3D    by 0x4076D75: g_list_prepend (glist.c:169)
=3D=3D5332=3D=3D    by 0x4085A82: add_pending_null (goption.c:1119)
=3D=3D5332=3D=3D    by 0x40868C6: parse_short_option (goption.c:1397)
=3D=3D5332=3D=3D    by 0x4087EC1: g_option_context_parse (goption.c:1858)
=3D=3D5332=3D=3D    by 0x804BB35: main (gsmdial.c:631)
=3D=3D5332=3D=3D =

=3D=3D5332=3D=3D 504 bytes in 1 blocks are possibly lost in loss record 17 =
of 23
=3D=3D5332=3D=3D    at 0x4023E7E: memalign (vg_replace_malloc.c:532)
=3D=3D5332=3D=3D    by 0x4023EDB: posix_memalign (vg_replace_malloc.c:660)
=3D=3D5332=3D=3D    by 0x409661D: slab_allocator_alloc_chunk (gslice.c:1136)
=3D=3D5332=3D=3D    by 0x40975AC: g_slice_alloc (gslice.c:666)
=3D=3D5332=3D=3D    by 0x406A628: g_hash_table_new_full (ghash.c:512)
=3D=3D5332=3D=3D    by 0x804D263: create_chat (gatchat.c:839)
=3D=3D5332=3D=3D    by 0x804D310: g_at_chat_new (gatchat.c:863)
=3D=3D5332=3D=3D    by 0x804B837: open_serial (gsmdial.c:517)
=3D=3D5332=3D=3D    by 0x804BBDD: main (gsmdial.c:651)
=3D=3D5332=3D=3D =

=3D=3D5332=3D=3D 1,240 bytes in 5 blocks are possibly lost in loss record 2=
2 of 23
=3D=3D5332=3D=3D    at 0x4023E7E: memalign (vg_replace_malloc.c:532)
=3D=3D5332=3D=3D    by 0x4023EDB: posix_memalign (vg_replace_malloc.c:660)
=3D=3D5332=3D=3D    by 0x409661D: slab_allocator_alloc_chunk (gslice.c:1136)
=3D=3D5332=3D=3D    by 0x40975AC: g_slice_alloc (gslice.c:666)
=3D=3D5332=3D=3D    by 0x40532D8: g_array_sized_new (garray.c:87)
=3D=3D5332=3D=3D    by 0x40533F6: g_array_new (garray.c:79)
=3D=3D5332=3D=3D    by 0x40A361E: g_static_private_set (gthread.c:451)
=3D=3D5332=3D=3D    by 0x40AA883: g_get_charset (gutf8.c:545)
=3D=3D5332=3D=3D    by 0x40834CC: g_print (gmessages.c:1043)
=3D=3D5332=3D=3D    by 0x804BBBA: main (gsmdial.c:647)
=3D=3D5332=3D=3D =

=3D=3D5332=3D=3D LEAK SUMMARY:
=3D=3D5332=3D=3D    definitely lost: 0 bytes in 0 blocks
=3D=3D5332=3D=3D    indirectly lost: 0 bytes in 0 blocks
=3D=3D5332=3D=3D      possibly lost: 2,848 bytes in 12 blocks
=3D=3D5332=3D=3D    still reachable: 6,006 bytes in 19 blocks
=3D=3D5332=3D=3D         suppressed: 0 bytes in 0 blocks
=3D=3D5332=3D=3D Reachable blocks (those to which a pointer was found) are =
not shown.
=3D=3D5332=3D=3D To see them, rerun with: --leak-check=3Dfull --show-reacha=
ble=3Dyes
=3D=3D5332=3D=3D =

=3D=3D5332=3D=3D For counts of detected and suppressed errors, rerun with: =
-v
=3D=3D5332=3D=3D ERROR SUMMARY: 8 errors from 8 contexts (suppressed: 15 fr=
om 6)

Regards,
Zhenhua


--===============8506013569152686013==--

