Content-Type: multipart/mixed; boundary="===============2262021934574492874=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] gatmux: Remove finalized watches from the list
Date: Mon, 23 Oct 2017 15:27:59 -0500
Message-ID: <638c4100-17ed-81b7-211f-7de59a3bf0aa@gmail.com>
In-Reply-To: <1508750250-32765-1-git-send-email-slava.monich@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2262021934574492874==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Slava,

On 10/23/2017 04:17 AM, Slava Monich wrote:
> Leaving them there may result in invalid reads like this:
> =

> =3D=3D2312=3D=3D Invalid read of size 4
> =3D=3D2312=3D=3D    at 0xAB8C0: dispatch_sources (gatmux.c:134)
> =3D=3D2312=3D=3D    by 0xAC5D3: channel_close (gatmux.c:479)
> =3D=3D2312=3D=3D    by 0x4AE8885: g_io_channel_shutdown (giochannel.c:523)
> =3D=3D2312=3D=3D    by 0x4AE8A1D: g_io_channel_unref (giochannel.c:240)
> =3D=3D2312=3D=3D    by 0xAC423: watch_finalize (gatmux.c:426)
> =3D=3D2312=3D=3D    by 0x4AF2CC9: g_source_unref_internal (gmain.c:2048)
> =3D=3D2312=3D=3D    by 0x4AF44E1: g_source_destroy_internal (gmain.c:1230)
> =3D=3D2312=3D=3D    by 0x4AF44E1: g_source_destroy (gmain.c:1256)
> =3D=3D2312=3D=3D    by 0x4AF5257: g_source_remove (gmain.c:2282)
> =3D=3D2312=3D=3D    by 0xAB5CB: io_shutdown (gatio.c:325)
> =3D=3D2312=3D=3D    by 0xAB667: g_at_io_unref (gatio.c:345)
> =3D=3D2312=3D=3D    by 0xA72C7: at_chat_unref (gatchat.c:972)
> =3D=3D2312=3D=3D    by 0xA829B: g_at_chat_unref (gatchat.c:1446)
> =3D=3D2312=3D=3D  Address 0x51420f0 is 56 bytes inside a block of size 60=
 free'd
> =3D=3D2312=3D=3D    at 0x4840B28: free (vg_replace_malloc.c:530)
> =3D=3D2312=3D=3D    by 0x4AF2D33: g_source_unref_internal (gmain.c:2075)
> =3D=3D2312=3D=3D    by 0x4AF44E1: g_source_destroy_internal (gmain.c:1230)
> =3D=3D2312=3D=3D    by 0x4AF44E1: g_source_destroy (gmain.c:1256)
> =3D=3D2312=3D=3D    by 0x4AF5257: g_source_remove (gmain.c:2282)
> =3D=3D2312=3D=3D    by 0xAB46B: g_at_io_set_write_handler (gatio.c:283)
> =3D=3D2312=3D=3D    by 0xA713F: at_chat_suspend (gatchat.c:938)
> =3D=3D2312=3D=3D    by 0xA72B7: at_chat_unref (gatchat.c:971)
> =3D=3D2312=3D=3D    by 0xA829B: g_at_chat_unref (gatchat.c:1446)
> =3D=3D2312=3D=3D  Block was alloc'd at
> =3D=3D2312=3D=3D    at 0x4841BF0: calloc (vg_replace_malloc.c:711)
> =3D=3D2312=3D=3D    by 0x4AFB117: g_malloc0 (gmem.c:124)
> =3D=3D2312=3D=3D    by 0x4AF401F: g_source_new (gmain.c:892)
> =3D=3D2312=3D=3D    by 0xAC6A7: channel_create_watch (gatmux.c:506)
> =3D=3D2312=3D=3D    by 0x4AE7C4F: g_io_add_watch_full (giochannel.c:649)
> =3D=3D2312=3D=3D    by 0xAB4EB: g_at_io_set_write_handler (gatio.c:297)
> =3D=3D2312=3D=3D    by 0xA7103: chat_wakeup_writer (gatchat.c:931)
> =3D=3D2312=3D=3D    by 0xA753F: at_chat_send_common (gatchat.c:1045)
> =3D=3D2312=3D=3D    by 0xA850F: g_at_chat_send (gatchat.c:1502)
> =

> It's also necessary to add additional references to the sources
> for the duration of the dispatch_sources loop because any source
> can be removed when any callback is invoked (and not necessarily
> the one being dispatched).
> ---
>   gatchat/gatmux.c | 109 +++++++++++++++++++++++++++++++++++++++---------=
-------
>   1 file changed, 77 insertions(+), 32 deletions(-)
> =


Applied, thanks.

Regards,
-Denis


--===============2262021934574492874==--

