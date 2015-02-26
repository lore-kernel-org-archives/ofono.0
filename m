Content-Type: multipart/mixed; boundary="===============7713539434513502530=="
MIME-Version: 1.0
From: Frederik Lotter <frederik.lotter@mixtelematics.com>
Subject: Re: CMGS <CTRL-Z> appears with terminate IO stream in Ofono
Date: Thu, 26 Feb 2015 14:27:21 +0200
Message-ID: <CAEM=xjh2V0CvevxZUAL_VL5EDZ5OHwzifA2hbbowPK1JGSg1+w@mail.gmail.com>
In-Reply-To: <CAEM=xjhWe=0wn1QsHyNZf__WWzZJ0WTfhDoO-KdgBJzueT9YEA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7713539434513502530==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi All,

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

It looks like the UBLOX U200 firmware sets the DCD line to low following
the CMGS <Ctrl-Z> character, even though I have configured AT&C0 on the
line. I am chatting to Ublox to see if this could be resolved from the
modem side.

--===============7713539434513502530==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+SGkgQWxsLDxicj48ZGl2IGNsYXNzPSJnbWFpbF9leHRyYSI+PGJyPjxk
aXYgY2xhc3M9ImdtYWlsX3F1b3RlIj5PbiAyNiBGZWJydWFyeSAyMDE1IGF0IDEwOjEyLCBGcmVk
ZXJpayBMb3R0ZXIgPHNwYW4gZGlyPSJsdHIiPiZsdDs8YSBocmVmPSJtYWlsdG86ZnJlZGVyaWsu
bG90dGVyQG1peHRlbGVtYXRpY3MuY29tIiB0YXJnZXQ9Il9ibGFuayI+ZnJlZGVyaWsubG90dGVy
QG1peHRlbGVtYXRpY3MuY29tPC9hPiZndDs8L3NwYW4+IHdyb3RlOjxicj48YmxvY2txdW90ZSBj
bGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDtib3JkZXItbGVmdDox
cHggI2NjYyBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij48ZGl2IGRpcj0ibHRyIj48ZGl2PkhpIEVu
cmljbyw8L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PiZndDsgSSBoYWQgYSBzaW1pbGFyIHByb2Js
ZW0gYW5kIHRoZSByZWFzb24gd2FzIHRoZSBoYW5nb3V0IG9mIHRoZSBtb2RlbSBvbiB0aGU8L2Rp
dj48ZGl2PiZndDsgU01TIHNlbmRpbmcuPC9kaXY+PGRpdj4mZ3Q7PC9kaXY+PGRpdj4mZ3Q7IEkg
c29sdmVkIHdpdGggdGhlIGZvbGxvd2luZyBjb21tYW5kIG9uIG15IHBsYXVnaW46PC9kaXY+PGRp
dj4mZ3Q7wqA8L2Rpdj48ZGl2PiZndDsgZ19hdF9jaGF0X3NlbmQoZGF0YS0mZ3Q7Y2hhdCwgJnF1
b3Q7QVQmYW1wO0MwJnF1b3Q7LCBOVUxMLCBOVUxMLCBOVUxMLCBOVUxMKTs8L2Rpdj48ZGl2PiZn
dDs8L2Rpdj48ZGl2PiZndDtIb3BlIHRoaXMgaGVscHMuPC9kaXY+PGRpdj4mZ3Q7PC9kaXY+PGRp
dj4mZ3Q7RW5yaWNvPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5JIGFscmVhZHkgaGF2ZSBBVCZh
bXA7QzAgb24gYm90aCBteSBBVCBjaGF0IGFuZCBkYXRhIGNoYW5uZWwuIE1heWJlIHRoZXJlIGlz
IGFuIGlzc3VlIHdpdGggdGhpcyBzZXR1cCBvbiBteSBtb2RlbS48L2Rpdj48ZGl2Pjxicj48L2Rp
dj48ZGl2PlRoZSByb290IGlzc3VlIGFwcGVhcnMgaW4gdGhlIGNhbGxiYWNrOjwvZGl2PjxkaXY+
PGJyPjwvZGl2PjxkaXY+PGRpdj5zdGF0aWMgZ2Jvb2xlYW4gcmVjZWl2ZWRfZGF0YShHSU9DaGFu
bmVsICpjaGFubmVsLCBHSU9Db25kaXRpb24gY29uZCw8c3BhbiBzdHlsZT0id2hpdGUtc3BhY2U6
cHJlLXdyYXAiPsKgPC9zcGFuPmdwb2ludGVyIGRhdGEpPC9kaXY+PGRpdj48YnI+PC9kaXY+PC9k
aXY+PGRpdj5UaGUgZ19pb19jaGFubmVsX3JlYWRfY2hhcnMgZnVuY3Rpb24gZ2V0cyBhbiBFT0Yg
c3RhdHVzIG9uIHJlYWQgYW5kIHJldHVybnMgemVybyBieXRlcy4gVGhpcyBoYXBwZW5zIGFmdGVy
IHRoZSBDVFJMLVogb2YgdGhlIENNR1Mgd3JpdGUgKGl0IGFwcGVhcnMpLsKgPC9kaXY+PGRpdj48
YnI+PC9kaXY+PGRpdj5XaGF0IEkgYW0gaG9waW5nIHNvbWVvbmUgY2FuIGV4cGxhaW4sIGlzIGlm
IHRoaXMgY291bGQgYmUgY2F1c2VkIG9ubHkgYnkgdGhlIG1vZGVtIGRvaW5nIHNvbWV0aGluZyBv
biB0aGUgbGluZSwgb3Igd2hldGhlciB0aGlzIGNvdWxkIGJlIGNhdXNlIGJ5IHRoZSBHTElCIElP
IGNoYW5uZWwgaW50ZXJwcmV0aW5nIHRoZSBDVFJMLVogYXMgYSBzaWduYWwgdG8gY2xvc2UgdGhl
IGNoYW5uZWw/wqA8L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PihJIGRvIG5vdCBrbm93IHdoaWNo
IGF2ZW51ZSB0byBwZXJzdWUgaW4gZGVidWdnaW5nKS48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2
PlJpZ2h0IGluIHRoZSBiZWdpbm5pbmcgb2YgbXkgbW9kZW0gaW5pdCBjb2RlIEkgZG86PGJyPjxi
cj48ZGl2PsKgIMKgZ19hdF9jaGF0X3NlbmQoZGF0YS0mZ3Q7Y2hhdCwgJnF1b3Q7QVRFMCtDTUVF
PTEmcXVvdDssIG5vbmVfcHJlZml4LDwvZGl2PjxkaXY+PHNwYW4gc3R5bGU9IndoaXRlLXNwYWNl
OnByZS13cmFwIj4JCQkJPC9zcGFuPk5VTEwsIE5VTEwsIE5VTEwpOzwvZGl2PjxkaXY+PGJyPjwv
ZGl2PjxkaXY+wqAgwqBnX2F0X2NoYXRfc2VuZChkYXRhLSZndDtjaGF0LCAmcXVvdDtBVCZhbXA7
QzAmcXVvdDssIG5vbmVfcHJlZml4LDwvZGl2PjxkaXY+wqAgwqAgwqAgwqAgwqAgwqAgTlVMTCwg
TlVMTCwgTlVMTCk7PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj7CoCDCoGdfYXRfY2hhdF9zZW5k
KGRhdGEtJmd0O2NoYXQsICZxdW90O0FUJmFtcDtEMCZxdW90Oywgbm9uZV9wcmVmaXgsPC9kaXY+
PGRpdj7CoCDCoCDCoCDCoCDCoCDCoCBOVUxMLCBOVUxMLCBOVUxMKTs8L2Rpdj48ZGl2Pjxicj48
L2Rpdj48ZGl2PsKgIMKgZ19hdF9jaGF0X3NlbmQoZGF0YS0mZ3Q7bW9kZW0sICZxdW90O0FUJmFt
cDtDMCZxdW90Oywgbm9uZV9wcmVmaXgsPC9kaXY+PGRpdj7CoCDCoCDCoCDCoCDCoCDCoCBOVUxM
LCBOVUxMLCBOVUxMKTs8L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PsKgIMKgZ19hdF9jaGF0X3Nl
bmQoZGF0YS0mZ3Q7bW9kZW0sICZxdW90O0FUJmFtcDtEMCZxdW90Oywgbm9uZV9wcmVmaXgsPC9k
aXY+PGRpdj7CoCDCoCDCoCDCoCDCoCDCoCBOVUxMLCBOVUxMLCBOVUxMKTs8L2Rpdj48L2Rpdj48
ZGl2Pjxicj48L2Rpdj48ZGl2PlRoYW5rIGZvciB0aGUgcXVpY2sgcmVwbHkgYW5kIGFzc2lzdGFu
Y2Ugc28gZmFyLjwvZGl2PjxzcGFuIGNsYXNzPSJIT0VuWmIiPjxmb250IGNvbG9yPSIjODg4ODg4
Ij48ZGl2Pjxicj48L2Rpdj48ZGl2PkZyZWRlcmlrIExvdHRlcjwvZGl2PjxkaXY+TWlYIFRlbGVt
YXRpY3MgU291dGggQWZyaWNhPC9kaXY+PC9mb250Pjwvc3Bhbj48L2Rpdj4KPC9ibG9ja3F1b3Rl
PjwvZGl2Pjxicj48L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9leHRyYSI+SXQgbG9va3MgbGlrZSB0
aGUgVUJMT1ggVTIwMCBmaXJtd2FyZSBzZXRzIHRoZSBEQ0QgbGluZSB0byBsb3cgZm9sbG93aW5n
IHRoZSBDTUdTICZsdDtDdHJsLVomZ3Q7IGNoYXJhY3RlciwgZXZlbiB0aG91Z2ggSSBoYXZlIGNv
bmZpZ3VyZWQgQVQmYW1wO0MwIG9uIHRoZSBsaW5lLiBJIGFtIGNoYXR0aW5nIHRvIFVibG94IHRv
IHNlZSBpZiB0aGlzIGNvdWxkIGJlIHJlc29sdmVkIGZyb20gdGhlIG1vZGVtIHNpZGUuPC9kaXY+
PC9kaXY+Cg==

--===============7713539434513502530==--

