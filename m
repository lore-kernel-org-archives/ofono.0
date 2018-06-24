Content-Type: multipart/mixed; boundary="===============8456719233739426487=="
MIME-Version: 1.0
From: Jason Tribe <jasontribe8@gmail.com>
Subject: HE910-G - Can't activate context
Date: Sun, 24 Jun 2018 21:45:07 +0200
Message-ID: <CAGyX7WZZGpb7VJgUPDKDwgxpsZH0qSgCzf8=gbq4-HwSXXNo8Q@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8456719233739426487==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi all,

I apologize in advance for the long email.

We are attempting to use Connman/Ofono to setup a data connection with a
Telit HE910-G modem. The modem is on a Telit development kit which plugs
into our embedded hardware via the USB port.

Using version 1.17 of ofono, we were able to pickup and power/enable the
modem.

Using version 1.24 of ofono, the first problem we had was that ofono would
generate a /telit_0 interface, but any attempt to enable the mode would
fail with a dbus timeout. Eventually we tracked this down to the +GMM
command ofono uses to get the model_variant string. We saw that ofono
expects "HE910-G" from the modem, but the modem was only responding with
the model and not the variant "HE910". Hard coding the model_varaint string
to "HE910-G" solved the problem and we were able to enable/power the modem
through ofono and even register the SIM on the network. From what I can
tell, this bug seems to be present in all ofono versions that don't use the
he910.c plugin.

I looked through the AT commands data sheet for the HE910 family and the
closest command I could find that would give us the model and variant was
..., but unfortunately this echos the command back which is a bit messy. So
for now I have left it hard coded.

The current problem we are having is that we cannot activate the context
with ofono or connman. Any attempt fails with:

Error activating /telit_1/context1: org.ofono.Error.NotImplemented:
Implementation not provided.

I have seen some old (2015) posts with the same problem, but these have all
been with the older versions of ofono that use the he910.c plugin, and non
of the solutions worked for us. I am currently stuck at this point and have
been unsuccessful at debugging this any further. Is there anyone who has
had a similar problem or have any ideas on how I can debug this?

Any help with our problem would be greatly appreciated.

Kind regards
Jason

--===============8456719233739426487==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+PGRpdj5IaSBhbGwsPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5JIGFw
b2xvZ2l6ZSBpbiBhZHZhbmNlIGZvciB0aGUgbG9uZyBlbWFpbC48YnI+PC9kaXY+PGRpdj48YnI+
PC9kaXY+PGRpdj5XZSBhcmUgYXR0ZW1wdGluZyB0byB1c2UgQ29ubm1hbi9PZm9ubyB0byBzZXR1
cCBhIGRhdGEgY29ubmVjdGlvbiB3aXRoIGEgVGVsaXQgSEU5MTAtRyBtb2RlbS4gVGhlIG1vZGVt
IGlzIG9uIGEgVGVsaXQgZGV2ZWxvcG1lbnQga2l0IHdoaWNoIHBsdWdzIGludG8gb3VyIGVtYmVk
ZGVkIGhhcmR3YXJlIHZpYSB0aGUgVVNCIHBvcnQuPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5V
c2luZyB2ZXJzaW9uIDEuMTcgb2Ygb2Zvbm8sIHdlIHdlcmUgYWJsZSB0byBwaWNrdXAgYW5kIHBv
d2VyL2VuYWJsZSB0aGUgbW9kZW0uPGJyPjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+VXNpbmcg
dmVyc2lvbiAxLjI0IG9mIG9mb25vLCB0aGUgZmlyc3QgcHJvYmxlbSB3ZSBoYWQgd2FzIHRoYXQg
b2Zvbm8gd291bGQgZ2VuZXJhdGUgYSAvdGVsaXRfMCBpbnRlcmZhY2UsIGJ1dCBhbnkgYXR0ZW1w
dCB0byBlbmFibGUgdGhlIG1vZGUgd291bGQgZmFpbCB3aXRoIGEgZGJ1cyB0aW1lb3V0LiBFdmVu
dHVhbGx5IHdlIHRyYWNrZWQgdGhpcyBkb3duIHRvIHRoZSArR01NIGNvbW1hbmQgb2Zvbm8gdXNl
cyB0byBnZXQgdGhlIG1vZGVsX3ZhcmlhbnQgc3RyaW5nLiBXZSBzYXcgdGhhdCBvZm9ubyBleHBl
Y3RzICZxdW90O0hFOTEwLUcmcXVvdDsgZnJvbSB0aGUgbW9kZW0sIGJ1dCB0aGUgbW9kZW0gd2Fz
IG9ubHkgcmVzcG9uZGluZyB3aXRoIHRoZSBtb2RlbCBhbmQgbm90IHRoZSB2YXJpYW50ICZxdW90
O0hFOTEwJnF1b3Q7LiBIYXJkIGNvZGluZyB0aGUgbW9kZWxfdmFyYWludCBzdHJpbmcgdG8gJnF1
b3Q7SEU5MTAtRyZxdW90OyBzb2x2ZWQgdGhlIHByb2JsZW0gYW5kIHdlIHdlcmUgYWJsZSB0byBl
bmFibGUvcG93ZXIgdGhlIG1vZGVtIHRocm91Z2ggb2Zvbm8gYW5kIGV2ZW4gcmVnaXN0ZXIgdGhl
IFNJTSBvbiB0aGUgbmV0d29yay4gRnJvbSB3aGF0IEkgY2FuIHRlbGwsIHRoaXMgYnVnIHNlZW1z
IHRvIGJlIHByZXNlbnQgaW4gYWxsIG9mb25vIHZlcnNpb25zIHRoYXQgZG9uJiMzOTt0IHVzZSB0
aGUgaGU5MTAuYyBwbHVnaW4uPGJyPjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+SSBsb29rZWQg
dGhyb3VnaCB0aGUgQVQgY29tbWFuZHMgZGF0YSBzaGVldCBmb3IgdGhlIEhFOTEwIGZhbWlseSBh
bmQgdGhlIGNsb3Nlc3QgY29tbWFuZCBJIGNvdWxkIGZpbmQgdGhhdCB3b3VsZCBnaXZlIHVzIHRo
ZSBtb2RlbCBhbmQgdmFyaWFudCB3YXMgLi4uLCBidXQgdW5mb3J0dW5hdGVseSB0aGlzIGVjaG9z
IHRoZSBjb21tYW5kIGJhY2sgd2hpY2ggaXMgYSBiaXQgbWVzc3kuIFNvIGZvciBub3cgSSBoYXZl
IGxlZnQgaXQgaGFyZCBjb2RlZC48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PlRoZSBjdXJyZW50
IHByb2JsZW0gd2UgYXJlIGhhdmluZyBpcyB0aGF0IHdlIGNhbm5vdCBhY3RpdmF0ZSB0aGUgY29u
dGV4dCB3aXRoIG9mb25vIG9yIGNvbm5tYW4uIEFueSBhdHRlbXB0IGZhaWxzIHdpdGg6PC9kaXY+
PGRpdj7CoDxicj48L2Rpdj48ZGl2PkVycm9yIGFjdGl2YXRpbmcgL3RlbGl0XzEvY29udGV4dDE6
IG9yZy5vZm9uby5FcnJvci5Ob3RJbXBsZW1lbnRlZDogSW1wbGVtZW50YXRpb24gbm90IHByb3Zp
ZGVkLjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+SSBoYXZlIHNlZW4gc29tZSBvbGQgKDIwMTUp
IHBvc3RzIHdpdGggdGhlIHNhbWUgcHJvYmxlbSwgYnV0IHRoZXNlIGhhdmUgYWxsIGJlZW4gd2l0
aCB0aGUgb2xkZXIgdmVyc2lvbnMgb2Ygb2Zvbm8gdGhhdCB1c2UgdGhlIGhlOTEwLmMgcGx1Z2lu
LCBhbmQgbm9uIG9mIHRoZSBzb2x1dGlvbnMgd29ya2VkIGZvciB1cy4gSSBhbSBjdXJyZW50bHkg
c3R1Y2sgYXQgdGhpcyBwb2ludCBhbmQgaGF2ZSBiZWVuIHVuc3VjY2Vzc2Z1bCBhdCBkZWJ1Z2dp
bmcgdGhpcyBhbnkgZnVydGhlci4gSXMgdGhlcmUgYW55b25lIHdobyBoYXMgaGFkIGEgc2ltaWxh
ciBwcm9ibGVtIG9yIGhhdmUgYW55IGlkZWFzIG9uIGhvdyBJIGNhbiBkZWJ1ZyB0aGlzPzwvZGl2
PjxkaXY+PGJyPjwvZGl2PjxkaXY+QW55IGhlbHAgd2l0aCBvdXIgcHJvYmxlbSB3b3VsZCBiZSBn
cmVhdGx5IGFwcHJlY2lhdGVkLjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+S2luZCByZWdhcmRz
PC9kaXY+PGRpdj5KYXNvbjxicj48L2Rpdj48L2Rpdj4K

--===============8456719233739426487==--

