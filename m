Content-Type: multipart/mixed; boundary="===============3999883060542675817=="
MIME-Version: 1.0
From: Enrico Sau <enrico.sau@gmail.com>
Subject: Re: CMGS <CTRL-Z> appears with terminate IO stream in Ofono
Date: Wed, 25 Feb 2015 14:54:48 +0100
Message-ID: <CAH4ZQwv7X605Xotg25OyAphTVi8s-ZOpkjn7t-DuDE++JkTDXQ@mail.gmail.com>
In-Reply-To: <CAEM=xjiOiVOeOD9biyuhfhpm260OJBMJ_LMO0baSRNbsJpBeEw@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3999883060542675817==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Frederik,

I had a similar problem and the reason was the hangout of the modem on the
SMS sending.

I solved with the following command on my plaugin:

g_at_chat_send(data->chat, "AT&C0", NULL, NULL, NULL, NULL);

Hope this helps.

Enrico


2015-02-25 14:48 GMT+01:00 Frederik Lotter <
frederik.lotter@mixtelematics.com>:

> Hi Ofono experts,
>
> I am using a UBLOX U200 modem and I wrote the driver for it some months
> ago, and have since been using GPRS successfully.
>
> I have now added the SMS feature and I am running into a problem:
>
> It looks like once the SMS PDU byte block is sent (with CTRL-Z) the stream
> disconnects.
>
> Aux: > 0011000A8170033962660000A7044679990C<CtrlZ>
>
> Any ideas? It looks like the g_io_channel_set_encoding() is called on both
> my tty channels to RAW mode, so I am not sure why the CTRL-Z (I guess) is
> causing this.
>
> Instrumented output below:
>
> ------------------------------------
>
> ofonod[1502]:
> /home/flotter/mix6000-angstrom/build/tmp-angstrom_v2014_06-eglibc/work/ar=
mv7at2hf-vfp-angstrom-linux-gnueabi/ofono/1.14-r0/ofono-1.14/drivers/atmode=
m/sms.c:at_cmgl_done()
> ofonod[1502]: Aux: > AT+CGSMS=3D3\r
> FRED[Write watcher destroyed...]
> ofonod[1502]: Aux: < \r\nOK\r\n
> FRED>>[
> OK
> ] - 6 - 6 <<
> ofonod[1502]: Aux: > AT+CMGS=3D17\r
> FRED[Write watcher destroyed...]
> ofonod[1502]: RegisterProfile() replied an error:
> org.freedesktop.DBus.Error.UnknownMethod, Method "RegisterProfile" with
> signature "osa{sv}" on interface "org.bluez.ProfileManager1" doesn't exist
> ofonod[1502]: Aux: < \r\n>
> FRED>>[
> > ] - 4 - 4 <<
> ofonod[1502]: Aux: > 0011000A8170033962660000A7044679990C<CtrlZ>
> FRED[Write watcher destroyed...]
> FRED[Read watcher destroyed...]
> FRED[IO Disconnect]
>
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> https://lists.ofono.org/mailman/listinfo/ofono
>
>

--===============3999883060542675817==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU9ImZvbnQtZmFt
aWx5OnZlcmRhbmEsc2Fucy1zZXJpZiI+SGnCoEZyZWRlcmlrLDwvZGl2PjxkaXYgY2xhc3M9Imdt
YWlsX2RlZmF1bHQiIHN0eWxlPSJmb250LWZhbWlseTp2ZXJkYW5hLHNhbnMtc2VyaWYiPjxicj48
L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0IiBzdHlsZT0iZm9udC1mYW1pbHk6dmVyZGFu
YSxzYW5zLXNlcmlmIj5JIGhhZCBhIHNpbWlsYXIgcHJvYmxlbSBhbmQgdGhlIHJlYXNvbiB3YXMg
dGhlIGhhbmdvdXQgb2YgdGhlIG1vZGVtIG9uIHRoZSBTTVMgc2VuZGluZy48L2Rpdj48ZGl2IGNs
YXNzPSJnbWFpbF9kZWZhdWx0IiBzdHlsZT0iZm9udC1mYW1pbHk6dmVyZGFuYSxzYW5zLXNlcmlm
Ij48YnI+PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU9ImZvbnQtZmFtaWx5
OnZlcmRhbmEsc2Fucy1zZXJpZiI+SSBzb2x2ZWQgd2l0aCB0aGUgZm9sbG93aW5nIGNvbW1hbmQg
b24gbXkgcGxhdWdpbjo8L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9kZWZhdWx0IiBzdHlsZT0iZm9u
dC1mYW1pbHk6dmVyZGFuYSxzYW5zLXNlcmlmIj48YnI+PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxf
ZGVmYXVsdCIgc3R5bGU+PGZvbnQgZmFjZT0idmVyZGFuYSwgc2Fucy1zZXJpZiI+Z19hdF9jaGF0
X3NlbmQoZGF0YS0mZ3Q7Y2hhdCwgJnF1b3Q7QVQmYW1wO0MwJnF1b3Q7LCBOVUxMLCBOVUxMLCBO
VUxMLCBOVUxMKTs8L2ZvbnQ+PGJyPjwvZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2RlZmF1bHQiIHN0
eWxlPjxmb250IGZhY2U9InZlcmRhbmEsIHNhbnMtc2VyaWYiPjxicj48L2ZvbnQ+PC9kaXY+PGRp
diBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU+PGZvbnQgZmFjZT0idmVyZGFuYSwgc2Fucy1z
ZXJpZiI+SG9wZSB0aGlzIGhlbHBzLjwvZm9udD48L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9leHRy
YSI+PGRpdj48ZGl2IGNsYXNzPSJnbWFpbF9zaWduYXR1cmUiPjxkaXY+PGJyPjwvZGl2PjxkaXY+
RW5yaWNvPC9kaXY+PGRpdj48YnI+PC9kaXY+PC9kaXY+PC9kaXY+Cjxicj48ZGl2IGNsYXNzPSJn
bWFpbF9xdW90ZSI+MjAxNS0wMi0yNSAxNDo0OCBHTVQrMDE6MDAgRnJlZGVyaWsgTG90dGVyIDxz
cGFuIGRpcj0ibHRyIj4mbHQ7PGEgaHJlZj0ibWFpbHRvOmZyZWRlcmlrLmxvdHRlckBtaXh0ZWxl
bWF0aWNzLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPmZyZWRlcmlrLmxvdHRlckBtaXh0ZWxlbWF0aWNz
LmNvbTwvYT4mZ3Q7PC9zcGFuPjo8YnI+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBz
dHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7Ym9yZGVyLWxlZnQ6MXB4ICNjY2Mgc29saWQ7cGFkZGlu
Zy1sZWZ0OjFleCI+PGRpdiBkaXI9Imx0ciI+SGkgT2Zvbm8gZXhwZXJ0cyw8ZGl2Pjxicj48L2Rp
dj48ZGl2PkkgYW0gdXNpbmcgYSBVQkxPWCBVMjAwIG1vZGVtIGFuZCBJIHdyb3RlIHRoZSBkcml2
ZXIgZm9yIGl0IHNvbWUgbW9udGhzIGFnbywgYW5kIGhhdmUgc2luY2UgYmVlbiB1c2luZyBHUFJT
IHN1Y2Nlc3NmdWxseS7CoDwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+SSBoYXZlIG5vdyBhZGRl
ZCB0aGUgU01TIGZlYXR1cmUgYW5kIEkgYW0gcnVubmluZyBpbnRvIGEgcHJvYmxlbTo8L2Rpdj48
ZGl2Pjxicj48L2Rpdj48ZGl2Pkl0IGxvb2tzIGxpa2Ugb25jZSB0aGUgU01TIFBEVSBieXRlIGJs
b2NrIGlzIHNlbnQgKHdpdGggQ1RSTC1aKSB0aGUgc3RyZWFtIGRpc2Nvbm5lY3RzLjwvZGl2Pjxk
aXY+PGJyPjwvZGl2PjxkaXY+QXV4OiAmZ3Q7IDAwMTEwMDBBODE3MDAzMzk2MjY2MDAwMEE3MDQ0
Njc5OTkwQyZsdDtDdHJsWiZndDs8YnI+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5BbnkgaWRl
YXM/IEl0IGxvb2tzIGxpa2UgdGhlwqBnX2lvX2NoYW5uZWxfc2V0X2VuY29kaW5nKCkgaXMgY2Fs
bGVkIG9uIGJvdGggbXkgdHR5IGNoYW5uZWxzIHRvIFJBVyBtb2RlLCBzbyBJIGFtIG5vdCBzdXJl
IHdoeSB0aGUgQ1RSTC1aIChJIGd1ZXNzKSBpcyBjYXVzaW5nIHRoaXMuwqA8L2Rpdj48ZGl2Pjxi
cj48L2Rpdj48ZGl2Pkluc3RydW1lbnRlZCBvdXRwdXQgYmVsb3c6PC9kaXY+PGRpdj48YnI+PC9k
aXY+PGRpdj4tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS08L2Rpdj48ZGl2Pjxi
cj48L2Rpdj48ZGl2PjxkaXY+b2Zvbm9kWzE1MDJdOiAvaG9tZS9mbG90dGVyL21peDYwMDAtYW5n
c3Ryb20vYnVpbGQvdG1wLWFuZ3N0cm9tX3YyMDE0XzA2LWVnbGliYy93b3JrL2FybXY3YXQyaGYt
dmZwLWFuZ3N0cm9tLWxpbnV4LWdudWVhYmkvb2Zvbm8vMS4xNC1yMC9vZm9uby0xLjE0L2RyaXZl
cnMvYXRtb2RlbS9zbXMuYzphdF9jbWdsX2RvbmUoKcKgPC9kaXY+PGRpdj5vZm9ub2RbMTUwMl06
IEF1eDogJmd0OyBBVCtDR1NNUz0zXHI8L2Rpdj48ZGl2PkZSRURbV3JpdGUgd2F0Y2hlciBkZXN0
cm95ZWQuLi5dPC9kaXY+PGRpdj5vZm9ub2RbMTUwMl06IEF1eDogJmx0OyBcclxuT0tcclxuPC9k
aXY+PGRpdj5GUkVEJmd0OyZndDtbPC9kaXY+PGRpdj5PSzwvZGl2PjxkaXY+XSAtIDYgLSA2ICZs
dDsmbHQ7PC9kaXY+PGRpdj5vZm9ub2RbMTUwMl06IEF1eDogJmd0OyBBVCtDTUdTPTE3XHI8L2Rp
dj48ZGl2PkZSRURbV3JpdGUgd2F0Y2hlciBkZXN0cm95ZWQuLi5dPC9kaXY+PGRpdj5vZm9ub2Rb
MTUwMl06IFJlZ2lzdGVyUHJvZmlsZSgpIHJlcGxpZWQgYW4gZXJyb3I6IG9yZy5mcmVlZGVza3Rv
cC5EQnVzLkVycm9yLlVua25vd25NZXRob2QsIE1ldGhvZCAmcXVvdDtSZWdpc3RlclByb2ZpbGUm
cXVvdDsgd2l0aCBzaWduYXR1cmUgJnF1b3Q7b3Nhe3N2fSZxdW90OyBvbiBpbnRlcmZhY2UgJnF1
b3Q7b3JnLmJsdWV6LlByb2ZpbGVNYW5hZ2VyMSZxdW90OyBkb2VzbiYjMzk7dCBleGlzdDwvZGl2
PjxkaXY+b2Zvbm9kWzE1MDJdOiBBdXg6ICZsdDsgXHJcbiZndDvCoDwvZGl2PjxkaXY+RlJFRCZn
dDsmZ3Q7WzwvZGl2PjxkaXY+Jmd0OyBdIC0gNCAtIDQgJmx0OyZsdDs8L2Rpdj48ZGl2Pm9mb25v
ZFsxNTAyXTogQXV4OiAmZ3Q7IDAwMTEwMDBBODE3MDAzMzk2MjY2MDAwMEE3MDQ0Njc5OTkwQyZs
dDtDdHJsWiZndDs8L2Rpdj48ZGl2PkZSRURbV3JpdGUgd2F0Y2hlciBkZXN0cm95ZWQuLi5dPC9k
aXY+PGRpdj5GUkVEW1JlYWQgd2F0Y2hlciBkZXN0cm95ZWQuLi5dPC9kaXY+PGRpdj5GUkVEW0lP
IERpc2Nvbm5lY3RdPC9kaXY+PC9kaXY+PC9kaXY+Cjxicj5fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXzxicj4Kb2Zvbm8gbWFpbGluZyBsaXN0PGJyPgo8YSBo
cmVmPSJtYWlsdG86b2Zvbm9Ab2Zvbm8ub3JnIj5vZm9ub0BvZm9uby5vcmc8L2E+PGJyPgo8YSBo
cmVmPSJodHRwczovL2xpc3RzLm9mb25vLm9yZy9tYWlsbWFuL2xpc3RpbmZvL29mb25vIiB0YXJn
ZXQ9Il9ibGFuayI+aHR0cHM6Ly9saXN0cy5vZm9uby5vcmcvbWFpbG1hbi9saXN0aW5mby9vZm9u
bzwvYT48YnI+Cjxicj48L2Jsb2NrcXVvdGU+PC9kaXY+PGJyPjwvZGl2PjwvZGl2Pgo=

--===============3999883060542675817==--

