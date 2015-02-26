Content-Type: multipart/mixed; boundary="===============8031484779451933736=="
MIME-Version: 1.0
From: Frederik Lotter <frederik.lotter@mixtelematics.com>
Subject: Re: CMGS <CTRL-Z> appears with terminate IO stream in Ofono
Date: Thu, 26 Feb 2015 12:20:28 +0200
Message-ID: <CAEM=xjhE_brtFqfUokBxMQ_xsn8rVGQNVaZMgu-R8e266htqyQ@mail.gmail.com>
In-Reply-To: <CAEM=xjhWe=0wn1QsHyNZf__WWzZJ0WTfhDoO-KdgBJzueT9YEA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8031484779451933736==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 26 February 2015 at 10:12, Frederik Lotter <
frederik.lotter@mixtelematics.com> wrote:

> Hi Enrico,
>
> > I had a similar problem and the reason was the hangout of the modem on
> the
> > SMS sending.
> >
> > I solved with the following command on my plaugin:
> >
> > g_at_chat_send(data->chat, "AT&C0", NULL, NULL, NULL, NULL);
> >
> >Hope this helps.
> >
> >Enrico
>
> I already have AT&C0 on both my AT chat and data channel. Maybe there is
> an issue with this setup on my modem.
>
> The root issue appears in the callback:
>
> static gboolean received_data(GIOChannel *channel, GIOCondition cond, gpo=
inter
> data)
>
> The g_io_channel_read_chars function gets an EOF status on read and
> returns zero bytes. This happens after the CTRL-Z of the CMGS write (it
> appears).
>
> What I am hoping someone can explain, is if this could be caused only by
> the modem doing something on the line, or whether this could be cause by
> the GLIB IO channel interpreting the CTRL-Z as a signal to close the
> channel?
>
> (I do not know which avenue to persue in debugging).
>
> Right in the beginning of my modem init code I do:
>
>    g_at_chat_send(data->chat, "ATE0+CMEE=3D1", none_prefix,
> NULL, NULL, NULL);
>
>    g_at_chat_send(data->chat, "AT&C0", none_prefix,
>             NULL, NULL, NULL);
>
>    g_at_chat_send(data->chat, "AT&D0", none_prefix,
>             NULL, NULL, NULL);
>
>    g_at_chat_send(data->modem, "AT&C0", none_prefix,
>             NULL, NULL, NULL);
>
>    g_at_chat_send(data->modem, "AT&D0", none_prefix,
>             NULL, NULL, NULL);
>
> Thank for the quick reply and assistance so far.
>
> Frederik Lotter
> MiX Telematics South Africa
>

Oh and in addition to me previous description, if I do the same CMGS over
kermit on the TTY port, I am not problem with the reply, so it really looks
to me like a GIO channel issue of some sort.

--===============8031484779451933736==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdiBjbGFzcz0iZ21haWxfZXh0cmEiPjxkaXYgY2xhc3M9ImdtYWls
X3F1b3RlIj5PbiAyNiBGZWJydWFyeSAyMDE1IGF0IDEwOjEyLCBGcmVkZXJpayBMb3R0ZXIgPHNw
YW4gZGlyPSJsdHIiPiZsdDs8YSBocmVmPSJtYWlsdG86ZnJlZGVyaWsubG90dGVyQG1peHRlbGVt
YXRpY3MuY29tIiB0YXJnZXQ9Il9ibGFuayI+ZnJlZGVyaWsubG90dGVyQG1peHRlbGVtYXRpY3Mu
Y29tPC9hPiZndDs8L3NwYW4+IHdyb3RlOjxicj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVv
dGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDtib3JkZXItbGVmdDoxcHggI2NjYyBzb2xpZDtw
YWRkaW5nLWxlZnQ6MWV4Ij48ZGl2IGRpcj0ibHRyIj48ZGl2PkhpIEVucmljbyw8L2Rpdj48ZGl2
Pjxicj48L2Rpdj48ZGl2PiZndDsgSSBoYWQgYSBzaW1pbGFyIHByb2JsZW0gYW5kIHRoZSByZWFz
b24gd2FzIHRoZSBoYW5nb3V0IG9mIHRoZSBtb2RlbSBvbiB0aGU8L2Rpdj48ZGl2PiZndDsgU01T
IHNlbmRpbmcuPC9kaXY+PGRpdj4mZ3Q7PC9kaXY+PGRpdj4mZ3Q7IEkgc29sdmVkIHdpdGggdGhl
IGZvbGxvd2luZyBjb21tYW5kIG9uIG15IHBsYXVnaW46PC9kaXY+PGRpdj4mZ3Q7wqA8L2Rpdj48
ZGl2PiZndDsgZ19hdF9jaGF0X3NlbmQoZGF0YS0mZ3Q7Y2hhdCwgJnF1b3Q7QVQmYW1wO0MwJnF1
b3Q7LCBOVUxMLCBOVUxMLCBOVUxMLCBOVUxMKTs8L2Rpdj48ZGl2PiZndDs8L2Rpdj48ZGl2PiZn
dDtIb3BlIHRoaXMgaGVscHMuPC9kaXY+PGRpdj4mZ3Q7PC9kaXY+PGRpdj4mZ3Q7RW5yaWNvPC9k
aXY+PGRpdj48YnI+PC9kaXY+PGRpdj5JIGFscmVhZHkgaGF2ZSBBVCZhbXA7QzAgb24gYm90aCBt
eSBBVCBjaGF0IGFuZCBkYXRhIGNoYW5uZWwuIE1heWJlIHRoZXJlIGlzIGFuIGlzc3VlIHdpdGgg
dGhpcyBzZXR1cCBvbiBteSBtb2RlbS48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PlRoZSByb290
IGlzc3VlIGFwcGVhcnMgaW4gdGhlIGNhbGxiYWNrOjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+
PGRpdj5zdGF0aWMgZ2Jvb2xlYW4gcmVjZWl2ZWRfZGF0YShHSU9DaGFubmVsICpjaGFubmVsLCBH
SU9Db25kaXRpb24gY29uZCw8c3BhbiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlLXdyYXAiPsKgPC9z
cGFuPmdwb2ludGVyIGRhdGEpPC9kaXY+PGRpdj48YnI+PC9kaXY+PC9kaXY+PGRpdj5UaGUgZ19p
b19jaGFubmVsX3JlYWRfY2hhcnMgZnVuY3Rpb24gZ2V0cyBhbiBFT0Ygc3RhdHVzIG9uIHJlYWQg
YW5kIHJldHVybnMgemVybyBieXRlcy4gVGhpcyBoYXBwZW5zIGFmdGVyIHRoZSBDVFJMLVogb2Yg
dGhlIENNR1Mgd3JpdGUgKGl0IGFwcGVhcnMpLsKgPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5X
aGF0IEkgYW0gaG9waW5nIHNvbWVvbmUgY2FuIGV4cGxhaW4sIGlzIGlmIHRoaXMgY291bGQgYmUg
Y2F1c2VkIG9ubHkgYnkgdGhlIG1vZGVtIGRvaW5nIHNvbWV0aGluZyBvbiB0aGUgbGluZSwgb3Ig
d2hldGhlciB0aGlzIGNvdWxkIGJlIGNhdXNlIGJ5IHRoZSBHTElCIElPIGNoYW5uZWwgaW50ZXJw
cmV0aW5nIHRoZSBDVFJMLVogYXMgYSBzaWduYWwgdG8gY2xvc2UgdGhlIGNoYW5uZWw/wqA8L2Rp
dj48ZGl2Pjxicj48L2Rpdj48ZGl2PihJIGRvIG5vdCBrbm93IHdoaWNoIGF2ZW51ZSB0byBwZXJz
dWUgaW4gZGVidWdnaW5nKS48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PlJpZ2h0IGluIHRoZSBi
ZWdpbm5pbmcgb2YgbXkgbW9kZW0gaW5pdCBjb2RlIEkgZG86PGJyPjxicj48ZGl2PsKgIMKgZ19h
dF9jaGF0X3NlbmQoZGF0YS0mZ3Q7Y2hhdCwgJnF1b3Q7QVRFMCtDTUVFPTEmcXVvdDssIG5vbmVf
cHJlZml4LDwvZGl2PjxkaXY+PHNwYW4gc3R5bGU9IndoaXRlLXNwYWNlOnByZS13cmFwIj4JCQkJ
PC9zcGFuPk5VTEwsIE5VTEwsIE5VTEwpOzwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+wqAgwqBn
X2F0X2NoYXRfc2VuZChkYXRhLSZndDtjaGF0LCAmcXVvdDtBVCZhbXA7QzAmcXVvdDssIG5vbmVf
cHJlZml4LDwvZGl2PjxkaXY+wqAgwqAgwqAgwqAgwqAgwqAgTlVMTCwgTlVMTCwgTlVMTCk7PC9k
aXY+PGRpdj48YnI+PC9kaXY+PGRpdj7CoCDCoGdfYXRfY2hhdF9zZW5kKGRhdGEtJmd0O2NoYXQs
ICZxdW90O0FUJmFtcDtEMCZxdW90Oywgbm9uZV9wcmVmaXgsPC9kaXY+PGRpdj7CoCDCoCDCoCDC
oCDCoCDCoCBOVUxMLCBOVUxMLCBOVUxMKTs8L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PsKgIMKg
Z19hdF9jaGF0X3NlbmQoZGF0YS0mZ3Q7bW9kZW0sICZxdW90O0FUJmFtcDtDMCZxdW90Oywgbm9u
ZV9wcmVmaXgsPC9kaXY+PGRpdj7CoCDCoCDCoCDCoCDCoCDCoCBOVUxMLCBOVUxMLCBOVUxMKTs8
L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PsKgIMKgZ19hdF9jaGF0X3NlbmQoZGF0YS0mZ3Q7bW9k
ZW0sICZxdW90O0FUJmFtcDtEMCZxdW90Oywgbm9uZV9wcmVmaXgsPC9kaXY+PGRpdj7CoCDCoCDC
oCDCoCDCoCDCoCBOVUxMLCBOVUxMLCBOVUxMKTs8L2Rpdj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48
ZGl2PlRoYW5rIGZvciB0aGUgcXVpY2sgcmVwbHkgYW5kIGFzc2lzdGFuY2Ugc28gZmFyLjwvZGl2
PjxzcGFuIGNsYXNzPSJIT0VuWmIiPjxmb250IGNvbG9yPSIjODg4ODg4Ij48ZGl2Pjxicj48L2Rp
dj48ZGl2PkZyZWRlcmlrIExvdHRlcjwvZGl2PjxkaXY+TWlYIFRlbGVtYXRpY3MgU291dGggQWZy
aWNhPC9kaXY+PC9mb250Pjwvc3Bhbj48L2Rpdj4KPC9ibG9ja3F1b3RlPjwvZGl2Pjxicj48L2Rp
dj48ZGl2IGNsYXNzPSJnbWFpbF9leHRyYSI+T2ggYW5kIGluIGFkZGl0aW9uIHRvIG1lIHByZXZp
b3VzIGRlc2NyaXB0aW9uLCBpZiBJIGRvIHRoZSBzYW1lIENNR1Mgb3ZlciBrZXJtaXQgb24gdGhl
IFRUWSBwb3J0LCBJIGFtIG5vdCBwcm9ibGVtIHdpdGggdGhlIHJlcGx5LCBzbyBpdCByZWFsbHkg
bG9va3MgdG8gbWUgbGlrZSBhIEdJTyBjaGFubmVsIGlzc3VlIG9mIHNvbWUgc29ydC7CoDwvZGl2
PjwvZGl2Pgo=

--===============8031484779451933736==--

