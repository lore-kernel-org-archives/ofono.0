Content-Type: multipart/mixed; boundary="===============2802399143743319994=="
MIME-Version: 1.0
From: John Tobias <john.tobias.ph@gmail.com>
Subject: Quectel TCP/IP connection
Date: Wed, 08 May 2019 16:13:47 -0700
Message-ID: <CACUGKYNcz0xOZsiJLnsVzvwfX4QK-LBvGTYX+2LZL7SoZnu1xg@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2802399143743319994==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi all,

I was trying to integrate the quectel
<https://www.quectel.com/UploadImage/Downlad/Quectel_BG96_TCP(IP)_AT_Comman=
ds_Manual_V1.0.pdf>
tcp/ip
connection in the ofono driver. I used AT+QIOPEN for opening the
socket, AT+QIRD for receiving data from the server and AT+QISENDEX for
sending data to the server.

The 3 functions are working correctly if I executed it directly in the
serial port. I had issue with ofono when it send the AT+QISENDEX. Below is
the command:

char const *command2 =3D "AT+QISENDEX=3D2,\"48656c6c6f\"";
g_at_chat_send(data->aux, command2, none_prefix, NULL, NULL,NULL);


The first execution of the QISENDEX works. My server received the data but
when I try it again, the ofono stuck somewhere where the it couldn't run
any AT commands anymore. Then, I killed the ofono and opened the serial, I
ran this command AT+QISENDEX=3D2,"48656c6c6f" and it works fine.

I enabled the -d (debug) in ofono parameter and I couldn't find any logs
related to what I am seeing. I would like to know if anyone could give me
pointers on how to trace the problem?.

Regards,

John

--===============2802399143743319994==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGRpdiBkaXI9Imx0ciI+SGkgYWxsLDxkaXY+PGJyPjwvZGl2PjxkaXY+SSB3YXMgdHJ5aW5nIHRv
IGludGVncmF0ZSB0aGXCoDxhIGhyZWY9Imh0dHBzOi8vd3d3LnF1ZWN0ZWwuY29tL1VwbG9hZElt
YWdlL0Rvd25sYWQvUXVlY3RlbF9CRzk2X1RDUChJUClfQVRfQ29tbWFuZHNfTWFudWFsX1YxLjAu
cGRmIiB0YXJnZXQ9Il9ibGFuayI+cXVlY3RlbDwvYT7CoHRjcC9pcCBjb25uZWN0aW9uIGluIHRo
ZSBvZm9ubyBkcml2ZXIuIEkgdXNlZCBBVCtRSU9QRU4gZm9yIG9wZW5pbmcgdGhlIHNvY2tldCzC
oEFUK1FJUkQgZm9yIHJlY2VpdmluZyBkYXRhIGZyb20gdGhlIHNlcnZlciBhbmTCoEFUK1FJU0VO
REVYIGZvciBzZW5kaW5nIGRhdGEgdG8gdGhlIHNlcnZlci48L2Rpdj48ZGl2Pjxicj48L2Rpdj48
ZGl2PlRoZSAzIGZ1bmN0aW9ucyBhcmUgd29ya2luZyBjb3JyZWN0bHkgaWYgSSBleGVjdXRlZCBp
dCBkaXJlY3RseSBpbiB0aGUgc2VyaWFsIHBvcnQuIEkgaGFkIGlzc3VlIHdpdGggb2Zvbm8gd2hl
biBpdCBzZW5kIHRoZSBBVCtRSVNFTkRFWC4gQmVsb3cgaXMgdGhlIGNvbW1hbmQ6PC9kaXY+PGRp
dj48YnI+PC9kaXY+PGRpdj5jaGFyIGNvbnN0ICpjb21tYW5kMiA9ICZxdW90O0FUK1FJU0VOREVY
PTIsXCZxdW90OzQ4NjU2YzZjNmZcJnF1b3Q7JnF1b3Q7Ozxicj48L2Rpdj48ZGl2PjxkaXY+Z19h
dF9jaGF0X3NlbmQoZGF0YS0mZ3Q7YXV4LCBjb21tYW5kMiwgbm9uZV9wcmVmaXgsIE5VTEwsIE5V
TEwsTlVMTCk7PC9kaXY+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5U
aGUgZmlyc3QgZXhlY3V0aW9uIG9mIHRoZSBRSVNFTkRFWCB3b3Jrcy4gTXkgc2VydmVyIHJlY2Vp
dmVkIHRoZSBkYXRhIGJ1dCB3aGVuIEkgdHJ5IGl0IGFnYWluLCB0aGUgb2Zvbm8gc3R1Y2sgc29t
ZXdoZXJlIHdoZXJlIHRoZSBpdCBjb3VsZG4mIzM5O3QgcnVuIGFueSBBVCBjb21tYW5kcyBhbnlt
b3JlLiBUaGVuLCBJIGtpbGxlZCB0aGUgb2Zvbm8gYW5kIG9wZW5lZCB0aGUgc2VyaWFsLCBJIHJh
biB0aGlzIGNvbW1hbmTCoEFUK1FJU0VOREVYPTIsJnF1b3Q7NDg2NTZjNmM2ZiZxdW90OyBhbmQg
aXQgd29ya3MgZmluZS48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PkkgZW5hYmxlZCB0aGUgLWQg
KGRlYnVnKSBpbiBvZm9ubyBwYXJhbWV0ZXIgYW5kIEkgY291bGRuJiMzOTt0IGZpbmQgYW55IGxv
Z3MgcmVsYXRlZCB0byB3aGF0IEkgYW0gc2VlaW5nLiBJIHdvdWxkIGxpa2UgdG8ga25vdyBpZiBh
bnlvbmUgY291bGQgZ2l2ZSBtZSBwb2ludGVycyBvbiBob3cgdG8gdHJhY2UgdGhlIHByb2JsZW0/
Ljxicj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PlJlZ2FyZHMsPC9kaXY+PGRpdj48YnI+PC9k
aXY+PGRpdj5Kb2huPC9kaXY+PC9kaXY+Cg==

--===============2802399143743319994==--

