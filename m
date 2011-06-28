Content-Type: multipart/mixed; boundary="===============9075873872253119439=="
MIME-Version: 1.0
From: Amit Mendapara <mendapara.amit@gmail.com>
Subject: Re: [PATCH 1/2] linktop: reimplemented with minimum features.
Date: Tue, 28 Jun 2011 09:43:04 +0530
Message-ID: <BANLkTi=fAw9_W5GxG4uD2bqwnkK-o+4K1w@mail.gmail.com>
In-Reply-To: <4E08A30C.7010808@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9075873872253119439==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On Mon, Jun 27, 2011 at 9:04 PM, Denis Kenzior <denkenz@gmail.com> wrote:

> Hi Amit,
>
> On 06/27/2011 01:22 AM, Amit Mendapara wrote:
> > The device supports subset of ST-Ericsson AT command
> > extensions but nither STE nor the MBM plugin works with
> > these devices.
> >
> > Fixes MeeGo bug #14784
> > ---
> >  plugins/linktop.c |  120
> +++++++++++++++++++++++------------------------------
> >  1 files changed, 52 insertions(+), 68 deletions(-)
> >
>
> I applied this patch with some amendments:
>

Thanks...


>
> > diff --git a/plugins/linktop.c b/plugins/linktop.c
> > index 953f634..2eb1c55 100644
> > --- a/plugins/linktop.c
> > +++ b/plugins/linktop.c
> > @@ -26,6 +26,7 @@
> >  #include <stdio.h>
> >  #include <errno.h>
> >  #include <stdlib.h>
> > +#include <string.h>
> >
>
> This header doesn't seem necessary
>
> >  #include <glib.h>
> >  #include <gatchat.h>
> > @@ -45,22 +42,20 @@
> >  #include <ofono/cbs.h>
> >  #include <ofono/sms.h>
> >  #include <ofono/ussd.h>
> > -#include <ofono/call-volume.h>
> > -#include <ofono/voicecall.h>
> >  #include <ofono/gprs.h>
> >  #include <ofono/gprs-context.h>
> >  #include <ofono/phonebook.h>
> >  #include <ofono/radio-settings.h>
> >  #include <ofono/log.h>
> >
> > -#include <drivers/atmodem/vendor.h>
> >  #include <drivers/atmodem/atutil.h>
> > +#include <drivers/atmodem/vendor.h>
> >
>
> Since you're not using any VENDOR defines, this header is not necessary.
>  However I actually question whether signal strength updates work right
> now without using the CIND based signal strength updates that MBM uses.
>

Yes, signal strength is being updated correctly using unsolicited CIEV
messages.


> >  static const char *none_prefix[] =3D { NULL };
> >
> >  struct linktop_data {
> >       GAtChat *modem;
> > -     GAtChat *control;
> > +     GAtChat *aux;
> >       struct ofono_gprs *gprs;
> >       struct ofono_gprs_context *gc;
> >  };
>
> <snip>
>
> > @@ -138,10 +133,9 @@ static void linktop_disconnect(gpointer user_data)
> >       struct ofono_modem *modem =3D user_data;
> >       struct linktop_data *data =3D ofono_modem_get_data(modem);
> >
> > -     DBG("");
> > +     DBG("%p, data->gc %p", modem, data->gc);
> >
> > -     if (data->gc)
> > -             ofono_gprs_context_remove(data->gc);
> > +     ofono_gprs_context_remove(data->gc);
> >
> >       g_at_chat_unref(data->modem);
> >       data->modem =3D NULL;
> > @@ -151,7 +145,7 @@ static void linktop_disconnect(gpointer user_data)
> >               return;
> >
> >       g_at_chat_set_disconnect_function(data->modem,
> > -                                             linktop_disconnect, modem=
);
> > +                     linktop_disconnect, modem);
>
> The original formatting was correct
>

> >
> >       ofono_info("Reopened GPRS context channel");
> >
> > @@ -232,13 +223,12 @@ static int linktop_disable(struct ofono_modem
> *modem)
> >               data->modem =3D NULL;
> >       }
> >
>
> It is not necessary to cancel_all on the modem channel, unref it and set
> it to zero, cancel_all is already called automatically from unref.  Not
> to mention you do the same thing in cfun_disable.
>

Thanks for correcting this...


>
> > -     if (data->control =3D=3D NULL)
> > +     if (data->aux =3D=3D NULL)
> >               return 0;
> >
> > -     g_at_chat_cancel_all(data->control);
> > -     g_at_chat_unregister_all(data->control);
> > -     g_at_chat_send(data->control, "AT+CFUN=3D4", none_prefix,
> > -                                     cfun_disable, modem, NULL);
> > +     g_at_chat_cancel_all(data->aux);
> > +     g_at_chat_unregister_all(data->aux);
> > +     g_at_chat_send(data->aux, "AT+CFUN=3D4", NULL, cfun_disable, mode=
m,
> NULL);
> >
> >       return -EINPROGRESS;
> >  }
> > @@ -247,22 +237,25 @@ static void set_online_cb(gboolean ok, GAtResult
> *result, gpointer user_data)
> >  {
> >       struct cb_data *cbd =3D user_data;
> >       ofono_modem_online_cb_t cb =3D cbd->cb;
> > -     struct ofono_error error;
> >
> > -     decode_at_error(&error, g_at_result_final_response(result));
> > -     cb(&error, cbd->data);
> > +     if (ok)
> > +             CALLBACK_WITH_SUCCESS(cb, cbd->data);
> > +     else
> > +             CALLBACK_WITH_FAILURE(cb, cbd->data);
>
> The original was actually correct and I updated the mbm plugin to do the
> same.
>
> >  }
> >
>
> Please test my changes and make sure I didn't break anything
>
>
I just tested and everything works fine :).

Thank you again...

Regards
--
Amit Mendapara

--===============9075873872253119439==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

SGkgRGVuaXMsPGJyPjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+T24gTW9uLCBKdW4gMjcs
IDIwMTEgYXQgOTowNCBQTSwgRGVuaXMgS2VuemlvciA8c3BhbiBkaXI9Imx0ciI+Jmx0OzxhIGhy
ZWY9Im1haWx0bzpkZW5rZW56QGdtYWlsLmNvbSI+ZGVua2VuekBnbWFpbC5jb208L2E+Jmd0Ozwv
c3Bhbj4gd3JvdGU6PGJyPjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1h
cmdpbjowIDAgMCAuOGV4O2JvcmRlci1sZWZ0OjFweCAjY2NjIHNvbGlkO3BhZGRpbmctbGVmdDox
ZXg7Ij4KSGkgQW1pdCw8YnI+CjxkaXYgY2xhc3M9ImltIj48YnI+Ck9uIDA2LzI3LzIwMTEgMDE6
MjIgQU0sIEFtaXQgTWVuZGFwYXJhIHdyb3RlOjxicj4KJmd0OyBUaGUgZGV2aWNlIHN1cHBvcnRz
IHN1YnNldCBvZiBTVC1Fcmljc3NvbiBBVCBjb21tYW5kPGJyPgomZ3Q7IGV4dGVuc2lvbnMgYnV0
IG5pdGhlciBTVEUgbm9yIHRoZSBNQk0gcGx1Z2luIHdvcmtzIHdpdGg8YnI+CiZndDsgdGhlc2Ug
ZGV2aWNlcy48YnI+CiZndDs8YnI+CiZndDsgRml4ZXMgTWVlR28gYnVnICMxNDc4NDxicj4KJmd0
OyAtLS08YnI+CiZndDsgoHBsdWdpbnMvbGlua3RvcC5jIHwgoDEyMCArKysrKysrKysrKysrKysr
KysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLTxicj4KJmd0OyCgMSBmaWxlcyBj
aGFuZ2VkLCA1MiBpbnNlcnRpb25zKCspLCA2OCBkZWxldGlvbnMoLSk8YnI+CiZndDs8YnI+Cjxi
cj4KPC9kaXY+SSBhcHBsaWVkIHRoaXMgcGF0Y2ggd2l0aCBzb21lIGFtZW5kbWVudHM6PGJyPjwv
YmxvY2txdW90ZT48ZGl2Pjxicj48L2Rpdj48ZGl2PlRoYW5rcy4uLjwvZGl2PjxkaXY+oDwvZGl2
PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowIDAgMCAuOGV4
O2JvcmRlci1sZWZ0OjFweCAjY2NjIHNvbGlkO3BhZGRpbmctbGVmdDoxZXg7Ij4KPGRpdiBjbGFz
cz0iaW0iPjxicj4KJmd0OyBkaWZmIC0tZ2l0IGEvcGx1Z2lucy9saW5rdG9wLmMgYi9wbHVnaW5z
L2xpbmt0b3AuYzxicj4KJmd0OyBpbmRleCA5NTNmNjM0Li4yZWIxYzU1IDEwMDY0NDxicj4KJmd0
OyAtLS0gYS9wbHVnaW5zL2xpbmt0b3AuYzxicj4KJmd0OyArKysgYi9wbHVnaW5zL2xpbmt0b3Au
Yzxicj4KJmd0OyBAQCAtMjYsNiArMjYsNyBAQDxicj4KJmd0OyCgI2luY2x1ZGUgJmx0O3N0ZGlv
LmgmZ3Q7PGJyPgomZ3Q7IKAjaW5jbHVkZSAmbHQ7ZXJybm8uaCZndDs8YnI+CiZndDsgoCNpbmNs
dWRlICZsdDtzdGRsaWIuaCZndDs8YnI+CiZndDsgKyNpbmNsdWRlICZsdDtzdHJpbmcuaCZndDs8
YnI+CiZndDs8YnI+Cjxicj4KPC9kaXY+VGhpcyBoZWFkZXIgZG9lc24mIzM5O3Qgc2VlbSBuZWNl
c3Nhcnk8YnI+CjxkaXYgY2xhc3M9ImltIj48YnI+CiZndDsgoCNpbmNsdWRlICZsdDtnbGliLmgm
Z3Q7PGJyPgomZ3Q7IKAjaW5jbHVkZSAmbHQ7Z2F0Y2hhdC5oJmd0Ozxicj4KPC9kaXY+PGRpdiBj
bGFzcz0iaW0iPiZndDsgQEAgLTQ1LDIyICs0MiwyMCBAQDxicj4KJmd0OyCgI2luY2x1ZGUgJmx0
O29mb25vL2Nicy5oJmd0Ozxicj4KJmd0OyCgI2luY2x1ZGUgJmx0O29mb25vL3Ntcy5oJmd0Ozxi
cj4KJmd0OyCgI2luY2x1ZGUgJmx0O29mb25vL3Vzc2QuaCZndDs8YnI+CiZndDsgLSNpbmNsdWRl
ICZsdDtvZm9uby9jYWxsLXZvbHVtZS5oJmd0Ozxicj4KJmd0OyAtI2luY2x1ZGUgJmx0O29mb25v
L3ZvaWNlY2FsbC5oJmd0Ozxicj4KJmd0OyCgI2luY2x1ZGUgJmx0O29mb25vL2dwcnMuaCZndDs8
YnI+CiZndDsgoCNpbmNsdWRlICZsdDtvZm9uby9ncHJzLWNvbnRleHQuaCZndDs8YnI+CiZndDsg
oCNpbmNsdWRlICZsdDtvZm9uby9waG9uZWJvb2suaCZndDs8YnI+CiZndDsgoCNpbmNsdWRlICZs
dDtvZm9uby9yYWRpby1zZXR0aW5ncy5oJmd0Ozxicj4KJmd0OyCgI2luY2x1ZGUgJmx0O29mb25v
L2xvZy5oJmd0Ozxicj4KJmd0Ozxicj4KJmd0OyAtI2luY2x1ZGUgJmx0O2RyaXZlcnMvYXRtb2Rl
bS92ZW5kb3IuaCZndDs8YnI+CiZndDsgoCNpbmNsdWRlICZsdDtkcml2ZXJzL2F0bW9kZW0vYXR1
dGlsLmgmZ3Q7PGJyPgomZ3Q7ICsjaW5jbHVkZSAmbHQ7ZHJpdmVycy9hdG1vZGVtL3ZlbmRvci5o
Jmd0Ozxicj4KJmd0Ozxicj4KPGJyPgo8L2Rpdj5TaW5jZSB5b3UmIzM5O3JlIG5vdCB1c2luZyBh
bnkgVkVORE9SIGRlZmluZXMsIHRoaXMgaGVhZGVyIGlzIG5vdCBuZWNlc3NhcnkuPGJyPgqgSG93
ZXZlciBJIGFjdHVhbGx5IHF1ZXN0aW9uIHdoZXRoZXIgc2lnbmFsIHN0cmVuZ3RoIHVwZGF0ZXMg
d29yayByaWdodDxicj4Kbm93IHdpdGhvdXQgdXNpbmcgdGhlIENJTkQgYmFzZWQgc2lnbmFsIHN0
cmVuZ3RoIHVwZGF0ZXMgdGhhdCBNQk0gdXNlcy48YnI+PC9ibG9ja3F1b3RlPjxkaXY+PGJyPjwv
ZGl2PjxkaXY+WWVzLCBzaWduYWygc3RyZW5ndGigaXMgYmVpbmcgdXBkYXRlZCBjb3JyZWN0bHkg
dXNpbmcgdW5zb2xpY2l0ZWQgQ0lFViBtZXNzYWdlcy48L2Rpdj48ZGl2Pjxicj48L2Rpdj48Ymxv
Y2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDtib3Jk
ZXItbGVmdDoxcHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4OyI+Cgo8ZGl2IGNsYXNzPSJp
bSI+PGJyPgomZ3Q7IKBzdGF0aWMgY29uc3QgY2hhciAqbm9uZV9wcmVmaXhbXSA9IHsgTlVMTCB9
Ozxicj4KJmd0Ozxicj4KJmd0OyCgc3RydWN0IGxpbmt0b3BfZGF0YSB7PGJyPgomZ3Q7IKAgoCCg
IEdBdENoYXQgKm1vZGVtOzxicj4KJmd0OyAtIKAgoCBHQXRDaGF0ICpjb250cm9sOzxicj4KJmd0
OyArIKAgoCBHQXRDaGF0ICphdXg7PGJyPgomZ3Q7IKAgoCCgIHN0cnVjdCBvZm9ub19ncHJzICpn
cHJzOzxicj4KJmd0OyCgIKAgoCBzdHJ1Y3Qgb2Zvbm9fZ3Byc19jb250ZXh0ICpnYzs8YnI+CiZn
dDsgoH07PGJyPgo8YnI+CjwvZGl2PiZsdDtzbmlwJmd0Ozxicj4KPGRpdiBjbGFzcz0iaW0iPjxi
cj4KJmd0OyBAQCAtMTM4LDEwICsxMzMsOSBAQCBzdGF0aWMgdm9pZCBsaW5rdG9wX2Rpc2Nvbm5l
Y3QoZ3BvaW50ZXIgdXNlcl9kYXRhKTxicj4KJmd0OyCgIKAgoCBzdHJ1Y3Qgb2Zvbm9fbW9kZW0g
Km1vZGVtID0gdXNlcl9kYXRhOzxicj4KJmd0OyCgIKAgoCBzdHJ1Y3QgbGlua3RvcF9kYXRhICpk
YXRhID0gb2Zvbm9fbW9kZW1fZ2V0X2RhdGEobW9kZW0pOzxicj4KJmd0Ozxicj4KJmd0OyAtIKAg
oCBEQkcoJnF1b3Q7JnF1b3Q7KTs8YnI+CiZndDsgKyCgIKAgREJHKCZxdW90OyVwLCBkYXRhLSZn
dDtnYyAlcCZxdW90OywgbW9kZW0sIGRhdGEtJmd0O2djKTs8YnI+CiZndDs8YnI+CiZndDsgLSCg
IKAgaWYgKGRhdGEtJmd0O2djKTxicj4KJmd0OyAtIKAgoCCgIKAgoCCgIG9mb25vX2dwcnNfY29u
dGV4dF9yZW1vdmUoZGF0YS0mZ3Q7Z2MpOzxicj4KJmd0OyArIKAgoCBvZm9ub19ncHJzX2NvbnRl
eHRfcmVtb3ZlKGRhdGEtJmd0O2djKTs8YnI+CiZndDs8YnI+CiZndDsgoCCgIKAgZ19hdF9jaGF0
X3VucmVmKGRhdGEtJmd0O21vZGVtKTs8YnI+CiZndDsgoCCgIKAgZGF0YS0mZ3Q7bW9kZW0gPSBO
VUxMOzxicj4KJmd0OyBAQCAtMTUxLDcgKzE0NSw3IEBAIHN0YXRpYyB2b2lkIGxpbmt0b3BfZGlz
Y29ubmVjdChncG9pbnRlciB1c2VyX2RhdGEpPGJyPgomZ3Q7IKAgoCCgIKAgoCCgIKAgcmV0dXJu
Ozxicj4KJmd0Ozxicj4KJmd0OyCgIKAgoCBnX2F0X2NoYXRfc2V0X2Rpc2Nvbm5lY3RfZnVuY3Rp
b24oZGF0YS0mZ3Q7bW9kZW0sPGJyPgomZ3Q7IC0goCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCg
IKAgoCCgIKAgoCCgIKAgoCBsaW5rdG9wX2Rpc2Nvbm5lY3QsIG1vZGVtKTs8YnI+CiZndDsgKyCg
IKAgoCCgIKAgoCCgIKAgoCCgIGxpbmt0b3BfZGlzY29ubmVjdCwgbW9kZW0pOzxicj4KPGJyPgo8
L2Rpdj5UaGUgb3JpZ2luYWwgZm9ybWF0dGluZyB3YXMgY29ycmVjdDxicj48L2Jsb2NrcXVvdGU+
PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7
Ym9yZGVyLWxlZnQ6MXB4ICNjY2Mgc29saWQ7cGFkZGluZy1sZWZ0OjFleDsiPjxkaXYgY2xhc3M9
ImltIj48YnI+CiZndDs8YnI+CiZndDsgoCCgIKAgb2Zvbm9faW5mbygmcXVvdDtSZW9wZW5lZCBH
UFJTIGNvbnRleHQgY2hhbm5lbCZxdW90Oyk7PGJyPgomZ3Q7PGJyPgo8L2Rpdj48ZGl2IGNsYXNz
PSJpbSI+Jmd0OyBAQCAtMjMyLDEzICsyMjMsMTIgQEAgc3RhdGljIGludCBsaW5rdG9wX2Rpc2Fi
bGUoc3RydWN0IG9mb25vX21vZGVtICptb2RlbSk8YnI+CiZndDsgoCCgIKAgoCCgIKAgoCBkYXRh
LSZndDttb2RlbSA9IE5VTEw7PGJyPgomZ3Q7IKAgoCCgIH08YnI+CiZndDs8YnI+Cjxicj4KPC9k
aXY+SXQgaXMgbm90IG5lY2Vzc2FyeSB0byBjYW5jZWxfYWxsIG9uIHRoZSBtb2RlbSBjaGFubmVs
LCB1bnJlZiBpdCBhbmQgc2V0PGJyPgppdCB0byB6ZXJvLCBjYW5jZWxfYWxsIGlzIGFscmVhZHkg
Y2FsbGVkIGF1dG9tYXRpY2FsbHkgZnJvbSB1bnJlZi4goE5vdDxicj4KdG8gbWVudGlvbiB5b3Ug
ZG8gdGhlIHNhbWUgdGhpbmcgaW4gY2Z1bl9kaXNhYmxlLjxicj48L2Jsb2NrcXVvdGU+PGRpdj48
YnI+PC9kaXY+PGRpdj5UaGFua3MgZm9yIGNvcnJlY3RpbmcgdGhpcy4uLjwvZGl2PjxkaXY+oDwv
ZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowIDAgMCAu
OGV4O2JvcmRlci1sZWZ0OjFweCAjY2NjIHNvbGlkO3BhZGRpbmctbGVmdDoxZXg7Ij4KCjxkaXYg
Y2xhc3M9ImltIj48YnI+CiZndDsgLSCgIKAgaWYgKGRhdGEtJmd0O2NvbnRyb2wgPT0gTlVMTCk8
YnI+CiZndDsgKyCgIKAgaWYgKGRhdGEtJmd0O2F1eCA9PSBOVUxMKTxicj4KJmd0OyCgIKAgoCCg
IKAgoCCgIHJldHVybiAwOzxicj4KJmd0Ozxicj4KJmd0OyAtIKAgoCBnX2F0X2NoYXRfY2FuY2Vs
X2FsbChkYXRhLSZndDtjb250cm9sKTs8YnI+CiZndDsgLSCgIKAgZ19hdF9jaGF0X3VucmVnaXN0
ZXJfYWxsKGRhdGEtJmd0O2NvbnRyb2wpOzxicj4KJmd0OyAtIKAgoCBnX2F0X2NoYXRfc2VuZChk
YXRhLSZndDtjb250cm9sLCAmcXVvdDtBVCtDRlVOPTQmcXVvdDssIG5vbmVfcHJlZml4LDxicj4K
Jmd0OyAtIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIKAgoCCgIGNmdW5fZGlzYWJsZSwg
bW9kZW0sIE5VTEwpOzxicj4KJmd0OyArIKAgoCBnX2F0X2NoYXRfY2FuY2VsX2FsbChkYXRhLSZn
dDthdXgpOzxicj4KJmd0OyArIKAgoCBnX2F0X2NoYXRfdW5yZWdpc3Rlcl9hbGwoZGF0YS0mZ3Q7
YXV4KTs8YnI+CiZndDsgKyCgIKAgZ19hdF9jaGF0X3NlbmQoZGF0YS0mZ3Q7YXV4LCAmcXVvdDtB
VCtDRlVOPTQmcXVvdDssIE5VTEwsIGNmdW5fZGlzYWJsZSwgbW9kZW0sIE5VTEwpOzxicj4KJmd0
Ozxicj4KJmd0OyCgIKAgoCByZXR1cm4gLUVJTlBST0dSRVNTOzxicj4KJmd0OyCgfTxicj4KJmd0
OyBAQCAtMjQ3LDIyICsyMzcsMjUgQEAgc3RhdGljIHZvaWQgc2V0X29ubGluZV9jYihnYm9vbGVh
biBvaywgR0F0UmVzdWx0ICpyZXN1bHQsIGdwb2ludGVyIHVzZXJfZGF0YSk8YnI+CiZndDsgoHs8
YnI+CiZndDsgoCCgIKAgc3RydWN0IGNiX2RhdGEgKmNiZCA9IHVzZXJfZGF0YTs8YnI+CiZndDsg
oCCgIKAgb2Zvbm9fbW9kZW1fb25saW5lX2NiX3QgY2IgPSBjYmQtJmd0O2NiOzxicj4KJmd0OyAt
IKAgoCBzdHJ1Y3Qgb2Zvbm9fZXJyb3IgZXJyb3I7PGJyPgomZ3Q7PGJyPgomZ3Q7IC0goCCgIGRl
Y29kZV9hdF9lcnJvcigmYW1wO2Vycm9yLCBnX2F0X3Jlc3VsdF9maW5hbF9yZXNwb25zZShyZXN1
bHQpKTs8YnI+CiZndDsgLSCgIKAgY2IoJmFtcDtlcnJvciwgY2JkLSZndDtkYXRhKTs8YnI+CiZn
dDsgKyCgIKAgaWYgKG9rKTxicj4KJmd0OyArIKAgoCCgIKAgoCCgIENBTExCQUNLX1dJVEhfU1VD
Q0VTUyhjYiwgY2JkLSZndDtkYXRhKTs8YnI+CiZndDsgKyCgIKAgZWxzZTxicj4KJmd0OyArIKAg
oCCgIKAgoCCgIENBTExCQUNLX1dJVEhfRkFJTFVSRShjYiwgY2JkLSZndDtkYXRhKTs8YnI+Cjxi
cj4KPC9kaXY+VGhlIG9yaWdpbmFsIHdhcyBhY3R1YWxseSBjb3JyZWN0IGFuZCBJIHVwZGF0ZWQg
dGhlIG1ibSBwbHVnaW4gdG8gZG8gdGhlPGJyPgpzYW1lLjxicj4KPGJyPgomZ3Q7IKB9PGJyPgom
Z3Q7PGJyPgo8YnI+ClBsZWFzZSB0ZXN0IG15IGNoYW5nZXMgYW5kIG1ha2Ugc3VyZSBJIGRpZG4m
IzM5O3QgYnJlYWsgYW55dGhpbmc8YnI+PGJyPjwvYmxvY2txdW90ZT48ZGl2Pjxicj48L2Rpdj48
ZGl2PkkganVzdCB0ZXN0ZWQgYW5kIGV2ZXJ5dGhpbmcgd29ya3MgZmluZSA6KS48L2Rpdj48ZGl2
Pjxicj48L2Rpdj48ZGl2PlRoYW5rIHlvdSBhZ2Fpbi4uLjwvZGl2PjxkaXY+PGJyPjwvZGl2Pjxk
aXY+UmVnYXJkczwvZGl2Pgo8ZGl2Pi0tPC9kaXY+PGRpdj5BbWl0IE1lbmRhcGFyYTwvZGl2Pjwv
ZGl2Pgo=

--===============9075873872253119439==--

