Content-Type: multipart/mixed; boundary="===============5087061002451008194=="
MIME-Version: 1.0
From: Martin =?unknown-8bit?q?Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: Re: [PATCH] gatmux: don't free cmux data until watchers are destroyed
Date: Mon, 07 Oct 2019 20:37:49 +0200
Message-ID: <dac0d35f-9d7e-4277-e694-2a17245755ef@geanix.com>
In-Reply-To: <b231a0fd-6b2e-c2aa-4537-42eeabd128d0@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5087061002451008194==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 30/09/2019 22.59, Denis Kenzior wrote:
>> @@ -227,12 +227,15 @@ static void dispatch_sources(GAtMuxChannel =

>> *channel, GIOCondition condition)
>> =C2=A0 static gboolean received_data(GIOChannel *channel, GIOCondition c=
ond,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 gpointer data)
>> =C2=A0 {
>> -=C2=A0=C2=A0=C2=A0 GAtMux *mux =3D data;
>> +=C2=A0=C2=A0=C2=A0 GAtMux *mux =3D g_at_mux_ref(data);
> =

> So you're taking a ref here unconditionally, yet...
> =

>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int i;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GIOStatus status;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gsize bytes_read;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (cond & G_IO_NVAL)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out_done;
>> +
>> +=C2=A0=C2=A0=C2=A0 if (mux->shutdown)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return FALSE;
> =

> You don't return it here?
> =

>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 debug(mux, "received data");
>> @@ -270,15 +273,22 @@ static gboolean received_data(GIOChannel =

>> *channel, GIOCondition cond,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (cond & (G_IO_HUP | G_IO_ERR))
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return FALSE;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out_done;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (status !=3D G_IO_STATUS_NORMAL && sta=
tus !=3D G_IO_STATUS_AGAIN)
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return FALSE;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out_done;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (mux->buf_used =3D=3D sizeof(mux->buf))
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return FALSE;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out_done;
>> +
>> +=C2=A0=C2=A0=C2=A0 g_at_mux_unref(mux);
> =

> Why not do something like:
> =

>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_at_mux_ref(mux);
> =

>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 for (i =3D 1; i <=3D MAX_CHANNELS && !mux->shutdown; i++=
) {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int offs=
et =3D i / 8;
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int bit =
=3D i % 8;
> =

>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!(mu=
x->newdata[offset] & (1 << bit)))
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 continue;
> =

>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dispatch=
_sources(mux->dlcs[i-1], G_IO_IN);
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 }
> =

>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_at_mux_unref(mux);
> =


I'm afraid this isn't enough, as I still get use-after-free when using =

gatmux in the quectel plugin (see attached log).

I've added g_at_mux_{ref,unref}() calls to the read and write watchers =

too. This fixes it. Patch coming up.

>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return TRUE;
>> +
>> +out_done:
>> +=C2=A0=C2=A0=C2=A0 g_at_mux_unref(mux);
>> +
>> +=C2=A0=C2=A0=C2=A0 return FALSE;
>> =C2=A0 }
>> =C2=A0 static void write_watcher_destroy_notify(gpointer user_data)
>> @@ -286,6 +296,9 @@ static void write_watcher_destroy_notify(gpointer =

>> user_data)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 GAtMux *mux =3D user_data;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mux->write_watch =3D 0;
>> +
>> +=C2=A0=C2=A0=C2=A0 if (mux->read_watch <=3D 0 && mux->write_watch <=3D =
0)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_free(mux);
>> =C2=A0 }
>> =C2=A0 static gboolean can_write_data(GIOChannel *chan, GIOCondition con=
d,
>> @@ -297,6 +310,9 @@ static gboolean can_write_data(GIOChannel *chan, =

>> GIOCondition cond,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (cond & (G_IO_NVAL | G_IO_HUP | G_IO_E=
RR))
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return FALSE;
>> +=C2=A0=C2=A0=C2=A0 if (mux->shutdown)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return FALSE;
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 debug(mux, "can write data");
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (dlc =3D 0; dlc < MAX_CHANNELS; dlc +=
=3D 1) {
>> @@ -607,6 +623,7 @@ GAtMux *g_at_mux_new(GIOChannel *channel, const =

>> GAtMuxDriver *driver)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (mux =3D=3D NULL)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return NULL;
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mux->ref_count =3D 1;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mux->driver =3D driver;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mux->shutdown =3D TRUE;
>> @@ -642,7 +659,8 @@ void g_at_mux_unref(GAtMux *mux)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (mux->driver->=
remove)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 mux->driver->remove(mux);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_free(mux);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (mux->read_watch <=3D 0 &=
& mux->write_watch <=3D 0)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_fr=
ee(mux);
> =

> This looks dangerous to me.=C2=A0 You're going to cause a crash like this=
. =

> You really want to call the disconnect function instead.=C2=A0 But I susp=
ect =

> this is a different patch entirely.

Yeah, I was obviously too tired when doing these patches last week. More =

coffee next time.

// Martin

--===============5087061002451008194==
Content-Type: text/x-log
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="gatmux.log"

b2Zvbm9kWzU5NjBdOiAuLi9naXQvcGx1Z2lucy9xdWVjdGVsLmM6Y2Z1bl9kaXNhYmxlKCkgMHg2
MTAwMDAwMDBkNDAKb2Zvbm9kWzU5NjBdOiAuLi9naXQvcGx1Z2lucy9xdWVjdGVsLmM6Y2xvc2Vf
c2VyaWFsKCkgMHg2MTAwMDAwMDBkNDAKb2Zvbm9kWzU5NjBdOiAuLi9naXQvZXhhbXBsZXMvZW11
bGF0b3IuYzpwb3dlcmVkX3dhdGNoKCkgUmVtb3ZpbmcgbW9kZW0gMHg2MTAwMDAwMDBkNDAgZnJv
bSB0aGUgbGlzdApvZm9ub2RbNTk2MF06IC4uL2dpdC9zcmMvbW9kZW0uYzptb2RlbV9jaGFuZ2Vf
c3RhdGUoKSBvbGQgc3RhdGU6IDAsIG5ldyBzdGF0ZTogMAo9PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQo9PTU5NjA9PUVSUk9S
OiBBZGRyZXNzU2FuaXRpemVyOiBoZWFwLXVzZS1hZnRlci1mcmVlIG9uIGFkZHJlc3MgMHg2MjEw
MDBhY2E3MzggYXQgcGMgMHg1NWI5YTNhZDZiOGYgYnAgMHg3ZmZlYWM5YTIwOTAgc3AgMHg3ZmZl
YWM5YTIwODAKUkVBRCBvZiBzaXplIDQgYXQgMHg2MjEwMDBhY2E3MzggdGhyZWFkIFQwCiAgICAj
MCAweDU1YjlhM2FkNmI4ZSBpbiByZWNlaXZlZF9kYXRhIC4uL2dpdC9nYXRjaGF0L2dhdG11eC5j
OjI4MgogICAgIzEgMHg3ZmNmNGM1MDgyY2UgaW4gZ19tYWluX2NvbnRleHRfZGlzcGF0Y2ggKC91
c3IvbGliL2xpYmdsaWItMi4wLnNvLjArMHg2YTJjZSkKICAgICMyIDB4N2ZjZjRjNTBhMjEwICAo
L3Vzci9saWIvbGliZ2xpYi0yLjAuc28uMCsweDZjMjEwKQogICAgIzMgMHg3ZmNmNGM1MGIxMjIg
aW4gZ19tYWluX2xvb3BfcnVuICgvdXNyL2xpYi9saWJnbGliLTIuMC5zby4wKzB4NmQxMjIpCiAg
ICAjNCAweDU1YjlhM2FmY2M0MyBpbiBtYWluIC4uL2dpdC9zcmMvbWFpbi5jOjI4NgogICAgIzUg
MHg3ZmNmNGMyYWQxNTIgaW4gX19saWJjX3N0YXJ0X21haW4gKC91c3IvbGliL2xpYmMuc28uNisw
eDI3MTUyKQogICAgIzYgMHg1NWI5YTM5MjUxYWQgaW4gX3N0YXJ0ICgvaG9tZS9tYXJ0aW4vcHJv
amVjdHMvb2Zvbm8veDg2L3NyYy9vZm9ub2QrMHhmZDFhZCkKCjB4NjIxMDAwYWNhNzM4IGlzIGxv
Y2F0ZWQgNDY2NCBieXRlcyBpbnNpZGUgb2YgNDY3Mi1ieXRlIHJlZ2lvbiBbMHg2MjEwMDBhYzk1
MDAsMHg2MjEwMDBhY2E3NDApCmZyZWVkIGJ5IHRocmVhZCBUMCBoZXJlOgogICAgIzAgMHg3ZmNm
NGM3NTY2YjAgaW4gX19pbnRlcmNlcHRvcl9mcmVlIC9idWlsZC9nY2Mvc3JjL2djYy9saWJzYW5p
dGl6ZXIvYXNhbi9hc2FuX21hbGxvY19saW51eC5jYzoxMjIKICAgICMxIDB4NTViOWEzYWQ4M2Zm
IGluIGdfYXRfbXV4X3VucmVmIC4uL2dpdC9nYXRjaGF0L2dhdG11eC5jOjY0OQogICAgIzIgMHg1
NWI5YTNhZDZiMjkgaW4gcmVjZWl2ZWRfZGF0YSAuLi9naXQvZ2F0Y2hhdC9nYXRtdXguYzoyNzMK
ICAgICMzIDB4N2ZjZjRjNTA4MmNlIGluIGdfbWFpbl9jb250ZXh0X2Rpc3BhdGNoICgvdXNyL2xp
Yi9saWJnbGliLTIuMC5zby4wKzB4NmEyY2UpCgpwcmV2aW91c2x5IGFsbG9jYXRlZCBieSB0aHJl
YWQgVDAgaGVyZToKICAgICMwIDB4N2ZjZjRjNzU2Y2Q4IGluIF9faW50ZXJjZXB0b3JfY2FsbG9j
IC9idWlsZC9nY2Mvc3JjL2djYy9saWJzYW5pdGl6ZXIvYXNhbi9hc2FuX21hbGxvY19saW51eC5j
YzoxNTMKICAgICMxIDB4NTViOWEzYWQ4MTMxIGluIGdfYXRfbXV4X25ldyAuLi9naXQvZ2F0Y2hh
dC9nYXRtdXguYzo2MTAKICAgICMyIDB4NTViOWEzYWRiMDkzIGluIGdfYXRfbXV4X25ld19nc20w
NzEwX2Jhc2ljIC4uL2dpdC9nYXRjaGF0L2dhdG11eC5jOjExNjkKICAgICMzIDB4NTViOWEzYWFk
OTdkIGluIGNtdXhfY2IgLi4vZ2l0L3BsdWdpbnMvcXVlY3RlbC5jOjg0OAogICAgIzQgMHg1NWI5
YTNhYzliZWIgaW4gYXRfY2hhdF9maW5pc2hfY29tbWFuZCAuLi9naXQvZ2F0Y2hhdC9nYXRjaGF0
LmM6NDU5CiAgICAjNSAweDU1YjlhM2FjYTEyNSBpbiBhdF9jaGF0X2hhbmRsZV9jb21tYW5kX3Jl
c3BvbnNlIC4uL2dpdC9nYXRjaGF0L2dhdGNoYXQuYzo1MjEKICAgICM2IDB4NTViOWEzYWNhOTY1
IGluIGhhdmVfbGluZSAuLi9naXQvZ2F0Y2hhdC9nYXRjaGF0LmM6NjAwCiAgICAjNyAweDU1Yjlh
M2FjYjhmYiBpbiBuZXdfYnl0ZXMgLi4vZ2l0L2dhdGNoYXQvZ2F0Y2hhdC5jOjc1OQogICAgIzgg
MHg1NWI5YTNhZDQ4NTYgaW4gcmVjZWl2ZWRfZGF0YSAuLi9naXQvZ2F0Y2hhdC9nYXRpby5jOjEy
MgogICAgIzkgMHg3ZmNmNGM1MDgyY2UgaW4gZ19tYWluX2NvbnRleHRfZGlzcGF0Y2ggKC91c3Iv
bGliL2xpYmdsaWItMi4wLnNvLjArMHg2YTJjZSkKClNVTU1BUlk6IEFkZHJlc3NTYW5pdGl6ZXI6
IGhlYXAtdXNlLWFmdGVyLWZyZWUgLi4vZ2l0L2dhdGNoYXQvZ2F0bXV4LmM6MjgyIGluIHJlY2Vp
dmVkX2RhdGEKU2hhZG93IGJ5dGVzIGFyb3VuZCB0aGUgYnVnZ3kgYWRkcmVzczoKICAweDBjNDI4
MDE1MTQ5MDogZmQgZmQgZmQgZmQgZmQgZmQgZmQgZmQgZmQgZmQgZmQgZmQgZmQgZmQgZmQgZmQK
ICAweDBjNDI4MDE1MTRhMDogZmQgZmQgZmQgZmQgZmQgZmQgZmQgZmQgZmQgZmQgZmQgZmQgZmQg
ZmQgZmQgZmQKICAweDBjNDI4MDE1MTRiMDogZmQgZmQgZmQgZmQgZmQgZmQgZmQgZmQgZmQgZmQg
ZmQgZmQgZmQgZmQgZmQgZmQKICAweDBjNDI4MDE1MTRjMDogZmQgZmQgZmQgZmQgZmQgZmQgZmQg
ZmQgZmQgZmQgZmQgZmQgZmQgZmQgZmQgZmQKICAweDBjNDI4MDE1MTRkMDogZmQgZmQgZmQgZmQg
ZmQgZmQgZmQgZmQgZmQgZmQgZmQgZmQgZmQgZmQgZmQgZmQKPT4weDBjNDI4MDE1MTRlMDogZmQg
ZmQgZmQgZmQgZmQgZmQgZmRbZmRdZmEgZmEgZmEgZmEgZmEgZmEgZmEgZmEKICAweDBjNDI4MDE1
MTRmMDogZmEgZmEgZmEgZmEgZmEgZmEgZmEgZmEgZmEgZmEgZmEgZmEgZmEgZmEgZmEgZmEKICAw
eDBjNDI4MDE1MTUwMDogZmEgZmEgZmEgZmEgZmEgZmEgZmEgZmEgZmEgZmEgZmEgZmEgZmEgZmEg
ZmEgZmEKICAweDBjNDI4MDE1MTUxMDogZmEgZmEgZmEgZmEgZmEgZmEgZmEgZmEgZmEgZmEgZmEg
ZmEgZmEgZmEgZmEgZmEKICAweDBjNDI4MDE1MTUyMDogZmQgZmQgZmQgZmQgZmQgZmQgZmQgZmQg
ZmQgZmQgZmQgZmQgZmQgZmQgZmQgZmQKICAweDBjNDI4MDE1MTUzMDogZmQgZmQgZmQgZmQgZmQg
ZmQgZmQgZmQgZmQgZmQgZmQgZmQgZmQgZmQgZmQgZmQKU2hhZG93IGJ5dGUgbGVnZW5kIChvbmUg
c2hhZG93IGJ5dGUgcmVwcmVzZW50cyA4IGFwcGxpY2F0aW9uIGJ5dGVzKToKICBBZGRyZXNzYWJs
ZTogICAgICAgICAgIDAwCiAgUGFydGlhbGx5IGFkZHJlc3NhYmxlOiAwMSAwMiAwMyAwNCAwNSAw
NiAwNwogIEhlYXAgbGVmdCByZWR6b25lOiAgICAgICBmYQogIEZyZWVkIGhlYXAgcmVnaW9uOiAg
ICAgICBmZAogIFN0YWNrIGxlZnQgcmVkem9uZTogICAgICBmMQogIFN0YWNrIG1pZCByZWR6b25l
OiAgICAgICBmMgogIFN0YWNrIHJpZ2h0IHJlZHpvbmU6ICAgICBmMwogIFN0YWNrIGFmdGVyIHJl
dHVybjogICAgICBmNQogIFN0YWNrIHVzZSBhZnRlciBzY29wZTogICBmOAogIEdsb2JhbCByZWR6
b25lOiAgICAgICAgICBmOQogIEdsb2JhbCBpbml0IG9yZGVyOiAgICAgICBmNgogIFBvaXNvbmVk
IGJ5IHVzZXI6ICAgICAgICBmNwogIENvbnRhaW5lciBvdmVyZmxvdzogICAgICBmYwogIEFycmF5
IGNvb2tpZTogICAgICAgICAgICBhYwogIEludHJhIG9iamVjdCByZWR6b25lOiAgICBiYgogIEFT
YW4gaW50ZXJuYWw6ICAgICAgICAgICBmZQogIExlZnQgYWxsb2NhIHJlZHpvbmU6ICAgICBjYQog
IFJpZ2h0IGFsbG9jYSByZWR6b25lOiAgICBjYgogIFNoYWRvdyBnYXA6ICAgICAgICAgICAgICBj
Ywo9PTU5NjA9PUFCT1JUSU5HCg==

--===============5087061002451008194==--

