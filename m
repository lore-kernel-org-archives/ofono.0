Content-Type: multipart/mixed; boundary="===============2844391984895413349=="
MIME-Version: 1.0
From: Frederik Lotter <frederik.lotter@mixtelematics.com>
Subject: CMGS <CTRL-Z> appears with terminate IO stream in Ofono
Date: Thu, 26 Feb 2015 10:12:12 +0200
Message-ID: <CAEM=xjhWe=0wn1QsHyNZf__WWzZJ0WTfhDoO-KdgBJzueT9YEA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2844391984895413349==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Enrico,

> I had a similar problem and the reason was the hangout of the modem on the
> SMS sending.
>
> I solved with the following command on my plaugin:
>
> g_at_chat_send(data->chat, "AT&C0", NULL, NULL, NULL, NULL);
>
>Hope this helps.
>
>Enrico

I already have AT&C0 on both my AT chat and data channel. Maybe there is an
issue with this setup on my modem.

The root issue appears in the callback:

static gboolean received_data(GIOChannel *channel, GIOCondition cond, gpoin=
ter
data)

The g_io_channel_read_chars function gets an EOF status on read and returns
zero bytes. This happens after the CTRL-Z of the CMGS write (it appears).

What I am hoping someone can explain, is if this could be caused only by
the modem doing something on the line, or whether this could be cause by
the GLIB IO channel interpreting the CTRL-Z as a signal to close the
channel?

(I do not know which avenue to persue in debugging).

Right in the beginning of my modem init code I do:

   g_at_chat_send(data->chat, "ATE0+CMEE=3D1", none_prefix,
NULL, NULL, NULL);

   g_at_chat_send(data->chat, "AT&C0", none_prefix,
            NULL, NULL, NULL);

   g_at_chat_send(data->chat, "AT&D0", none_prefix,
            NULL, NULL, NULL);

   g_at_chat_send(data->modem, "AT&C0", none_prefix,
            NULL, NULL, NULL);

   g_at_chat_send(data->modem, "AT&D0", none_prefix,
            NULL, NULL, NULL);

Thank for the quick reply and assistance so far.

Frederik Lotter
MiX Telematics South Africa

--===============2844391984895413349==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdj5IaSBFbnJpY28sPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj4m
Z3Q7IEkgaGFkIGEgc2ltaWxhciBwcm9ibGVtIGFuZCB0aGUgcmVhc29uIHdhcyB0aGUgaGFuZ291
dCBvZiB0aGUgbW9kZW0gb24gdGhlPC9kaXY+PGRpdj4mZ3Q7IFNNUyBzZW5kaW5nLjwvZGl2Pjxk
aXY+Jmd0OzwvZGl2PjxkaXY+Jmd0OyBJIHNvbHZlZCB3aXRoIHRoZSBmb2xsb3dpbmcgY29tbWFu
ZCBvbiBteSBwbGF1Z2luOjwvZGl2PjxkaXY+Jmd0O8KgPC9kaXY+PGRpdj4mZ3Q7IGdfYXRfY2hh
dF9zZW5kKGRhdGEtJmd0O2NoYXQsICZxdW90O0FUJmFtcDtDMCZxdW90OywgTlVMTCwgTlVMTCwg
TlVMTCwgTlVMTCk7PC9kaXY+PGRpdj4mZ3Q7PC9kaXY+PGRpdj4mZ3Q7SG9wZSB0aGlzIGhlbHBz
LjwvZGl2PjxkaXY+Jmd0OzwvZGl2PjxkaXY+Jmd0O0VucmljbzwvZGl2PjxkaXY+PGJyPjwvZGl2
PjxkaXY+SSBhbHJlYWR5IGhhdmUgQVQmYW1wO0MwIG9uIGJvdGggbXkgQVQgY2hhdCBhbmQgZGF0
YSBjaGFubmVsLiBNYXliZSB0aGVyZSBpcyBhbiBpc3N1ZSB3aXRoIHRoaXMgc2V0dXAgb24gbXkg
bW9kZW0uPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5UaGUgcm9vdCBpc3N1ZSBhcHBlYXJzIGlu
IHRoZSBjYWxsYmFjazo8L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PjxkaXY+c3RhdGljIGdib29s
ZWFuIHJlY2VpdmVkX2RhdGEoR0lPQ2hhbm5lbCAqY2hhbm5lbCwgR0lPQ29uZGl0aW9uIGNvbmQs
PHNwYW4gc3R5bGU9IndoaXRlLXNwYWNlOnByZSI+wqA8L3NwYW4+Z3BvaW50ZXIgZGF0YSk8L2Rp
dj48ZGl2Pjxicj48L2Rpdj48L2Rpdj48ZGl2PlRoZSBnX2lvX2NoYW5uZWxfcmVhZF9jaGFycyBm
dW5jdGlvbiBnZXRzIGFuIEVPRiBzdGF0dXMgb24gcmVhZCBhbmQgcmV0dXJucyB6ZXJvIGJ5dGVz
LiBUaGlzIGhhcHBlbnMgYWZ0ZXIgdGhlIENUUkwtWiBvZiB0aGUgQ01HUyB3cml0ZSAoaXQgYXBw
ZWFycykuwqA8L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PldoYXQgSSBhbSBob3Bpbmcgc29tZW9u
ZSBjYW4gZXhwbGFpbiwgaXMgaWYgdGhpcyBjb3VsZCBiZSBjYXVzZWQgb25seSBieSB0aGUgbW9k
ZW0gZG9pbmcgc29tZXRoaW5nIG9uIHRoZSBsaW5lLCBvciB3aGV0aGVyIHRoaXMgY291bGQgYmUg
Y2F1c2UgYnkgdGhlIEdMSUIgSU8gY2hhbm5lbCBpbnRlcnByZXRpbmcgdGhlIENUUkwtWiBhcyBh
IHNpZ25hbCB0byBjbG9zZSB0aGUgY2hhbm5lbD/CoDwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+
KEkgZG8gbm90IGtub3cgd2hpY2ggYXZlbnVlIHRvIHBlcnN1ZSBpbiBkZWJ1Z2dpbmcpLjwvZGl2
PjxkaXY+PGJyPjwvZGl2PjxkaXY+UmlnaHQgaW4gdGhlIGJlZ2lubmluZyBvZiBteSBtb2RlbSBp
bml0IGNvZGUgSSBkbzo8YnI+PGJyPjxkaXY+wqAgwqBnX2F0X2NoYXRfc2VuZChkYXRhLSZndDtj
aGF0LCAmcXVvdDtBVEUwK0NNRUU9MSZxdW90Oywgbm9uZV9wcmVmaXgsPC9kaXY+PGRpdj48c3Bh
biBjbGFzcz0iIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JCQkJPC9zcGFuPk5VTEwsIE5VTEws
IE5VTEwpOzwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+wqAgwqBnX2F0X2NoYXRfc2VuZChkYXRh
LSZndDtjaGF0LCAmcXVvdDtBVCZhbXA7QzAmcXVvdDssIG5vbmVfcHJlZml4LDwvZGl2PjxkaXY+
wqAgwqAgwqAgwqAgwqAgwqAgTlVMTCwgTlVMTCwgTlVMTCk7PC9kaXY+PGRpdj48YnI+PC9kaXY+
PGRpdj7CoCDCoGdfYXRfY2hhdF9zZW5kKGRhdGEtJmd0O2NoYXQsICZxdW90O0FUJmFtcDtEMCZx
dW90Oywgbm9uZV9wcmVmaXgsPC9kaXY+PGRpdj7CoCDCoCDCoCDCoCDCoCDCoCBOVUxMLCBOVUxM
LCBOVUxMKTs8L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PsKgIMKgZ19hdF9jaGF0X3NlbmQoZGF0
YS0mZ3Q7bW9kZW0sICZxdW90O0FUJmFtcDtDMCZxdW90Oywgbm9uZV9wcmVmaXgsPC9kaXY+PGRp
dj7CoCDCoCDCoCDCoCDCoCDCoCBOVUxMLCBOVUxMLCBOVUxMKTs8L2Rpdj48ZGl2Pjxicj48L2Rp
dj48ZGl2PsKgIMKgZ19hdF9jaGF0X3NlbmQoZGF0YS0mZ3Q7bW9kZW0sICZxdW90O0FUJmFtcDtE
MCZxdW90Oywgbm9uZV9wcmVmaXgsPC9kaXY+PGRpdj7CoCDCoCDCoCDCoCDCoCDCoCBOVUxMLCBO
VUxMLCBOVUxMKTs8L2Rpdj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PlRoYW5rIGZvciB0aGUg
cXVpY2sgcmVwbHkgYW5kIGFzc2lzdGFuY2Ugc28gZmFyLjwvZGl2PjxkaXY+PGJyPjwvZGl2Pjxk
aXY+RnJlZGVyaWsgTG90dGVyPC9kaXY+PGRpdj5NaVggVGVsZW1hdGljcyBTb3V0aCBBZnJpY2E8
L2Rpdj48L2Rpdj4K

--===============2844391984895413349==--

