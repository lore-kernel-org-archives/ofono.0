Content-Type: multipart/mixed; boundary="===============2195556185970354905=="
MIME-Version: 1.0
From: Johan Hedberg <johan.hedberg@gmail.com>
Subject: Re: [RFC v0 00/11] External HFP Profile
Date: Fri, 23 Nov 2012 10:54:32 +0200
Message-ID: <20121123085432.GA4850@x220>
In-Reply-To: <20121123084420.GA4271@x220>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2195556185970354905==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Claudio,

On Fri, Nov 23, 2012, Johan Hedberg wrote:
> On Thu, Nov 22, 2012, Claudio Takahasi wrote:
> > BlueZ supports now external profile registration, see:
> > bluez/doc/profile-api.txt
> > =

> > This patch series has the initial implementation of the HFP external
> > profile in oFono. HandsfreeAgent and HandsfreeGateway interfaces were
> > removed from BlueZ.
> > =

> > The next step: implement SCO connection handling in oFono.
> =

> In general the patches seem quite good, but I get the following when
> connecting HFP, disconnecting and reconnecting (all actions triggered
> from the phone side):
> =

> ofonod[3940]: plugins/hfp_hf.c:profile_new_connection() Profile handler N=
ewConnection
> ofonod[3940]: plugins/hfp_hf.c:profile_new_connection() hfp_data: 0x4e190=
f0 SLC FD: 9 Version: 0x0106 Features: 0x0027
> =3D=3D3940=3D=3D Invalid read of size 8
> =3D=3D3940=3D=3D    at 0x47E565: profile_new_connection (hfp_hf.c:196)
> =3D=3D3940=3D=3D    by 0x40F960: process_message.isra.0 (object.c:197)
> =3D=3D3940=3D=3D    by 0x37F181D874: ??? (in /usr/lib64/libdbus-1.so.3.7.=
1)
> =3D=3D3940=3D=3D    by 0x37F180FAEF: dbus_connection_dispatch (in /usr/li=
b64/libdbus-1.so.3.7.1)
> =3D=3D3940=3D=3D    by 0x40DFE7: message_dispatch (mainloop.c:76)
> =3D=3D3940=3D=3D    by 0x37EE0483BA: g_timeout_dispatch (gmain.c:3882)
> =3D=3D3940=3D=3D    by 0x37EE047824: g_main_context_dispatch (gmain.c:253=
9)
> =3D=3D3940=3D=3D    by 0x37EE047B57: g_main_context_iterate.isra.23 (gmai=
n.c:3146)
> =3D=3D3940=3D=3D    by 0x37EE047F51: g_main_loop_run (gmain.c:3340)
> =3D=3D3940=3D=3D    by 0x40DC41: main (main.c:247)
> =3D=3D3940=3D=3D  Address 0x4e19130 is 64 bytes inside a block of size 96=
 free'd
> =3D=3D3940=3D=3D    at 0x4A07786: free (vg_replace_malloc.c:446)
> =3D=3D3940=3D=3D    by 0x37EE04D50E: g_free (gmem.c:252)
> =3D=3D3940=3D=3D    by 0x37EE045797: g_source_callback_unref (gmain.c:128=
8)
> =3D=3D3940=3D=3D    by 0x37EE04528A: g_source_destroy_internal (gmain.c:9=
57)
> =3D=3D3940=3D=3D    by 0x37EE04786F: g_main_context_dispatch (gmain.c:256=
3)
> =3D=3D3940=3D=3D    by 0x37EE047B57: g_main_context_iterate.isra.23 (gmai=
n.c:3146)
> =3D=3D3940=3D=3D    by 0x37EE047F51: g_main_loop_run (gmain.c:3340)
> =3D=3D3940=3D=3D    by 0x40DC41: main (main.c:247)

I also found this leak:

=3D=3D3940=3D=3D 195 (96 direct, 99 indirect) bytes in 1 blocks are definit=
ely lost in loss record 134 of 175
=3D=3D3940=3D=3D    at 0x4A0881C: malloc (vg_replace_malloc.c:270)
=3D=3D3940=3D=3D    by 0x37EE04D55D: g_try_malloc0 (gmem.c:296)
=3D=3D3940=3D=3D    by 0x47E2F3: hfp_hf_probe (hfp_hf.c:225)
=3D=3D3940=3D=3D    by 0x47B9A4: device_properties_cb (bluetooth.c:307)
=3D=3D3940=3D=3D    by 0x37F180C729: ??? (in /usr/lib64/libdbus-1.so.3.7.1)
=3D=3D3940=3D=3D    by 0x37F180F7F2: dbus_connection_dispatch (in /usr/lib6=
4/libdbus-1.so.3.7.1)
=3D=3D3940=3D=3D    by 0x40DFE7: message_dispatch (mainloop.c:76)
=3D=3D3940=3D=3D    by 0x37EE0483BA: g_timeout_dispatch (gmain.c:3882)
=3D=3D3940=3D=3D    by 0x37EE047824: g_main_context_dispatch (gmain.c:2539)
=3D=3D3940=3D=3D    by 0x37EE047B57: g_main_context_iterate.isra.23 (gmain.=
c:3146)
=3D=3D3940=3D=3D    by 0x37EE047F51: g_main_loop_run (gmain.c:3340)
=3D=3D3940=3D=3D    by 0x40DC41: main (main.c:247)

Johan

--===============2195556185970354905==--

