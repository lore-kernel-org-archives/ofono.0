Content-Type: multipart/mixed; boundary="===============3101329644184031329=="
MIME-Version: 1.0
From: =?unknown-8bit?b?5ZC05rGf5rOi?= <wujiangbo_1987@163.com>
Subject: Re:ofono bug
Date: Tue, 06 Nov 2012 14:27:51 +0000
Message-ID: <22bf93ea.1c0c0.13ad61e5931.Coremail.wujiangbo_1987@163.com>
In-Reply-To: <3c536d98.1c057.13ad61aa4af.Coremail.wujiangbo_1987@163.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3101329644184031329==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,
   i already fix the bug, so i think this is the real bug.
   i set a callback fuc to GAtMux, and add status member for echo channel, =
when i find the channel active, it will call back the fuc, fuc check all ch=
annel is active, if all channel is active, continue to send AT commands you=
 want.






At 2012-11-06 22:23:21,"=E5=90=B4=E6=B1=9F=E6=B3=A2" <wujiangbo_1987@163.=
com> wrote:

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




--===============3101329644184031329==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBzdHlsZT0ibGluZS1oZWlnaHQ6MS43O2NvbG9yOiMwMDAwMDA7Zm9udC1zaXplOjE0cHg7
Zm9udC1mYW1pbHk6YXJpYWwiPkhpLDxicj4mbmJzcDsmbmJzcDsgaSBhbHJlYWR5IGZpeCB0aGUg
YnVnLCBzbyBpIHRoaW5rIHRoaXMgaXMgdGhlIHJlYWwgYnVnLjxicj4mbmJzcDsmbmJzcDsgaSBz
ZXQgYSBjYWxsYmFjayBmdWMgdG8gR0F0TXV4LCBhbmQgYWRkIHN0YXR1cyBtZW1iZXIgZm9yIGVj
aG8gY2hhbm5lbCwgd2hlbiBpIGZpbmQgdGhlIGNoYW5uZWwgYWN0aXZlLCBpdCB3aWxsIGNhbGwg
YmFjayB0aGUgZnVjLCBmdWMgY2hlY2sgYWxsIGNoYW5uZWwgaXMgYWN0aXZlLCBpZiBhbGwgY2hh
bm5lbCBpcyBhY3RpdmUsIGNvbnRpbnVlIHRvIHNlbmQgQVQgY29tbWFuZHMgeW91IHdhbnQuPGJy
Pjxicj48YnI+PGJyPjxicj48ZGl2PjwvZGl2PjxkaXYgaWQ9ImRpdk5ldGVhc2VNYWlsQ2FyZCI+
PC9kaXY+PGJyPkF0IDIwMTItMTEtMDYgMjI6MjM6MjEsIs7iva2yqCImbmJzcDsmbHQ7d3VqaWFu
Z2JvXzE5ODdAMTYzLmNvbSZndDsgd3JvdGU6PGJyPiA8YmxvY2txdW90ZSBpZD0iaXNSZXBseUNv
bnRlbnQiIHN0eWxlPSJQQURESU5HLUxFRlQ6IDFleDsgTUFSR0lOOiAwcHggMHB4IDBweCAwLjhl
eDsgQk9SREVSLUxFRlQ6ICNjY2MgMXB4IHNvbGlkIj48ZGl2IHN0eWxlPSJsaW5lLWhlaWdodDox
Ljc7Y29sb3I6IzAwMDAwMDtmb250LXNpemU6MTRweDtmb250LWZhbWlseTphcmlhbCI+SGkgRGVu
aXMgS2Vuemlvciw8YnI+Jm5ic3A7ICZuYnNwOyBJIGZpbmQgYSBidWcgYWJvdXQgb2Zvbm8sIGlu
IHNyYy9pZnguYy4gVGhlIGZ1bmN0aW9uIHNldHVwX2ludGVybmFsX211eC4gaWYgd2UgbW9kZW0g
dXNlIE11eCBpbiBvZm9ubyBjb2RlLCBvZm9ubyB3aWxsIGNyZWF0ZSBzaXggY2hhbm5lbCB0byBz
ZW5kIHJlcXVlc3QuIEFmdGVyIHdlIHNlbmQgQVQgY29tbWFuZHMsIGVhY2ggbXV4IGNoYW5uZWwg
c2hvdWxkIGJlIGFjdGl2ZSB0aGF0IHRocm91Z2ggc2VuZCBhIGxpdHRsZSBkYXRhIGFuZCByZWNl
aXZlLiBJbiBzZXR1cF9pbnRlcm5hbF9tdXggZnVuY3Rpb24gaXQgb25seSBzZXQgMTAgbWlsbGlz
ZWNvbmQgdG8gZG8gdGhhdCwgaXQgbWFudWFsIHRoaW5rIGNoYW5uZWwgYWN0aXZlIHdoaWxlIDEw
IG1pbGxpc2Vjb25kLiBpZiB0aGUgbW9kZW0gZG9uJ3QgcmVzcG9uc2UgY2hhbm5lbCBhY3RpdmUg
aW4gMTAgbWlsbGlzZWNvbmQsIHRoZSBzZW5kaW5nIEFUIGNvbW1hbmRzIGRvbid0IGRpc3BhdGNo
IHRvIHJpZ2h0IGNoYW5uZWwuIGlmIHlvdSBhcmUgbHVja3ksIG9mb25vIHdpbGwgd29yayB3ZWxs
LCBidXQgaXQgZG9uJ3QgZ3VhcmFudGVlLiBhbmQgYWxzbyBpIGhhdmUgdGhlIHByb2JsZW0uIG9m
b25vIGRvbid0IHdvcmsgd2VsbCwgaXQgYmUgY2F1c2UgYnkgY2hhbm5lbCBoYXZuJ3QgY29uZmln
dXJlLCBvZm9ubyBzZW5kIEFUIGNvbWFuZHMuIFRoZSBHQXRNdXggcmVjZWl2ZSB0aGUgcmVzcG9u
c2UsIGJ1dCBHQXRNdXggZG9uJ3Qga25vdyB3aGljaCBjaGFubmVsIHRoZSByZXNwb25zZSBzaG91
bGQgYmUgZGlzcGF0Y2hlZC4gR0F0TXV4IHdpbGwgZGlzY2FyZCB0aGUgcmlnaHQgcmVzcG9uc2Us
IGFuZCB0aGUgQVQgY29tbWFuZCB3aWxsIGRvbid0IHJlY2VpdmUgdGhlIHJlc3BvbnNlIGZvcmV2
ZXIsIGl0IHdpbGwgY2FzZSBzb21lIHJlcXVlc3QgdGltZW91dCwgYW5kIG9mb25vIHRoaW5rIGl0
IGhhdmUgc29tZSBwcm9ibGVtIGl0IGRvbid0IHdvcmsuPGJyPiZuYnNwOyZuYnNwOyZuYnNwOyBh
bnkgcXVlc3Rpb25zLiB0aGVuIHdlIG9wZW4gbXV4LCBvZm9ubyB3aWxsIGNyZWF0ZSBhIG5ldyBJ
T0NoYW5uZWwsIHRoZSBwcmV2aW91c2x5IGRldmljZSBJT0NoYW5uZWwgc2hvdWxkIHJlbW92ZSBm
cm9tIG1haW4gY29udGV4dCwgYnV0IG9mb25vIGRvbid0IGRvIHRoYXQuIHdoeT88YnI+PGJyPnN0
YXRpYyB2b2lkIHNldHVwX2ludGVybmFsX211eChzdHJ1Y3Qgb2Zvbm9fbW9kZW0gKm1vZGVtKTxi
cj57PGJyPiZuYnNwOyZuYnNwOyZuYnNwOyAuLi4uLi4uLi4uLi4uLjxicj4mbmJzcDsmbmJzcDsm
bmJzcDsgZ19hdF9tdXhfc3RhcnQoZGF0YS0mZ3Q7bXV4KTs8YnI+PGJyPiZuYnNwOyZuYnNwOyZu
YnNwOyBmb3IgKGkgPSAwOyBpICZsdDsgTlVNX0RMQzsgaSsrKSB7PGJyPiZuYnNwOyZuYnNwOyZu
YnNwOyAmbmJzcDsmbmJzcDsgJm5ic3A7R0lPQ2hhbm5lbCAqY2hhbm5lbCA9IGdfYXRfbXV4X2Ny
ZWF0ZV9jaGFubmVsKGRhdGEtJmd0O211eCk7PGJyPjxicj4mbmJzcDsmbmJzcDsmbmJzcDsgJm5i
c3A7Jm5ic3A7ICZuYnNwO2RhdGEtJmd0O2RsY3NbaV0gPSBjcmVhdGVfY2hhdChjaGFubmVsLCBt
b2RlbSwgZGxjX3ByZWZpeGVzW2ldKTs8YnI+Jm5ic3A7Jm5ic3A7Jm5ic3A7ICZuYnNwOyZuYnNw
OyAmbmJzcDtpZiAoZGF0YS0mZ3Q7ZGxjc1tpXSA9PSBOVUxMKSB7PGJyPiZuYnNwOyZuYnNwOyZu
YnNwOyAmbmJzcDsmbmJzcDsgJm5ic3A7Jm5ic3A7Jm5ic3A7ICZuYnNwO29mb25vX2Vycm9yKCJG
YWlsZWQgdG8gY3JlYXRlIGNoYW5uZWwiKTs8YnI+Jm5ic3A7Jm5ic3A7Jm5ic3A7ICZuYnNwOyZu
YnNwOyAmbmJzcDsmbmJzcDsmbmJzcDsgJm5ic3A7Z290byBlcnJvcjs8YnI+Jm5ic3A7Jm5ic3A7
Jm5ic3A7ICZuYnNwOyZuYnNwOyAmbmJzcDt9PGJyPiZuYnNwOyZuYnNwOyZuYnNwOyB9PGJyPjxi
cj4mbmJzcDsmbmJzcDsmbmJzcDsgLyogd2FpdCBmb3IgRExDIGNyZWF0aW9uIHRvIHNldHRsZSAq
Lzxicj4mbmJzcDsmbmJzcDsmbmJzcDsgZGF0YS0mZ3Q7ZGxjX2luaXRfc291cmNlID0gZ190aW1l
b3V0X2FkZCgxMCwgZGxjX3NldHVwLCBtb2RlbSk7PGJyPiZuYnNwOyZuYnNwOyZuYnNwOyAuLi4u
Li4uLi4uLi4uLi4uLi4uLjxicj59IDxicj48YnI+QmVzdCByZWdhcmRzPGJyPkFuZCBUaGFua3Mh
PGJyPkppYW5nYm8ud3U8YnI+PC9kaXY+PGJyPjxicj48c3BhbiB0aXRsZT0ibmV0ZWFzZWZvb3Rl
ciI+PHNwYW4gaWQ9Im5ldGVhc2VfbWFpbF9mb290ZXIiPjwvc3Bhbj48L3NwYW4+PC9ibG9ja3F1
b3RlPjwvZGl2Pjxicj48YnI+PHNwYW4gdGl0bGU9Im5ldGVhc2Vmb290ZXIiPjxzcGFuIGlkPSJu
ZXRlYXNlX21haWxfZm9vdGVyIj48L3NwYW4+PC9zcGFuPg==
--===============3101329644184031329==--

