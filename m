Content-Type: multipart/mixed; boundary="===============2708899550904625384=="
MIME-Version: 1.0
From: =?unknown-8bit?b?5ZC05rGf5rOi?= <wujiangbo_1987@163.com>
Subject: ofono bug
Date: Tue, 06 Nov 2012 14:23:48 +0000
Message-ID: <3c536d98.1c057.13ad61aa4af.Coremail.wujiangbo_1987@163.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2708899550904625384==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis Kenzior,
    I find a bug about ofono, in src/ifx.c. The function setup_internal_mux=
. if we modem use Mux in ofono code, ofono will create six channel to send =
request. After we send AT commands, each mux channel should be active that =
through send a little data and receive. In setup_internal_mux function it o=
nly set 10 millisecond to do that, it manual think channel active while 10 =
millisecond. if the modem don't response channel active in 10 millisecond, =
the sending AT commands don't dispatch to right channel. if you are lucky, =
ofono will work well, but it don't guarantee. and also i have the problem. =
ofono don't work well, it be cause by channel havn't configure, ofono send =
AT comands. The GAtMux receive the response, but GAtMux don't know which ch=
annel the response should be dispatched. GAtMux will discard the right resp=
onse, and the AT command will don't receive the response forever, it will c=
ase some request timeout, and ofono think it have some problem it don't wor=
k.
    any questions. then we open mux, ofono will create a new IOChannel, the=
 previously device IOChannel should remove from main context, but ofono don=
't do that. why?

static void setup_internal_mux(struct ofono_modem *modem)
{
    ..............
    g_at_mux_start(data->mux);

    for (i =3D 0; i < NUM_DLC; i++) {
        GIOChannel *channel =3D g_at_mux_create_channel(data->mux);

        data->dlcs[i] =3D create_chat(channel, modem, dlc_prefixes[i]);
        if (data->dlcs[i] =3D=3D NULL) {
            ofono_error("Failed to create channel");
            goto error;
        }
    }

    /* wait for DLC creation to settle */
    data->dlc_init_source =3D g_timeout_add(10, dlc_setup, modem);
    ....................
}

Best regards
And Thanks!
Jiangbo.wu

--===============2708899550904625384==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBzdHlsZT0ibGluZS1oZWlnaHQ6MS43O2NvbG9yOiMwMDAwMDA7Zm9udC1zaXplOjE0cHg7
Zm9udC1mYW1pbHk6YXJpYWwiPkhpIERlbmlzIEtlbnppb3IsPGJyPiZuYnNwOyAmbmJzcDsgSSBm
aW5kIGEgYnVnIGFib3V0IG9mb25vLCBpbiBzcmMvaWZ4LmMuIFRoZSBmdW5jdGlvbiBzZXR1cF9p
bnRlcm5hbF9tdXguIGlmIHdlIG1vZGVtIHVzZSBNdXggaW4gb2Zvbm8gY29kZSwgb2Zvbm8gd2ls
bCBjcmVhdGUgc2l4IGNoYW5uZWwgdG8gc2VuZCByZXF1ZXN0LiBBZnRlciB3ZSBzZW5kIEFUIGNv
bW1hbmRzLCBlYWNoIG11eCBjaGFubmVsIHNob3VsZCBiZSBhY3RpdmUgdGhhdCB0aHJvdWdoIHNl
bmQgYSBsaXR0bGUgZGF0YSBhbmQgcmVjZWl2ZS4gSW4gc2V0dXBfaW50ZXJuYWxfbXV4IGZ1bmN0
aW9uIGl0IG9ubHkgc2V0IDEwIG1pbGxpc2Vjb25kIHRvIGRvIHRoYXQsIGl0IG1hbnVhbCB0aGlu
ayBjaGFubmVsIGFjdGl2ZSB3aGlsZSAxMCBtaWxsaXNlY29uZC4gaWYgdGhlIG1vZGVtIGRvbid0
IHJlc3BvbnNlIGNoYW5uZWwgYWN0aXZlIGluIDEwIG1pbGxpc2Vjb25kLCB0aGUgc2VuZGluZyBB
VCBjb21tYW5kcyBkb24ndCBkaXNwYXRjaCB0byByaWdodCBjaGFubmVsLiBpZiB5b3UgYXJlIGx1
Y2t5LCBvZm9ubyB3aWxsIHdvcmsgd2VsbCwgYnV0IGl0IGRvbid0IGd1YXJhbnRlZS4gYW5kIGFs
c28gaSBoYXZlIHRoZSBwcm9ibGVtLiBvZm9ubyBkb24ndCB3b3JrIHdlbGwsIGl0IGJlIGNhdXNl
IGJ5IGNoYW5uZWwgaGF2bid0IGNvbmZpZ3VyZSwgb2Zvbm8gc2VuZCBBVCBjb21hbmRzLiBUaGUg
R0F0TXV4IHJlY2VpdmUgdGhlIHJlc3BvbnNlLCBidXQgR0F0TXV4IGRvbid0IGtub3cgd2hpY2gg
Y2hhbm5lbCB0aGUgcmVzcG9uc2Ugc2hvdWxkIGJlIGRpc3BhdGNoZWQuIEdBdE11eCB3aWxsIGRp
c2NhcmQgdGhlIHJpZ2h0IHJlc3BvbnNlLCBhbmQgdGhlIEFUIGNvbW1hbmQgd2lsbCBkb24ndCBy
ZWNlaXZlIHRoZSByZXNwb25zZSBmb3JldmVyLCBpdCB3aWxsIGNhc2Ugc29tZSByZXF1ZXN0IHRp
bWVvdXQsIGFuZCBvZm9ubyB0aGluayBpdCBoYXZlIHNvbWUgcHJvYmxlbSBpdCBkb24ndCB3b3Jr
Ljxicj4mbmJzcDsmbmJzcDsmbmJzcDsgYW55IHF1ZXN0aW9ucy4gdGhlbiB3ZSBvcGVuIG11eCwg
b2Zvbm8gd2lsbCBjcmVhdGUgYSBuZXcgSU9DaGFubmVsLCB0aGUgcHJldmlvdXNseSBkZXZpY2Ug
SU9DaGFubmVsIHNob3VsZCByZW1vdmUgZnJvbSBtYWluIGNvbnRleHQsIGJ1dCBvZm9ubyBkb24n
dCBkbyB0aGF0LiB3aHk/PGJyPjxicj5zdGF0aWMgdm9pZCBzZXR1cF9pbnRlcm5hbF9tdXgoc3Ry
dWN0IG9mb25vX21vZGVtICptb2RlbSk8YnI+ezxicj4mbmJzcDsmbmJzcDsmbmJzcDsgLi4uLi4u
Li4uLi4uLi48YnI+Jm5ic3A7Jm5ic3A7Jm5ic3A7IGdfYXRfbXV4X3N0YXJ0KGRhdGEtJmd0O211
eCk7PGJyPjxicj4mbmJzcDsmbmJzcDsmbmJzcDsgZm9yIChpID0gMDsgaSAmbHQ7IE5VTV9ETEM7
IGkrKykgezxicj4mbmJzcDsmbmJzcDsmbmJzcDsgJm5ic3A7Jm5ic3A7ICZuYnNwO0dJT0NoYW5u
ZWwgKmNoYW5uZWwgPSBnX2F0X211eF9jcmVhdGVfY2hhbm5lbChkYXRhLSZndDttdXgpOzxicj48
YnI+Jm5ic3A7Jm5ic3A7Jm5ic3A7ICZuYnNwOyZuYnNwOyAmbmJzcDtkYXRhLSZndDtkbGNzW2ld
ID0gY3JlYXRlX2NoYXQoY2hhbm5lbCwgbW9kZW0sIGRsY19wcmVmaXhlc1tpXSk7PGJyPiZuYnNw
OyZuYnNwOyZuYnNwOyAmbmJzcDsmbmJzcDsgJm5ic3A7aWYgKGRhdGEtJmd0O2RsY3NbaV0gPT0g
TlVMTCkgezxicj4mbmJzcDsmbmJzcDsmbmJzcDsgJm5ic3A7Jm5ic3A7ICZuYnNwOyZuYnNwOyZu
YnNwOyAmbmJzcDtvZm9ub19lcnJvcigiRmFpbGVkIHRvIGNyZWF0ZSBjaGFubmVsIik7PGJyPiZu
YnNwOyZuYnNwOyZuYnNwOyAmbmJzcDsmbmJzcDsgJm5ic3A7Jm5ic3A7Jm5ic3A7ICZuYnNwO2dv
dG8gZXJyb3I7PGJyPiZuYnNwOyZuYnNwOyZuYnNwOyAmbmJzcDsmbmJzcDsgJm5ic3A7fTxicj4m
bmJzcDsmbmJzcDsmbmJzcDsgfTxicj48YnI+Jm5ic3A7Jm5ic3A7Jm5ic3A7IC8qIHdhaXQgZm9y
IERMQyBjcmVhdGlvbiB0byBzZXR0bGUgKi88YnI+Jm5ic3A7Jm5ic3A7Jm5ic3A7IGRhdGEtJmd0
O2RsY19pbml0X3NvdXJjZSA9IGdfdGltZW91dF9hZGQoMTAsIGRsY19zZXR1cCwgbW9kZW0pOzxi
cj4mbmJzcDsmbmJzcDsmbmJzcDsgLi4uLi4uLi4uLi4uLi4uLi4uLi48YnI+fSA8YnI+PGJyPkJl
c3QgcmVnYXJkczxicj5BbmQgVGhhbmtzITxicj5KaWFuZ2JvLnd1PGJyPjwvZGl2Pjxicj48YnI+
PHNwYW4gdGl0bGU9Im5ldGVhc2Vmb290ZXIiPjxzcGFuIGlkPSJuZXRlYXNlX21haWxfZm9vdGVy
Ij48L3NwYW4+PC9zcGFuPg==
--===============2708899550904625384==--

